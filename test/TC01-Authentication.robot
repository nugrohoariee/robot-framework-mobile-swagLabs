*** Settings ***
Resource          ${CURDIR}/../resources/POM/loginPage.robot
Resource          ${CURDIR}/../resources/POM/common.robot
Resource          ${CURDIR}/../resources/POM/sideBar.robot
Test Setup        Start Appium Session
Suite Setup       Load All Test Data

*** Test Cases ***
TC01001 - User dapat melakukan login dengan valid
    Wait Until Element Is Visible    accessibility_id=test-Username    timeout=15s
    Isi Form Login    
    ...    ${LOGIN_DATA['validLogin']['user_name']}
    ...    ${LOGIN_DATA['validLogin']['password']}
    Capture Page Screenshot
    Klik Tombol Login
    Capture Page Screenshot
    [Teardown]    Close Application

TC01002 - User tidak dapat melakukan login dengan invalid
    Wait Until Element Is Visible    accessibility_id=test-Username    timeout=15s
    Isi Form Login    
    ...    ${LOGIN_DATA['invalidLogin']['user_name']}    
    ...    ${LOGIN_DATA['invalidLogin']['password']}
    Klik Tombol Login
    Show Error Message
    Capture Page Screenshot
    [Teardown]    Close Application

TC01003 - User dapat melakukan logout
    Wait Until Element Is Visible    accessibility_id=test-Username    timeout=15s
    Isi Form Login    
    ...    ${LOGIN_DATA['validLogin']['user_name']} 
    ...    ${LOGIN_DATA['validLogin']['password']}
    Klik Tombol Login
    Klik Burger Menu
    Sleep    5s
    Klik Logout
    Capture Page Screenshot
    [Teardown]    Close Application

