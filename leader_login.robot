*** Settings ***
Library                 AppiumLibrary
Suite Setup             Login to Leader App
Suite Teardown          Close All Applications
Resource                globalVariable.robot
Resource                input_data.robot

*** Variables ***
#Element
${app_viewgroup}      android.view.ViewGroup

*** Keywords ***
Login to Leader app
    # Open Application   ${REMOTE_URL}     platformName=Android    platformVersion=7.0    deviceName=emulator-5554         appPackage=asia.sendit.leader2stage    appActivity=asia.sendit.leader2stagelib.activity.view.LoginActivity
    Open Application   ${REMOTE_URL}     platformName=${PLATFORM_ANDROID}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}         appPackage=${LEADER_APP_PACKAGE}    appActivity=${LEADER_APP_ACTIVITY}
    Wait Until Page Contains Element      class=${app_viewgroup}        20s
    Click Element        ${PERMISSION_ALLOW}
    Sleep  3s
    Click Element        ${PERMISSION_ALLOW}
    Wait Until Page Contains Element      id=viewAnimator     10s
    Input Text           ${username}        ${Leader_username}
    Click Element        ${password}
    Input Password       ${password}        ${Leader_password}
    Hide Keyboard
    Click Element        ${login_btn}
    Wait Until Element Is Visible    id=alertTitle        10s
    # Element Text Should Be    id=alertTitle    Please select your location
    Capture Page Screenshot

Select location     [Arguments]     ${location_name}
    Click Element       xpath=//*[contains(@text,${location_name})]
    Element Should Be Visible       id=img_qrcode
    Capture Page Screenshot         filename = Leader_selected_location_result.png

*** Test Cases ***
Login and select location
    Select location       '${Location1}'

Change location
    Click Element         id=action_current_location
    Select location       '${Location2}'

Logout from Leader app
    Click Element         class=android.widget.ImageButton
    Click Element         ${driver_logout_btn}
