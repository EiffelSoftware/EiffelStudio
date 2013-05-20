note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_URI_TEMPLATE

inherit
	EQA_TEST_SET

feature -- Expander	 https://github.com/uri-templates/uritemplate-test/blob/master/spec-examples.json

	expander_level_1
		note
			testing:  "uri-template-rfc"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
		do
			create ht.make (2)
			ht.force ("value", "var")
			ht.force ("Hello World!", "hello")

			uri_template_string (ht, "{var}", "value")
			uri_template_string (ht, "{hello}", "Hello%%20World%%21")
		end

	expander_level_2
		note
			testing:  "uri-template-rfc"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
		do
			create ht.make (2)
			ht.force ("value", "var")
			ht.force ("Hello World!", "hello")
			ht.force ("/foo/bar", "path")

        	uri_template_string (ht, "{+var}", "value")
        	uri_template_string (ht, "{+hello}", "Hello%%20World!")
        	uri_template_string (ht, "{+path}/here", "/foo/bar/here")
        	uri_template_string (ht, "here?ref={+path}", "here?ref=/foo/bar")
		end

	expander_level_3
		note
			testing:  "uri-template-rfc"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
		do
			create ht.make (2)
			ht.force ("value", "var")
			ht.force ("Hello World!", "hello")
			ht.force ("", "empty")
			ht.force ("/foo/bar", "path")
			ht.force ("1024", "x")
			ht.force ("768", "y")

			uri_template_string (ht, "map?{x,y}", "map?1024,768")
			uri_template_string (ht, "{x,hello,y}", "1024,Hello%%20World%%21,768")
			uri_template_string (ht, "{+x,hello,y}", "1024,Hello%%20World!,768")
			uri_template_string (ht, "{+path,x}/here", "/foo/bar,1024/here")
			uri_template_string (ht, "{#x,hello,y}", "#1024,Hello%%20World!,768")
			uri_template_string (ht, "{#path,x}/here", "#/foo/bar,1024/here")
			uri_template_string (ht, "X{.var}", "X.value")
			uri_template_string (ht, "X{.x,y}", "X.1024.768")
			uri_template_string (ht, "{/var}", "/value")
			uri_template_string (ht, "{/var,x}/here", "/value/1024/here")
			uri_template_string (ht, "{;x,y}", ";x=1024;y=768")
			uri_template_string (ht, "{;x,y,empty}", ";x=1024;y=768;empty")
			uri_template_string (ht, "{?x,y}", "?x=1024&y=768")
			uri_template_string (ht, "{?x,y,empty}", "?x=1024&y=768&empty=")
			uri_template_string (ht, "?fixed=yes{&x}", "?fixed=yes&x=1024")
			uri_template_string (ht, "{&x,y,empty}", "&x=1024&y=768&empty=")
		end

	expander_level_4
		note
			testing:  "uri-template-rfc"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
			keys: HASH_TABLE [detachable ANY, STRING]
		do
			create ht.make (2)
			ht.force ("value", "var")
			ht.force ("Hello World!", "hello")
			ht.force ("/foo/bar", "path")
			ht.force (<<"red", "green", "blue">>, "list")
			create keys.make (2)
			keys.force (";", "semi")
			keys.force (".", "dot")
			keys.force (",", "comma")
			ht.force (keys, "keys")

			create {ARRAYED_LIST [STRING]} uri_template_string_errors.make (10)

			uri_template_string (ht, "{var:3}", "val")
			uri_template_string (ht, "{var:30}", "value")
			uri_template_string (ht, "{list}", "red,green,blue")
			uri_template_string (ht, "{list*}", "red,green,blue")

			uri_template_string_x (ht, "{keys}", <<"comma,%%2C,dot,.,semi,%%3B", "comma,%%2C,semi,%%3B,dot,.", "dot,.,comma,%%2C,semi,%%3B", "dot,.,semi,%%3B,comma,%%2C", "semi,%%3B,comma,%%2C,dot,.", "semi,%%3B,dot,.,comma,%%2C" >>)
			uri_template_string_x (ht, "{keys*}", <<"comma=%%2C,dot=.,semi=%%3B", "comma=%%2C,semi=%%3B,dot=.", "dot=.,comma=%%2C,semi=%%3B", "dot=.,semi=%%3B,comma=%%2C", "semi=%%3B,comma=%%2C,dot=.", "semi=%%3B,dot=.,comma=%%2C" >>)
			uri_template_string (ht, "{+path:6}/here", "/foo/b/here")
			uri_template_string (ht, "{+list}", "red,green,blue")
			uri_template_string (ht, "{+list*}", "red,green,blue")

			uri_template_string_x (ht, "{+keys}", <<"comma,,,dot,.,semi,;", "comma,,,semi,;,dot,.", "dot,.,comma,,,semi,;", "dot,.,semi,;,comma,,", "semi,;,comma,,,dot,.", "semi,;,dot,.,comma,," >>)
			uri_template_string_x (ht, "{+keys*}", <<"comma=,,dot=.,semi=;", "comma=,,semi=;,dot=.", "dot=.,comma=,,semi=;", "dot=.,semi=;,comma=,", "semi=;,comma=,,dot=.", "semi=;,dot=.,comma=," >>)
			uri_template_string (ht, "{#path:6}/here", "#/foo/b/here")
			uri_template_string (ht, "{#list}", "#red,green,blue")
			uri_template_string (ht, "{#list*}", "#red,green,blue")
			uri_template_string_x (ht, "{#keys}", <<"#comma,,,dot,.,semi,;", "#comma,,,semi,;,dot,.", "#dot,.,comma,,,semi,;", "#dot,.,semi,;,comma,,", "#semi,;,comma,,,dot,.", "#semi,;,dot,.,comma,," >>)
			uri_template_string_x (ht, "{#keys*}", <<"#comma=,,dot=.,semi=;", "#comma=,,semi=;,dot=.", "#dot=.,comma=,,semi=;", "#dot=.,semi=;,comma=,", "#semi=;,comma=,,dot=.", "#semi=;,dot=.,comma=," >>)
			uri_template_string (ht, "X{.var:3}", "X.val")
			uri_template_string (ht, "X{.list}", "X.red,green,blue")
			uri_template_string (ht, "X{.list*}", "X.red.green.blue")
			uri_template_string_x (ht, "X{.keys}", <<"X.comma,%%2C,dot,.,semi,%%3B", "X.comma,%%2C,semi,%%3B,dot,.", "X.dot,.,comma,%%2C,semi,%%3B", "X.dot,.,semi,%%3B,comma,%%2C", "X.semi,%%3B,comma,%%2C,dot,.", "X.semi,%%3B,dot,.,comma,%%2C" >>)
			uri_template_string (ht, "{/var:1,var}", "/v/value")
			uri_template_string (ht, "{/list}", "/red,green,blue")
			uri_template_string (ht, "{/list*}", "/red/green/blue")
			uri_template_string (ht, "{/list*,path:4}", "/red/green/blue/%%2Ffoo")
			uri_template_string_x (ht, "{/keys}", <<"/comma,%%2C,dot,.,semi,%%3B", "/comma,%%2C,semi,%%3B,dot,.",
													"/dot,.,comma,%%2C,semi,%%3B", "/dot,.,semi,%%3B,comma,%%2C",
													"/semi,%%3B,comma,%%2C,dot,.", "/semi,%%3B,dot,.,comma,%%2C" >>)
			uri_template_string_x (ht, "{/keys*}", <<"/comma=%%2C/dot=./semi=%%3B", "/comma=%%2C/semi=%%3B/dot=.",
													 "/dot=./comma=%%2C/semi=%%3B", "/dot=./semi=%%3B/comma=%%2C",
													  "/semi=%%3B/comma=%%2C/dot=.", "/semi=%%3B/dot=./comma=%%2C" >>)
			uri_template_string (ht, "{;hello:5}", ";hello=Hello")
			uri_template_string (ht, "{;list}", ";list=red,green,blue")
			uri_template_string (ht, "{;list*}", ";list=red;list=green;list=blue")
			uri_template_string_x (ht, "{;keys}", <<";keys=comma,%%2C,dot,.,semi,%%3B", ";keys=comma,%%2C,semi,%%3B,dot,.", ";keys=dot,.,comma,%%2C,semi,%%3B", ";keys=dot,.,comma,%%2C,semi,%%3B", ";keys=semi,%%3B,comma,%%2C,dot,.", ";keys=semi,%%3B,dot,.,comma,%%2C" >>)
			uri_template_string_x (ht, "{;keys*}", <<";comma=%%2C;dot=.;semi=%%3B", ";comma=%%2C;semi=%%3B;dot=.", ";dot=.;comma=%%2C;semi=%%3B", ";dot=.;semi=%%3B;comma=%%2C", ";semi=%%3B;comma=%%2C;dot=.", ";semi=%%3B;dot=.;comma=%%2C" >>)
			uri_template_string (ht, "{?var:3}", "?var=val")
			uri_template_string (ht, "{?list}", "?list=red,green,blue")
			uri_template_string (ht, "{?list*}", "?list=red&list=green&list=blue")
			uri_template_string_x (ht, "{?keys}", <<"?keys=comma,%%2C,dot,.,semi,%%3B", "?keys=comma,%%2C,semi,%%3B,dot,.", "?keys=dot,.,comma,%%2C,semi,%%3B", "?keys=dot,.,semi,%%3B,comma,%%2C", "?keys=semi,%%3B,comma,%%2C,dot,.", "?keys=semi,%%3B,dot,.,comma,%%2C" >>)
			uri_template_string_x (ht, "{?keys*}", <<"?comma=%%2C&dot=.&semi=%%3B", "?comma=%%2C&semi=%%3B&dot=.", "?dot=.&comma=%%2C&semi=%%3B", "?dot=.&semi=%%3B&comma=%%2C", "?semi=%%3B&comma=%%2C&dot=.", "?semi=%%3B&dot=.&comma=%%2C" >>)
			uri_template_string (ht, "{&var:3}", "&var=val")
			uri_template_string (ht, "{&list}", "&list=red,green,blue")
			uri_template_string (ht, "{&list*}", "&list=red&list=green&list=blue")
			uri_template_string_x (ht, "{&keys}", <<"&keys=comma,%%2C,dot,.,semi,%%3B", "&keys=comma,%%2C,semi,%%3B,dot,.", "&keys=dot,.,comma,%%2C,semi,%%3B", "&keys=dot,.,semi,%%3B,comma,%%2C", "&keys=semi,%%3B,comma,%%2C,dot,.", "&keys=semi,%%3B,dot,.,comma,%%2C" >>)
			uri_template_string_x (ht, "{&keys*}", <<"&comma=%%2C&dot=.&semi=%%3B", "&comma=%%2C&semi=%%3B&dot=.", "&dot=.&comma=%%2C&semi=%%3B", "&dot=.&semi=%%3B&comma=%%2C", "&semi=%%3B&comma=%%2C&dot=.", "&semi=%%3B&dot=.&comma=%%2C" >>)

			assert ("all strings built", uri_template_string_errors = Void or (attached uri_template_string_errors as err and then err.is_empty))
		end


