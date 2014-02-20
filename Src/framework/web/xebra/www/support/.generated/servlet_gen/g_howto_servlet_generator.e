note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_HOWTO_SERVLET_GENERATOR

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
				-- line: 94 row: 2 of file: ./howto.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 94 row: 2 of file: ./howto.xeb"
			l_root_tag := temp
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 94 row: 1 of file: ./howto.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 94 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("template", "support_side")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "include"
			stack.put (temp)
				-- line: 33 row: 2 of file: ./support_side.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 33 row: 2 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 33 row: 1 of file: ./support_side.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 33 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("template", "support_master")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "include"
			stack.put (temp)
				-- line: 76 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 76 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 2 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 2 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "<!DOCTYPE html PUBLIC %"-//W3C//DTD XHTML 1.0 Strict//EN%" %"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd%">%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 75 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 75 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 3 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 3 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 4 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 4 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "controller"
				-- line: 4 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 10 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 10 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "head"
			stack.put (temp)
				-- line: 5 row: 3 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 3 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 8 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "noscript"
			stack.put (temp)
				-- line: 6 row: 4 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 4 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 7 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 7 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("http-equiv", "refresh")
			temp.put_value_attribute("id", "refresh")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "meta"
				-- line: 7 row: 3 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 3 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 8 row: 3 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 3 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 9 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 9 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("rel", "stylesheet")
			temp.put_value_attribute("type", "text/css")
			temp.put_value_attribute("id", "stylesheet")
			temp.put_value_attribute("href", "/support/default.css")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "link"
				-- line: 9 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 10 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 74 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 74 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "body"
			stack.put (temp)
				-- line: 11 row: 3 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 3 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 63 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 63 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "shadow_top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 12 row: 4 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 4 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 57 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 57 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "shadow_bottom")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 13 row: 5 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 13 row: 5 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 56 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 56 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "wrap")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 14 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 15 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 15 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "header")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 14 row: 82 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 14 row: 82 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("src", "/support/images/support/banner.jpg")
			temp.put_value_attribute("alt", "login")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
			stack.remove
				-- line: 15 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 39 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 39 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "navbars")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 16 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 16 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 24 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 24 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "general_links")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 17 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 17 row: 50 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 17 row: 50 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://www.eiffel.com")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 17 row: 46 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 46 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Eiffel")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 18 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 18 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " |%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 19 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 19 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "default.xeb")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 18 row: 34 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 18 row: 34 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Home")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 19 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 23 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 23 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "is_logged_in")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 20 row: 11 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 20 row: 11 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/| ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 20 row: 71 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 20 row: 71 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 20 row: 57 of file: ./support_master.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 20 row: 57 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("text", "user_name")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 20 row: 67 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 20 row: 67 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "'s support")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 21 row: 9 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 9 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " |%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 22 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 22 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "problem_report_form.xeb")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 21 row: 59 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 59 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Report a problem")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 22 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 22 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 23 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 23 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 24 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 24 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 36 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 36 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "nav_bar")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 25 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 25 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 35 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 35 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "nav_bar_links")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 26 row: 9 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 26 row: 9 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 29 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 29 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "is_not_logged_in")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 27 row: 10 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 10 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 27 row: 73 of file: ./support_master.xeb
			create {XTAG_F_FORM_TAG} temp.make
			temp.debug_information := "line: 27 row: 73 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "form"
			stack.put (temp)
				-- line: 27 row: 64 of file: ./support_master.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 27 row: 64 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("action", "login")
			temp.put_value_attribute("text", "Login")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "command_link"
			stack.remove
				-- line: 27 row: 76 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 76 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " | ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 28 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 28 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 27 row: 95 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 95 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Register")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 28 row: 9 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 28 row: 9 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 29 row: 9 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 29 row: 9 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 34 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 34 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "is_logged_in")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 30 row: 10 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 30 row: 10 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 33 row: 1 of file: ./support_master.xeb
			create {XTAG_F_FORM_TAG} temp.make
			temp.debug_information := "line: 33 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "form"
			stack.put (temp)
				-- line: 31 row: 11 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 31 row: 11 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 32 row: 1 of file: ./support_master.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 32 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Logout")
			temp.put_value_attribute("action", "logout")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "command_link"
				-- line: 32 row: 10 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 32 row: 10 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 33 row: 9 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 33 row: 9 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 34 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 34 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 35 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 35 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 36 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 36 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 37 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 37 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "spacer")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 37 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 37 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 38 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 38 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "responsibles_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 38 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 38 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 39 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 39 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 47 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 47 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "main_form")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 40 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 40 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 43 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 43 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "is_logged_in")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 41 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 41 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 42 row: 1 of file: ./support_master.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 42 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "default_authorized_main_content")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "declare_region"
			stack.put (temp)
				-- line: 3 row: 3 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 3 row: 3 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 23 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 23 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "sidebar")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 4 row: 4 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 4 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 22 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 22 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "vert_bar_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 5 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 6 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 6 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h3"
			stack.put (temp)
				-- line: 5 row: 21 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 21 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Self Support")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 6 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 12 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 12 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "vert_bar_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "ul"
			stack.put (temp)
				-- line: 7 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 8 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 7 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 7 row: 102 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 7 row: 102 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://www.eiffel.com/developers/presentations/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 7 row: 98 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 98 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Technical Presentations")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 8 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 9 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 9 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 8 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 8 row: 76 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 76 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://docs.eiffel.com/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 8 row: 72 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 72 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Product Documentation")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 9 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 10 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 10 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 9 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 9 row: 88 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 9 row: 88 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://groups.yahoo.com/group/eiffel_software/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 9 row: 84 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 84 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "User Group")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 10 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 11 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 11 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 10 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 10 row: 77 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 10 row: 77 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://activate.eiffel.com/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 10 row: 73 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 73 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Product Activation")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 11 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 12 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 13 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 13 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h3"
			stack.put (temp)
				-- line: 12 row: 25 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 25 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Assisted Support")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 13 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 13 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 17 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 17 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "vert_bar_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "ul"
			stack.put (temp)
				-- line: 14 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 15 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 15 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 14 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 14 row: 84 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 14 row: 84 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://www.eiffel.com/services/support/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 14 row: 80 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 80 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Support Plans")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 15 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 16 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 16 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 15 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 15 row: 98 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 15 row: 98 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://www.eiffel.com/services/training/index.html")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 15 row: 94 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 94 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Training Courses")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 16 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 16 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 17 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 18 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 18 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h3"
			stack.put (temp)
				-- line: 17 row: 27 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 27 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Account Management")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 18 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 18 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 21 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 21 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "vert_bar_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "ul"
			stack.put (temp)
				-- line: 19 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 20 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 20 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 19 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 19 row: 108 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 19 row: 108 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "<%%=login_root (True)%%>/secure/protected/account_info.aspx")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 19 row: 104 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 104 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Account Information")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 20 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 20 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 21 row: 4 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 4 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 22 row: 3 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 22 row: 3 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 23 row: 3 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 23 row: 3 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 28 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 28 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "content")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 24 row: 4 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 24 row: 4 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 25 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 25 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "prop")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 25 row: 4 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 25 row: 4 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 26 row: 1 of file: ./support_side.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 26 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "main_content")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "declare_region"
			stack.put (temp)
				-- line: 3 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 3 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 92 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 92 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 4 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 5 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 5 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "title_box")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 4 row: 59 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 4 row: 59 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h1"
			stack.put (temp)
				-- line: 4 row: 54 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 54 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Submitting a Problem Report")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 5 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 13 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 13 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "p"
			stack.put (temp)
				-- line: 8 row: 6 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 6 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/Following these recommendations will help us provide you with a speedier and more %N%/9/%/9/efficient response to your problem. There are specific recommendations when submitting%N%/9/%/9/a ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 8 row: 38 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 38 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "#compiler")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 8 row: 34 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 34 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "compiler")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 8 row: 43 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 43 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", ", an ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 8 row: 83 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 83 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "#eiffelstudio")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 8 row: 79 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 79 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "EiffelStudio")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 9 row: 6 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 6 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " or%N%/9/%/9/a ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 9 row: 36 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 9 row: 36 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "#library")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 9 row: 32 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 32 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "library")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 11 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " (i.e. a problem with EiffelBase, EiffelVision2 or any %N%/9/%/9/other source library provided with our products) problem report. There are also %N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 11 row: 35 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 11 row: 35 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "#any")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 11 row: 31 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 31 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "instructions")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 12 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " applicable to any problem report.%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 13 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 13 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 16 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 16 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "compiler")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 14 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 15 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 15 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h2"
			stack.put (temp)
				-- line: 14 row: 44 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 44 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Submitting a Compiler Problem Report")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 15 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 16 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 16 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 21 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 21 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "p"
			stack.put (temp)
				-- line: 20 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 20 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/Before submitting a compiler related report, please modify the configuration of%N%/9/%/9/the product so that it generates additional information we will use to find the cause of%N%/9/%/9/the problem:%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 21 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 48 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 48 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "ul"
			stack.put (temp)
				-- line: 22 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 22 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 35 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 35 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 24 row: 5 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 24 row: 5 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/Edit the file `general.cfg' located in $ISE_EIFFEL/eifinit/studio and:%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 34 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 34 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "ol"
			stack.put (temp)
				-- line: 25 row: 6 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 25 row: 6 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 29 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 29 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 26 row: 24 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 26 row: 24 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/Replace the line ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 26 row: 73 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 26 row: 73 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "code")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 26 row: 66 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 26 row: 66 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "automatic_backup: False")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 27 row: 7 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 7 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " with %N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 27 row: 55 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 27 row: 55 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "code")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 27 row: 48 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 48 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "automatic_backup: True")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 28 row: 6 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 28 row: 6 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", ".%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 29 row: 6 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 29 row: 6 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 33 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 33 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 30 row: 24 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 30 row: 24 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/Replace the line ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 30 row: 71 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 30 row: 71 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "code")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 30 row: 64 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 30 row: 64 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "fail_on_rescue: False")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 31 row: 7 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 31 row: 7 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " with%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 31 row: 53 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 31 row: 53 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "code")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 31 row: 46 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 31 row: 46 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "fail_on_rescue: True")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 32 row: 6 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 32 row: 6 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", ".%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 33 row: 5 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 33 row: 5 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 34 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 34 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 35 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 35 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 38 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 38 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 37 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 37 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/Delete the EIFGEN folder generated by the compiler.%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 38 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 38 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 43 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 43 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 40 row: 57 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 40 row: 57 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/Relaunch the compilation until it fails: On Windows a trace should appear in a DOS prompt, %N%/9/%/9/%/9/a copy of its content will be saved in a file named ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 40 row: 83 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 40 row: 83 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "i"
			stack.put (temp)
				-- line: 40 row: 79 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 40 row: 79 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "exception_trace.log")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 41 row: 35 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 41 row: 35 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", ". On Unix, copy %N%/9/%/9/%/9/the output into a file called ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 41 row: 61 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 41 row: 61 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "i"
			stack.put (temp)
				-- line: 41 row: 57 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 41 row: 57 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "exception_trace.log")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 42 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 42 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", ".%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 43 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 43 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 47 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 47 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 44 row: 46 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 46 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/Attach a zip package containing the file ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 44 row: 72 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 44 row: 72 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "i"
			stack.put (temp)
				-- line: 44 row: 68 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 68 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "exception_trace.log")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 44 row: 81 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 81 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " and the ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 44 row: 94 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 44 row: 94 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "i"
			stack.put (temp)
				-- line: 44 row: 90 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 90 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "BACKUP")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 45 row: 20 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 45 row: 20 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " directory %N%/9/%/9/%/9/located in the ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 45 row: 33 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 45 row: 33 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "i"
			stack.put (temp)
				-- line: 45 row: 29 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 45 row: 29 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "EIFGEN")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 46 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 46 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " directory to the problem report. %N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 47 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 47 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 48 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 48 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 52 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 52 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "p"
			stack.put (temp)
				-- line: 49 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 49 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 49 row: 16 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 49 row: 16 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "b"
			stack.put (temp)
				-- line: 49 row: 12 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 49 row: 12 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Note:")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 50 row: 88 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 50 row: 88 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " If a dialog box appears instead of a DOS console on Windows or an output trace on Unix when%N%/9/%/9/EiffelStudio fails then please send us the content of the dialog box instead of the ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 50 row: 114 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 50 row: 114 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "I"
			stack.put (temp)
				-- line: 50 row: 110 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 50 row: 110 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "exception_trace.log")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 51 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 51 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " file.%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 52 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 52 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 55 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 55 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "eiffelstudio")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 53 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 53 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 54 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 54 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h2"
			stack.put (temp)
				-- line: 53 row: 49 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 53 row: 49 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Submitting an EiffelStudio Problem Report")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 54 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 54 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 55 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 55 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 60 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 60 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "p"
			stack.put (temp)
				-- line: 57 row: 58 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 57 row: 58 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/If the problem occurs during compilation then the problem is probably a compiler problem. Please%N%/9/%/9/use the compiler category and follow the instructions ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 57 row: 87 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 57 row: 87 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "#compiler")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 57 row: 83 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 57 row: 83 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "above")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 59 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 59 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " to submit the%N%/9/%/9/report.%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 60 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 60 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 64 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 64 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "p"
			stack.put (temp)
				-- line: 63 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 63 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/If a crash occurs, then a dialog box appears with an exception trace in it. Copy the %N%/9/%/9/exception trace and include it in the problem report.%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 64 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 64 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 67 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 67 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "p"
			stack.put (temp)
				-- line: 66 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 66 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/As always provide as much details as possible.%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 67 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 67 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 70 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 70 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "library")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 68 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 68 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 69 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 69 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h2"
			stack.put (temp)
				-- line: 68 row: 43 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 68 row: 43 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Submitting a Library Problem Report")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 69 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 69 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 70 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 70 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 77 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 77 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "p"
			stack.put (temp)
				-- line: 76 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 76 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/When you find a problem using a source library, please send us a complete %N%/9/%/9/package when submitting a problem report so we can rebuild your system. If you are using%N%/9/%/9/a precompiled library, make sure that the problem still occurs when not using it. The %N%/9/%/9/package should contain your Ace file (not using a precompiled library), your Eiffel source%N%/9/%/9/code files and any other file that may be required to rebuild the system.%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 77 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 77 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 82 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 82 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "p"
			stack.put (temp)
				-- line: 80 row: 28 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 80 row: 28 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/If the problem only occurs when using a precompiled library the problem is probably not%N%/9/%/9/a library problem but rather a compiler problem. please use the compiler category and %N%/9/%/9/follow the instructions ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 80 row: 57 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 80 row: 57 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "#compiler")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 80 row: 53 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 80 row: 53 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "above")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 81 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 81 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", ".%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 82 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 82 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 85 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 85 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "any")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 83 row: 4 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 83 row: 4 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 84 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 84 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h2"
			stack.put (temp)
				-- line: 83 row: 37 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 83 row: 37 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Submitting any Problem Report")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 84 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 84 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 85 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 85 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 91 row: 1 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 91 row: 1 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "p"
			stack.put (temp)
				-- line: 87 row: 60 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 87 row: 60 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/If you have a problem with any Eiffel Software product, please send us all the required%N%/9/%/9/instructions necessary to reproduce the problem (in the ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 87 row: 79 of file: ./howto.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 87 row: 79 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "b"
			stack.put (temp)
				-- line: 87 row: 75 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 87 row: 75 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "To Reproduce")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 90 row: 3 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 90 row: 3 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " field). If %N%/9/%/9/the problem cannot be reproduced we will probably not be able to provide you with a %N%/9/%/9/solution and you might consider waiting until you can reproduce the problem before submitting it.%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 91 row: 2 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 91 row: 2 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 92 row: 2 of file: ./howto.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 92 row: 2 of file: ./howto.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 26 row: 4 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 26 row: 4 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 27 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 27 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "spacer")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 27 row: 3 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 3 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 28 row: 2 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 28 row: 2 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 42 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 42 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 43 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 43 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 46 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 46 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "is_not_logged_in")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 44 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 45 row: 1 of file: ./support_master.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 45 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "default_not_authorized_main_content")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "declare_region"
			stack.put (temp)
				-- line: 31 row: 2 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 31 row: 2 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%NYou are not logged in!%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 45 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 45 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 46 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 46 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 47 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 47 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 55 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 55 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "footer")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 48 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 48 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 48 row: 105 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 48 row: 105 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://www.eiffel.com/general/contact_details.html")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 48 row: 101 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 48 row: 101 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Questions? Comments? Let us know!")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 49 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 49 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "br"
				-- line: 50 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 50 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/&copy; 1993-2009 Eiffel Software inc. All rights reserved. --%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 51 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 51 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://www.eiffel.com/general/privacy_policy.html")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 50 row: 81 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 50 row: 81 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Privacy Policy")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 51 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 51 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 54 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 54 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "logo")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 52 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 52 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 53 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 53 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("src", "/support/images/support/xebra_for_eiffel.png")
			temp.put_value_attribute("alt", "Xebra for Eiffel")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
				-- line: 53 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 53 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 54 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 54 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 55 row: 5 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 55 row: 5 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 56 row: 4 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 56 row: 4 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 57 row: 4 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 57 row: 4 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 62 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 62 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "shadow_horizontal")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 58 row: 5 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 58 row: 5 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 59 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 59 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "shadow_horizontal_left")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 59 row: 5 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 59 row: 5 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 60 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 60 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "shadow_horizontal_middle")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 60 row: 5 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 60 row: 5 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 61 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 61 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "shadow_horizontal_right")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 61 row: 4 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 61 row: 4 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 62 row: 3 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 62 row: 3 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 64 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 64 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N<!-- The Following is for Google Analytics -->%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 68 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 68 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "text/javascript")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "script"
			stack.put (temp)
				-- line: 67 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 67 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%Nvar gaJsHost = ((%"https:%" == document.location.protocol) ? %"https://ssl.%" : %"http://www.%");%Ndocument.write(unescape(%"%%3Cscript src='%" + gaJsHost + %"google-analytics.com/ga.js' type='text/javascript'%%3E%%3C/script%%3E%"));%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 68 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 68 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 73 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 73 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "text/javascript")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "script"
			stack.put (temp)
				-- line: 72 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 72 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%Nvar pageTracker = _gat._getTracker(%"UA-1289714-2%");%NpageTracker._initData();%NpageTracker._trackPageview();%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 73 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 73 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 74 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 74 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
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
