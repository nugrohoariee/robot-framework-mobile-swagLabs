*** Settings ***
Library    AppiumLibrary

*** Variables ***
${FIELD_USERNAME}         //android.widget.EditText[@content-desc="test-Username"]
${FIELD_PASSWORD}         //android.widget.EditText[@content-desc="test-Password"]
${BTN_LOGIN}              accessibility_id=test-LOGIN
${ERROR_MESSAGE}          //android.view.ViewGroup[@content-desc="test-Error message"]


*** Keywords ***
Isi Form Login
    [Arguments]     ${email}    ${password}
    Input Text    ${FIELD_USERNAME}      ${email}
    Input Text    ${FIELD_PASSWORD}      ${password}

Klik Tombol Login
    Click Element    ${BTN_LOGIN}
    Capture Page Screenshot

Show Error Message
    Wait Until Element Is Visible    android=new UiSelector().text("Username and password do not match any user in this service.")    timeout=15s
    Capture Page Screenshot


