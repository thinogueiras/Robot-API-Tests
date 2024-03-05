*** Settings ***
Documentation               Exigência de autenticação das rotas

Resource                    ../resources/base.resource

Suite Setup                 Setup

***Test Cases***
Deve exigir autenticação
    Check Route Authentication    contas    saldo    transacoes