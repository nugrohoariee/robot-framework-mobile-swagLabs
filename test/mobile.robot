*** Settings ***
Library           AppiumLibrary

*** Variables ***
${REMOTE_URL}     http://127.0.0.1:4723
${PLATFORM}       Android
${DEVICE_NAME}    emulator-5554
${APP_PATH}       ${CURDIR}/../apk/saucelabs.apk
${PACKAGE}        com.swaglabsmobileapp
${ACTIVITY}       com.swaglabsmobileapp.SplashActivity

*** Test Cases ***
Buka Aplikasi Dan Klik Tombol
    Open Application    ${REMOTE_URL}    
    ...                 platformName=${PLATFORM}    
    ...                 deviceName=${DEVICE_NAME}
    ...                 udid=${DEVICE_NAME}
    ...                 app=${APP_PATH}
    ...                 appPackage=${PACKAGE}
    ...                 appActivity=${ACTIVITY}
    ...                 automationName=UiAutomator2
    ...                 noReset=false

    Wait Until Element Is Visible    accessibility_id=test-Username    timeout=15s
    Input Text         //android.widget.EditText[@content-desc="test-Username"]  standard_user
    Input Text       //android.widget.EditText[@content-desc="test-Password"]   secret_sauce
    Click Element    accessibility_id=test-LOGIN
    click element    com.swaglabsmobileapp:id/action_bar_root
    Capture Page Screenshot

    [Teardown]    Close Application