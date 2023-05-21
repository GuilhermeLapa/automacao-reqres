*** Settings ***
Resource    ../resource/reqres.resource
Library    RequestsLibrary

# Feature: POST - Criar Sessão Login

*** Test Cases ***
Cenário 01: Login Sucesso
    [Tags]    Login
    Given que possuo email e senha válidos
    When efetuo login
    Then verifico o status code    200
    And verifico que existe a chave    $    token
    And verifico o valor do campo string no json    token    QpwL5tke4Pnpja7X4

Cenário 02: Login Erro Obrigatoriedade
    [Tags]    Login
    Given que não possuo email e senha
    When efetuo login
    Then verifico o status code    400
    And verifico que existe a chave    $    error
    And verifico a mensagem de erro    Missing email or username

Cenário 03: Login Erro Obrigatoriedade Campo Email
    [Tags]    Login
    Given que possuo email mas não possuo senha
    When efetuo login
    Then verifico o status code    400
    And verifico que existe a chave    $    error
    And verifico a mensagem de erro    Missing password

Cenário 04: Login Erro Obrigatoriedade Campo Senha
    [Tags]    Login
    Given que não possuo email mas possuo senha
    When efetuo login
    Then verifico o status code    400
    And verifico que existe a chave    $    error
    And verifico a mensagem de erro    Missing email or username

Cenário 05: Login Erro Usuário Inexistente
    [Tags]    Login
    Given que possuo email inválido e uma senha válida    naoExiste@naoExiste.com
    When efetuo login
    Then verifico o status code    400
    And verifico a mensagem de erro    user not found

Cenário 06: Registrar Usuário Sucesso
    [Tags]    Register
    Given que possuo email e senha para registro
    When efetuo cadastro
    Then verifico o status code    200
    And verifico que existe a chave    $    id
    And verifico que existe a chave    $    token

Cenário 07: Registrar Usuário Não Definido
    [Tags]    Register
    Given que possuo dados de usuário não definido
    When efetuo cadastro
    Then verifico o status code    400
    And verifico que existe a chave    $    error
    And verifico a mensagem de erro    Note: Only defined users succeed registration

Cenário 08: Registrar Erro Obrigatoriedade
    [Tags]    Register
    Given que não possuo email e senha para registro
    When efetuo cadastro
    Then verifico o status code    400
    And verifico que existe a chave    $    error
    And verifico a mensagem de erro    Missing email or username

Cenário 09: Registrar Erro Obrigatoriedade Senha
    [Tags]    Register
    Given que possuo email mas não possuo senha para registro
    When efetuo cadastro
    Then verifico o status code    400
    And verifico que existe a chave    $    error
    And verifico a mensagem de erro    Missing password

Cenário 10: Registrar Erro Obrigatoriedade Email
    [Tags]    Register
    Given que não possuo email mas possuo senha para registro
    When efetuo cadastro
    Then verifico o status code    400
    And verifico que existe a chave    $    error
    And verifico a mensagem de erro    Missing email or username
