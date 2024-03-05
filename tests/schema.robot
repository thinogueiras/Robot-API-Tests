*** Settings ***
Documentation               JSON Schema Tests

Resource                    ../resources/base.resource

Suite Setup                 Setup

*** Test Cases ***
Deve validar o JSON Schema para Contas
    ${response}             Get All Accounts

    Validate Json By Schema File        ${response.json()}       ${EXECDIR}/resources/schemas/account.json

Deve validar o JSON Schema para Saldo
    ${response}             Get All Balances

    Validate Json By Schema File        ${response.json()}       ${EXECDIR}/resources/schemas/balance.json

Deve validar o JSON Schema para Movimentações
    ${response}             Get All Movements

    Validate Json By Schema File        ${response.json()}       ${EXECDIR}/resources/schemas/movement.json