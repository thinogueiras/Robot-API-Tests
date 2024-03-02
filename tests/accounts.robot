*** Settings ***
Documentation               Contas

Resource                    ../resources/base.resource

Suite Setup                 Setup

*** Test Cases ***
Deve retornar todas as contas
    ${response}             Get Account

    ${size}                 Get Length            ${response.json()}

    Status Should Be        200

    Should Be True          ${size} == 6

Deve editar uma conta
    ${account_name}         Create Dictionary     nome=Conta Alterada com Sucesso

    ${response}             Edit Account          Conta para alterar        ${account_name}

    Status Should Be        200

    Should Be Equal         ${response.json()}[nome]        Conta Alterada com Sucesso

Deve inserir uma conta
    ${payload}              Create Dictionary     nome=Conta de investimentos

    ${response}             Insert Account        ${payload}

    Status Should Be        201

    Should Be Equal         ${response.json()}[nome]        Conta de investimentos

Não deve inserir uma conta com mesmo nome
    ${payload}              Create Dictionary     nome=Conta mesmo nome

    ${response}             Insert Account        ${payload}

    Status Should Be        400

    Should Be Equal         ${response.json()}[error]       Já existe uma conta com esse nome!

Não deve remover conta com movimentação
    ${account_id}          Get Account ID By Name           Conta com movimentacao

    ${response}            Delete Account         ${account_id}

    Status Should Be       500

    Should Be Equal        ${response.json()}[constraint]   transacoes_conta_id_foreign
