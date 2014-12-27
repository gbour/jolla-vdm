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
import "pages"
import "logic/api.js" as Api

ApplicationWindow
{
    id: root

    initialPage: Component { ArticleList { } }
    //initialPage: Component { Comments { story_id: 1 } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    property var api: new Api.FmlApi(myglobal.uri, myglobal.locale, myglobal.apikey);
    property var comments:  Component { Comments {} }

    Component.onCompleted: {
        console.log("app started: " + myglobal.uri + "/" + myglobal.locale);
    }
}

