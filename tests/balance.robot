*** Settings ***
Documentation               Consulta de saldo

Resource                    ../resources/base.resource

Suite Setup                 Start Test

*** Test Cases ***
Deve validar o saldo da conta
    ${response}             Get Account Balance        Conta para saldo

    Status Should Be        200
    
    Should Be True          ${response} == 534


