/*
    This file is part of «VDM app».

    «VDM app» is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    «VDM app» is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with «VDM app».  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
//import QtGraphicalEffects 1.0

Rectangle {
    id: storyView

    width: parent.width -10
    implicitHeight: story.height + story.anchors.topMargin + thumbup.height + thumbup.anchors.bottomMargin + 5
    //border.width: 3
    //border.color: "#81C6DC" //"black"

    color: "transparent"

    property string author;
    property string location;
    property string time;
    property string category;
    property string story;
    property string comments;
    property string agreed;
    property string deserved;

    property int fontsize: Theme.fontSizeSmall - 2

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
        text: parent.author
        font.pixelSize: fontsize //Theme.fontSizeSmall - 6
        font.bold: true

        anchors {
            left: category.right
            top: parent.top

            leftMargin: 10
            topMargin: 3

        }
    }

    Label {
        id: location
        text: '(' + parent.location + ')'
        font.pixelSize: fontsize - 4 //Theme.fontSizeSmall - 8
        font.italic: true

        anchors {
            right: date.left
            rightMargin: 5

            top: parent.top
            topMargin: 3
        }
    }

    Label {
        id: date
        text: parent.time
        font.pixelSize: fontsize - 4 //Theme.fontSizeSmall - 8
        font.italic: true

        anchors {
            right: parent.right
            top: parent.top

            rightMargin: 10
            topMargin: 3

        }
    }

    Label {
        id: story
        text: parent.story
        textFormat: Text.RichText
        font.pixelSize: fontsize //6
        wrapMode: Text.WordWrap

        horizontalAlignment: Text.AlignLeft

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top

            leftMargin: 10
            rightMargin: 10
            topMargin: 30
        }
    }

    Image {
        id: popup
        source: '../res/comments4.png'
        width: 20
        height: 20

        anchors {
            bottom: thumbup.bottom
            left: parent.left
            leftMargin: 20
            bottomMargin: 3
        }
    }

    Label {
        id: comments
        text: parent.comments //"42"
        font.pixelSize: fontsize - 4 //Theme.fontSizeSmall - 8
        font.italic: true

        anchors {
            bottom: thumbup.bottom
            left: popup.right
            leftMargin: 3
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
        text: parent.agreed
        font.pixelSize: fontsize - 4 //Theme.fontSizeSmall - 8
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
        font.pixelSize: fontsize - 4 //Theme.fontSizeSmall - 8
        font.italic: true

        anchors {
            bottom: thumbup.bottom
            bottomMargin: -3
            right: date.right
            rightMargin: 0
        }
    }
}
