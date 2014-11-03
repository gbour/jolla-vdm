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

    comments: function(storyid, onComplete) {
        return this.__query('/view/' + storyid, {}, onComplete);
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
        //console.log('uri= ' + uri);
        //console.log('itm parser=' + FmlItem.parser + ',' + FmlItem.parser.start);
        //return;

        var http = new XMLHttpRequest();
        http.open("GET", uri, true);

        http.onreadystatechange = function() {
            if (http.readyState === XMLHttpRequest.DONE && http.status === 200) {
                //console.log(http.responseText)

                var items = XMLParser.XMLParser(http.responseText, new FmlItem());
                onComplete(items);

                //var articles = scraper.fetch(http.responseText);
                //callback(articles);
            }
        }

        http.send();
    }
}

var FmlItem = function() {
    this.__result =  [];
    this.__top    = {
        name: '<root>',
        childs:[],
        getchild: function(name) {
                for(var i = 0; i < this.childs.length; i++) {
                 if(this.childs[i].name === name) {
                        return this.childs[i];
                    }
                }

                return undefined;
            }
    };
}

FmlItem.prototype = {
    start: function(tag, attrs, unary) {
        //console.log('FmlItem::start= ' + tag + ',' + Utils.dump(this.__top));
        this.__tagname = tag;

        var parent = this.__top;

        this.__top = {
            name: tag,
            attrs: Utils.clone(attrs),
            childs: [],
            parent: parent,
            getchild: function(name) {
                //console.log("GETCHILD=" + this);
                for(var i = 0; i < this.childs.length; i++) {
                    if(this.childs[i].name === name) {
                        return this.childs[i];
                    }
                }

                return undefined;
            }
        };
        parent.childs.push(this.__top);        
    },

    end: function(tag) {
        /*
        if(this.__top) {
            this.__top = this.__top.parent;
        }
        */
        var node   = this.__top;
        var parent = node.parent;
        delete node.parent;

        // return length of pseudo-hashtables
        var hlen = function(o) {
            return Object.keys(o).length
        }

        var remove = function(arr, elt) {
            var idx = arr.indexOf(elt);
            arr.splice(idx,idx);
        }

        // tree optimizations
        // node w/o attrs and 1 cdata child:
        //  . no params => merged in parent as node.name => cdata.value
        //  . 1+ params => merged as node param
        if(node.childs.length === 1 && node.childs[0].name === 'cdata') {
            //console.log('cdata: ' + node.attrs + ',' + Object.keys(node.attrs).length + '>'+hlen(node.attrs) + ',' + Utils.dump(node))
            if(hlen(node.attrs) === 0) {
                //console.log('merge with parent')
                parent.attrs[node.name] = node.childs[0].cdata;

                remove(parent.childs, node);
            } else {
                //console.log('merge in node attrs')
                node.attrs.cdata = node.childs[0].cdata;
                delete node.childs[0];
            }
        }

        // node w/o attrs and childs: name => true
        if(hlen(node.attrs) === 0 && node.childs.length === 0) {
            parent.attrs[node.name] = undefined;
            remove(parent.childs, node);
        }


        this.__top = parent;
        //console.log('end:' + this.__top.name);
    },

    chars: function(text) {
        //console.log('text= ' + text);
        if(this.__top) {
            //console.log(Utils.dump(this.__top));
            this.__top.childs.push({name: 'cdata', cdata: text, attrs:[], childs:[]});
        }
    },

    result: function() {
        return this.__top;
    }
}

