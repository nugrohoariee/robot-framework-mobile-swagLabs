*** Settings ***
Library      AppiumLibrary  
Library      JSONLibrary
Variables    ../../config.py

*** Variables ***
${REMOTE_URL}     http://127.0.0.1:4723
${PLATFORM}       Android
${DEVICE_NAME}    emulator-5554
${PACKAGE}        com.swaglabsmobileapp
${ACTIVITY}       com.swaglabsmobileapp.SplashActivity
${APP_PATH}       ${BASE_PATH}/robot-framework-mobile-swagLabs/apk/saucelabs.apk
${JSON_PATH}      ${BASE_PATH}/robot-framework-mobile-swagLabs/resources/dataFiles/users.json
${JSON_COINFO}    ${BASE_PATH}/robot-framework-mobile-swagLabs/resources/dataFiles/COInfo.json
${JSON_DATA}      ${None}
${LOGIN_DATA}     ${None}
${CO_DATA}        ${None}


*** Keywords ***
Start Appium Session
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM}
    ...    deviceName=${DEVICE_NAME}
    ...    automationName=UiAutomator2
    ...    app=${APP_PATH}
    ...    appPackage=${PACKAGE}
    ...    appActivity=${ACTIVITY}
    ...    noReset=false
    Capture Page Screenshot


Load All Test Data
    ${data_login}=    Load Json From File    ${JSON_PATH}
    ${data_co}=       Load Json From File    ${JSON_COINFO}
    Set Suite Variable    ${LOGIN_DATA}    ${data_login}
    Set Suite Variable    ${CO_DATA}       ${data_co}

