*** Settings ***
Documentation               Helpers

Library                     RequestsLibrary

*** Keywords ***
Get Account ID By Name
    [Arguments]             ${account_name}

    ${response}             GET On Session
    ...                     alias=Barriga-REST
    ...                     url=/contas?nome=${account_name}
    ...                     expected_status=any

    RETURN                  ${response.json()}[0][id]

Get Movement ID By Name
    [Arguments]             ${movement_description}

    ${response}             GET On Session
    ...                     alias=Barriga-REST
    ...                     url=/transacoes?descricao=${movement_description}
    ...                     expected_status=any

    RETURN                  ${response.json()}[0][id]

Reset Database
    ${response}             GET On Session
    ...                     alias=Barriga-REST
    ...                     url=/reset
    ...                     expected_status=any