import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: raiz
    visible: true
    width: 1280
    height: 800
    title: qsTr("Universo")
    Material.theme: Material.Dark
    Material.background: "#FFFFFF"
    Material.accent: "#4F4F4F"
    Material.foreground: "#4F4F4F"

    property var campos: [campo1, campo2, campo3, campo4, campo5, campo6]
    property int campoAlvo: 0
    property var numeroSorteado: geraNumeroSorteado()
    property int tentativas: 1

    function geraNumeroSorteado() {
        var numeros = [0,1,2,3,4,5,6,7,8,9];
        var resultado = "";
        for(var i=0; i<6; i++){
            resultado += numeros.splice(Math.floor(Math.random() * numeros.length), 1);
        }
        return resultado;
    }

    function resetAll() {
        for(var i=0; i<btnsId.children.length; i++){
            if(!!btnsId.children[i].text)
                btnsId.children[i].enabled = true
        }
        for(var j=0; j<campos.length; j++){
            campos[j].value = ""
            campos[j].checkColor = Material.color(Material.Grey)

        }
        if(tentativas === 100){
            tentativas = 1
            numeroSorteado = geraNumeroSorteado()
        }
        tentativas++
        root.forceActiveFocus()
    }

    function verificaSeGanhou(){
        var result = campo1.value + campo2.value + campo3.value + campo4.value + campo5.value + campo6.value
        print("Tentativa...")

        for(var i = 0; i < campos.length; i++){
            if(campos[i].value === numeroSorteado.toString()[i]){
                campos[i].checkColor = Material.color(Material.Green)
            } else {
                campos[i].checkColor = Material.color(Material.Red)
            }
        }

        if(result === numeroSorteado.toString())
            print("GANHOUUU")
        else
            print("Não GANHOUUU")
        resetTimer.start()
    }

    Timer {
        id: resetTimer
        interval: 2000
        repeat: false
        onTriggered: resetAll()
    }

    function checkCampo(index) {
        if(campos[campoAlvo].value === ""){
            campos[campoAlvo].value = index
            if(campoAlvo == 5){
                tecladoId.visible = false
                campoAlvo = 0
                verificaSeGanhou()
            }
        } else {
            campoAlvo++
            checkCampo(index)
        }
    }

//    Rectangle {
//        width: 100
//        height: width
//        color: "red"
//        MouseArea {
//            anchors.fill: parent
//            onClicked: tecladoId.visible = true
//        }
//    }

    Rectangle {
        id: root
        width: parent.width
        height: parent.height * 0.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -parent.height * 0.10
        focus: true

        Keys.onPressed: {
            if(event.key === Qt.Key_Plus)
                tecladoId.visible = true
        }

        RowLayout {
            id: linhaCampoId
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            Campo {
                id: campo1
                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.15
            }

            Campo {
                id: campo2
                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.15
            }

            Campo {
                id: campo3
                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.15
            }

            Campo {
                id: campo4
                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.15
            }

            Campo {
                id: campo5
                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.15
            }

            Campo {
                id: campo6
                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.15
            }

        }
    }

    Rectangle {
        id: tecladoId
        y: parent.height
        color: Material.color(Material.Brown)
        width: parent.width
        height: parent.height * 0.3
        visible: false

        states: State {
            name: "visible"
            when: tecladoId.visible == true
            PropertyChanges {
                target: tecladoId
                y: raiz.height-height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }


        RowLayout {
            id: btnsId
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            Repeater {
                model: 10

                delegate: Button {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredHeight: parent.height * 0.40
                    Layout.preferredWidth: parent.width * 0.08
                    text: index
                    font.pixelSize: 34
                    Material.elevation: 12
                    Material.background: Material.Orange
                    onClicked: {
                        enabled = false
                        checkCampo(index)
                        print(numeroSorteado)
                    }
                }
            }
        }
    }
}
