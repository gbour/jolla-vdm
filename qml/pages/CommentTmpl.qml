import QtQuick 2.0
import Sailfish.Silica 1.0
//import QtGraphicalEffects 1.0

Rectangle {
    width: parent.width -10
    height: Math.max(avatar.height, comment.height) + 20
    radius: 20
    //border.color: "white"
    //border.width: 3

    color: "transparent"

    anchors.centerIn: parent

    property string avatar;
    property string comment;
    property string author;
    property string note;
    property int depth;

    Image {
        id: avatar
        source: parent.avatar
        //source: "../res/joker.png"
        //width: 60
        height: 60
        fillMode: Image.PreserveAspectFit

        anchors {
            left: parent.left
            top: parent.top
            topMargin: 5
            leftMargin: 10 + (depth > 0 ? 40:0)
        }

        //onSourceChanged: if(source == "") { source = "../res/joker.png" }

        Component.onCompleted: {
            console.log("source="+source + ',' + (parent.avatar === ""))

            if(parent.avatar === "") {
                source = "../res/default_avatar3.png"
            }
        }
    }

    Label {
        id: comment
        text: parent.comment
        textFormat: Text.RichText
        font.pixelSize: Theme.fontSizeSmall - 6
        wrapMode: Text.WordWrap

        horizontalAlignment: Text.AlignLeft

        anchors {
            left: avatar.right
            right: parent.right
            top: parent.top

            leftMargin: 10
            rightMargin: 10
            //topMargin: 10
        }
    }

    Label {
        id: author
        text: parent.author
        font.pixelSize: Theme.fontSizeSmall - 10
        font.italic: true

        anchors {
            top: comment.height < 60 ? avatar.bottom : comment.bottom
            left: avatar.left

            topMargin: 3
            leftMargin: 0
        }
    }

    Image {
        id: thumb
        source: '../res/thumb-' + (parseInt(parent.note)>=0?"up":"down") +'50.png'
        width: 20
        height: 20

        anchors {
            top: author.top
            right: note.left
            rightMargin: 0
        }
    }

    Label {
        id: note
        text: parent.note
        font.pixelSize: Theme.fontSizeSmall - 8
        font.italic: true

        anchors {
            bottom: thumb.bottom
            right: comment.right
            rightMargin: 0
        }
    }
    Component.onCompleted: {
        /*
        height = comment.height + comment.anchors.topMargin + 40*/
        parent.height = height + 20

    }

}
