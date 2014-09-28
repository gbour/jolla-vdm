/*
    This file is part of «VDM app».

    «VDM app» is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License.

    «NVDM app» is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with «VDM app».  If not, see <http://www.gnu.org/licenses/>.
*/

.import '../lib/xmlparser.js' as XMLParser
.import "../lib/utils.js" as Utils

var FmlApi = function(base, language, key) {
    this.base     = base;
    this.language = language;
    this.key      = key;

}

FmlApi.prototype = {

    /*
      starts from 0
     */
    list: function(page, onComplete) {
        return this.__query('/view/last/' + page, {}, onComplete)
    },


    __query: function(uri, params, onComplete) {
        var uri = this.base + uri + '?' +
                'language=' + this.language + '&' +
                'key='      + this.key;

        /*
        var _keys = keys(params);
        for(var i = 0; i < _keys.length; i++) {
            uri += '&' + _keys[i] + '=' + params[_keys[i]];
        }
        */        
        console.log('uri= ' + uri);
        console.log('itm parser=' + FmlItem.parser + ',' + FmlItem.parser.start);
        //return;

        var http = new XMLHttpRequest();
        http.open("GET", uri, true);

        http.onreadystatechange = function() {
            if (http.readyState === XMLHttpRequest.DONE && http.status === 200) {
                //console.log(http.responseText)

                var items = XMLParser.XMLParser(http.responseText, FmlItem.parser);
                onComplete(items);

                //var articles = scraper.fetch(http.responseText);
                //callback(articles);
            }
        }

        http.send();
    }
}

var FmlItem = function() {
}

FmlItem.parser = {
    __result: [],
    __top   : undefined,

    /*
    __result.last: function() {
        return this[this.length-1],
    },
    */

    start: function(tag, attrs, unary) {
        console.log('FmlItem::start= ' + tag + ',' + Utils.dump(this.__top));
        this.__tagname = tag;

        if(tag === 'root' || tag === 'items') {
            return;
        }
        else if(tag === 'item') {
            this.__top = {name: tag, obj: Utils.clone(attrs), parent: undefined};
            this.__result.push(this.__top.obj);

            console.log('>! ' + Utils.dump(this.__top));
        }
        else if(this.__top && this.__top.name === 'item') {
            if(Object.keys(attrs).length > 0) {
                this.__top.obj[tag] = Utils.clone(attrs);
                this.__top = {name: tag, obj: this.__top.obj[tag], parent: this.__top};
            } else {
                // we stack up the same object, with current tagname
                this.__top = {name: tag, obj: this.__top.obj, parent: this.__top};
            }
        }
    },

    end: function(tag) {
        if(this.__top) {
            this.__top = this.__top.parent;
        }

    },

    chars: function(text) {
        console.log('text= ' + text);
        if(this.__top) {
            console.log(Utils.dump(this.__top))
            this.__top.obj[this.__top.name] = text;
        }
    },

    result: function() {
        return this.__result;
    }
}
