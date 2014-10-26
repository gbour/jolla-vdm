/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../lib/utils.js" as Utils

Page {
    id: commentsPage
    property var story

    SilicaListView {
        id: commentsListView
        //model: 20
        anchors.fill: parent

        header:
            Column {
            anchors.top: parent.top
            anchors.topMargin: 10
            height: titleitem.height + effect.height

            MyItem {
                id: titleitem

                author: commentsPage.story.author
                time: commentsPage.story.time
                location: commentsPage.story.location
                category: commentsPage.story.category
                story: commentsPage.story.text
                comments: comments.story.comments
                agreed: commentsPage.story.agree
                deserved: commentsPage.story.deserved
            }

            GlassItem {
                id: effect
                objectName: "menuitem"
                height: Theme.paddingLarge
                width: commentsPage.width
                falloffRadius: Math.exp(fpixw.value)
                radius: Math.exp(pixw.value)
                color: Theme.highlightColor
                cache: false
            }
        }


/*PageHeader {

            title: qsTr("Nested Page")*/
        //}

        model: ListModel {
            /*
            ListElement {
                author: "ArroZ"
                note: "+42"
                comment: "Peut-être qu'il organisait une fête surprise.. Mais non x)"
                depth: 0
                photo: "http://cdn.betacie.com/fmylife/data/fr/membres/mid/556c5b3ecdbd9930e4487c6cbacfc01a.jpg"
            }
            ListElement {
                author: "Mr. Citation"
                note: "-5"
                comment: "Il voulait organiser une fête surprise au début, mais il s'est vite rendu compte qu'avec un an de plus, le nombre de bougies ne tenaient plus sur le gâteau. Mais i
l est paré pour l'année prochaine, il achètera un gâteau plus gros."
                depth: 0
                photo: "http://cdn.betacie.com/fmylife/data/fr/membres/mid/02dde4b6beaee6e4cd5e183385a607e5.jpg"
            }
            ListElement {
                author: "skypok"
                note: "0"
                comment: "S'il est toujours la, le jours j"
                depth: 1
                photo: ""//"http://cdn.betacie.com/fmylife/data/fr/membres/mid/8193516d2db2e42ff958028ab447201e.jpg"
            }
            */
        }
        delegate: ListItem {
            CommentTmpl {
                avatar: model.photo
                comment: model.comment
                author: model.author
                note: model.note
                depth: model.depth
            }
        }

/*
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: qsTr("Item") + " " + index
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: console.log("Clicked " + index)
        }
        */
        VerticalScrollDecorator {}

        Component.onCompleted: {
            root.api.comments(8385693, function(xmltree) {
                console.log('comment loaded');

                var story = xmltree.getchild('root').getchild('items').getchild('item');
                var attrs = story.attrs;

                var author = story.getchild('author');
                attrs.author = author.attrs.cdata;

                // location formatting
                attrs.location = '';
                if(author.attrs.region !== '') {
                    attrs.location = author.attrs.region;
                }
                if(author.attrs.country !== 'France' || attrs.location.length === 0) {
                    attrs.location += (attrs.location.length > 0?', ':'') + author.attrs.country;
                }

                var dt = new Date(attrs.date);
                var hours = dt.getHours()+'';
                var mins = dt.getMinutes()+'';
                attrs.time = (hours.length==1?'0'+hours:hours)+':'+(mins.length==1?'0'+mins:mins);
                attrs.date = dt.toLocaleDateString();

                console.log(Utils.dump(attrs));
                commentsPage.story = attrs;

            });

        }
    }
}





