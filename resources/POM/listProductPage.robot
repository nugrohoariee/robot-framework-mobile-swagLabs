*** Settings ***
Library    AppiumLibrary

*** Variables ***
${BTN_CART}      //android.view.ViewGroup[@content-desc="test-Cart"]
${BTN_TOGGLE}    //android.view.ViewGroup[@content-desc="test-Toggle"]
${BTN_FILTER}    //android.view.ViewGroup[@content-desc="test-Modal Selector Button"]/android.view.ViewGroup
${BTN_PRODUCT}      xpath=(//android.widget.TextView[@text="ADD TO CART"])[1]


*** Keywords ***
Klik Cart
    click Element    ${BTN_CART}      

Klik Toggle
    click Element    ${BTN_TOGGLE}      

Klik Filter
    click Element    ${BTN_FILTER}   

Klik Product
    click Element    ${BTN_PRODUCT}   
    
    