import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12


Rectangle {
    color: "transparent"
    property alias value: valor.text
    property alias checkColor: checkColorId.color
    Pane {
        id: numeroId
        anchors.centerIn: parent
        width: parent.width * 0.8
        height: parent.height * 0.7
        Material.elevation: 12
        padding: 0

        Text {
            id: valor
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: ""
            font.pointSize: 200
            minimumPointSize: 2
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

        }
        Rectangle {
            id: checkColorId
            color: Material.color(Material.Grey)
            anchors.bottom: parent.bottom
            width: numeroId.width
            height: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
