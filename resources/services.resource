*** Settings ***
Documentation               Serviços

Library                     libs/search_values.py
Library                     RequestsLibrary

Resource                    helpers.resource

*** Keywords ***
Get Account
    ${response}             GET On Session
    ...                     alias=Barriga-REST
    ...                     url=/contas
    ...                     expected_status=any
    
    [Return]                ${response}

Edit Account
    [Arguments]             ${account_name}             ${payload}

    ${account_id}           Get Account ID By Name      ${account_name}

    ${response}             PUT On Session
    ...                     alias=Barriga-REST
    ...                     url=/contas/${account_id}
    ...                     json=${payload}
    ...                     expected_status=any
    
    [Return]                ${response}

Insert Account
    [Arguments]             ${payload}

    ${response}             POST On Session
    ...                     alias=Barriga-REST
    ...                     url=/contas
    ...                     json=${payload}
    ...                     expected_status=any
    
    [Return]                ${response}

Delete Account
    [Arguments]             ${account_id}

    ${response}             DELETE On Session
    ...                     alias=Barriga-REST
    ...                     url=/contas/${account_id}
    ...                     expected_status=any

    [Return]                ${response}

Get Account Balance        
    [Arguments]             ${account_name}

    ${account_id}           Get Account ID By Name      ${account_name}

    ${response}             GET On Session
    ...                     alias=Barriga-REST
    ...                     url=/saldo
    ...                     expected_status=any

    ${value}                Find Value By Id    ${response.json()}    ${account_id}

    [Return]                ${value}

Get All Movements
    ${response}             GET On Session
    ...                     alias=Barriga-REST
    ...                     url=/transacoes
    ...                     expected_status=any

    [Return]                ${response}

Insert Movement
    [Arguments]             ${payload}

    ${response}             POST On Session
    ...                     alias=Barriga-REST
    ...                     url=/transacoes
    ...                     json=${payload}
    ...                     expected_status=any

    [Return]                ${response}

Delete Movement
    [Arguments]             ${movement_id}

    ${response}             DELETE On Session
    ...                     alias=Barriga-REST
    ...                     url=/transacoes/${movement_id}
    ...                     expected_status=any

    [Return]                ${response}