feature -- Expander	 https://github.com/uri-templates/uritemplate-test/blob/master/spec-examples-by-section.json

	examples_by_section_variables: HASH_TABLE [detachable ANY, STRING]
		local
			ht: HASH_TABLE [detachable ANY, STRING]
			keys: HASH_TABLE [detachable ANY, STRING]
		do
			create ht.make (2)
			ht.force (<<"one", "two", "three">>, "count")
			ht.force (<<"example", "com">>, "dom")
			ht.force ("me/too", "dub")
			ht.force ("Hello World!", "hello")
			ht.force ("50%%", "half")
			ht.force ("value", "var")
			ht.force ("fred", "who")
			ht.force ("http://example.com/home/", "base")
			ht.force ("/foo/bar", "path")
			ht.force (<<"red", "green", "blue">>, "list")
			create keys.make (2)
			keys.force (",", "comma")
			keys.force (".", "dot")
			keys.force (";", "semi")
			ht.force (keys, "keys")
			ht.force ("6", "v")
			ht.force ("1024", "x")
			ht.force ("768", "y")
			ht.force ("", "empty")
			create keys.make (0)
			ht.force (keys, "empty_keys")
			ht.force (Void, "undef")
			Result := ht
		end

	expander_variable_expansion
			-- "3.2.1 Variable Expansion"
		note
			testing:  "uri-template-rfc-ex"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
		do
			ht := examples_by_section_variables

			create {ARRAYED_LIST [STRING]} uri_template_string_errors.make (10)
			uri_template_string (ht, "{count}", "one,two,three")
			uri_template_string (ht, "{count*}", "one,two,three")
			uri_template_string (ht, "{/count}", "/one,two,three")
			uri_template_string (ht, "{/count*}", "/one/two/three")
			uri_template_string (ht, "{;count}", ";count=one,two,three")
			uri_template_string (ht, "{;count*}", ";count=one;count=two;count=three")
			uri_template_string (ht, "{?count}", "?count=one,two,three")
			uri_template_string (ht, "{?count*}", "?count=one&count=two&count=three")
			uri_template_string (ht, "{&count*}", "&count=one&count=two&count=three")

			assert ("all strings built", uri_template_string_errors = Void or (attached uri_template_string_errors as err and then err.is_empty))
		end

	expander_simple_string_expansion
			-- "3.2.2 Simple String Expansion"
		note
			testing:  "uri-template-rfc-ex"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
		do
			ht := examples_by_section_variables

			create {ARRAYED_LIST [STRING]} uri_template_string_errors.make (10)

			uri_template_string (ht, "{var}", "value")
			uri_template_string (ht, "{hello}", "Hello%%20World%%21")
			uri_template_string (ht, "{half}", "50%%25")
			uri_template_string (ht, "O{empty}X", "OX")
			uri_template_string (ht, "O{undef}X", "OX")
			uri_template_string (ht, "{x,y}", "1024,768")
			uri_template_string (ht, "{x,hello,y}", "1024,Hello%%20World%%21,768")
			uri_template_string (ht, "?{x,empty}", "?1024,")
			uri_template_string (ht, "?{x,undef}", "?1024")
			uri_template_string (ht, "?{undef,y}", "?768")
			uri_template_string (ht, "{var:3}", "val")
			uri_template_string (ht, "{var:30}", "value")
			uri_template_string (ht, "{list}", "red,green,blue")
			uri_template_string (ht, "{list*}", "red,green,blue")
			uri_template_string (ht, "{keys}", "comma,%%2C,dot,.,semi,%%3B")
			uri_template_string (ht, "{keys*}", "comma=%%2C,dot=.,semi=%%3B")

			assert ("all strings built", uri_template_string_errors = Void or (attached uri_template_string_errors as err and then err.is_empty))
		end

	expander_reserved_expansion
			--  "3.2.3 Reserved Expansion"
		note
			testing:  "uri-template-rfc-ex"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
		do
			ht := examples_by_section_variables

			create {ARRAYED_LIST [STRING]} uri_template_string_errors.make (10)

			uri_template_string (ht, "{+var}", "value")
			uri_template_string (ht, "{+hello}", "Hello%%20World!")
			uri_template_string (ht, "{+half}", "50%%25")
			uri_template_string (ht, "{base}index", "http%%3A%%2F%%2Fexample.com%%2Fhome%%2Findex")
			uri_template_string (ht, "{+base}index", "http://example.com/home/index")
			uri_template_string (ht, "O{+empty}X", "OX")
			uri_template_string (ht, "O{+undef}X", "OX")
			uri_template_string (ht, "{+path}/here", "/foo/bar/here")
			uri_template_string (ht, "{+path:6}/here", "/foo/b/here")
			uri_template_string (ht, "here?ref={+path}", "here?ref=/foo/bar")
			uri_template_string (ht, "up{+path}{var}/here", "up/foo/barvalue/here")
			uri_template_string (ht, "{+x,hello,y}", "1024,Hello%%20World!,768")
			uri_template_string (ht, "{+path,x}/here", "/foo/bar,1024/here")
			uri_template_string (ht, "{+list}", "red,green,blue")
			uri_template_string (ht, "{+list*}", "red,green,blue")
			uri_template_string (ht, "{+keys}", "comma,,,dot,.,semi,;")
			uri_template_string (ht, "{+keys*}", "comma=,,dot=.,semi=;")

			assert ("all strings built", uri_template_string_errors = Void or (attached uri_template_string_errors as err and then err.is_empty))
		end

	expander_fragment_expansion
			--  "3.2.4 Fragment Expansion"
		note
			testing:  "uri-template-rfc-ex"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
		do
			ht := examples_by_section_variables

			create {ARRAYED_LIST [STRING]} uri_template_string_errors.make (10)

			uri_template_string (ht, "{#var}", "#value")
			uri_template_string (ht, "{#hello}", "#Hello%%20World!")
			uri_template_string (ht, "{#half}", "#50%%25")
			uri_template_string (ht, "foo{#empty}", "foo#")
			uri_template_string (ht, "foo{#undef}", "foo")
			uri_template_string (ht, "{#x,hello,y}", "#1024,Hello%%20World!,768")
			uri_template_string (ht, "{#path,x}/here", "#/foo/bar,1024/here")
			uri_template_string (ht, "{#path:6}/here", "#/foo/b/here")
			uri_template_string (ht, "{#list}", "#red,green,blue")
			uri_template_string (ht, "{#list*}", "#red,green,blue")
			uri_template_string (ht, "{#keys}", "#comma,,,dot,.,semi,;")

			assert ("all strings built", uri_template_string_errors = Void or (attached uri_template_string_errors as err and then err.is_empty))
		end

	expander_label_expansion_with_dot_prefix
			-- "3.2.5 Label Expansion with Dot-Prefix"
		note
			testing:  "uri-template-rfc-ex"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
		do
			ht := examples_by_section_variables

			create {ARRAYED_LIST [STRING]} uri_template_string_errors.make (10)

			uri_template_string (ht, "{.who}", ".fred")
			uri_template_string (ht, "{.who,who}", ".fred.fred")
			uri_template_string (ht, "{.half,who}", ".50%%25.fred")
			uri_template_string (ht, "www{.dom*}", "www.example.com")
			uri_template_string (ht, "X{.var}", "X.value")
			uri_template_string (ht, "X{.var:3}", "X.val")
			uri_template_string (ht, "X{.empty}", "X.")
			uri_template_string (ht, "X{.undef}", "X")
			uri_template_string (ht, "X{.list}", "X.red,green,blue")
			uri_template_string (ht, "X{.list*}", "X.red.green.blue")
			uri_template_string (ht, "X{.keys}", "X.comma,%%2C,dot,.,semi,%%3B")
			uri_template_string (ht, "X{.keys*}", "X.comma=%%2C.dot=..semi=%%3B")
			uri_template_string (ht, "X{.empty_keys}", "X")
			uri_template_string (ht, "X{.empty_keys*}", "X")

			assert ("all strings built", uri_template_string_errors = Void or (attached uri_template_string_errors as err and then err.is_empty))
		end

	expander_path_segment_expansion
			-- "3.2.6 Path Segment Expansion"
		note
			testing:  "uri-template-rfc-ex"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
		do
			ht := examples_by_section_variables

			create {ARRAYED_LIST [STRING]} uri_template_string_errors.make (10)

			uri_template_string (ht, "{/who}", "/fred")
			uri_template_string (ht, "{/who,who}", "/fred/fred")
			uri_template_string (ht, "{/half,who}", "/50%%25/fred")
			uri_template_string (ht, "{/who,dub}", "/fred/me%%2Ftoo")
			uri_template_string (ht, "{/var}", "/value")
			uri_template_string (ht, "{/var,empty}", "/value/")
			uri_template_string (ht, "{/var,undef}", "/value")
			uri_template_string (ht, "{/var,x}/here", "/value/1024/here")
			uri_template_string (ht, "{/var:1,var}", "/v/value")
			uri_template_string (ht, "{/list}", "/red,green,blue")
			uri_template_string (ht, "{/list*}", "/red/green/blue")
			uri_template_string (ht, "{/list*,path:4}", "/red/green/blue/%%2Ffoo")
			uri_template_string (ht, "{/keys}", "/comma,%%2C,dot,.,semi,%%3B")
			uri_template_string (ht, "{/keys*}", "/comma=%%2C/dot=./semi=%%3B")

			assert ("all strings built", uri_template_string_errors = Void or (attached uri_template_string_errors as err and then err.is_empty))
		end

	expander_path_style_parameter_expansion
			-- "3.2.7 Path-Style Parameter Expansion"
		note
			testing:  "uri-template-rfc-ex"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
		do
			ht := examples_by_section_variables

			create {ARRAYED_LIST [STRING]} uri_template_string_errors.make (10)

			uri_template_string (ht, "{;who}", ";who=fred")
			uri_template_string (ht, "{;half}", ";half=50%%25")
			uri_template_string (ht, "{;empty}", ";empty")
			uri_template_string (ht, "{;hello:5}", ";hello=Hello")
			uri_template_string (ht, "{;v,empty,who}", ";v=6;empty;who=fred")
			uri_template_string (ht, "{;v,bar,who}", ";v=6;who=fred")
			uri_template_string (ht, "{;x,y}", ";x=1024;y=768")
			uri_template_string (ht, "{;x,y,empty}", ";x=1024;y=768;empty")
			uri_template_string (ht, "{;x,y,undef}", ";x=1024;y=768")
			uri_template_string (ht, "{;list}", ";list=red,green,blue")
			uri_template_string (ht, "{;list*}", ";list=red;list=green;list=blue")
			uri_template_string (ht, "{;keys}", ";keys=comma,%%2C,dot,.,semi,%%3B")
			uri_template_string (ht, "{;keys*}", ";comma=%%2C;dot=.;semi=%%3B")

			assert ("all strings built", uri_template_string_errors = Void or (attached uri_template_string_errors as err and then err.is_empty))
		end

	expander_form_style_query_expansion
			--   "3.2.8 Form-Style Query Expansion"
		note
			testing:  "uri-template-rfc-ex"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
		do
			ht := examples_by_section_variables

			create {ARRAYED_LIST [STRING]} uri_template_string_errors.make (10)

			uri_template_string (ht, "{?who}", "?who=fred")
			uri_template_string (ht, "{?half}", "?half=50%%25")
			uri_template_string (ht, "{?x,y}", "?x=1024&y=768")
			uri_template_string (ht, "{?x,y,empty}", "?x=1024&y=768&empty=")
			uri_template_string (ht, "{?x,y,undef}", "?x=1024&y=768")
			uri_template_string (ht, "{?var:3}", "?var=val")
			uri_template_string (ht, "{?list}", "?list=red,green,blue")
			uri_template_string (ht, "{?list*}", "?list=red&list=green&list=blue")
			uri_template_string (ht, "{?keys}", "?keys=comma,%%2C,dot,.,semi,%%3B")
			uri_template_string (ht, "{?keys*}", "?comma=%%2C&dot=.&semi=%%3B")

			assert ("all strings built", uri_template_string_errors = Void or (attached uri_template_string_errors as err and then err.is_empty))
		end

	expander_form_style_query_continuation
			--   "3.2.9 Form-Style Query Continuation"
		note
			testing:  "uri-template-rfc-ex"
		local
			ht: HASH_TABLE [detachable ANY, STRING]
		do
			ht := examples_by_section_variables

			create {ARRAYED_LIST [STRING]} uri_template_string_errors.make (10)

			uri_template_string (ht, "{&who}", "&who=fred")
			uri_template_string (ht, "{&half}", "&half=50%%25")
			uri_template_string (ht, "?fixed=yes{&x}", "?fixed=yes&x=1024")
			uri_template_string (ht, "{&var:3}", "&var=val")
			uri_template_string (ht, "{&x,y,empty}", "&x=1024&y=768&empty=")
			uri_template_string (ht, "{&x,y,undef}", "&x=1024&y=768")
			uri_template_string (ht, "{&list}", "&list=red,green,blue")
			uri_template_string (ht, "{&list*}", "&list=red&list=green&list=blue")
			uri_template_string (ht, "{&keys}", "&keys=comma,%%2C,dot,.,semi,%%3B")
			uri_template_string (ht, "{&keys*}", "&comma=%%2C&dot=.&semi=%%3B")

			assert ("all strings built", uri_template_string_errors = Void or (attached uri_template_string_errors as err and then err.is_empty))
		end

