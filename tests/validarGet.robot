*** Settings ***
Library    RequestsLibrary
Resource    ../resource/reqres.resource

*** Test Cases ***
Cenário 01: Consultar Lista de Usuários Sucesso
    [Tags]    Users
    Given que existem usuários registrados    1    5
    When consulto a lista de usuários
    Then verifico o status code    200
    And verifico que existe a chave    $    total
    And verifico o valor do campo inteiro no json    total    12
    And verifico que existe a chave    $    total_pages
    And verifico o valor do campo inteiro no json    total_pages    2
    And verifico que existe a chave    $    data
    And verifico que existe a chave    ['data'][0]    id
    And verifico que existe a chave    ['data'][0]    email
    And verifico que existe a chave    ['data'][0]    first_name
    And verifico que existe a chave    ['data'][0]    last_name
    And verifico que existe a chave    ['data'][0]    avatar
    And verifico o valor do campo inteiro no json    ['data'][0]['id']    1
    And verifico o valor do campo string no json    ['data'][0]['email']    george.bluth@reqres.in
    And verifico o valor do campo string no json    ['data'][0]['first_name']    George
    And verifico o valor do campo string no json    ['data'][0]['last_name']    Bluth
    And verifico o valor do campo string no json    ['data'][0]['avatar']    https://reqres.in/img/faces/1-image.jpg
    And verifico que existe a chave    $    support
    And verifico que existe a chave    ['support']    url
    And verifico o valor do campo string no json    ['support']['url']    https://reqres.in/#support-heading
    And verifico que existe a chave    ['support']    text
    And verifico o valor do campo string no json    ['support']['text']    To keep ReqRes free, contributions towards server costs are appreciated!
