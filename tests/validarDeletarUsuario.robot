*** Settings ***
Resource    ../resource/reqres.resource
Library    RequestsLibrary

# Feature: DELETE - Deletar Usuário

*** Test Cases ***
Cenário 01: Deletar Usuário Sucesso
    [Tags]    DeleteUser
    Given que possuo um id de usuário
    When deleto o usuário
    Then verifico o status code    204
