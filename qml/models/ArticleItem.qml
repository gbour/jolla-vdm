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
        api.list(0, function(items) {
            // remove all articles
            clear();

            for (var idx in items) {
                var item = items[idx];
                console.log('item=' + item + ","  + typeof(item))
                console.log(item.id);

                item.date = new Date(item.date).toLocaleDateString();
                item.author_name = item.author.author;
                item.author = undefined;
                console.log(Utils.dump(item));

                append(item);
                //break;
            }

            onComplete();
        });
    }
}
