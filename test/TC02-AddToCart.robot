*** Settings ***
Resource          ${CURDIR}/../resources/POM/listProductPage.robot
Resource          ${CURDIR}/../resources/utils/common.robot
Resource          ${CURDIR}/../resources/POM/loginPage.robot
Resource          ${CURDIR}/../resources/POM/cartPage.robot
Resource          ${CURDIR}/../resources/POM/checkOutPage.robot
# Test Setup        Start Appium Session
Suite Setup       Load All Test Data


*** Test Cases ***
TC02001 - User dapat melihat produk dan dapat melakukan add to cart
    [Setup]    Setup Login App    validLogin
    Capture Page Screenshot
    Klik Product
    Klik Cart
    Sleep    5s
    Klik Checkout
    Sleep    5s
    Isi Form CO Info    
    ...    ${CO_DATA['COInfo']['first_name']}
    ...    ${CO_DATA['COInfo']['last_name']}
    ...    ${CO_DATA['COInfo']['zip_code']}
    Klik Continue
    Capture Page Screenshot
    [Teardown]    Close Application