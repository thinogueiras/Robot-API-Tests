*** Settings ***
Documentation               Serviços

Library                     RequestsLibrary
Library                     libs/search_values.py

Resource                    helpers.resource

*** Keywords ***
Get All Accounts
    ${response}             GET On Session
    ...                     alias=Barriga-REST
    ...                     url=/contas
    ...                     expected_status=any

    RETURN                  ${response}

Edit Account
    [Arguments]             ${account_name}             ${payload}

    ${account_id}           Get Account ID By Name      ${account_name}

    ${response}             PUT On Session
    ...                     alias=Barriga-REST
    ...                     url=/contas/${account_id}
    ...                     json=${payload}
    ...                     expected_status=any

    RETURN                  ${response}

Insert Account
    [Arguments]             ${payload}

    ${response}             POST On Session
    ...                     alias=Barriga-REST
    ...                     url=/contas
    ...                     json=${payload}
    ...                     expected_status=any

    RETURN                  ${response}

Delete Account
    [Arguments]             ${account_id}

    ${response}             DELETE On Session
    ...                     alias=Barriga-REST
    ...                     url=/contas/${account_id}
    ...                     expected_status=any

    RETURN                  ${response}

Get All Balances
    ${response}             GET On Session
    ...                     alias=Barriga-REST
    ...                     url=/saldo
    ...                     expected_status=any

    RETURN                  ${response}

Get Account Balance
    [Arguments]             ${account_name}

    ${account_id}           Get Account ID By Name      ${account_name}

    ${response}             GET On Session
    ...                     alias=Barriga-REST
    ...                     url=/saldo
    ...                     expected_status=any

    ${value}                Find Value By Id    ${response.json()}    ${account_id}

    RETURN                  ${value}

Get All Movements
    ${response}             GET On Session
    ...                     alias=Barriga-REST
    ...                     url=/transacoes
    ...                     expected_status=any

    RETURN                  ${response}

Insert Movement
    [Arguments]             ${payload}

    ${response}             POST On Session
    ...                     alias=Barriga-REST
    ...                     url=/transacoes
    ...                     json=${payload}
    ...                     expected_status=any

    RETURN                  ${response}

Delete Movement
    [Arguments]             ${movement_id}

    ${response}             DELETE On Session
    ...                     alias=Barriga-REST
    ...                     url=/transacoes/${movement_id}
    ...                     expected_status=any

    RETURN                  ${response}

Get Routes
    [Arguments]             ${route}

    ${response}             GET On Session
    ...                     alias=Barriga-REST
    ...                     url=/${route}
    ...                     headers=${EMPTY}
    ...                     expected_status=any

    Status Should Be        401

Check Route Authentication
    [Arguments]             @{routes}

    FOR    ${route}    IN   @{routes}

        Run Keyword And Continue On Failure    Get routes    ${route}

    END