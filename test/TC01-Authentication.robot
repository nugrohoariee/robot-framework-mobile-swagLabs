*** Settings ***
Resource          ${CURDIR}/../resources/POM/loginPage.robot
Resource          ${CURDIR}/../resources/POM/common.robot
Test Setup        Start Appium Session
Suite Setup       Load Data Json

*** Test Cases ***
TC01001 - User dapat melakukan login dengan valid
    Wait Until Element Is Visible    accessibility_id=test-Username    timeout=15s
    Isi Form Login    
    ...    ${JSON_DATA['validLogin']['user_name']}
    ...    ${JSON_DATA['validLogin']['password']}
    Capture Page Screenshot
    Klik Tombol Login
    Capture Page Screenshot
    [Teardown]    Close Application

TC01002 - User tidak dapat melakukan login dengan invalid
    Wait Until Element Is Visible    accessibility_id=test-Username    timeout=15s
    Isi Form Login    
    ...    ${JSON_DATA['invalidLogin']['user_name']}    
    ...    ${JSON_DATA['invalidLogin']['password']}
    Klik Tombol Login
    Show Error Message
    Capture Page Screenshot
    [Teardown]    Close Application

TC01003 - User dapat melakukan logout
    Wait Until Element Is Visible    accessibility_id=test-Username    timeout=15s
    Isi Form Login    
    ...    ${JSON_DATA['invalidLogin']['user_name']} 
    ...    ${JSON_DATA['invalidLogin']['password']}
    Klik Tombol Login
    Show Error Message
    Capture Page Screenshot
    [Teardown]    Close Application

