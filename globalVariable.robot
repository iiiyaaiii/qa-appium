*** Variables ***
#Device Settings
${REMOTE_URL}                 http://127.0.0.1:4723/wd/hub
${PLATFORM_ANDROID}           Android
${PLATFORM_VERSION}           7.0
${DEVICE_NAME}                AY8HT4EYFYGEEIQG

#Driver App
${DRIVER_APP_PACKAGE}         asia.sendit.driver2stagestaging
${DRIVER_APP_ACTIVITY}        asia.sendit.driver2stagelib.activity.LoginActivity
${driver_logout_btn}          id=txt_menu_logout

#Leader App
${LEADER_APP_PACKAGE}         asia.sendit.leader2stage
${LEADER_APP_ACTIVITY}        asia.sendit.leader2stagelib.activity.view.LoginActivity

#Element
${PERMISSION_ALLOW}           id=com.android.packageinstaller:id/permission_allow_button
${ALLOW_GPS}                  id=android:id/button1
${username}                   id=edt_username
${password}                   id=edt_password
${login_btn}                  id=txt_login
${select_company}             id=spinner
${Driver_logo_sendit}         id=img_logo
${money_amount}               id=txt_money_collected
${deposit_btn}                id=layout_deposit
