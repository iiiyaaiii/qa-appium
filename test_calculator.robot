*** Settings ***
Library                 AppiumLibrary
Suite Teardown          Close All Applications

*** Variables ***
${REMOTE_URL}   http://127.0.0.1:4723/wd/hub

*** Keywords ***
TestStart
    Open Application   ${REMOTE_URL}     platformName=Android    platformVersion=7.0    deviceName=emulator-5554         appPackage=com.android.calculator2    appActivity=com.android.calculator2.Calculator
    Sleep  5s
    Click Element      id=digit_5
    Click Element      id=op_add
    Click Element      id=digit_5
    Click Element      id=eq
    Element Text Should Be      id=result     10
    Capture Page Screenshot     filename = Calculator_result.png

*** Test Cases ***
Test Case Example 1
    TestStart
