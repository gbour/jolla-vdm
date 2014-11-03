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
import "../lib/utils.js" as Utils

Page {
    id: commentsPage

    property int story_id
    property var story

    SilicaListView {
        id: commentsListView

        anchors {
            fill: parent

            top: parent.top
            topMargin: 100
        }

        header:
            Column {
            height: titleitem.height + effect.height

            MyItem {
                id: titleitem
                width: parent.width

                author: commentsPage.story.author
                time: commentsPage.story.time
                location: commentsPage.story.location
                category: commentsPage.story.category
                story: commentsPage.story.text
                comments: commentsPage.story.comments
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

        model: ListModel {
            id: commentsListModel
        }

        delegate: ListItem {
            CommentTmpl {
                avatar: model.photo
                comment: model.text
                author: model.author
                note: model.note
                depth: model.depth
            }
        }

        VerticalScrollDecorator {}

        Component.onCompleted: {
            console.log("loading "+story_id+" story,"+root);

            root.api.comments(story_id, function(xmltree) {
                console.log('comment loaded');
                //console.log(Utils.dump(xmltree));

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

                //console.log(Utils.dump(attrs));
                commentsPage.story = attrs;

                var comments = xmltree.getchild('root').getchild('comments');
                commentsListModel.clear()

                for(var i in comments.childs) {
                    var comment = comments.childs[i];
                    console.log(Utils.dump(comment));

                    attrs = comment.attrs;
                    author = comment.getchild('author');

                    attrs.photo = author.attrs.photo;
                    attrs.author = author.attrs.cdata
                    attrs.depth= 0;
                    if('in_reply_to' in attrs) {
                        attrs.depth=1;
                    }

                    var c = comment.getchild('thumbs')
                    attrs.note = c?c.attrs.cdata:attrs.thumbs;

                    commentsListModel.append(attrs);
                }
            });

        }
    }
}





