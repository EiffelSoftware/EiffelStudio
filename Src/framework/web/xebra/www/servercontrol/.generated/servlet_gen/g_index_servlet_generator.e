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
				-- line: 93 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 93 row: 2 of file: ./index.xeb"
			l_root_tag := temp
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 2 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 2 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "<!DOCTYPE html PUBLIC %"-//W3C//DTD XHTML 1.0 Strict//EN%" %"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd%">%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 92 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 92 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("xmlns", "http://www.w3.org/1999/xhtml")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 3 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 3 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " %N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 9 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 9 row: 1 of file: ./index.xeb"
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
				-- line: 5 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 5 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "title"
			stack.put (temp)
				-- line: 4 row: 29 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 29 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Xebra Server Control")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 5 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 6 row: 1 of file: ./index.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 6 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "controller"
				-- line: 6 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 7 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 7 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("http-equiv", "Content-Type")
			temp.put_value_attribute("content", "text/html; charset=utf-8")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "meta"
				-- line: 7 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 8 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "base.css")
			temp.put_value_attribute("rel", "stylesheet")
			temp.put_value_attribute("type", "text/css")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "link"
				-- line: 8 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 9 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 91 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 91 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "body"
			stack.put (temp)
				-- line: 10 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 90 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 90 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "main")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 11 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 14 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 14 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "header")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 12 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 13 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 13 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "title")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 12 row: 38 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 38 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Xebra Server Control")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 13 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 13 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 14 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 86 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 86 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "content")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 15 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 85 row: 1 of file: ./index.xeb
			create {XTAG_F_FORM_TAG} temp.make
			temp.debug_information := "line: 85 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "form"
			stack.put (temp)
				-- line: 17 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 18 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 18 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h1"
			stack.put (temp)
				-- line: 17 row: 20 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 20 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Server Control")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 19 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 30 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 30 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "default")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "table"
			stack.put (temp)
				-- line: 20 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 20 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 24 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 24 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 21 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 22 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 22 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 21 row: 12 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 12 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Name")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 22 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 22 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 23 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 23 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 22 row: 15 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 22 row: 15 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Control")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 23 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 23 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 24 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 24 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 27 row: 9 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 27 row: 9 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 25 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 25 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 25 row: 25 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 25 row: 25 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 25 row: 20 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 25 row: 20 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Main Server")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 26 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 26 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%/9/%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 27 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 27 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 26 row: 68 of file: ./index.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 26 row: 68 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "shutdown")
			temp.put_value_attribute("action", "shutdown_server")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "command_link"
				-- line: 26 row: 71 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 26 row: 71 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " | ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 26 row: 137 of file: ./index.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 26 row: 137 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "reload config file")
			temp.put_value_attribute("action", "reload_config")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "command_link"
			stack.remove
				-- line: 27 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 29 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 29 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 30 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 30 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 31 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 31 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h1"
			stack.put (temp)
				-- line: 30 row: 13 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 30 row: 13 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Modules")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 33 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 33 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 34 row: 1 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 34 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("text", "get_modules")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 34 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 34 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 50 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 50 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "default")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "table"
			stack.put (temp)
				-- line: 35 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 35 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 40 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 40 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 36 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 36 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 37 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 37 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 36 row: 12 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 36 row: 12 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Name")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 37 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 37 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 38 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 38 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 37 row: 16 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 37 row: 16 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Launched")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 38 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 38 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 39 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 39 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 38 row: 15 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 38 row: 15 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Running")
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
			stack.remove
				-- line: 40 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 40 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 49 row: 1 of file: ./index.xeb
			create {XTAG_XEB_ITERATE_TAG} temp.make
			temp.debug_information := "line: 49 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("list", "modules")
			temp.put_value_attribute("variable", "module")
			temp.put_value_attribute("type", "XC_SERVER_MODULE_BEAN")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "iterate"
			stack.put (temp)
				-- line: 41 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 41 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 47 row: 9 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 47 row: 9 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 42 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 42 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 43 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 43 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 42 row: 46 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 42 row: 46 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "module.name")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 44 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 45 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 45 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 44 row: 57 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 44 row: 57 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "module.is_launched.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 46 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 46 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 47 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 47 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 46 row: 56 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 46 row: 56 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "module.is_running.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 46 row: 58 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 46 row: 58 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " (")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 46 row: 133 of file: ./index.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 46 row: 133 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "stop")
			temp.put_value_attribute("action", "shutdown_mod")
			temp.put_value_attribute("variable", "module.name")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "command_link"
				-- line: 46 row: 136 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 46 row: 136 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " | ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 46 row: 213 of file: ./index.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 46 row: 213 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "restart")
			temp.put_value_attribute("action", "relaunch_mod")
			temp.put_value_attribute("variable", "module.name")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "command_link"
				-- line: 46 row: 214 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 46 row: 214 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", ")")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 47 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 47 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 48 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 48 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 49 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 49 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 51 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 51 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 52 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 52 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h1"
			stack.put (temp)
				-- line: 51 row: 13 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 51 row: 13 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Webapps")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 53 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 53 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 54 row: 1 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 54 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("text", "get_webapps")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 54 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 54 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 82 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 82 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "default")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "table"
			stack.put (temp)
				-- line: 55 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 55 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 66 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 66 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 56 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 56 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 57 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 57 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 56 row: 12 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 56 row: 12 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Name")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 57 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 57 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 58 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 58 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 57 row: 20 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 57 row: 20 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Webapp Host ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 58 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 58 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 59 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 59 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 58 row: 12 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 58 row: 12 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Port")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 59 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 59 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 60 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 60 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 59 row: 19 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 59 row: 19 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Interactive")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 60 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 60 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 61 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 61 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 60 row: 15 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 60 row: 15 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Status ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 61 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 61 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 61 row: 22 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 61 row: 22 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 61 row: 17 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 61 row: 17 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Sessions ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 62 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 62 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " %N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 62 row: 21 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 62 row: 21 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 62 row: 16 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 62 row: 16 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Disabled")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 63 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 63 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 64 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 64 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 63 row: 24 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 63 row: 24 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Development Mode")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 65 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 65 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 66 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 66 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 81 row: 1 of file: ./index.xeb
			create {XTAG_XEB_ITERATE_TAG} temp.make
			temp.debug_information := "line: 81 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("list", "webapps")
			temp.put_value_attribute("variable", "webapp")
			temp.put_value_attribute("type", "XC_WEBAPP_BEAN")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "iterate"
			stack.put (temp)
				-- line: 67 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 67 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 80 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 80 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 68 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 68 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 69 row: 1 of file: ./index.xeb
			create {XTAG_XEB_SET_VARIABLE_TAG} temp.make
			temp.debug_information := "line: 69 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("variable", "wappurl")
			temp.put_value_attribute("value", "../")
			temp.put_value_attribute("type", "STRING")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "set_variable"
				-- line: 69 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 69 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 70 row: 1 of file: ./index.xeb
			create {XTAG_XEB_CONCAT_TAG} temp.make
			temp.debug_information := "line: 70 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("variable", "wappurl")
			temp.put_variable_attribute("right", "webapp.app_config.name.value.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "concat"
				-- line: 70 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 70 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 71 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 71 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 70 row: 92 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 70 row: 92 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("href", "wappurl")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 70 row: 88 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 70 row: 88 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "webapp.app_config.name.value.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
			stack.remove
				-- line: 71 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 71 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 72 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 72 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 71 row: 74 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 71 row: 74 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "webapp.app_config.webapp_host.value.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 72 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 72 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 73 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 73 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 72 row: 67 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 72 row: 67 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "webapp.app_config.port.value.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 73 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 73 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 74 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 74 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 73 row: 71 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 73 row: 71 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "webapp.app_config.is_interactive.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 74 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 74 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 75 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 75 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 74 row: 48 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 74 row: 48 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "webapp.status")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 75 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 75 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 76 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 76 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 75 row: 54 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 75 row: 54 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "webapp.sessions.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 76 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 76 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 77 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 77 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 76 row: 57 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 76 row: 57 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "webapp.is_disabled.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 76 row: 59 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 76 row: 59 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " (")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 76 row: 155 of file: ./index.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 76 row: 155 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "on")
			temp.put_value_attribute("action", "disable_webapp")
			temp.put_value_attribute("variable", "webapp.app_config.name.value.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "command_link"
				-- line: 76 row: 158 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 76 row: 158 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " | ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 76 row: 254 of file: ./index.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 76 row: 254 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "off")
			temp.put_value_attribute("action", "enable_webapp")
			temp.put_value_attribute("variable", "webapp.app_config.name.value.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "command_link"
				-- line: 76 row: 255 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 76 row: 255 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", ")")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 77 row: 5 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 77 row: 5 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 78 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 78 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 77 row: 54 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 77 row: 54 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "webapp.dev_mode.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 77 row: 56 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 77 row: 56 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " (")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 77 row: 156 of file: ./index.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 77 row: 156 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "on")
			temp.put_value_attribute("action", "dev_mode_on_webapp")
			temp.put_value_attribute("variable", "webapp.app_config.name.value.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "command_link"
				-- line: 77 row: 159 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 77 row: 159 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " | ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 77 row: 261 of file: ./index.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 77 row: 261 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "off")
			temp.put_value_attribute("action", "dev_mode_off_webapp")
			temp.put_value_attribute("variable", "webapp.app_config.name.value.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "command_link"
				-- line: 77 row: 262 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 77 row: 262 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", ")")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 79 row: 4 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 79 row: 4 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 80 row: 3 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 80 row: 3 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 81 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 81 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 84 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 84 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%N%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 85 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 85 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 86 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 86 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 89 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 89 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "footer")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 87 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 87 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 88 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 88 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "footertext")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 87 row: 43 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 87 row: 43 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Xebra Server Control")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 88 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 88 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 89 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 89 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 90 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 90 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 91 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 91 row: 2 of file: ./index.xeb"
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
