*** Settings ***
Documentation               Movimentações

Resource                    ../resources/base.resource

Suite Setup                 Start Test

*** Test Cases ***
Deve retornar todas as Movimentações
    ${response}             Get All Movements

    ${size}                 Get Length        ${response.json()}
    
    Status Should Be        200

    Should Be True          ${size} == 6

Deve inserir um movimentação
    ${account_id}           Get Account ID By Name        Conta para movimentacoes

    ${payload}              Create Dictionary
    ...                     conta_id=${account_id}
    ...                     descricao=Teste de inserção de movimentação
    ...                     envolvido=Env mov
    ...                     tipo=REC
    ...                     data_transacao=03/09/2023
    ...                     data_pagamento=30/12/2099
    ...                     valor=5555.55
    ...                     status=True

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

    Should Be True          ${size} == ${list_size}

    Status Should Be        400

Não deve inserir movimentação com data futura
    ${account_id}           Get Account ID By Name        Conta para movimentacoes

    ${payload}              Create Dictionary
    ...                     conta_id=${account_id}
    ...                     descricao=Teste de inserção de movimentação com data futura
    ...                     envolvido=Env mov
    ...                     tipo=REC
    ...                     data_transacao=30/09/2080
    ...                     data_pagamento=30/12/2099
    ...                     valor=1111.11
    ...                     status=True

    ${response}             Insert Movement               ${payload}

    ${message}              Find Value By Key        ${response.json()}        msg

    Status Should Be        400

    Should Be Equal         ${message}    Data da Movimentação deve ser menor ou igual à data atual

Deve remover uma movimentação
    ${movement_id}          Get Movement ID By Name        Movimentacao para exclusao

    ${response}             Delete Movement        ${movement_id}

    Status Should Be        204