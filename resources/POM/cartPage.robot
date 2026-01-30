*** Settings ***
Library    AppiumLibrary

*** Variables ***
${BTN_REMOVE}                //android.view.ViewGroup[@content-desc="test-REMOVE"]
${BTN_CONTINUE_SHOPPING}    //android.view.ViewGroup[@content-desc="test-CONTINUE SHOPPING"]
${BTN_CHECKOUT}             accessibility_id=test-CHECKOUT


*** Keywords ***
Klik Remove
    click Element    ${BTN_REMOVE}      

Klik Continue Shopping
    click Element    ${BTN_CONTINUE_SHOPPING}      

Klik Checkout
    click Element    ${BTN_CHECKOUT}   
