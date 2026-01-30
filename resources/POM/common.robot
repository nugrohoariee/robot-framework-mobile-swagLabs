*** Settings ***
Library    AppiumLibrary  
Library    JSONLibrary

*** Variables ***
${REMOTE_URL}     http://127.0.0.1:4723
${PLATFORM}       Android
${DEVICE_NAME}    emulator-5554
${APP_PATH}       D:/RND/ROBOT-MOBILE/robot-framework-mobile-swagLabs/apk/saucelabs.apk
${PACKAGE}        com.swaglabsmobileapp
${ACTIVITY}       com.swaglabsmobileapp.SplashActivity
${JSON_PATH}      D:/RND/ROBOT-MOBILE/robot-framework-mobile-swagLabs/resources/dataFiles/users.json
${JSON_DATA}      ${None}


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

Load Data Json
    ${data}=    Load Json From File    ${JSON_PATH}
    Set Suite Variable    ${JSON_DATA}    ${data}
