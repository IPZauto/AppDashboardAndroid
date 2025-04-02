cmake_minimum_required(VERSION 3.16)

project(AppDashboardAndroid VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Multimedia)


qt_add_executable(appAppDashboardAndroid
    main.cpp
    networkdata.h networkdata.cpp
    game.h game.cpp
)

qt_add_qml_module(appAppDashboardAndroid
    URI AppDashboardAndroid
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/CustomText.qml
        qml/TopBar.qml
        qml/MenuButton.qml
        qml/CustomMenuBar.qml
        qml/GlobeScreen.qml
        qml/MusicScreen.qml
        qml/NavScreen.qml
        qml/ReverseScreen.qml
        qml/PlayStopButton.qml
        qml/LandscapeMain.qml
        qml/PortraitMain.qml
        qml/Separator.qml
        qml/TemperatureScreen.qml
        qml/TemperatureDriver.qml
        qml/TemperaturePassenger.qml
        RESOURCES resources.qrc
)

qt_add_resources(appAppDashboardAndroid "resources"
    PREFIX /
    FILES
        resources/images/icon_globe1.png
        resources/images/icon_music.png
        resources/images/icon_nav.png
        resources/images/icon_reverse2.png
        resources/images/play_circle_icon.png
        resources/images/pause_circle_icon.png
        resources/images/arrow_back_icon.png
        resources/images/arrow_forward_icon.png
        resources/images/sound_icon_internet31.png
        resources/images/sound_icon_internet33.png
        resources/images/car_fan_low_left_icon.png
        resources/images/car_fan_low_mid_left_icon.png
        resources/images/car_fan_mid_left_icon.png
        resources/images/minus_icon.png
        resources/images/plus_icon.png
        resources/images/fan_icon.png
        resources/images/seat_heat_left_icon.png
	resources/images/steering_wheel_heat_icon.png
        resources/images/windshield_defrost_front_icon.png
        resources/images/windshield_defrost_rear_icon.png
        resources/sounds/Harry_Styles_-_Daylight.mp3
        resources/sounds/Harry_Styles_-_Satellite.mp3
        resources/sounds/Hozier_-_Too_Sweet.mp3
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appAppDashboardAndroid PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appAppDashboardAndroid
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appAppDashboardAndroid
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Multimedia
)

include(GNUInstallDirs)
install(TARGETS appAppDashboardAndroid
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
