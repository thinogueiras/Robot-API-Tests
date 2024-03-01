*** Settings ***
Documentation               Autorização

Resource                    ../resources/base.resource

Suite Setup                 Setup

***Test Cases***
Deve exigir autenticação
    Check Route Authentication    contas    saldo    transacoes    movimentacoes