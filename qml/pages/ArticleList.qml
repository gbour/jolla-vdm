/*
    This file is part of «NextINpact app».

    «NextINpact app» is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    «NextINpact app» is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with «NextINpact app».  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../models"

Page {
    id: articles

    Row {
        id: loader
        visible: false

        spacing: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        height: 200

        BusyIndicator {
            id: loader_bi
            running: false
            size: BusyIndicatorSize.Large
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    SilicaListView {
        id: mylistview
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
            MenuItem {
                text: qsTr("Refresh")
                onClicked: mylistview.refresh()
            }

        }
        // Tell SilicaFlickable the height of its content.
        //contentHeight: column.height
       // spacing: Theme.paddingMedium


        header: PageHeader {
            //title: ""
        }

        model: ArticleItem {}
        delegate: ArticleDelegate {
            onClicked: {
                console.log("clicked on " + model.id);
                var params = {
                    story_id: model.id
                }

                //pageStack.push(Qt.resolvedUrl("Comments.qml"), params, PageStackAction.Animated)
                pageStack.push(root.comments, params, PageStackAction.Animated)
            }
        }

        section {
            property: 'date'
            delegate: SectionHeader {
                text: section
                height: Theme.itemSizeExtraSmall
            }
        }

        VerticalScrollDecorator {}


        Component.onCompleted: {
            // initialize JS context
            refresh();
            //model.append({'category': 'yoyo', 'foo': { 'author': 'YOYO'}})
        }

        function refresh() {
            console.log("refreshing items list...");

            loader.visible = true; loader_bi.running = true;
            model.init(root.api, function()
                { loader.visible = false; loader_bi.running = false; }
            );

        }
    }
}

