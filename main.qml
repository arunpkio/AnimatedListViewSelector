import QtQuick 2.7
import QtQuick.Controls 1.5

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 400
    title: qsTr("Hello World")

    property int itemWidth: 50
    property int itemHeightMax: 110

    Rectangle {
        id: tracker
        width: view.width
        height: 50
        z: 2
        color: "transparent"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        MouseArea {
//            hoverEnabled: true    //uncomment this line to activate the feature on hovering mouse
            anchors.fill: parent
            onClicked: {
                var offset = tracker.width / 12
                var indx = mouse.x / offset
                view.currentIndex = indx
                preview.color = view.currentItem.color
            }

            onPositionChanged: {
                var offset = tracker.width / 12
                var indx = mouse.x / offset
                view.currentIndex = indx
                preview.color = view.currentItem.color
            }
            onReleased: {
                preview.color = view.currentItem.color
            }
        }
    }

    ListView {
        id: view
        model: new Array(1,2,3,4,5,6,7,8,9,10,11,12)
        height: itemHeightMax
        delegate: item
        anchors {
            top: parent.top;
            topMargin: 10;
            horizontalCenter: parent.horizontalCenter;
        }
        width: model.length * itemWidth + (model.length - 1) * spacing
        spacing: 2
        orientation: Qt.Horizontal
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.ApplyRange
        interactive: false
        Component.onCompleted: currentIndex = -1;
    }

    Rectangle {
        id: preview
        z: 5
        anchors.top: view.bottom
        width: view.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
    }

    Component {
        id: item
        Rectangle {
            id: itemrect
            width: itemWidth
            color: getRandomColor()
            height: if (ListView.isCurrentItem)
                    {
                        if (view.flickingHorizontally)
                        {
                            90
                        }
                        else
                        {
                            itemHeightMax
                        }
                    } else {
                        if ( view.currentIndex==-1)
                        {
                            90
                        } else {
                            90
                        }
                    }

            Behavior on height { SpringAnimation { spring: 4; damping: 0.4 } }
            Text {
                anchors.centerIn: parent
                text: model.index
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (!ListView.isCurrentItem)
                        view.currentIndex = index;
                    else
                        view.currentIndex = -1;
                }
            }
        }
    }

    function getHeight()
    {
        var height
        if (ListView.isCurrentItem) {
            if (view.flickingHorizontally) {
                height = 90
            }
            else
            {
                height = itemHeightMax
            }
        } else {
            if ( view.currentIndex==-1) {
                height = 90
            } else {
                height = 90
            }
        }
        return height
    }

    function getRandomColor() {
        var letters = '0123456789ABCDEF';
        var color = '#';
        for (var i = 0; i < 6; i++ ) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }
}
