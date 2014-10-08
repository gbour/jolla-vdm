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

ListItem {
    //x: Theme.paddingSmall
    //width: parent.width - 2*Theme.paddingSmall
    //height: childrenRect.height * 1.7
    // how it is computed ?
    //height: childrenRect.height * 2
    ///height: Math.max(icon.height, title.height+subtitle.height) + 15
    //implicitHeight: Math.max(icon.implicitHeight, (title.implicitHeight+subtitle.implicitHeight))

    property string link;

    //height: 120
    //height: children.height

    MyItem {
        author: model.author;
        time: model.time;
        category: model.category;
        story: model.text;
        comments: model.comments;
        agreed: model.agree;
        deserved: model.deserved;
    }

}
