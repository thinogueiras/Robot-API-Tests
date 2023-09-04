*** Settings ***
Documentation               Arquivo base do projeto

Library                     ../libraries/search_values.py

Resource                    services.resource
Resource                    helpers.resource

*** Keywords ***
Start Test
    Set Authorization
    Reset