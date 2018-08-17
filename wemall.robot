*** Settings ***
Library                 AppiumLibrary
Suite Setup             Open browser and go to wemall website
Suite Teardown          Close All Applications
Resource                globalVariable.robot
Resource                input_data.robot

*** Variables ***
${DRIVER_APP_PACKAGE}       com.android.chrome
${DRIVER_APP_ACTIVITY}      com.google.android.apps.chrome.Main
${wemall_username}          pitchaya_ket@sendit.asia
${wemall_password}          Qa12345678
${login_menu}               xpath=//android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[2]/android.webkit.WebView/android.view.View[3]/android.view.View[2]/android.view.View[2]
${login_btn}                xpath=//android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[2]/android.webkit.WebView/android.view.View[6]/android.view.View[5]/android.widget.Button
${avartar_image}            xpath=//android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[2]/android.webkit.WebView/android.view.View[6]/android.view.View[5]/android.widget.Button
${user_menu}                xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[2]/android.webkit.WebView/android.view.View[3]/android.view.View[2]/android.view.View[2]/android.widget.Image
${user_menu_toggle}         xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[2]/android.webkit.WebView/android.view.View/android.view.View[1]/android.view.View/android.view.View[2]/android.view.View[2]/android.view.View[1]/android.widget.Image
${logout}                   xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout[2]/android.webkit.WebView/android.view.View/android.view.View[1]/android.view.View/android.view.View[2]/android.view.View[2]/android.view.View[2]/android.widget.ListView/android.view.View[3]/android.view.View
# ${fb_username}
# ${fb_password}

*** Keywords ***
Open browser and go to wemall website
    Open Application   ${REMOTE_URL}     platformName=${PLATFORM_ANDROID}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}         appPackage=${DRIVER_APP_PACKAGE}    appActivity=${DRIVER_APP_ACTIVITY}
    Click Element      id=com.android.chrome:id/terms_accept
    Sleep  2s
    CLick Element      id=com.android.chrome:id/next_button
    Click Element      id=com.android.chrome:id/positive_button
    Sleep  5s
    Click Element      id=com.android.chrome:id/more_button
    Click Element      id=com.android.chrome:id/positive_button
    Go To Url          https://wemall-dev.com
    Sleep  20s

Login to wemall
    Click Element       ${login_menu}
    Sleep  5s
    Wait Until Element Is Visible       id=login_user     10s
    Input Text        id=username       ${wemall_username}
    Input Password    id=password       ${wemall_password}
    Hide Keyboard
    Click Element     ${avartar_image}
    Sleep  5s

Login to wemall via Facebook
    Click Element     ${login_menu}
    Sleep  10s
    Click Element     xpath=//*[contains(@text,'Facebook')]
    Input Text        id=m_login_email            ${fb_username}
    Input Password    id=m_login_password         ${fb_password}
    Click Button      id=u_0_5
    Sleep  5s

Logout from wemall
    Click Element     ${user_menu}
    Sleep  5s
    Click Element     ${user_menu_toggle}
    Click Element     ${logout}

*** Test Cases ***
Access wemall website and login by user
    Login to wemall
    Logout from wemall

# Access wemall website and login via Facebook
#     Login to wemall via Facebook

Access wemall website and login by shop owner
    Login to wemall
    Logout from wemall
