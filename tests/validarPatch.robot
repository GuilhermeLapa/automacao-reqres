*** Settings ***
Library    RequestsLibrary
Library    String
Resource    ../resource/reqres.resource

*** Test Cases ***
Cenário 01: Atualizar Usuário Sucesso
    [Tags]    UpdateUser
    Given que possuo um id de usuário
    When atualizo o usuário    zion resident
    Then verifico o status code    200
    And verifico que existe a chave    $    name
    And verifico o valor do campo string no json    name    Eve
    And verifico que existe a chave    $    job
    And verifico o valor do campo string no json    job    zion resident
    And verifico que existe a chave    $    updatedAt
    And comparo os valores dos campos string    ${updatedAt}    ${dataAtual}
