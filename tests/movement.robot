*** Settings ***
Documentation               Movimentações

Resource                    ../resources/base.resource

Suite Setup                 Setup

*** Test Cases ***
Deve retornar todas as Movimentações
    ${response}             Get All Movements

    ${size}                 Get Length        ${response.json()}

    Status Should Be        200

    Should Be True          ${size} == 6

Deve inserir movimentação
    ${payload}              Get Movement Fixture   movimentacao_valida

    ${response}             Insert Movement        ${payload}

    Status Should Be        201

Deve validar os campos obrigatórios para a inserção de uma movimentação
    ${payload}              Create Dictionary

    ${response}             Insert Movement        ${payload}

    ${size}                 Get Length             ${response.json()}

    ${msgs_error}           Create List
    ...                     Data da Movimentação é obrigatório
    ...                     Data do pagamento é obrigatório
    ...                     Descrição é obrigatório
    ...                     Interessado é obrigatório
    ...                     Valor é obrigatório
    ...                     Valor deve ser um número
    ...                     Conta é obrigatório
    ...                     Situação é obrigatório

    ${list_size}            Get Length        ${msgs_error}

    Status Should Be        400

    Should Be True          ${size} == ${list_size}

Não deve inserir movimentação com data futura
    ${payload}              Get Movement Fixture   movimentacao_data_futura

    ${response}             Insert Movement        ${payload}

    Status Should Be        400

    Should Be Equal         ${response.json()[0]['msg']}        Data da Movimentação deve ser menor ou igual à data atual

Deve remover uma movimentação
    ${movement_id}          Get Movement ID By Name       Movimentacao para exclusao

    ${response}             Delete Movement        ${movement_id}

    Status Should Be        204