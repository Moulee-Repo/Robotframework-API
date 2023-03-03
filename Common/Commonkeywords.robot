*** Comments ***
Common Keywords for Rest API

*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

Resource  Endpoint_URLs.robot

*** Keywords ***
    
GET SINGLE USER Response
    [Arguments]    ${ID}
    ${headers}=     Create Dictionary     Content-Type    application/json
    Create Session  GET(1)  ${BASE_URL}  ${headers}  verify=true
    ${response}=  GET On Session  GET(1)  ${Users}  params=/   =${ID}
    Log To Console    ${response}

    ##Check Status as 200
    Status Should Be  200  ${response}  
    Log To Console    ${response.status_code}
      