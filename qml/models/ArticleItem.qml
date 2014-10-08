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
import "../lib/utils.js" as Utils

ListModel {
    id: model

    function init(api, onComplete) {
        /*
        api.comments(8386466, function(xml) {
            console.log(Utils.dump(xml));
        });
        return;
        */

        api.list(0, function(items) {
            //console.log('ITEMS=' + Utils.dump(items));
            items = items.getchild('root').getchild('items');
            if(items === undefined) {
                return;
            }

            // remove all articles
            clear();

            for (var i in items.childs) {
                var attrs = items.childs[i].attrs;

                attrs.author = items.childs[i].getchild('author').attrs.cdata;

                var dt = new Date(attrs.date);
                var mins = dt.getMinutes()+'';
                attrs.time = dt.getHours()+':'+(mins.length==1?'0'+mins:mins);
                attrs.date = dt.toLocaleDateString();
                //console.log(Utils.dump(attrs));

                append(attrs);
                //break;
            }

            onComplete();
        });
    }
}
