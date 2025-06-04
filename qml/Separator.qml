import QtQuick

// Decorative line between buttons in the Temperature Screens (LandscapeTemperature.qml, TemperatureDriver.qml and TempraturePassenger.qml)
Rectangle {
    color: "#ffffff"

    gradient: Gradient {
        orientation: Gradient.Vertical
            GradientStop { position: 0; color: "#ffffff" }
            GradientStop { position: 0.45; color: "#302f2f" }
            GradientStop { position: 0.9; color: "#000000" }
    }
}
