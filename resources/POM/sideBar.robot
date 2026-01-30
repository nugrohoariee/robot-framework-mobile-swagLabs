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
    Click Element    xpath=//*[contains(@text, 'LOGOUT')]

Klik All Items
    Click Element    xpath=//*[contains(@text, 'ALL ITEMS')]

Klik Web View
    Click Element    xpath=//*[contains(@text, 'WEBVIEW')]

Klik QR Code Scanner
    Click Element    xpath=//*[contains(@text, 'QR CODE SCANNER')]

Klik Geo Location
    Click Element    xpath=//*[contains(@text, 'GEO LOCATION')]

Klik Drawing
    Click Element    xpath=//*[contains(@text, 'DRAWING')]

Klik About
    Click Element    xpath=//*[contains(@text, 'ABOUT')]

Klik Reset App State
    Click Element    xpath=//*[contains(@text, 'RESET APP STATE')]
