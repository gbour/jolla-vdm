/*
 * HTML5 Parser By Sam Blowes
 *
 * Designed for HTML5 documents
 *
 * Original code by John Resig (ejohn.org)
 * http://ejohn.org/blog/pure-javascript-html-parser/
 * Original code by Erik Arvidsson, Mozilla Public License
 * http://erik.eae.net/simplehtmlparser/simplehtmlparser.js
 *
 * // Use like so:
 * HTMLParser(htmlString, {
 *     start: function(tag, attrs, unary) {},
 *     end: function(tag) {},
 *     chars: function(text) {},
 *     comment: function(text) {}
 * });
 *
 * // or to get an XML string:
 * HTMLtoXML(htmlString);
 *
 * // or to get an XML DOM Document
 * HTMLtoDOM(htmlString);
 *
 * // or to inject into an existing document/DOM node
 * HTMLtoDOM(htmlString, document);
 * HTMLtoDOM(htmlString, document.body);
 *
 */

var XMLParser;

(function () {

	// Regular Expressions for parsing tags and attributes
    //var startTag = /^<([-A-Za-z0-9_]+)((?:\s+[a-zA-Z_:][-a-zA-Z0-9_:.]+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/,
    var startTag = /^<([-A-Za-z0-9_]+)((?:\s+[^\s=>]+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/,
        endTag = /^<\/([-A-Za-z0-9_]+)[^>]*>/,
		attr = /([a-zA-Z_:][-a-zA-Z0-9_:.]+)(?:\s*=\s*(?:(?:"((?:\\.|[^"])*)")|(?:'((?:\\.|[^'])*)')|([^>\s]+)))?/g;

    XMLParser = function (html, handler) {
		var index, chars, match, stack = [], last = html;
		stack.last = function () {
			return this[this.length - 1];
		};

		while (html) {
			chars = true;

            console.log('start= ' + html.substring(0,10) + ',' + stack.last());
			// Make sure we're not in a script or style element
            if (!stack.last() || true) {
                //console.log("CC2")
                if( html.indexOf("<?xml") == 0) {
                    console.log("xml")
                    var end = html.indexOf(">");
                    html = html.substring(end+1);
                    chars=false
                }

				// Comment
                else if (html.indexOf("<!--") == 0) {
					index = html.indexOf("-->");

					if (index >= 0) {
						if (handler.comment)
							handler.comment(html.substring(4, index));
						html = html.substring(index + 3);
						chars = false;
					}

					// end tag
				} else if (html.indexOf("</") == 0) {
					match = html.match(endTag);

					if (match) {
						html = html.substring(match[0].length);
						match[0].replace(endTag, parseEndTag);
						chars = false;
					}

					// start tag
				} else if (html.indexOf("<") == 0) {
					match = html.match(startTag);
                    console.log("star tag:" + match + "," + html.substring(0, 20) )


					if (match) {
						html = html.substring(match[0].length);
						match[0].replace(startTag, parseStartTag);
						chars = false;
					}
				}

				if (chars) {
					index = html.indexOf("<");

					var text = index < 0 ? html : html.substring(0, index);
					html = index < 0 ? "" : html.substring(index);

					if (handler.chars)
						handler.chars(text);
				}

			} else {
                console.log('plop')
                html = html.replace(new RegExp("([\\s\\S]*?)<\/" + stack.last() + "[^>]*>"),
                                    function (all, text) {
					text = text.replace(/<!--([\s\S]*?)-->|<!\[CDATA\[([\s\S]*?)]]>/g, "$1$2");
					if (handler.chars)
						handler.chars(text);

					return "";
				});

				parseEndTag("", stack.last());
			}

            //console.log('start2= ' + html.substring(0,10));
			if (html == last)
                throw "Parse Error: ";// + html;
			last = html;
		}

		// Clean up any remaining tags
		parseEndTag();
        if(handler.result) {
            return handler.result()
        }

		function parseStartTag(tag, tagName, rest, unary) {
			tagName = tagName.toLowerCase();
            //console.log('parseStartTag:'+ tagName + ',' + rest + ',' + unary);

            /*
			if (block[tagName]) {
				while (stack.last() && inline[stack.last()]) {
					parseEndTag("", stack.last());
				}
            }*/

            /*
			if (closeSelf[tagName] && stack.last() == tagName) {
				parseEndTag("", tagName);
            }*/

            //unary = empty[tagName] || !!unary;

            if (!unary)
				stack.push(tagName);

			if (handler.start) {
                var attrs = {};

				rest.replace(attr, function (match, name) {
					var value = arguments[2] ? arguments[2] :
						arguments[3] ? arguments[3] :
						arguments[4] ? arguments[4] :
                        "";

                    //attrs.push({
                    /*
                    attrs[name] = {
						name: name,
						value: value,
						escaped: value.replace(/(^|[^\\])"/g, '$1\\\"') //"
                    };*/
                    attrs[name] = value;
				});

				if (handler.start)
					handler.start(tagName, attrs, unary);
			}
		}

		function parseEndTag(tag, tagName) {
			// If no tag name is provided, clean shop
			if (!tagName)
				var pos = 0;

				// Find the closest opened tag of the same type
			else
				for (var pos = stack.length - 1; pos >= 0; pos--)
					if (stack[pos] == tagName)
						break;

			if (pos >= 0) {
				// Close all the open elements, up the stack
				for (var i = stack.length - 1; i >= pos; i--)
					if (handler.end)
						handler.end(stack[i]);

				// Remove the open elements from the stack
				stack.length = pos;
			}
		}
	};

	function makeMap(str) {
		var obj = {}, items = str.split(",");
		for (var i = 0; i < items.length; i++)
			obj[items[i]] = true;
		return obj;
	}
})();
