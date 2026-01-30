*** Settings ***
Library    AppiumLibrary
Resource    common.robot

*** Variables ***
${FIELD_FIRST_NAME}    //android.widget.EditText[@content-desc="test-First Name"]
${FIELD_LAST_NAME}     //android.widget.EditText[@content-desc="test-Last Name"]
${FIELD_ZIP_CODE}      //android.widget.EditText[@content-desc="test-Zip/Postal Code"]
${BTN_CONTINUE}        accessibility_id=test-CONTINUE
${BTN_CANCEL}          accessibility_id=test-CANCEL


*** Keywords ***
Isi Form CO Info
    [Arguments]    ${first_name}    ${last_name}    ${zip_code}
    Input Text    ${FIELD_FIRST_NAME}      ${first_name}
    Input Text    ${FIELD_LAST_NAME}       ${last_name}
    Input Text    ${FIELD_ZIP_CODE}       ${zip_code}

Klik Continue
    click Element    ${BTN_CONTINUE}   

Klik Cancel
    click Element    ${BTN_CANCEL}   



