*** Settings ***
Library    AppiumLibrary

*** Variables ***
${BTN_SIDEBAR}            //android.view.ViewGroup[@content-desc="test-Menu"]/android.view.ViewGroup/android.widget.ImageView
${BTN_ALL_ITEMS}          //android.widget.TextView[@text="ALL ITEMS"]
${BTN_WEB_VIEW}           //android.widget.TextView[@text="WEBVIEW"]
${BTN_QR_CODE_SCANNER}    //android.widget.TextView[@text="QR CODE SCANNER"]
${BTN_GEO_LOCATION}       //android.widget.TextView[@text="GEO LOCATION"]
${BTN_DRAWING}            //android.widget.TextView[@text="DRAWING"]
${BTN_ABOUT}              //android.widget.TextView[@text="ABOUT"]
${BTN_LOGOUT}             //android.widget.TextView[@text="LOGOUT"]
${BTN_APP_STATE}          //android.widget.TextView[@text="RESET APP STATE"]


*** Keywords ***
Klik Burger Menu
    click Element    ${BTN_SIDEBAR}      

Klik Logout
    # click Element    ${BTN_LOGOUT}      
    # Click Element At Coordinates    119    1361
    # Tap    None    119    1361
    Click Element    xpath=//*[contains(@text, 'LOGOUT')]
