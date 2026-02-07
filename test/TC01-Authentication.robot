*** Settings ***
Resource          ${CURDIR}/../resources/utils/common.robot
Resource          ${CURDIR}/../resources/POM/sideBar.robot
Suite Setup       Load All Test Data

*** Test Cases ***
TC01001 - User dapat melakukan login dengan valid
    [Setup]    Setup Login App    validLogin
    Capture Page Screenshot
    [Teardown]    Close Application

TC01002 - User tidak dapat melakukan login dengan invalid
    [Setup]    Setup Login App    invalidLogin
    Show Error Message
    Capture Page Screenshot
    [Teardown]    Close Application


TC01003 - User dapat melakukan logout
    [Setup]    Setup Login App    validLogin
    Klik Burger Menu
    Sleep    5s
    Klik Logout
    Capture Page Screenshot
    [Teardown]    Close Application

