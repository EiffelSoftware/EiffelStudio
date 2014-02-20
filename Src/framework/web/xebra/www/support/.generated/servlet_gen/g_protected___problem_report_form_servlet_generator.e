note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_PROTECTED___PROBLEM_REPORT_FORM_SERVLET_GENERATOR

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
				-- line: 199 row: 2 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 199 row: 2 of file: ./protected/problem_report_form.xeb"
			l_root_tag := temp
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 199 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 199 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("template", "support_side")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "include"
			stack.put (temp)
				-- line: 33 row: 2 of file: ./support_side.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 33 row: 2 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 33 row: 1 of file: ./support_side.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 33 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("template", "support_master")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "include"
			stack.put (temp)
				-- line: 76 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 76 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 2 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 2 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "<!DOCTYPE html PUBLIC %"-//W3C//DTD XHTML 1.0 Strict//EN%" %"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd%">%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 75 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 75 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 3 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 3 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 4 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 4 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "controller"
				-- line: 4 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 10 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 10 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "head"
			stack.put (temp)
				-- line: 5 row: 3 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 3 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 8 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "noscript"
			stack.put (temp)
				-- line: 6 row: 4 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 4 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 7 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 7 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("http-equiv", "refresh")
			temp.put_value_attribute("id", "refresh")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "meta"
				-- line: 7 row: 3 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 3 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 8 row: 3 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 3 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 9 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 9 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("rel", "stylesheet")
			temp.put_value_attribute("type", "text/css")
			temp.put_value_attribute("id", "stylesheet")
			temp.put_value_attribute("href", "/support/default.css")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "link"
				-- line: 9 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 10 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 74 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 74 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "body"
			stack.put (temp)
				-- line: 11 row: 3 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 3 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 63 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 63 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "shadow_top")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 12 row: 4 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 4 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 57 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 57 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "shadow_bottom")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 13 row: 5 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 13 row: 5 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 56 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 56 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "wrap")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 14 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 15 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 15 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "header")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 14 row: 82 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 14 row: 82 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("src", "/support/images/support/banner.jpg")
			temp.put_value_attribute("alt", "login")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "img"
			stack.remove
				-- line: 15 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 39 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 39 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "navbars")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 16 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 16 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 24 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 24 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "general_links")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 17 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 17 row: 50 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 17 row: 50 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://www.eiffel.com")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 17 row: 46 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 46 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Eiffel")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 18 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 18 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " |%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 19 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 19 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "default.xeb")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 18 row: 34 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 18 row: 34 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Home")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 19 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 23 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 23 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "is_logged_in")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 20 row: 11 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 20 row: 11 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/| ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 20 row: 71 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 20 row: 71 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 20 row: 57 of file: ./support_master.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 20 row: 57 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("text", "user_name")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "display"
				-- line: 20 row: 67 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 20 row: 67 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "'s support")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 21 row: 9 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 9 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " |%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 22 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 22 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "problem_report_form.xeb")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 21 row: 59 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 59 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Report a problem")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 22 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 22 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 23 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 23 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 24 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 24 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 36 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 36 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "nav_bar")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 25 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 25 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 35 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 35 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "nav_bar_links")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 26 row: 9 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 26 row: 9 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 29 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 29 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "is_not_logged_in")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 27 row: 10 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 10 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 27 row: 73 of file: ./support_master.xeb
			create {XTAG_F_FORM_TAG} temp.make
			temp.debug_information := "line: 27 row: 73 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "form"
			stack.put (temp)
				-- line: 27 row: 64 of file: ./support_master.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 27 row: 64 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("action", "login")
			temp.put_value_attribute("text", "Login")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "command_link"
			stack.remove
				-- line: 27 row: 76 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 76 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " | ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 28 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 28 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 27 row: 95 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 95 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Register")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 28 row: 9 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 28 row: 9 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 29 row: 9 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 29 row: 9 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 34 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 34 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "is_logged_in")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 30 row: 10 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 30 row: 10 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 33 row: 1 of file: ./support_master.xeb
			create {XTAG_F_FORM_TAG} temp.make
			temp.debug_information := "line: 33 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "form"
			stack.put (temp)
				-- line: 31 row: 11 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 31 row: 11 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 32 row: 1 of file: ./support_master.xeb
			create {XTAG_F_COMMAND_LINK_TAG} temp.make
			temp.debug_information := "line: 32 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Logout")
			temp.put_value_attribute("action", "logout")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "command_link"
				-- line: 32 row: 10 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 32 row: 10 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 33 row: 9 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 33 row: 9 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 34 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 34 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 35 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 35 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 36 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 36 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 37 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 37 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "spacer")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
				-- line: 37 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 37 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 38 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 38 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "responsibles_link")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
				-- line: 38 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 38 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 39 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 39 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 47 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 47 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "main_form")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 40 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 40 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 43 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 43 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "is_logged_in")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 41 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 41 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 42 row: 1 of file: ./support_master.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 42 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "default_authorized_main_content")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "declare_region"
			stack.put (temp)
				-- line: 3 row: 3 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 3 row: 3 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 23 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 23 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "sidebar")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 4 row: 4 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 4 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 22 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 22 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "vert_bar_link")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 5 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 6 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 6 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "h3"
			stack.put (temp)
				-- line: 5 row: 21 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 21 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Self Support")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 6 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 12 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 12 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "vert_bar_link")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "ul"
			stack.put (temp)
				-- line: 7 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 8 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 7 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 7 row: 102 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 7 row: 102 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://www.eiffel.com/developers/presentations/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 7 row: 98 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 98 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Technical Presentations")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 8 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 9 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 9 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 8 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 8 row: 76 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 76 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://docs.eiffel.com/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 8 row: 72 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 72 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Product Documentation")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 9 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 10 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 10 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 9 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 9 row: 88 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 9 row: 88 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://groups.yahoo.com/group/eiffel_software/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 9 row: 84 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 84 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "User Group")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 10 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 11 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 11 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 10 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 10 row: 77 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 10 row: 77 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://activate.eiffel.com/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 10 row: 73 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 73 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Product Activation")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 11 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 12 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 13 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 13 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "h3"
			stack.put (temp)
				-- line: 12 row: 25 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 25 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Assisted Support")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 13 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 13 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 17 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 17 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "vert_bar_link")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "ul"
			stack.put (temp)
				-- line: 14 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 15 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 15 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 14 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 14 row: 84 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 14 row: 84 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://www.eiffel.com/services/support/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 14 row: 80 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 80 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Support Plans")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 15 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 16 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 16 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 15 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 15 row: 98 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 15 row: 98 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://www.eiffel.com/services/training/index.html")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 15 row: 94 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 94 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Training Courses")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 16 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 16 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 17 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 18 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 18 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "h3"
			stack.put (temp)
				-- line: 17 row: 27 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 27 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Account Management")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 18 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 18 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 21 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 21 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "vert_bar_link")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "ul"
			stack.put (temp)
				-- line: 19 row: 6 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 6 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 20 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 20 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "li"
			stack.put (temp)
				-- line: 19 row: 17 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 17 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "&#187; ")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 19 row: 108 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 19 row: 108 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "<%%=login_root (True)%%>/secure/protected/account_info.aspx")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 19 row: 104 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 104 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Account Information")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 20 row: 5 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 20 row: 5 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 21 row: 4 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 4 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 22 row: 3 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 22 row: 3 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 23 row: 3 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 23 row: 3 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 28 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 28 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "content")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 24 row: 4 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 24 row: 4 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 25 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 25 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "prop")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
				-- line: 25 row: 4 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 25 row: 4 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 26 row: 1 of file: ./support_side.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 26 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "main_content")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "declare_region"
			stack.put (temp)
				-- line: 4 row: 3 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 3 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 5 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 5 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "title_box")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 4 row: 57 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 4 row: 57 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h1"
			stack.put (temp)
				-- line: 4 row: 52 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 52 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Problem Report Submission")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 5 row: 3 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 3 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 10 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 10 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "p"
			stack.put (temp)
				-- line: 7 row: 22 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 22 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/Use this page to submit a problem report. If you haven't already we strongly suggest%N%/9/%/9/that you read the ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 8 row: 38 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 38 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "howto.xeb")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 8 row: 34 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 34 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "instructions%N%/9/%/9/for submitting problem reports")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 9 row: 3 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 3 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", ".%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 10 row: 3 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 3 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 197 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 197 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "main_id")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 12 row: 4 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 4 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/<!--Here is the form, note that the id for the labels must match the %"title%" column of the ProblemReportFormFields table: might be obsolete?-->%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_FORM_TAG} temp.make
			temp.debug_information := "line: 196 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("variable", "problem_report")
			temp.put_value_attribute("class", "PROBLEM_REPORT_BEAN")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "form"
			stack.put (temp)
				-- line: 13 row: 4 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 13 row: 4 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 98 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 98 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "problem_report")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "table"
			stack.put (temp)
				-- line: 14 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 38 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 38 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 15 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 21 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 21 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 16 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 16 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 20 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 20 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltipped")
			temp.put_value_attribute("id", "category_tooltip_container")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 17 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 18 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 18 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "to_reproduce_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 17 row: 120 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 17 row: 120 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("alt", "")
			temp.put_value_attribute("class", "info_icon")
			temp.put_value_attribute("src", "/support/images/problem_report/information.png")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
			stack.remove
				-- line: 18 row: 25 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 18 row: 25 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/Product/Category ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 19 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 19 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("style", "color: red")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 18 row: 114 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "category")
			temp.put_value_attribute("variable", "category_error")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.remove
				-- line: 19 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 20 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 20 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 21 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 26 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 26 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "separator_field")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 22 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 22 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_DROP_DOWN_LIST_TAG} temp.make
			temp.debug_information := "line: 25 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("items", "category_list")
			temp.put_value_attribute("name", "category")
			temp.put_value_attribute("value", "category")
			temp.put_variable_attribute("selected_index", "problem_report.category")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "drop_down_list"
			stack.put (temp)
				-- line: 23 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 23 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 24 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 24 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 24 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 24 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 25 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 25 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 26 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 26 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 32 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 32 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 27 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 31 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 31 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltipped")
			temp.put_value_attribute("id", "severity_tooltip_container")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 28 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 28 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 28 row: 124 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 28 row: 124 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "to_reproduce_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 28 row: 120 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 28 row: 120 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("alt", "")
			temp.put_value_attribute("class", "info_icon")
			temp.put_value_attribute("src", "/support/images/problem_report/information.png")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
			stack.remove
				-- line: 29 row: 17 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 29 row: 17 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/%/9/%/9/Severity ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 30 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 30 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("style", "color: red")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 29 row: 106 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "severity")
			temp.put_value_attribute("variable", "severity_error")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.remove
				-- line: 30 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 30 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 31 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 31 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 32 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 32 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 37 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 37 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 33 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 33 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_DROP_DOWN_LIST_TAG} temp.make
			temp.debug_information := "line: 36 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("items", "severity_list")
			temp.put_value_attribute("name", "severity")
			temp.put_value_attribute("value", "severity")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "drop_down_list"
			stack.put (temp)
				-- line: 34 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 34 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 35 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 35 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 35 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 35 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 36 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 36 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 37 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 37 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 38 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 38 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 62 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 62 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 39 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 39 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 45 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 45 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 40 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 40 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 44 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 44 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltipped")
			temp.put_value_attribute("id", "class_tooltip_container")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 41 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 41 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 41 row: 124 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 41 row: 124 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "to_reproduce_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 41 row: 120 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 41 row: 120 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("alt", "")
			temp.put_value_attribute("class", "info_icon")
			temp.put_value_attribute("src", "/support/images/problem_report/information.png")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
			stack.remove
				-- line: 42 row: 14 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 42 row: 14 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/%/9/%/9/Class ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 42 row: 104 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 42 row: 104 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("style", "color: red")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 42 row: 97 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "class")
			temp.put_value_attribute("variable", "class_error")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.remove
				-- line: 43 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 43 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 44 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 45 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 45 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 50 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 50 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 46 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 46 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_DROP_DOWN_LIST_TAG} temp.make
			temp.debug_information := "line: 49 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("items", "e_class_list")
			temp.put_value_attribute("name", "class")
			temp.put_value_attribute("value", "e_class")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "drop_down_list"
			stack.put (temp)
				-- line: 47 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 47 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 48 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 48 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 48 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 48 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 49 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 49 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 50 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 50 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 56 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 56 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 51 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 51 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 55 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 55 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltipped")
			temp.put_value_attribute("id", "priority_tooltip_container")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 52 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 52 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 52 row: 124 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 52 row: 124 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "to_reproduce_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 52 row: 120 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 52 row: 120 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("alt", "")
			temp.put_value_attribute("class", "info_icon")
			temp.put_value_attribute("src", "/support/images/problem_report/information.png")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
			stack.remove
				-- line: 53 row: 17 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 53 row: 17 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/%/9/%/9/Priority ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 54 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 54 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("style", "color: red")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 53 row: 106 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "priority")
			temp.put_value_attribute("variable", "priority_error")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.remove
				-- line: 54 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 54 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 55 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 55 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 56 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 56 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 61 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 61 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 57 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 57 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_DROP_DOWN_LIST_TAG} temp.make
			temp.debug_information := "line: 60 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("items", "priority_list")
			temp.put_value_attribute("name", "priority")
			temp.put_value_attribute("value", "priority")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "drop_down_list"
			stack.put (temp)
				-- line: 58 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 58 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 59 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 59 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 59 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 59 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 60 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 60 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 61 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 61 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 62 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 62 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 97 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 97 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 63 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 63 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 69 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 69 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 64 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 64 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 68 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 68 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltipped")
			temp.put_value_attribute("id", "release_tooltip_container")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 65 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 65 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 65 row: 124 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 65 row: 124 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "to_reproduce_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 65 row: 120 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 65 row: 120 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("alt", "")
			temp.put_value_attribute("class", "info_icon")
			temp.put_value_attribute("src", "/support/images/problem_report/information.png")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
			stack.remove
				-- line: 67 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 67 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/%/9/%/9/Release%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 68 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 68 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 69 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 69 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 81 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 81 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 70 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 70 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_INPUT_TAG} temp.make
			temp.debug_information := "line: 73 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("size", "14")
			temp.put_value_attribute("name", "release_input")
			temp.put_variable_attribute("text", "problem_report.release")
			temp.put_value_attribute("value", "release")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input_text"
			stack.put (temp)
				-- line: 71 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 71 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 72 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 72 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 72 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 72 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 74 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 74 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 80 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 80 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("style", "color: red")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 75 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 75 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 78 row: 30 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "release_input")
			temp.put_value_attribute("variable", "release_error")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.put (temp)
				-- line: 76 row: 9 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 76 row: 9 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 77 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 77 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "br"
				-- line: 77 row: 9 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 77 row: 9 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 78 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 78 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "release_error.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 78 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 78 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 79 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 79 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%/9/%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 80 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 80 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 81 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 81 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 91 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 91 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 82 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 82 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 90 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 90 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltipped")
			temp.put_value_attribute("id", "confidential_tooltip_container")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 83 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 83 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 84 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 84 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "confidential_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 83 row: 120 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 83 row: 120 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("alt", "")
			temp.put_value_attribute("class", "info_icon")
			temp.put_value_attribute("src", "/support/images/problem_report/information.png")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
			stack.remove
				-- line: 84 row: 21 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 84 row: 21 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/Confidential ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 89 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 89 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("style", "color: red")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 85 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 85 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 88 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "confidential")
			temp.put_value_attribute("variable", "confidential_errors")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.put (temp)
				-- line: 86 row: 9 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 86 row: 9 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 86 row: 58 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 86 row: 58 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "confidential_errors.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 87 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 87 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 88 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 88 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 89 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 89 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 90 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 90 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 91 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 91 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 96 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 96 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 92 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 92 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_DROP_DOWN_LIST_TAG} temp.make
			temp.debug_information := "line: 95 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("items", "confidential_list")
			temp.put_value_attribute("name", "confidential")
			temp.put_value_attribute("value", "confidential")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "drop_down_list"
			stack.put (temp)
				-- line: 93 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 93 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 94 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 94 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 94 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 94 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 95 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 95 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 96 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 96 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 97 row: 4 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 97 row: 4 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 99 row: 4 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 99 row: 4 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 195 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 195 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "problem_report")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "table"
			stack.put (temp)
				-- line: 100 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 100 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 110 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 110 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 101 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 101 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 109 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 109 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 102 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 102 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 108 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 108 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltipped")
			temp.put_value_attribute("id", "environment_tooltip_container")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 103 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 103 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 104 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 104 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "environment_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 103 row: 119 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 103 row: 119 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("alt", "")
			temp.put_value_attribute("class", "info_icon")
			temp.put_value_attribute("src", "/support/images/problem_report/information.png")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
			stack.remove
				-- line: 104 row: 20 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 104 row: 20 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/Environment ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 107 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 107 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("style", "color: red")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 106 row: 30 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "environment_text")
			temp.put_value_attribute("variable", "environment_errors")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.put (temp)
				-- line: 105 row: 9 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 105 row: 9 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 105 row: 57 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 105 row: 57 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "environment_errors.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 106 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 106 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 107 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 107 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 108 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 108 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 109 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 109 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 110 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 110 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 117 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 117 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 111 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 111 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 116 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 116 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 112 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 112 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_TEXTAREA_TAG} temp.make
			temp.debug_information := "line: 115 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("rows", "3")
			temp.put_value_attribute("cols", "80")
			temp.put_value_attribute("name", "environment_text")
			temp.put_value_attribute("value", "environment_text")
			temp.put_dynamic_attribute("text", "environment_info")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "text_area"
			stack.put (temp)
				-- line: 113 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 113 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 114 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 114 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 114 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 114 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 115 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 115 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 116 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 116 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 117 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 117 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 127 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 127 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 118 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 118 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 126 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 126 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 119 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 119 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 125 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 125 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltipped")
			temp.put_value_attribute("id", "synopsis_tooltip_container")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 120 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 120 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 121 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 121 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "synopsis_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 120 row: 116 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 120 row: 116 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("alt", "")
			temp.put_value_attribute("class", "info_icon")
			temp.put_value_attribute("src", "/support/images/problem_report/information.png")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
			stack.remove
				-- line: 121 row: 17 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 121 row: 17 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/Synopsis ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 124 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 124 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("style", "color: red")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 123 row: 30 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "synopsis_text")
			temp.put_value_attribute("variable", "synopsis_errors")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.put (temp)
				-- line: 122 row: 9 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 122 row: 9 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 122 row: 54 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 122 row: 54 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "synopsis_errors.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 123 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 123 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
			stack.remove
				-- line: 124 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 124 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 125 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 125 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 126 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 126 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 127 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 127 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 134 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 134 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 128 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 128 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 133 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 133 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 129 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 129 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_INPUT_TAG} temp.make
			temp.debug_information := "line: 132 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "synopsis_text")
			temp.put_value_attribute("size", "70")
			temp.put_value_attribute("value", "synopsis")
			temp.put_value_attribute("text", "")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input_text"
			stack.put (temp)
				-- line: 130 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 130 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 131 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 131 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 131 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 131 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 132 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 132 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 133 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 133 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 135 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 135 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/<!--%% if edited_problem_report_number = 0 then %%-->%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 143 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 143 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 136 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 136 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 142 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 142 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 137 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 137 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 141 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 141 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltipped")
			temp.put_value_attribute("id", "attachments_tooltip_container")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 138 row: 9 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 138 row: 9 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 139 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 139 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "attachments_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 138 row: 120 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 138 row: 120 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("alt", "")
			temp.put_value_attribute("class", "info_icon")
			temp.put_value_attribute("src", "/support/images/problem_report/information.png")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
			stack.remove
				-- line: 140 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 140 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/Attachments %/9/%/9/%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 141 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 141 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 142 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 142 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 143 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 143 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 148 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 148 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 144 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 144 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 146 row: 12 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 146 row: 12 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 145 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 145 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 145 row: 47 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 145 row: 47 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "file")
			temp.put_value_attribute("name", "file")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input"
				-- line: 146 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 146 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%/9/%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 147 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 147 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " %N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 149 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 149 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/<!--%% end %%-->%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 161 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 161 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 150 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 150 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 160 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 160 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 151 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 151 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 159 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 159 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltipped")
			temp.put_value_attribute("id", "description_tooltip_container")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 152 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 152 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 153 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 153 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "description_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 152 row: 119 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 152 row: 119 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("alt", "")
			temp.put_value_attribute("class", "info_icon")
			temp.put_value_attribute("src", "/support/images/problem_report/information.png")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
			stack.remove
				-- line: 153 row: 20 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 153 row: 20 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/Description ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 158 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 158 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("style", "color: red")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 154 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 154 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 157 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "description_text")
			temp.put_value_attribute("variable", "description_errors")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.put (temp)
				-- line: 155 row: 9 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 155 row: 9 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 155 row: 53 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 155 row: 53 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "description_errors")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 156 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 156 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 157 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 157 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 158 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 158 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 159 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 159 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 160 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 160 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 161 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 161 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 169 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 169 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 162 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 162 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 167 row: 11 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 167 row: 11 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 163 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 163 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_TEXTAREA_TAG} temp.make
			temp.debug_information := "line: 166 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("rows", "15")
			temp.put_value_attribute("cols", "80")
			temp.put_value_attribute("name", "description_text")
			temp.put_value_attribute("text", "")
			temp.put_value_attribute("value", "description_text")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "text_area"
			stack.put (temp)
				-- line: 164 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 164 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 165 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 165 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 165 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 165 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 167 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 167 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 168 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 168 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " %N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 169 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 169 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 182 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 182 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 170 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 170 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 181 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 181 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 171 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 171 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 180 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 180 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltipped")
			temp.put_value_attribute("id", "to_reproduce_tooltip_container")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 172 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 172 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 173 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 173 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "to_reproduce_link")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 172 row: 120 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 172 row: 120 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("alt", "")
			temp.put_value_attribute("class", "info_icon")
			temp.put_value_attribute("src", "/support/images/problem_report/information.png")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
			stack.remove
				-- line: 174 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 174 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/To Reproduce%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 179 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 179 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("style", "color: red")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 175 row: 9 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 175 row: 9 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATION_RESULT_TAG} temp.make
			temp.debug_information := "line: 178 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "to_reproduce_text")
			temp.put_value_attribute("variable", "to_reproduce_text_errors")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validation_result"
			stack.put (temp)
				-- line: 176 row: 10 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 176 row: 10 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 176 row: 60 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 176 row: 60 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "to_reproduce_text_errors")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 177 row: 9 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 177 row: 9 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 178 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 178 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 179 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 179 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 180 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 180 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 181 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 181 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 182 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 182 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 189 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 189 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 183 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 183 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 187 row: 11 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 187 row: 11 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "last_row")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 184 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 184 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_TEXTAREA_TAG} temp.make
			temp.debug_information := "line: 187 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("rows", "10")
			temp.put_value_attribute("cols", "80")
			temp.put_value_attribute("name", "to_reproduce_text")
			temp.put_value_attribute("value", "to_reproduce_text")
			temp.put_value_attribute("text", "")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "text_area"
			stack.put (temp)
				-- line: 185 row: 8 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 185 row: 8 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 186 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_VALIDATOR_TAG} temp.make
			temp.debug_information := "line: 186 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "XWA_NOT_EMPTY_VALIDATOR")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "validator"
				-- line: 186 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 186 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 187 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 187 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 188 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 188 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " %N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 189 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 189 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 194 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 194 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 190 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 190 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 193 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 193 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "submit_column_big_padding")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 191 row: 7 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 191 row: 7 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
			create {XTAG_F_BUTTON_TAG} temp.make
			temp.debug_information := "line: 192 row: 1 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Preview")
			temp.put_value_attribute("action", "save")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "button"
				-- line: 192 row: 6 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 192 row: 6 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 193 row: 5 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 193 row: 5 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 194 row: 4 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 194 row: 4 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 195 row: 4 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 195 row: 4 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 196 row: 3 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 196 row: 3 of file: ./protected/problem_report_form.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 197 row: 2 of file: ./protected/problem_report_form.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 197 row: 2 of file: ./protected/problem_report_form.xeb"
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
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 27 row: 1 of file: ./support_side.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 27 row: 1 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "spacer")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
				-- line: 27 row: 3 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 3 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 28 row: 2 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 28 row: 2 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 42 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 42 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 43 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 43 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 46 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 46 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("render", "is_not_logged_in")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "container"
			stack.put (temp)
				-- line: 44 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 45 row: 1 of file: ./support_master.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 45 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "default_not_authorized_main_content")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "declare_region"
			stack.put (temp)
				-- line: 31 row: 2 of file: ./support_side.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 31 row: 2 of file: ./support_side.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%NYou are not logged in!%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 45 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 45 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 46 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 46 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 47 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 47 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 55 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 55 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "footer")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 48 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 48 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 48 row: 105 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 48 row: 105 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://www.eiffel.com/general/contact_details.html")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 48 row: 101 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 48 row: 101 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Questions? Comments? Let us know!")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 49 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 49 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "br"
				-- line: 50 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 50 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/&copy; 1993-2009 Eiffel Software inc. All rights reserved. --%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 51 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 51 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "http://www.eiffel.com/general/privacy_policy.html")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 50 row: 81 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 50 row: 81 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Privacy Policy")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 51 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 51 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 54 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 54 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "logo")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 52 row: 8 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 52 row: 8 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 53 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 53 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("src", "/support/images/support/xebra_for_eiffel.png")
			temp.put_value_attribute("alt", "Xebra for Eiffel")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "img"
				-- line: 53 row: 7 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 53 row: 7 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 54 row: 6 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 54 row: 6 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 55 row: 5 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 55 row: 5 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 56 row: 4 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 56 row: 4 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 57 row: 4 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 57 row: 4 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 62 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 62 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "shadow_horizontal")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 58 row: 5 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 58 row: 5 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 59 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 59 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "shadow_horizontal_left")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
				-- line: 59 row: 5 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 59 row: 5 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 60 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 60 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "shadow_horizontal_middle")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
				-- line: 60 row: 5 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 60 row: 5 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 61 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 61 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "shadow_horizontal_right")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
				-- line: 61 row: 4 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 61 row: 4 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 62 row: 3 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 62 row: 3 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 64 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 64 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N<!-- The Following is for Google Analytics -->%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 68 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 68 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "text/javascript")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "script"
			stack.put (temp)
				-- line: 67 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 67 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%Nvar gaJsHost = ((%"https:%" == document.location.protocol) ? %"https://ssl.%" : %"http://www.%");%Ndocument.write(unescape(%"%%3Cscript src='%" + gaJsHost + %"google-analytics.com/ga.js' type='text/javascript'%%3E%%3C/script%%3E%"));%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 68 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 68 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 73 row: 1 of file: ./support_master.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 73 row: 1 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "text/javascript")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "script"
			stack.put (temp)
				-- line: 72 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 72 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%Nvar pageTracker = _gat._getTracker(%"UA-1289714-2%");%NpageTracker._initData();%NpageTracker._trackPageview();%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 73 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 73 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 74 row: 2 of file: ./support_master.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 74 row: 2 of file: ./support_master.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_2"
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
