*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    JSONLibrary
Library    SeleniumLibrary

*** Variables ***
${url}    https://reqres.in/api
${urlLogin}    /login
${urlRegister}    /register
${urlListarUsuarios}    /users
${email}    eve.holt@reqres.in
${password}    cityslicka

*** Keywords ***
verifico o status code
    [Arguments]    ${statusCode}
    Should Be Equal As Strings    ${responseBody.status_code}    ${statusCode}

verifico que existe a chave
    [Arguments]    ${jsonPath}    ${chave}
    IF    "${jsonPath}" == "$"
        Dictionary Should Contain Key    ${responseBody.json()}    ${chave}
    ELSE
        Dictionary Should Contain Key    ${responseBody.json()${jsonPath}}    ${chave}
    END

verifico o valor do campo string no json
    [Arguments]    ${jsonPath}    ${valorEsperado}
    ${valorEsperado}=    Convert To String    ${valorEsperado}
    ${valorAtual}=    Get Value From Json    ${responseBody.json()}    ${jsonPath}
    Should Be Equal    ${valorAtual}[0]    ${valorEsperado}

verifico o valor do campo inteiro no json
    [Arguments]    ${jsonPath}    ${valorEsperado}
    ${valorEsperado}=    Convert To Integer    ${valorEsperado}
    ${valorAtual}=    Get Value From Json    ${responseBody.json()}    ${jsonPath}
    Should Be Equal    ${valorAtual}[0]    ${valorEsperado}

que possuo email e senha válidos
    ${body}=    Create Dictionary    email=${email}    password=${password}
    Set Global Variable    ${body}

efetuo login
    ${responseBody} =    POST    ${url}${urlLogin}    json=${body}    expected_status=anything
    Set Global Variable    ${responseBody}
    Log    Resposta: ${responseBody}

que não possuo email e senha
    ${body}=    Create Dictionary    email=    password=
    Set Global Variable    ${body}

verifico a mensagem de erro
    [Arguments]    ${msgErro}
    Dictionary Should Contain Item    ${responseBody.json()}    error    ${msgErro}

que possuo email mas não possuo senha
    ${body}=    Create Dictionary    email=${email}    password=
    Set Global Variable    ${body}

que não possuo email mas possuo senha
    ${body}=    Create Dictionary    email=    password=${password}
    Set Global Variable    ${body}

que possuo email inválido e uma senha válida
    [Arguments]    ${emailInvalido}
    ${body}=    Create Dictionary    email=${emailInvalido}    password=${password}
    Set Global Variable    ${body}

que possuo email e senha para registro
    ${body}    Create Dictionary    email=${email}    password=${password}
    Set Global Variable    ${body}
efetuo cadastro
    ${responseBody}    POST    ${url}${urlRegister}    json=${body}    expected_status=anything
    Set Global Variable    ${responseBody}
    Log    Resposta: ${responseBody}

que possuo dados de usuário não definido
    ${body}=    Create Dictionary    email=eve.holt@reqres.com    password=teste123
    Set Global Variable    ${body}

que não possuo email e senha para registro
    ${body}=    Create Dictionary    email=    password=
    Set Global Variable    ${body}

que possuo email mas não possuo senha para registro
    ${body}=    Create Dictionary    email=eve.holt@reqres.com    password=
    Set Global Variable    ${body}

que não possuo email mas possuo senha para registro
    ${body}=    Create Dictionary    email=    password=teste123
    Set Global Variable    ${body}

que existem usuários registrados
    [Arguments]    ${page}    ${per_page}
    ${body}=    Create Dictionary    page=${page}    per_page=${per_page}
    Set Global Variable    ${body}

consulto a lista de usuários
    ${responseBody}=    Get    ${url}${urlListarUsuarios}    json=${body}    expected_status=anything
    Set Global Variable    ${responseBody}
    Log    Resposta: ${responseBody}
