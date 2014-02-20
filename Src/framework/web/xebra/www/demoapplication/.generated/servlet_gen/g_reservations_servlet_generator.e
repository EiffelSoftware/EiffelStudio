note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_RESERVATIONS_SERVLET_GENERATOR

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
				-- line: 105 row: 2 of file: ./reservations.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 105 row: 2 of file: ./reservations.xeb"
			l_root_tag := temp
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 105 row: 1 of file: ./reservations.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 105 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("template", "master_template")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "include"
			stack.put (temp)
				-- line: 45 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 45 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 2 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 2 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "<!DOCTYPE html PUBLIC %"-//W3C//DTD XHTML 1.0 Transitional//EN%" %"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd%">%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 45 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 45 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("xmlns", "http://www.w3.org/1999/xhtml")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 3 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 3 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 10 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 10 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "head"
			stack.put (temp)
				-- line: 4 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 5 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 5 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "controller"
				-- line: 5 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 6 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 6 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("http-equiv", "Content-Type")
			temp.put_value_attribute("content", "text/html; charset=utf-8")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "meta"
				-- line: 6 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 7 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 7 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "title"
			stack.put (temp)
				-- line: 6 row: 31 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 31 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Xebra Demo Application")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 7 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 8 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "base.css")
			temp.put_value_attribute("rel", "stylesheet")
			temp.put_value_attribute("type", "text/css")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "link"
				-- line: 8 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 8 row: 104 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 104 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("language", "javascript1.2")
			temp.put_value_attribute("type", "text/javascript")
			temp.put_value_attribute("src", "Scripts/codethatcalendarstd.js")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "script"
				-- line: 9 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 9 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("language", "javascript1.2")
			temp.put_value_attribute("type", "text/javascript")
			temp.put_value_attribute("src", "scroller_ex.js")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "script"
				-- line: 9 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 10 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 44 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 44 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "body"
			stack.put (temp)
				-- line: 11 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 43 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 43 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "main")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 12 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 27 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 27 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "header_title")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 13 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 13 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 26 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 26 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "login_text")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 14 row: 3 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 3 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 19 row: 19 of file: ./master_template.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 19 row: 19 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "authenticated")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 15 row: 13 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 13 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " Welcome%N%/9/          ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 16 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 16 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("text", "username")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "display"
				-- line: 16 row: 14 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 16 row: 14 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/          ,")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 19 row: 1 of file: ./master_template.xeb
			create {XTAG_F_FORM_TAG} temp.make
			temp.debug_information := "line: 19 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("variable", "b")
			temp.put_value_attribute("class", "login_bean")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "form"
			stack.put (temp)
				-- line: 17 row: 5 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 5 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 18 row: 1 of file: ./master_template.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 18 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Logout")
			temp.put_value_attribute("action", "logout")
			temp.put_value_attribute("variable", "b")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "command_link"
				-- line: 18 row: 4 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 18 row: 4 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 19 row: 3 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 3 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 21 row: 3 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 3 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " %N%/9/ %N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 24 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 24 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "not_authenticated")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 22 row: 5 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 22 row: 5 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/ ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 23 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 23 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "login.xeb")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 22 row: 30 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 22 row: 30 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Login")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 23 row: 3 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 23 row: 3 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 25 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 25 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 26 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 26 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 27 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 28 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 28 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "header_img")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
				-- line: 28 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 28 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 37 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 37 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "column nav")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 29 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 29 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 30 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 30 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "h2"
			stack.put (temp)
				-- line: 29 row: 16 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 29 row: 16 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Navigation")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 30 row: 3 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 30 row: 3 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 36 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 36 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "ul"
			stack.put (temp)
				-- line: 31 row: 10 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 31 row: 10 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N        ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 32 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 32 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 31 row: 42 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 31 row: 42 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "index.xeb")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 31 row: 38 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 31 row: 38 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Home")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 32 row: 10 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 32 row: 10 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N        ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 33 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 33 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 32 row: 57 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 32 row: 57 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "reservations.xeb")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 32 row: 53 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 32 row: 53 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Reservations")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 33 row: 3 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 33 row: 3 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 34 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 34 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 33 row: 38 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 33 row: 38 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "upload.xeb")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 33 row: 34 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 33 row: 34 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Upload")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 34 row: 10 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 34 row: 10 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N        ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 35 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 35 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 34 row: 47 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 34 row: 47 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "contact.xeb")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 34 row: 43 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 34 row: 43 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Contact")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 35 row: 7 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 35 row: 7 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N     ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 36 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 36 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 37 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 37 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 38 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 38 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "column line")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
				-- line: 38 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 38 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 41 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 41 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "column content")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 39 row: 3 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 39 row: 3 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 40 row: 1 of file: ./master_template.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 40 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "content")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "declare_region"
			stack.put (temp)
				-- line: 4 row: 4 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 4 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 5 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 5 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "style1")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h2"
			stack.put (temp)
				-- line: 4 row: 35 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 35 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Reservations")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 5 row: 4 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 4 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 8 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 8 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "not_authenticated")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 6 row: 5 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 5 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 7 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 7 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "p"
			stack.put (temp)
				-- line: 6 row: 42 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 42 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Please log in to see reservations.")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 7 row: 4 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 4 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 8 row: 4 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 4 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 43 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 43 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "authenticated")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 9 row: 5 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 5 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 42 row: 1 of file: ./reservations.xeb
			create {XTAG_F_FORM_TAG} temp.make
			temp.debug_information := "line: 42 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "form"
			stack.put (temp)
				-- line: 10 row: 5 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 5 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 41 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 41 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("width", "100%%")
			temp.put_value_attribute("border", "0")
			temp.put_value_attribute("cellpadding", "0")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "table"
			stack.put (temp)
				-- line: 11 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 22 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 22 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tableheader")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 12 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 13 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 13 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 12 row: 15 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 15 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Name")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 13 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 13 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 14 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 14 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 13 row: 15 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 13 row: 15 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Date")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 14 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 15 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 15 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 14 row: 18 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 18 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Persons")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 15 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 18 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 18 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "authenticated_admin")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 16 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 16 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 17 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 17 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 16 row: 18 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 16 row: 18 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Delete")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 17 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 18 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 18 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 21 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 21 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "not_authenticated_admin")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 19 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 20 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 20 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 19 row: 19 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 19 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Details")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 20 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 20 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 21 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 23 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 23 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 39 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_ITERATE_TAG} temp.make
			temp.debug_information := "line: 39 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("list", "global_state.db.reservations")
			temp.put_value_attribute("variable", "reservation")
			temp.put_value_attribute("type", "RESERVATION")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "iterate"
			stack.put (temp)
				-- line: 25 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 25 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 38 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 38 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 26 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 26 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 27 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 27 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 26 row: 53 of file: ./reservations.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 26 row: 53 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "reservation.name")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 27 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 28 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 28 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 27 row: 57 of file: ./reservations.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 27 row: 57 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "reservation.date.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 28 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 28 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 29 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 29 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 28 row: 58 of file: ./reservations.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 28 row: 58 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "reservation.s_persons")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 29 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 29 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 34 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 34 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "authenticated_admin")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 30 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 30 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 32 row: 14 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 32 row: 14 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "style2")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 31 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 31 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 32 row: 1 of file: ./reservations.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 32 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Delete")
			temp.put_value_attribute("action", "delete")
			temp.put_value_attribute("variable", "reservation")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "command_link"
				-- line: 32 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 32 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 33 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 33 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 34 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 34 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 37 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 37 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "not_authenticated_admin")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 35 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 35 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 36 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 36 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "style2")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 35 row: 50 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 35 row: 50 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 35 row: 46 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 35 row: 46 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Details")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 36 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 36 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 37 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 37 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 38 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 38 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 40 row: 5 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 40 row: 5 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 41 row: 5 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 41 row: 5 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 42 row: 4 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 42 row: 4 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 43 row: 4 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 43 row: 4 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 103 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 103 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "authenticated_admin")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 44 row: 5 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 5 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 45 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 45 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "style1")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h2"
			stack.put (temp)
				-- line: 44 row: 39 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 39 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "New Reservation")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 45 row: 5 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 45 row: 5 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 102 row: 1 of file: ./reservations.xeb
			create {XTAG_F_FORM_TAG} temp.make
			temp.debug_information := "line: 102 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("variable", "new_reservation")
			temp.put_value_attribute("class", "RESERVATION")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "form"
			stack.put (temp)
				-- line: 46 row: 5 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 46 row: 5 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 101 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 101 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("width", "400")
			temp.put_value_attribute("border", "0")
			temp.put_value_attribute("cellpadding", "2")
			temp.put_value_attribute("cellspacing", "2")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "table"
			stack.put (temp)
				-- line: 47 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 47 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 59 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 59 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 48 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 48 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 49 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 49 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 48 row: 15 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 48 row: 15 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Name")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 49 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 49 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 58 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 58 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 50 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 50 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 54 row: 1 of file: ./reservations.xeb
			create {XTAG_F_INPUT_TAG} temp.make
			temp.debug_information := "line: 54 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("value", "name")
			temp.put_value_attribute("name", "a_name")
			temp.put_dynamic_attribute("text", "logged_in_name")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input_text"
			stack.put (temp)
				-- line: 51 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 51 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 52 row: 1 of file: ./reservations.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 52 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 52 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 52 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 53 row: 1 of file: ./reservations.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 53 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_ALPHA_NUMERIC_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 53 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 53 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 54 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 54 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 57 row: 1 of file: ./reservations.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 57 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "a_name")
			temp.put_value_attribute("variable", "name_errors")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.put (temp)
				-- line: 55 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 55 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 55 row: 15 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 55 row: 15 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "br"
				-- line: 56 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 56 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "name_errors.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 56 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 56 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 57 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 57 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 58 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 58 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 59 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 59 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 70 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 70 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 60 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 60 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 61 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 61 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 60 row: 15 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 60 row: 15 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Date")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 61 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 61 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 69 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 69 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 62 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 62 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 65 row: 1 of file: ./reservations.xeb
			create {XTAG_F_CALENDAR_TAG} temp.make
			temp.debug_information := "line: 65 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("value", "date")
			temp.put_value_attribute("name", "a_date")
			temp.put_variable_attribute("date", "new_reservation.date.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "calendar"
			stack.put (temp)
				-- line: 63 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 63 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 64 row: 1 of file: ./reservations.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 64 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 64 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 64 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 65 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 65 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 68 row: 1 of file: ./reservations.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 68 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "a_date")
			temp.put_value_attribute("variable", "date_errors")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.put (temp)
				-- line: 66 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 66 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 66 row: 15 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 66 row: 15 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "br"
				-- line: 67 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 67 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "date_errors.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 67 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 67 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 68 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 68 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 69 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 69 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 70 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 70 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 83 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 83 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 71 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 71 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 72 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 72 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 71 row: 18 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 71 row: 18 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Persons")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 72 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 72 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 82 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 82 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 73 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 73 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 78 row: 1 of file: ./reservations.xeb
			create {XTAG_F_INPUT_TAG} temp.make
			temp.debug_information := "line: 78 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("value", "s_persons")
			temp.put_value_attribute("name", "a_s_persons")
			temp.put_variable_attribute("text", "new_reservation.s_persons")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input_text"
			stack.put (temp)
				-- line: 74 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 74 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 75 row: 1 of file: ./reservations.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 75 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 75 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 75 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 76 row: 1 of file: ./reservations.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 76 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NUMBER_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 76 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 76 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 77 row: 1 of file: ./reservations.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 77 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_BIGGER_THAN_ZERO_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 77 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 77 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 78 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 78 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 81 row: 1 of file: ./reservations.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 81 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "a_s_persons")
			temp.put_value_attribute("variable", "persons_errors")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.put (temp)
				-- line: 79 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 79 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 79 row: 15 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 79 row: 15 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "br"
				-- line: 80 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 80 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "persons_errors.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 80 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 80 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 81 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 81 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 82 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 82 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 83 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 83 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 94 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 94 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 84 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 84 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 85 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 85 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 84 row: 22 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 84 row: 22 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Description")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 85 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 85 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 93 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 93 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 86 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 86 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 89 row: 1 of file: ./reservations.xeb
			create {XTAG_F_TEXTAREA_TAG} temp.make
			temp.debug_information := "line: 89 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("value", "description")
			temp.put_value_attribute("name", "a_description")
			temp.put_variable_attribute("text", "new_reservation.description")
			temp.put_value_attribute("cols", "45")
			temp.put_value_attribute("rows", "5")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "text_area"
			stack.put (temp)
				-- line: 87 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 87 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 88 row: 1 of file: ./reservations.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 88 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 88 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 88 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 89 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 89 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 92 row: 1 of file: ./reservations.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 92 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "a_description")
			temp.put_value_attribute("variable", "description_errors")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.put (temp)
				-- line: 90 row: 9 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 90 row: 9 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 90 row: 15 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 90 row: 15 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "br"
				-- line: 91 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 91 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "description_errors.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 91 row: 8 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 91 row: 8 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 92 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 92 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 93 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 93 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 94 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 94 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 100 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 100 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 95 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 95 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 99 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 99 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("colspan", "2")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 96 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 96 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 98 row: 1 of file: ./reservations.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 98 row: 1 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("align", "center")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 97 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 97 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 97 row: 59 of file: ./reservations.xeb
			create {XTAG_F_BUTTON_TAG} temp.make
			temp.debug_information := "line: 97 row: 59 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Save")
			temp.put_value_attribute("action", "save")
			temp.put_value_attribute("type", "submit")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "button"
			stack.remove
				-- line: 98 row: 7 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 98 row: 7 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 99 row: 6 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 99 row: 6 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 100 row: 5 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 100 row: 5 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 101 row: 5 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 101 row: 5 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 102 row: 4 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 102 row: 4 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 103 row: 3 of file: ./reservations.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 103 row: 3 of file: ./reservations.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 40 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 40 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 41 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 41 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 42 row: 1 of file: ./master_template.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 42 row: 1 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "footer")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
				-- line: 42 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 42 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 43 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 43 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 44 row: 2 of file: ./master_template.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 2 of file: ./master_template.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
			stack.remove
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
