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

Page {
    id: about

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height
        contentWidth: column.width

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column


            PageHeader {
                title: qsTr("About «VDM»")
            }

            Label {
                x: Theme.paddingLarge
                width: about.width - 2*Theme.paddingLarge

                text: qsTr("
                    version %1, released at %2 (git %3).<br/>
                    <br/>
                    The VDM Jolla application is developed by <a href=\"http://guillaume.bour.cc\">Guillaume Bour</a>, </br>
                    and distributed under GPLv3 license.<br/>
                    You are welcome to download source code at <a href=\"https://github.com/gbour/jolla-vdm\">github.com/gbour/jolla-vdm</a> and contribute.
                    <br/><br/>
                    <img src=\"../res/logo-about.png\" />
                    VDM Logo and name are properties of Beta&Cie, editor of <a href=\"http://www.viedemerde.fr\">VieDeMerde</a> website.<br/>
                    Stories are displayed as posted by their authors.<br/>
                    <br/>
                    Additional credits:
                    <ul>
                      <li><b>thumbup</b> and <b>thumbdown</b> icons by <a href=\"https://openclipart.org/detail/192852/thumbs-up-by-savanaprice-192852\">SavanaPrice (Opencliparts)</a></li>
                      <li><b>default avatar</b> by <a href=\"https://openclipart.org/detail/21196/anonymous-by-buggi\">buggi (Opencliparts)</a></li>
                      <li><b>work category icon</b> from <a href=\"https://openclipart.org/detail/35299/tango-preferences-desktop-theme-by-warszawianka\">Tango iconset</a></li>
                      <li><b>animals category icon</b> by <a href=\"https://openclipart.org/detail/85909/cat--5-by-inky2010\">inky2010 (OpenCliparts)</a></li>
                      <li><b>childs category icon</b> by <a href=\"https://openclipart.org/detail/189272/baby-pictogram-by-libberry-189272\">libberry (OpenCliparts)</a></li>
                      <li><b>transport category icon</b> by <a href=\"https://openclipart.org/detail/66751/beach-ball\">rg1024 (OpenCliparts)</a></li>
                      <li><b>holidays category icon</b> by <a href=\"https://openclipart.org/detail/173654/train-pictogram\">libberry (OpenCliparts)</a></li>
                      <li><b>geek category icon</b> by <a href=\"https://openclipart.org/detail/151627/nerd-with-glasses\">darrenbeck (OpenCliparts)</a></li>
                      <li><b>love (U+1F49D) and sex (U+1F48B) categories icons</b> from UniversaliaPlus font (© OSR Labs)</li>
                    </ul>"
                ).arg(APP_VERSION).arg(BUILD_DATE).arg(GIT_VERSION)

                textFormat: Text.RichText
                //color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeSmall//Medium
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignJustify

                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }
}