feature {NONE} -- Implementation	

	uri_template_string_errors: detachable LIST [STRING]

	uri_template_string_x (a_ht: HASH_TABLE [detachable ANY, STRING]; a_expression: STRING; a_expected: ARRAY [STRING])
		local
			tpl: URI_TEMPLATE
			s: STRING
			m: STRING
			b: BOOLEAN
		do
			create tpl.make (a_expression)
			s := tpl.expanded_string (a_ht)
			across
				a_expected as c
			until
				b
			loop
				b := b or s.same_string (c.item)
			end

			if not b then
				m := "Unexpected string for %"" + a_expression + "%" got %"" + s + "%" but expected either of "
				across
					a_expected as c
				loop
					m.append ("%"" + c.item + "%" ")
				end
				m.append ("%N")
				if attached uri_template_string_errors as err then
					print (m)
					err.force (m)
				else
					assert (m, False)
				end
			end
		end

	uri_template_string (a_ht: HASH_TABLE [detachable ANY, STRING]; a_expression: STRING; a_expected: STRING)
		local
			tpl: URI_TEMPLATE
			s: STRING
			m: STRING
		do
			create tpl.make (a_expression)
			s := tpl.expanded_string (a_ht)
			if not s.same_string (a_expected) then
				m := "Expected string for %"" + a_expression + "%" expected=%""+ a_expected +"%" but got %"" + s + "%"%N"
				if attached uri_template_string_errors as err then
					print (m)
					err.force (m)
				else
					assert (m, False)
				end
			end
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
