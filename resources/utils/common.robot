*** Settings ***
Library    AppiumLibrary  
Library    JSONLibrary
Resource    ../POM/loginPage.robot

*** Variables ***
${REMOTE_URL}     http://127.0.0.1:4723
${PLATFORM}       Android
${DEVICE_NAME}    emulator-5554
${APP_PATH}       D:/RND/ROBOT-MOBILE/robot-framework-mobile-swagLabs/apk/saucelabs.apk
${PACKAGE}        com.swaglabsmobileapp
${ACTIVITY}       com.swaglabsmobileapp.SplashActivity
${JSON_PATH}      D:/RND/ROBOT-MOBILE/robot-framework-mobile-swagLabs/resources/dataFiles/users.json
${JSON_COINFO}    D:/RND/ROBOT-MOBILE/robot-framework-mobile-swagLabs/resources/dataFiles/COInfo.json
${JSON_DATA}      ${None}
${LOGIN_DATA}     ${None}
${CO_DATA}        ${None}
${USER_TYPE}      ${None}


*** Keywords ***
Load All Test Data
    ${data_login}=    Load Json From File    ${JSON_PATH}
    ${data_co}=       Load Json From File    ${JSON_COINFO}
    Set Suite Variable    ${LOGIN_DATA}    ${data_login}
    Set Suite Variable    ${CO_DATA}       ${data_co}


Setup Login App
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM}
    ...    deviceName=${DEVICE_NAME}
    ...    automationName=UiAutomator2
    ...    app=${APP_PATH}
    ...    appPackage=${PACKAGE}
    ...    appActivity=${ACTIVITY}
    ...    noReset=false
    Capture Page Screenshot
    [Arguments]    ${user_type}    
    Wait Until Element Is Visible    accessibility_id=test-Username    timeout=15s
    Isi Form Login    ${LOGIN_DATA['${user_type}']['user_name']}    ${LOGIN_DATA['${user_type}']['password']}
    Klik Tombol Login