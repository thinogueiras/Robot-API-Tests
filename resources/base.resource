*** Settings ***
Documentation               Arquivo base do projeto

Resource                    services.resource

Variables                   ../env.yml

*** Variables ***
${BASE_URL}                 https://barrigarest.wcaquino.me
&{AUTH}                     email=${EMAIL}        senha=${PASSWORD}
${TOKEN}                    ${EMPTY}

*** Keywords ***
Setup
    IF  $TOKEN == '${EMPTY}'

        ${response}             POST
        ...                     url=${BASE_URL}/signin
        ...                     json=${AUTH}
        ...                     expected_status=any

        Set Global Variable     ${TOKEN}       ${response.json()}[token]

        ${HEADERS}              Create Dictionary
        ...                     Authorization=JWT ${TOKEN}

        Create Session          alias=Barriga-REST
        ...                     url=${BASE_URL}
        ...                     headers=${HEADERS}
        ...                     disable_warnings=True

        Reset Database

    ELSE
        RETURN  $TOKEN
    END