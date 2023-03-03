*** Comments ***
Demo Rest API Testcases

*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections
Library    String

Resource    ../Common/Commonkeywords.robot
Resource    ../Common/Endpoint_URLs.robot


*** Test Cases ***
Do a GET Request and validate the response code and response body
    [documentation]  This test case verifies that the response code of the GET Request should be 200,
    ...  the response body contains the 'title' key with value as 'London',
    ...  and the response body contains the key 'location_type'.
    [tags]  sanity
    ${headers}=     Create Dictionary     Content-Type    application/json
    Create Session  GET(1)  ${BASE_URL}  ${headers}  verify=true
    ${response}=  GET On Session  GET(1)  ${Users}  params=${Pages}=0
    Log To Console    ${response}

    ##Check Status as 200
    Status Should Be  200  ${response}  
    Log To Console    ${response.status_code}

    # Response Validation
    ${Json_response}=  Convert String To Json  ${response.content}
    Log To Console    ${Json_response}
    ${page_num}=  Get Value From Json    ${Json_response}   ['page']  
    ${page_num}=  Convert To String  ${page_num}
    Should Be Equal   ${page_num}   [1]

Do a GET Request and validate the response code and response body
    [documentation]  This test case verifies that the response code of the GET Request should be 200,
    ...  the response body contains the 'title' key with value as 'London',
    ...  and the response body contains the key 'location_type'.
    [tags]  sanity
    ${headers}=     Create Dictionary     Content-Type    application/json
    ${Body}=     Create Dictionary     name=Moulee     Email=Mowlee
    Create Session   POST(1)   ${BASE_URL}  ${headers}  verify=true
    ${response}=    POST On Session  POST(1)  ${Users}   json=${Body}
    ${Json_response}=  Convert String To Json  ${response.content}
    Log To Console    ${Json_response}


    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    ${response.status_code}

    ${Created_ID}=    Get Value From Json    ${Json_response}    id 
    ${Created_ID}=    Convert To String    ${Created_ID}
    ${Created_ID}=    Remove String Using Regexp  ${Created_ID}   ['\\[\\],]
    #validation for created ID
    # GET SINGLE USER Response    ${Created_ID}
    
