*** Settings ***
Resource          ${CURDIR}/../resources/POM/listProductPage.robot
Resource          ${CURDIR}/../resources/POM/common.robot
Resource          ${CURDIR}/../resources/POM/loginPage.robot
Resource          ${CURDIR}/../resources/POM/cartPage.robot
Resource          ${CURDIR}/../resources/POM/checkOutPage.robot
Test Setup        Start Appium Session
Suite Setup       Load All Test Data


*** Test Cases ***
TC02001 - User dapat melihat produk dan dapat melakukan add to cart dan
    Wait Until Element Is Visible    accessibility_id=test-Username    timeout=15s
    Isi Form Login    
    ...    ${LOGIN_DATA['validLogin']['user_name']}
    ...    ${LOGIN_DATA['validLogin']['password']}
    Capture Page Screenshot
    Klik Tombol Login
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
    # [Teardown]    Close Application



