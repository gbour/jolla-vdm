import QtQuick 2.0
import Sailfish.Silica 1.0
//import QtGraphicalEffects 1.0

Rectangle {
    id: storyView

    width: parent.width -10
    height: 100
    //border.width: 3
    //border.color: "#81C6DC" //"black"
    radius: 20

    //color: "#FFFFFFFFF00"
    color: "transparent"


    //anchors.centerIn: parent

    property string author;
    property string location;
    property string time;
    property string category;
    property string story;
    property string comments;
    property string agreed;
    property string deserved;
/*
    Rectangle {
        id: avatar
        height: 40
        width: 40
        //radius: 40

        x: 20
        y: -15

        //border.color: "black"
        border.color: parent.border.color
        border.width: 3

        Image {
            source: '../res/icon.png'
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            anchors {
                fill: parent
                margins: 1
            }
        }
    }
*/
    Image {
        id: category
        source: '../res/categories/'+parent.category+'.png'
        width: 20
        height: 20

        anchors {
            left: story.left
            bottom: story.top
        }

    }

    Label {
        id: username
        //text: "Pretty Girl"
        //text: model.author.author
        text: parent.author
        font.pixelSize: Theme.fontSizeSmall - 6
        font.bold: true
        //color: "black"

        anchors {
            left: category.right //parent.left //avatar.right
            top: parent.top

            leftMargin: 10
            topMargin: 3

        }
    }

    Label {
        id: location
        text: '(' + parent.location + ')'
        font.pixelSize: Theme.fontSizeSmall - 8
        font.italic: true
        //color: "black"

        anchors {
            right: date.left
            rightMargin: 5

            top: parent.top
            topMargin: 3
        }
    }

    Label {
        id: date
        text: parent.time //"28/09 14:35"
        //color: "black"
        font.pixelSize: Theme.fontSizeSmall - 8
        font.italic: true
        //horizontalAlignment: Text.AlignRight

        anchors {
            right: parent.right
            top: parent.top

            rightMargin: 10
            topMargin: 3

        }

        /*
        Component.onCompleted: {
            console.log("> " + parent.right + "," + parent.width)
        }
        */
    }

    Label {
        id: story
        //text: "Aujourdh'ui, mon mari hypocondriaque porte en permanence la ceinture de son cardiofréquencemètre de course à pied pour vérifier qu'il n'est pas en train de mourir. VDM"
        text: parent.story
        textFormat: Text.RichText
        font.pixelSize: Theme.fontSizeSmall - 6
        wrapMode: Text.WordWrap

        horizontalAlignment: Text.AlignLeft

        anchors {
            //horizontalCenter: parent.horizontalCenter
            //verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            top: parent.top
            //bottom: parent.bottom

            leftMargin: 10
            rightMargin: 10
            topMargin: 30
            //bottomMargin: 10

        }

        Component.onCompleted: {
            console.log("story changed")
            storyView.onCompleted();
        }

        onContentHeightChanged:  {
            console.log("story height changed")
            ///storyView.onCompleted();
            storyView.height = story.height + story.anchors.topMargin + 40

        }

    }

    Image {
        id: popup
        source: '../res/comments.png'
        width: 20
        height: 20

        anchors {
            bottom: thumbup.bottom
            //bottomMargin: 13
            left: parent.left
            leftMargin: 20
        }
    }

    Label {
        id: comments
        text: parent.comments //"42"
        font.pixelSize: Theme.fontSizeSmall - 8
        font.italic: true

        anchors {
            bottom: thumbup.bottom
            //bottomMargin: -3
            left: popup.right
            leftMargin: 3
            //rightMargin: 10
        }
    }

    Image {
        id: thumbup
        source: '../res/thumb-up50.png'
        width: 20
        height: 20

        anchors {
            bottom: parent.bottom
            bottomMargin: 13
            right: agreed.left
            rightMargin: 0
        }
    }

    Label {
        id: agreed
        text: parent.agreed //"47345"
        font.pixelSize: Theme.fontSizeSmall - 8
        font.italic: true

        anchors {
            bottom: thumbup.bottom
            bottomMargin: -3
            right: thumbdown.left
            rightMargin: 10
        }
    }

    Image {
        id: thumbdown
        source: '../res/thumb-down50.png'
        width: 20
        height: 20

        anchors {
            bottom: thumbup.bottom
            bottomMargin: -7
            right: deserved.left
            rightMargin: 0
        }
    }

    Label {
        id: deserved
        text: parent.deserved //"143"
        font.pixelSize: Theme.fontSizeSmall - 8
        font.italic: true

        anchors {
            bottom: thumbup.bottom
            bottomMargin: -3
            right: date.right
            rightMargin: 0
        }
    }

        /*
        Label {
            id: comments
            text: "42"
        }

*/
    /*
        OpacityMask {

        }
        */

    Component.onCompleted: {
        console.log("storyView completed");
        //console.log(parent.height + "," + height + "," + parent.id + ',' + story.height)
        height = story.height + story.anchors.topMargin + 40
        //parent.height = height + 20

        //console.log(model.author)
        console.log(model.category)
    }
}
