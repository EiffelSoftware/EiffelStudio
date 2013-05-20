note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_URI_TEMPLATE_DRAFT

inherit
	TEST_URI_TEMPLATE

feature -- Expander	

	test_uri_template_string_builder
		note
			testing:  "uri-template"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
			empty_keys: HASH_TABLE [STRING, STRING]
			empty_list: ARRAY [STRING]
			favs: HASH_TABLE [detachable ANY, STRING]
			keys: HASH_TABLE [STRING, STRING]
			colors: ARRAY [STRING]
			names: ARRAY [STRING]
			semi_dot: HASH_TABLE [STRING, STRING]
			vals: ARRAY [STRING]
		do
			create ht.make (3)
			ht.force ("FooBar", "foo_id")
			ht.force ("That's right!", "extra")
			ht.force ("123", "id")
			ht.force ("California", "state")
			ht.force ("Goleta", "city")
			ht.force ("today", "day")

			ht.force ("value", "var")
			ht.force ("Hello World!", "hello")
			ht.force ("", "empty")
			ht.force ("/foo/bar", "path")
			ht.force ("1024", "x")
			ht.force ("768", "y")
			ht.force ("fred", "foo")
			ht.force ("That's right!", "foo2")
        	ht.force ("http://example.com/home/", "base")

        	names := <<"Fred", "Wilma", "Pebbles">>
        	ht.force (names, "name")
        	create favs.make (2)
        	favs.force ("red", "color")
        	favs.force ("high", "volume")
        	ht.force (favs, "favs")

			create empty_list.make_empty
			ht.force (empty_list,"empty_list")

			create empty_keys.make (0)
			ht.force (empty_keys,"empty_keys")

			vals := <<"val1", "val2", "val3">>
			ht.force (vals, "list")
        	create keys.make (2)
        	keys.force ("val1", "key1")
        	keys.force ("val2", "key2")
        	ht.force (keys, "keys")

			colors := <<"red", "green", "blue">>
			create semi_dot.make (3)
			semi_dot.force (";", "semi")
			semi_dot.force (".", "dot")
			semi_dot.force (",", "comma")

			create {ARRAYED_LIST [STRING]} uri_template_string_errors.make (10)


			--| Simple string expansion
			uri_template_string (ht, "{var}", "value")
			uri_template_string (ht, "{hello}", "Hello%%20World%%21")
			uri_template_string (ht, "O{empty}X", "OX")
			uri_template_string (ht, "O{undef}X", "OX")

			--| String expansion with defaults
			uri_template_string (ht, "{var=default}", "value")
			uri_template_string (ht, "O{empty=default}X", "OX")
			uri_template_string (ht, "O{undef=default}X", "OdefaultX")

			--| Reserved expansion with defaults
			uri_template_string (ht, "{+var}", "value")
			uri_template_string (ht, "{+hello}", "Hello%%20World!")
			uri_template_string (ht, "{+path}/here", "/foo/bar/here")
			uri_template_string (ht, "here?ref={+path}", "here?ref=/foo/bar")
			uri_template_string (ht, "up{+path}{x}/here", "up/foo/bar1024/here")
			uri_template_string (ht, "up{+empty=/1}/here", "up/here")
			uri_template_string (ht, "up{+undef=/1}/here", "up/1/here")

			--| String expansion with multiple variables
			uri_template_string (ht, "{x,y}", "1024,768")
			uri_template_string (ht, "{x,hello,y}", "1024,Hello%%20World%%21,768")
			uri_template_string (ht, "?{x,empty}", "?1024,")
			uri_template_string (ht, "?{x,undef}", "?1024")
			uri_template_string (ht, "?{undef,y}", "?768")
			uri_template_string (ht, "?{x,undef=0}", "?1024,0")

			--| Reserved expansion with multiple variables
			uri_template_string (ht, "{+x,hello,y}", "1024,Hello%%20World!,768")
			uri_template_string (ht, "{+path,x}/here", "/foo/bar,1024/here")
			--| Label expansion, dot-prefixed
			uri_template_string (ht, "X{.var}", "X.value")
			uri_template_string (ht, "X{.empty}", "X.")
			uri_template_string (ht, "X{.undef}", "X")

			--| Path segments, slash-prefixed
 			uri_template_string (ht, "{/var}", "/value")
 			uri_template_string (ht, "{/var,empty}", "/value/")
 			uri_template_string (ht, "{/var,undef}", "/value")

			--| Path-style parameters, semicolon-prefixed
			uri_template_string (ht, "{;x,y}", ";x=1024;y=768")
			uri_template_string (ht, "{;x,y,empty}", ";x=1024;y=768;empty")
			uri_template_string (ht, "{;x,y,undef}", ";x=1024;y=768")

			--| Form-style query, ampersand-separated
			uri_template_string (ht, "{?x,y}", "?x=1024&y=768")
			uri_template_string (ht, "{?x,y,empty}", "?x=1024&y=768&empty=")
			uri_template_string (ht, "{?x,y,undef}", "?x=1024&y=768")


			ht.force (colors, "list")
			ht.force (semi_dot, "keys")
			--| String expansion with value modifiers
			uri_template_string (ht, "{var:3}", "val")
			uri_template_string (ht, "{var:30}", "value")
			uri_template_string (ht, "{var^3}", "ue")
			uri_template_string (ht, "{var^-3}", "va")

			uri_template_string (ht, "{list}", "red,green,blue")
			uri_template_string (ht, "{list*}", "red,green,blue")
			uri_template_string (ht, "{keys}", "semi,%%3B,dot,.,comma,%%2C")
			uri_template_string (ht, "{keys*}", "semi=%%3B,dot=.,comma=%%2C")
			--| Reserved expansion with value modifiers
			uri_template_string (ht, "{+path:6}/here", "/foo/b/here")
			uri_template_string (ht, "{+list}", "red,green,blue")
			uri_template_string (ht, "{+list*}", "red,green,blue")
			uri_template_string (ht, "{+keys}", "semi,;,dot,.,comma,,")
			uri_template_string (ht, "{+keys*}", "semi=;,dot=.,comma=,")
			--| Label expansion, dot-prefixed
			uri_template_string (ht, "X{.var:3}", "X.val")
			uri_template_string (ht, "X{.list}", "X.red,green,blue")
			uri_template_string (ht, "X{.list*}", "X.red.green.blue")
			uri_template_string (ht, "X{.keys}", "X.semi,%%3B,dot,.,comma,%%2C")
			uri_template_string (ht, "X{.keys*}", "X.semi=%%3B.dot=..comma=%%2C")

			--| Path segments, slash-prefixed
			uri_template_string (ht, "{/var:1,var}", "/v/value")
			uri_template_string (ht, "{/list}", "/red,green,blue")
			uri_template_string (ht, "{/list*}", "/red/green/blue")
			uri_template_string (ht, "{/list*,path:4}", "/red/green/blue/%%2Ffoo")
			uri_template_string (ht, "{/keys}", "/semi,%%3B,dot,.,comma,%%2C")
			uri_template_string (ht, "{/keys*}", "/semi=%%3B/dot=./comma=%%2C")

   			--| Path-style parameters, semicolon-prefixed
			uri_template_string (ht, "{;hello:5}", ";hello=Hello")
			uri_template_string (ht, "{;list}", ";list=red,green,blue")
			uri_template_string (ht, "{;list*}", ";list=red;list=green;list=blue")
			uri_template_string (ht, "{;keys}", ";keys=semi,%%3B,dot,.,comma,%%2C")
			uri_template_string (ht, "{;keys*}", ";semi=%%3B;dot=.;comma=%%2C")

			--| Form-style query, ampersand-separated
			uri_template_string (ht, "{?var:3}", "?var=val")
			uri_template_string (ht, "{?list}", "?list=red,green,blue")
			uri_template_string (ht, "{?list*}", "?list=red&list=green&list=blue")
			uri_template_string (ht, "{?keys}", "?keys=semi,%%3B,dot,.,comma,%%2C")
			uri_template_string (ht, "{?keys*}", "?semi=%%3B&dot=.&comma=%%2C")

			assert ("all strings built", uri_template_string_errors = Void or (attached uri_template_string_errors as err and then err.is_empty))
		end


	test_uri_template_string_builder_extra
		note
			testing:  "uri-template"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
			empty_keys: HASH_TABLE [STRING, STRING]
			empty_list: ARRAY [STRING]
			favs: HASH_TABLE [detachable ANY, STRING]
			keys: HASH_TABLE [STRING, STRING]
			colors: ARRAY [STRING]
			names: ARRAY [STRING]
			semi_dot: HASH_TABLE [STRING, STRING]
			vals: ARRAY [STRING]
		do
			create ht.make (3)
			ht.force ("FooBar", "foo_id")
			ht.force ("That's right!", "extra")
			ht.force ("123", "id")
			ht.force ("California", "state")
			ht.force ("Goleta", "city")
			ht.force ("today", "day")

			ht.force ("value", "var")
			ht.force ("Hello World!", "hello")
			ht.force ("", "empty")
			ht.force ("/foo/bar", "path")
			ht.force ("1024", "x")
			ht.force ("768", "y")
			ht.force ("fred", "foo")
			ht.force ("That's right!", "foo2")
        	ht.force ("http://example.com/home/", "base")

        	names := <<"Fred", "Wilma", "Pebbles">>
        	ht.force (names, "name")
        	create favs.make (2)
        	favs.force ("red", "color")
        	favs.force ("high", "volume")
        	ht.force (favs, "favs")

			create empty_list.make_empty
			ht.force (empty_list,"empty_list")

			create empty_keys.make (0)
			ht.force (empty_keys,"empty_keys")

			vals := <<"val1", "val2", "val3">>
			ht.force (vals, "list")
        	create keys.make (2)
        	keys.force ("val1", "key1")
        	keys.force ("val2", "key2")
        	ht.force (keys, "keys")

			colors := <<"red", "green", "blue">>
			create semi_dot.make (3)
			semi_dot.force (";", "semi")
			semi_dot.force (".", "dot")
			semi_dot.force (",", "comma")

			create {ARRAYED_LIST [STRING]} uri_template_string_errors.make (10)

			--| Addition to the spec
			uri_template_string (ht, "api/foo/{foo_id}/{?id,extra}",
									 "api/foo/FooBar/?id=123&extra=That%%27s%%20right%%21")

			uri_template_string (ht, "api/foo/{foo_id}/{?id,empty,undef,extra}",
									 "api/foo/FooBar/?id=123&empty=&extra=That%%27s%%20right%%21")

			uri_template_string (ht, "weather/{state}/{city}?forecast={day}",
									 "weather/California/Goleta?forecast=today")


			uri_template_string (ht, "{var=default}", "value")
			uri_template_string (ht, "{undef=default}", "default")
			uri_template_string (ht, "{undef:3=default}", "default")

			uri_template_string (ht, "x{empty}y", "xy")
			uri_template_string (ht, "x{empty=_}y", "xy")
			uri_template_string (ht, "x{undef}y", "xy")
			uri_template_string (ht, "x{undef=_}y", "x_y")

			uri_template_string (ht, "x{.name=none}", "x.Fred,Wilma,Pebbles")
			uri_template_string (ht, "x{.name*=none}", "x.Fred.Wilma.Pebbles")
			uri_template_string (ht, "x{.empty}", "x.")
			uri_template_string (ht, "x{.empty=none}", "x.")
			uri_template_string (ht, "x{.undef}", "x")
			uri_template_string (ht, "x{.undef=none}", "x.none")

			uri_template_string (ht, "x{/name=none}", "x/Fred,Wilma,Pebbles")
			uri_template_string (ht, "x{/name*=none}", "x/Fred/Wilma/Pebbles")
			uri_template_string (ht, "x{/undef}", "x")
			uri_template_string (ht, "x{/undef=none}", "x/none")
			uri_template_string (ht, "x{/empty}", "x/")
			uri_template_string (ht, "x{/empty=none}", "x/")
			uri_template_string (ht, "x{/empty_keys}", "x")
			uri_template_string (ht, "x{/empty_keys=none}", "x/none")
			uri_template_string (ht, "x{/empty_keys*}", "x")
			uri_template_string (ht, "x{/empty_keys*=none}", "x/none")

			uri_template_string (ht, "x{;name=none}", "x;name=Fred,Wilma,Pebbles")
			uri_template_string (ht, "x{;favs=none}", "x;favs=color,red,volume,high")
			uri_template_string (ht, "x{;favs*=none}", "x;color=red;volume=high")
			uri_template_string (ht, "x{;empty}", "x;empty")
			uri_template_string (ht, "x{;empty=none}", "x;empty")

			uri_template_string (ht, "x{;undef}", "x")
			uri_template_string (ht, "x{;undef=none}", "x;none")
			uri_template_string (ht, "x{;undef=foo=y}", "x;foo=y")

			uri_template_string (ht, "x{?var=none}", "x?var=value")
			uri_template_string (ht, "x{?favs=none}", "x?favs=color,red,volume,high")
			uri_template_string (ht, "x{?favs*=none}", "x?color=red&volume=high")
			uri_template_string (ht, "x{?empty}", "x?empty=")
			uri_template_string (ht, "x{?empty=foo=none}", "x?empty=")
			uri_template_string (ht, "x{?undef}", "x")
			uri_template_string (ht, "x{?undef=foo=none}", "x?foo=none")
			uri_template_string (ht, "x{?empty_keys}", "x")
			uri_template_string (ht, "x{?empty_keys=none}", "x?none")
			uri_template_string (ht, "x{?empty_keys=y=z}", "x?y=z")
			uri_template_string (ht, "x{?empty_keys*=y=z}", "x?y=z")


			------

			uri_template_string (ht, "x{empty_list}y", "xy")
			uri_template_string (ht, "x{empty_list=_}y", "xy")
			uri_template_string (ht, "x{empty_list*}y", "xy")
			uri_template_string (ht, "x{empty_list*=_}y", "x_y")
			uri_template_string (ht, "x{empty_list+}y", "xy")
			uri_template_string (ht, "x{empty_list+=_}y", "xempty_list._y")

			uri_template_string (ht, "x{empty_keys}y", "xy")
			uri_template_string (ht, "x{empty_keys=_}y", "xy")
			uri_template_string (ht, "x{empty_keys*}y", "xy")
			uri_template_string (ht, "x{empty_keys*=_}y", "x_y")
			uri_template_string (ht, "x{empty_keys+}y", "xy")
			uri_template_string (ht, "x{empty_keys+=_}y", "xempty_keys._y")

			uri_template_string (ht, "x{?name=none}", "x?name=Fred,Wilma,Pebbles")
			uri_template_string (ht, "x{?favs=none}", "x?favs=color,red,volume,high")
			uri_template_string (ht, "x{?favs*=none}", "x?color=red&volume=high")
			uri_template_string (ht, "x{?favs+=none}", "x?favs.color=red&favs.volume=high")

			uri_template_string (ht, "x{?undef}", "x")
			uri_template_string (ht, "x{?undef=none}", "x?undef=none")
			uri_template_string (ht, "x{?empty}", "x?empty=")
			uri_template_string (ht, "x{?empty=none}", "x?empty=")

			uri_template_string (ht, "x{?empty_list}", "x")
			uri_template_string (ht, "x{?empty_list=none}", "x?empty_list=none")
			uri_template_string (ht, "x{?empty_list*}", "x")
			uri_template_string (ht, "x{?empty_list*=none}", "x?none")
			uri_template_string (ht, "x{?empty_list+}", "x")
			uri_template_string (ht, "x{?empty_list+=none}", "x?empty_list.none")

			uri_template_string (ht, "x{?empty_keys}", "x")
			uri_template_string (ht, "x{?empty_keys=none}", "x?empty_keys=none")
			uri_template_string (ht, "x{?empty_keys*}", "x")
			uri_template_string (ht, "x{?empty_keys*=none}", "x?none")
			uri_template_string (ht, "x{?empty_keys+}", "x")
			uri_template_string (ht, "x{?empty_keys+=none}", "x?empty_keys.none")

			uri_template_string (ht, "x{;name=none}", "x;name=Fred,Wilma,Pebbles")
			uri_template_string (ht, "x{;favs=none}", "x;favs=color,red,volume,high")
			uri_template_string (ht, "x{;favs*=none}", "x;color=red;volume=high")
			uri_template_string (ht, "x{;favs+=none}", "x;favs.color=red;favs.volume=high")
			uri_template_string (ht, "x{;undef}", "x")
			uri_template_string (ht, "x{;undef=none}", "x;undef=none")
			uri_template_string (ht, "x{;undef=none}", "x;none")
			uri_template_string (ht, "x{;empty}", "x;empty")
			uri_template_string (ht, "x{;empty=none}", "x;empty")

			uri_template_string (ht, "x{;empty_list}", "x")
			uri_template_string (ht, "x{;empty_list=none}", "x;empty_list=none")
			uri_template_string (ht, "x{;empty_list*}", "x")
			uri_template_string (ht, "x{;empty_list*=none}", "x;none")
			uri_template_string (ht, "x{;empty_list+}", "x")
			uri_template_string (ht, "x{;empty_list+=none}", "x;empty_list.none")

			uri_template_string (ht, "x{;empty_keys}", "x")
			uri_template_string (ht, "x{;empty_keys=none}", "x;empty_keys=none")
			uri_template_string (ht, "x{;empty_keys*}", "x")
			uri_template_string (ht, "x{;empty_keys*=none}", "x;none")
			uri_template_string (ht, "x{;empty_keys+}", "x")
			uri_template_string (ht, "x{;empty_keys+=none}", "x;empty_keys.none")

			uri_template_string (ht, "x{/name=none}", "x/Fred,Wilma,Pebbles")
			uri_template_string (ht, "x{/name*=none}", "x/Fred/Wilma/Pebbles")
			uri_template_string (ht, "x{/name+=none}", "x/name.Fred/name.Wilma/name.Pebbles")
			uri_template_string (ht, "x{/favs=none}", "x/color,red,volume,high")
			uri_template_string (ht, "x{/favs*=none}", "x/color/red/volume/high")
			uri_template_string (ht, "x{/favs+=none}", "x/favs.color/red/favs.volume/high")

			uri_template_string (ht, "x{/undef}", "x")
			uri_template_string (ht, "x{/undef=none}", "x/none")
			uri_template_string (ht, "x{/empty}", "x/")
			uri_template_string (ht, "x{/empty=none}", "x/")

			uri_template_string (ht, "x{/empty_list}", "x")
			uri_template_string (ht, "x{/empty_list=none}", "x/none")
			uri_template_string (ht, "x{/empty_list*}", "x")
			uri_template_string (ht, "x{/empty_list*=none}", "x/none")
			uri_template_string (ht, "x{/empty_list+}", "x")
			uri_template_string (ht, "x{/empty_list+=none}", "x/empty_list.none")

			uri_template_string (ht, "x{/empty_keys}", "x")
			uri_template_string (ht, "x{/empty_keys=none}", "x/none")
			uri_template_string (ht, "x{/empty_keys*}", "x")
			uri_template_string (ht, "x{/empty_keys*=none}", "x/none")
			uri_template_string (ht, "x{/empty_keys+}", "x")
			uri_template_string (ht, "x{/empty_keys+=none}", "x/empty_keys.none")

				--| Simple expansion with comma-separated values
			uri_template_string (ht, "{var}", "value")
			uri_template_string (ht, "{hello}", "Hello%%20World%%21")
			uri_template_string (ht, "{path}/here", "%%2Ffoo%%2Fbar/here")
			uri_template_string (ht, "{x,y}", "1024,768")
			uri_template_string (ht, "{var=default}", "value")
			uri_template_string (ht, "{undef=default}", "default")
			uri_template_string (ht, "{list}", "val1,val2,val3")
			uri_template_string (ht, "{list*}", "val1,val2,val3")
			uri_template_string (ht, "{list+}", "list.val1,list.val2,list.val3")
			uri_template_string (ht, "{keys}", "key1,val1,key2,val2")
			uri_template_string (ht, "{keys*}", "key1,val1,key2,val2")
			uri_template_string (ht, "{keys+}", "keys.key1,val1,keys.key2,val2")

				--| Reserved expansion with comma-separated values
			uri_template_string (ht, "{+var}", "value")
			uri_template_string (ht, "{+hello}", "Hello%%20World!")
			uri_template_string (ht, "{+path}/here", "/foo/bar/here")
			uri_template_string (ht, "{+path,x}/here", "/foo/bar,1024/here")
			uri_template_string (ht, "{+path}{x}/here", "/foo/bar1024/here")
			uri_template_string (ht, "{+empty}/here", "/here")
			uri_template_string (ht, "{+undef}/here", "/here")
			uri_template_string (ht, "{+list}", "val1,val2,val3")
			uri_template_string (ht, "{+list*}", "val1,val2,val3")
			uri_template_string (ht, "{+list+}", "list.val1,list.val2,list.val3")
			uri_template_string (ht, "{+keys}", "key1,val1,key2,val2")
			uri_template_string (ht, "{+keys*}", "key1,val1,key2,val2")
			uri_template_string (ht, "{+keys+}", "keys.key1,val1,keys.key2,val2")

				--| Path-style parameters, semicolon-prefixed
			uri_template_string (ht, "{;x,y}", ";x=1024;y=768")
			uri_template_string (ht, "{;x,y,empty}", ";x=1024;y=768;empty")
			uri_template_string (ht, "{;x,y,undef}", ";x=1024;y=768")
			uri_template_string (ht, "{;list}", ";list=val1,val2,val3") -- DIFF
			uri_template_string (ht, "{;list*}", ";val1;val2;val3")
			uri_template_string (ht, "{;list+}", ";list=val1;list=val2;list=val3")
			uri_template_string (ht, "{;keys}", ";keys=key1,val1,key2,val2")
			uri_template_string (ht, "{;keys*}", ";key1=val1;key2=val2")
			uri_template_string (ht, "{;keys+}", ";key1=val1;key2=val2")

				--| Form-style parameters, ampersand-separated
			uri_template_string (ht, "{?x,y}", "?x=1024&y=768")
			uri_template_string (ht, "{?x,y,empty}", "?x=1024&y=768&empty=")
			uri_template_string (ht, "{?x,y,undef}", "?x=1024&y=768")
			uri_template_string (ht, "{?list}", "?list=val1,val2,val3")
			uri_template_string (ht, "{?list*}", "?list=val1&list=val2&list=val3")
			uri_template_string (ht, "{?list+}", "?list=val1&list=val2&list=val3")
			uri_template_string (ht, "{?keys}", "?keys=key1,val1,key2,val2")
			uri_template_string (ht, "{?keys*}", "?key1=val1&key2=val2")
			uri_template_string (ht, "{?keys+}", "?keys.key1=val1&keys.key2=val2")

				--| Hierarchical path segments, slash-separated
			uri_template_string (ht, "{/var}", "/value")
			uri_template_string (ht, "{/var,empty}", "/value/")
			uri_template_string (ht, "{/var,undef}", "/value")
			uri_template_string (ht, "{/list}", "/val1,val2,val3")
			uri_template_string (ht, "{/list*}", "/val1/val2/val3")
			uri_template_string (ht, "{/list*,x}", "/val1/val2/val3/1024")
			uri_template_string (ht, "{/list+}", "/list.val1/list.val2/list.val3")
			uri_template_string (ht, "{/keys}", "/key1,val1,key2,val2")
			uri_template_string (ht, "{/keys*}", "/key1=val1/key2=val2")
			uri_template_string (ht, "{/keys+}", "/keys.key1=val1/keys.key2=val2")

				--| Label expansion, dot-prefixed
			uri_template_string (ht, "X{.var}", "X.value")
			uri_template_string (ht, "X{.empty}", "X.")
			uri_template_string (ht, "X{.undef}", "X")
			uri_template_string (ht, "X{.list}", "X.val1,val2,val3")
			uri_template_string (ht, "X{.list*}", "X.val1.val2.val3")
			uri_template_string (ht, "X{.list*,x}", "X.val1.val2.val3.1024")
			uri_template_string (ht, "X{.list+}", "X.list.val1.list.val2.list.val3")
			uri_template_string (ht, "X{.keys}", "X.key1,val1,key2,val2")
			uri_template_string (ht, "X{.keys*}", "X.key1.val1.key2.val2")
			uri_template_string (ht, "X{.keys+}", "X.keys.key1.val1.keys.key2.val2")

				--| Simple Expansion
			uri_template_string (ht, "{foo}", "fred")
			uri_template_string (ht, "{foo,foo}", "fred,fred")
			uri_template_string (ht, "{bar,foo}", "fred")
			uri_template_string (ht, "{bar=wilma}", "wilma")

				--| Reserved  Expansion
			uri_template_string (ht, "{foo2}", "That%%27s%%20right%%21")
			uri_template_string (ht, "{+foo2}", "That%%27s%%20right!")
			uri_template_string (ht, "{base}index", "http%%3A%%2F%%2Fexample.com%%2Fhome%%2Findex")
			uri_template_string (ht, "{+base}index", "http://example.com/home/index")

			assert ("all strings built", uri_template_string_errors = Void or (attached uri_template_string_errors as err and then err.is_empty))
		end

note
	copyright: "2011-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


