*** Settings ***
Documentation               Serviços

Library                     libs/search_values.py
Library                     RequestsLibrary

Resource                    helpers.resource

*** Keywords ***
Get Account
    ${response}             GET
    ...                     headers=${HEADERS}
    ...                     url=${BASE_URL}/contas
    ...                     expected_status=any
    
    [Return]                ${response}

Edit Account
    [Arguments]             ${account_name}             ${payload}

    ${account_id}           Get Account ID By Name      ${account_name}

    ${response}             PUT
    ...                     headers=${HEADERS}
    ...                     url=${BASE_URL}/contas/${account_id}
    ...                     json=${payload}
    ...                     expected_status=any
    
    [Return]                ${response}

Insert Account
    [Arguments]             ${payload}

    ${response}             POST
    ...                     headers=${HEADERS}
    ...                     url=${BASE_URL}/contas
    ...                     json=${payload}
    ...                     expected_status=any
    
    [Return]                ${response}

Delete Account
    [Arguments]             ${account_id}

    ${response}             DELETE
    ...                     headers=${HEADERS}
    ...                     url=${BASE_URL}/contas/${account_id}
    ...                     expected_status=any

    [Return]                ${response}

Get Account Balance        
    [Arguments]             ${account_name}

    ${account_id}           Get Account ID By Name      ${account_name}

    ${response}             GET
    ...                     headers=${HEADERS}
    ...                     url=${BASE_URL}/saldo
    ...                     expected_status=any

    ${value}                Find Value By Id    ${response.json()}    ${account_id}

    [Return]                ${value}

Get All Movements
    ${response}             GET
    ...                     headers=${HEADERS}
    ...                     url=${BASE_URL}/transacoes
    ...                     expected_status=any

    [Return]                ${response}

Insert Movement
    [Arguments]             ${payload}

    ${response}             POST
    ...                     headers=${HEADERS}
    ...                     url=${BASE_URL}/transacoes
    ...                     json=${payload}
    ...                     expected_status=any

    [Return]                ${response}

Delete Movement
    [Arguments]             ${movement_id}

    ${response}             DELETE
    ...                     headers=${HEADERS}
    ...                     url=${BASE_URL}/transacoes/${movement_id}
    ...                     expected_status=any

    [Return]                ${response}