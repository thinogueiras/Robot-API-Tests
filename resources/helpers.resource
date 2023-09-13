*** Settings ***
Documentation               Helpers

Library                     RequestsLibrary

*** Variables ***
${BASE_URL}                 https://barrigarest.wcaquino.me
${USERNAME}                 thinogueiras@testing.com
${PASSWORD}                 test123
&{AUTH}                     email=${username}        senha=${password}

*** Keywords ***
Set Authorization    
    ${response}             POST
    ...                     url=${BASE_URL}/signin
    ...                     json=${AUTH}
    ...                     expected_status=any

    Set Global Variable     ${TOKEN}            ${response.json()}[token]

    Set Global Variable     &{HEADERS}          Authorization=JWT ${TOKEN}

Reset
    ${response}             GET
    ...                     headers=${HEADERS}
    ...                     url=${BASE_URL}/reset
    ...                     expected_status=any

    [Return]                ${response}

Get Account ID By Name
    [Arguments]             ${account_name}

    ${response}             GET
    ...                     headers=${HEADERS}
    ...                     url=${BASE_URL}/contas?nome=${account_name}
    ...                     expected_status=any

    [Return]                ${response.json()}[0][id]

Get Movement ID By Name
    [Arguments]             ${movement_description}

    ${response}             GET
    ...                     headers=${HEADERS}
    ...                     url=${BASE_URL}/transacoes?descricao=${movement_description}
    ...                     expected_status=any

    [Return]                ${response.json()}[0][id]