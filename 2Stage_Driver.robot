*** Settings ***
Library                 AppiumLibrary
Library                 String
Suite Setup             Open Driver app and select company
Suite Teardown          Close All Applications
Resource                globalVariable.robot
Resource                input_data.robot

*** Variables ***
${logo_sendit}            id=img_logo
${menu_more}              xpath=//android.widget.ImageView[@content-desc="ตัวเลือกเพิ่มเติม"]
${menu_profile}           xpath=/hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.ListView/android.widget.LinearLayout[1]
${menu_neworder}          xpath=/hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.ListView/android.widget.LinearLayout[2]
${drivername_profile}     id=txt_name
${driver_logout_btn}      id=txt_logout
${driver_confirm_logout}  id=button1
${select_bag_item}        xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.RelativeLayout[2]/android.view.ViewGroup/android.widget.ViewSwitcher/android.support.v7.widget.RecyclerView/android.widget.FrameLayout[2]/android.widget.LinearLayout/android.widget.LinearLayout
${select_bag_btn}         id=asia.sendit.driver2stagestaging:id/txt_select_bag
${sequence_item}          id=asia.sendit.driver2stagestaging:id/layout_sequence
${bag_routemap}           id=asia.sendit.driver2stagestaging:id/action_job_map
${sequence_phone_icon}    id=ic_call
${sequence_recipientname}     id=txt_name
${sequence_recipient_phoneno}   id=txt_tel
${cancel_callbtn}         id=txt_cancel
${call_button}            id=txt_call
${sequence_recipient_address}   id=txt_address
${sequence_map}           xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.ScrollView/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout[2]/android.widget.LinearLayout[1]/android.widget.TextView[2]
${sequence_prefertime}          id=txt_prefer_time
${sequence_note}          id=txt_note
${parcels_layout}         id=tableLayout

*** Keywords ***
Open Driver app and select company
    Open Application   ${REMOTE_URL}     platformName=${PLATFORM_ANDROID}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}         appPackage=${DRIVER_APP_PACKAGE}    appActivity=${DRIVER_APP_ACTIVITY}
    Click Element        ${PERMISSION_ALLOW}
    Sleep  3s
    Click Element        ${PERMISSION_ALLOW}
    Sleep  3s
    Click Element        ${PERMISSION_ALLOW}
    Sleep  3s
    Click Element        ${PERMISSION_ALLOW}
    Sleep  3s
    Click Element        ${PERMISSION_ALLOW}
    Sleep  1s
    Click Element        ${ALLOW_GPS}
    Go Back
    Sleep  3s
    Select company       '${Driver_company}'
    Click Element         ${login_btn}

Input Driver username and password then login
    Input Text            ${username}        ${Driver_username}
    Hide Keyboard
    Input Password        ${password}        ${Driver_password}
    Hide Keyboard
    Click Element         ${login_btn}
    Sleep  10s
    ${has_update} = 		Run Keyword And Return Status        Element Is Visible    id=txt_download
    Run Keyword If      '${has_update}' == 'True'      Install new version

Install new version
    Click Element       id=txt_download
    Wait Until Element Is Visible         id=ok_button     5s
    Click Element       id=ok_button
    Click Element       id=button1
    Click Element       id=launch_button

Select company        [Arguments]       ${company}
    Click Element     ${select_company}
    Click Element     xpath=//*[contains(@text,${company})]

Check display parcels correct amount
    ${parcels_amount_txt}      Get Text      id=txt_item
    ${parcels_amount} =       Get Substring   ${parcels_amount_txt}     1   2
    ${parcel_items} =     Get Matching Xpath Count    xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.ScrollView/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.widget.TableLayout/android.widget.TableRow
    Should Be Equal     ${parcels_amount}       ${parcel_items}

Logout from Driver app
    Wait Until Element Is Visible       ${menu_more}        5s
    Click Element         ${menu_more}
    Sleep  2s
    Click Element         ${menu_profile}
    Wait Until Element Is Visible         ${drivername_profile}       5s
    Click Element         ${driver_logout_btn}
    Click Element         ${driver_confirm_logout}

*** Test Cases ***
Display alert message not selecting company
    Go Back
    Sleep  3s
    Click Element      ${login_btn}
    ${toast_text} =    Get Text    xpath=//android.widget.Toast
    Log To Console        ${toast_text}

Select company and login as Driver
    Input Driver username and password then login
    Element Should Be Visible             ${logo_sendit}
    Element Should Be Visible             ${money_amount}
    Element Should Be Visible             ${deposit_btn}

# Login fail not input username
#     Input Password        ${password}        ${Driver_password}
#     Hide Keyboard
#     Click Element         ${login_btn}
#     Page Should Contain Text     Username or Password not found

Login then logout from Driver app
    Logout from Driver app

Click into Bag to view detail
    Select company       '${Driver_company}'
    Click Element         ${login_btn}
    Input Driver username and password then login
    Click Element         ${select_bag_item}
    Page Should Contain Element         ${sequence_item}
    Element Should Be Visible           ${bag_routemap}
    Element Should Be Visible           ${menu_more}
    Element Should Be Visible           ${select_bag_btn}
    Go Back

# View Bag route map
#     Input Driver username and password then login
#     Click Element         ${select_bag_item}
#     Click Element         ${bag_routemap}

View recipient phone number and call
    Click Element         ${select_bag_item}
    Click Element         ${sequence_phone_icon}
    Element Should Be Visible         ${sequence_recipientname}
    Element Should Be Visible         ${sequence_recipient_phoneno}
    Element Should Be Visible         ${cancel_callbtn}
    Element Should Be Visible         ${call_button}
    Click Element         ${cancel_callbtn}
    Go Back

Select Sequence
    Click Element         ${select_bag_item}
    Click Element         ${sequence_item}
    Sleep  3s
    Element Should Be Visible         ${sequence_recipientname}
    Element Should Be Visible         ${sequence_phone_icon}
    Element Should Be Visible         ${sequence_recipient_address}
    Element Should Be Visible         ${sequence_map}
    Element Should Be Visible         ${sequence_prefertime}
    Element Should Be Visible         ${sequence_note}
    Element Should Be Visible         ${parcels_layout}
    Element Should Be Visible         ${menu_more}
    Element Should Be Visible         ${select_bag_btn}
    Check display parcels correct amount
