import QtQuick

Rectangle {
    id: root
    color: "#000000"

    CustomText {
        id: test
        text: backend ? backend.dateString() : "Brak danych"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

    }


    // WebEngineView {
    //     id: webView
    //     anchors.fill: parent
    //     url: "https://www.example.com"
    // }



}
