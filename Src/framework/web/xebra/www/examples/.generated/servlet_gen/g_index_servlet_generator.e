note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_INDEX_SERVLET_GENERATOR

inherit
	XGEN_SERVLET_GENERATOR

create
	make

feature-- Access

feature-- Implementation

	root_tag: XTAG_TAG_SERIALIZER
			--<Precursor>
		local
			stack: ARRAYED_STACK [XTAG_TAG_SERIALIZER]
			l_root_tag, temp: XTAG_TAG_SERIALIZER
		do
			create stack.make (10)
				-- line: 140 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 140 row: 2 of file: ./index.xeb"
			l_root_tag := temp
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 140 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 140 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 2 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 2 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 3 row: 1 of file: ./index.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 3 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "controller"
				-- line: 3 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 3 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 32 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 32 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "head"
			stack.put (temp)
				-- line: 4 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 31 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 31 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "style"
			stack.put (temp)
				-- line: 30 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 30 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/div.title { %N%/9/%/9/font-weight: bold; font-size: 110%%; %N%/9/%/9/margin: 5px;%N%/9/%/9/}%N%/9/div.example { %N%/9/%/9/padding: 10px; margin: 10px; %N%/9/%/9/background-color: #fff; %N%/9/%/9/border-top: solid 2px #000;%N%/9/%/9/}%N%/9/div.source { %N%/9/%/9/white-space: pre;  padding: 3px; %N%/9/%/9/font-size: 70%%;%N%/9/%/9/border: dotted 1px #99c;%N%/9/%/9/background-color: #fff; font-family: verdana; %N%/9/%/9/margin-bottom: 5px;%N%/9/%/9/}%N%/9/div.demo { %N%/9/%/9/clear:both; %N%/9/%/9/background-color: #ddddff; %N%/9/%/9/border: solid 1px #aae; %N%/9/%/9/padding: 5px; %N%/9/%/9/margin-top: 5px; %N%/9/%/9/}%N%/9/.xeb { float: left; width: 48%%}%N%/9/.eiffel { float: right; width: 48%%; }%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 31 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 31 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 32 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 32 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 139 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 139 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "body"
			stack.put (temp)
				-- line: 33 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 33 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 34 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 34 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h1"
			stack.put (temp)
				-- line: 33 row: 40 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 33 row: 40 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Xebra's quick tutorial by examples")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 35 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 35 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 43 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 43 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "example")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 36 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 36 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "title")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 35 row: 64 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 35 row: 64 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "xeb:display's example:")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 36 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 36 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 39 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 39 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "source xeb")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 38 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 38 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/&lt;xeb:display text=%"This is a text%" /&gt;%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 39 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 39 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 42 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 42 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "demo")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 40 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 40 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 41 row: 1 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 41 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "This is a text")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 41 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 41 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 42 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 42 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 44 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 63 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 63 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "example")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 45 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 45 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "title")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 44 row: 65 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 65 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Calling the controller:")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 45 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 45 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 52 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 52 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "source xeb")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 51 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 51 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/&lt;html&gt;%N%/9/&lt;page:controller class=%"MAIN_CONTROLLER%" create=%"make%"/&gt;%N%/9/....%N%/9/&lt;body&gt;%N%/9/&lt;xeb:display text=%"%%=the_text%%%" /&gt;%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 52 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 52 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 58 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 58 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "source eiffel")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 57 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 57 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/the_text: STRING%N%/9/%/9/do%N%/9/%/9/%/9/Result := %"This is a text%"%N%/9/%/9/end%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 58 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 58 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 62 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 62 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "demo")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 59 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 59 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 60 row: 1 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 60 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("text", "the_text")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 60 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 60 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 61 row: 1 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 61 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("text", "xebra_documentation_url")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 61 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 61 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 62 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 62 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 64 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 64 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 81 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 81 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "example")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 65 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 65 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "title")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 64 row: 61 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 64 row: 61 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "xeb:loop's example:")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 65 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 65 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 72 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 72 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "source xeb")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 71 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 71 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/&lt;ol&gt;%N%/9/&lt;xeb:loop times=%"5%" variable=%"loop_index%" &gt;%N%/9/&lt;li&gt;item &lt;xeb:display text=%"#{loop_index.out}%" /&gt;&lt;/li&gt;%N%/9/&lt;/xeb:loop&gt;%N%/9/&lt;/ol&gt;%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 73 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 73 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 80 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 80 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "demo")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 74 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 74 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 79 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 79 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "ol"
			stack.put (temp)
				-- line: 75 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 75 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 78 row: 1 of file: ./index.xeb
			create {XTAG_XEB_LOOP_TAG} temp.make
			temp.debug_information := "line: 78 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("times", "5")
			temp.put_value_attribute("variable", "loop_index")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "loop"
			stack.put (temp)
				-- line: 76 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 76 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 77 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 77 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 76 row: 13 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 76 row: 13 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "item ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 76 row: 53 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 76 row: 53 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "loop_index.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 77 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 77 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 78 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 78 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 79 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 79 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 80 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 80 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 83 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 83 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 108 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 108 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "example")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 84 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 84 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "title")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 83 row: 64 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 83 row: 64 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "xeb:iterate's example:")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 84 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 84 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 91 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 91 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "source xeb")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 90 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 90 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/&lt;ul&gt;%N%/9/&lt;xeb:iterate list=%"%%=my_items%%%" variable=%"entry%" type=%"STRING%" &gt;%N%/9/&lt;li&gt;&lt;xeb:display text=%"#{entry}%" /&gt;&lt;/li&gt;%N%/9/&lt;/xeb:iterate&gt;%N%/9/&lt;/ul&gt;%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 91 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 91 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 100 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 100 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "source eiffel")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 99 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 99 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/my_items: ARRAYED_LIST [STRING]%N%/9/%/9/do%N%/9/%/9/%/9/create Result.make (3)%N%/9/%/9/%/9/Result.force (%"a%")%N%/9/%/9/%/9/Result.force (%"b%")%N%/9/%/9/%/9/Result.force (%"c%")%N%/9/%/9/end%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 100 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 100 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 107 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 107 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "demo")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 101 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 101 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 106 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 106 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "ul"
			stack.put (temp)
				-- line: 102 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 102 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 105 row: 1 of file: ./index.xeb
			create {XTAG_XEB_ITERATE_TAG} temp.make
			temp.debug_information := "line: 105 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("list", "my_items")
			temp.put_value_attribute("variable", "entry")
			temp.put_value_attribute("type", "STRING")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "iterate"
			stack.put (temp)
				-- line: 103 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 103 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 104 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 104 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 103 row: 38 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 103 row: 38 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "entry")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 104 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 104 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 105 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 105 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 106 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 106 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 107 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 107 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 110 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 110 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 123 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 123 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "example")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 111 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 111 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "title")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 110 row: 69 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 110 row: 69 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "xeb:set_variable's example:")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 111 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 111 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 115 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 115 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "source xeb")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 114 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 114 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/&lt;xeb:set_variable variable=%"doc_url%" value=%"%%=xebra_documentation_url%%%" type=%"STRING%" /&gt;%N%/9/Check the Xebra's documentation: &lt;a href=%"#{doc_url}%"&gt;&lt;xeb:display text=%"#{doc_url}%"/&gt; &lt;/a&gt;%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 115 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 115 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 118 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 118 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "source eiffel")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 117 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 117 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/Result := %"http://dev.eiffel.com/Xebra_Documentation%"%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 118 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 118 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 122 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 122 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "demo")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 119 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 119 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 120 row: 1 of file: ./index.xeb
			create {XTAG_XEB_SET_VARIABLE_TAG} temp.make
			temp.debug_information := "line: 120 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("variable", "doc_url")
			temp.put_dynamic_attribute("value", "xebra_documentation_url")
			temp.put_value_attribute("type", "STRING")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "set_variable"
				-- line: 120 row: 36 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 120 row: 36 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/Check the Xebra's documentation: ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 121 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 121 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("href", "doc_url")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 120 row: 89 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 120 row: 89 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "doc_url")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 120 row: 90 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 120 row: 90 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 121 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 121 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 122 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 122 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 124 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 124 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 136 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 136 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "example")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 125 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 125 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "title")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 124 row: 63 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 124 row: 63 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "xeb:concat's example:")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 125 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 125 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 130 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 130 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "source xeb")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 129 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 129 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/&lt;xeb:set_variable variable=%"aplusb%" value=%"PLUS%" type=%"STRING%" /&gt;%N%/9/&lt;xeb:concat variable=%"aplusb%" left=%"a%" right=%"b%" /&gt;%N%/9/&lt;xeb:display text=%"#{aplusb}%" /&gt;%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 130 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 130 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 135 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 135 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "demo")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 131 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 131 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 132 row: 1 of file: ./index.xeb
			create {XTAG_XEB_SET_VARIABLE_TAG} temp.make
			temp.debug_information := "line: 132 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("variable", "aplusb")
			temp.put_value_attribute("value", "PLUS")
			temp.put_value_attribute("type", "STRING")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "set_variable"
				-- line: 132 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 132 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 133 row: 1 of file: ./index.xeb
			create {XTAG_XEB_CONCAT_TAG} temp.make
			temp.debug_information := "line: 133 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("variable", "aplusb")
			temp.put_value_attribute("left", "a")
			temp.put_value_attribute("right", "b")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "concat"
				-- line: 133 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 133 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 134 row: 1 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 134 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "aplusb")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 134 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 134 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 135 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 135 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 138 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 138 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 139 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 139 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
			Result := l_root_tag
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"end
