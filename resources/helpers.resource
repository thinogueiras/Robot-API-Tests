*** Settings ***
Documentation               Helpers

Library                     RequestsLibrary
Library                     JSONLibrary

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

Get Movement Fixture
    [Arguments]             ${json_object}

    ${fixture}              Load Json From File
    ...                     ${EXECDIR}/resources/fixtures/movimentacoes.json
    ...                     encoding=UTF-8

    ${account_id}           Get Account ID By Name        Conta para movimentacoes

    ${payload}              Update Value To Json
    ...                     ${fixture["${json_object}"]}
    ...                     $.conta_id
    ...                     ${account_id}

    RETURN                  ${payload}

Reset Database
    ${response}             GET On Session
    ...                     alias=Barriga-REST
    ...                     url=/reset
    ...                     expected_status=any