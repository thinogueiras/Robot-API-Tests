*** Settings ***
Documentation               Arquivo base do projeto

Library                     libs/search_values.py

Resource                    services.resource

*** Variables ***
${BASE_URL}                 https://barrigarest.wcaquino.me
${TOKEN}

*** Keywords ***
Setup
    IF  $TOKEN == '${null}' or $TOKEN == '${EMPTY}'

        ${AUTH}                 Create Dictionary
        ...                     email=thinogueiras@testing.com        
        ...                     senha=test123

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