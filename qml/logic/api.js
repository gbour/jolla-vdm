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

var FmlApi = function(base, language, key) {
    this.base     = base;
    this.language = language;
    this.key      = key;

}

FmlApi.prototype = {

    /*
      starts from 0
     */
    list: function(page) {
        return this.__query('/view/last/' + page, {})
    },


    __query: function(uri, params) {
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
    }
}
