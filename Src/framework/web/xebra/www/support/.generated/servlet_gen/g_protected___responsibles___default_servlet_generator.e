note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_PROTECTED___RESPONSIBLES___DEFAULT_SERVLET_GENERATOR

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
				-- line: 220 row: 2 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 220 row: 2 of file: ./protected/responsibles/default.xeb"
			l_root_tag := temp
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 220 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 220 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("template", "support_plain")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "include"
			stack.put (temp)
				-- line: 13 row: 2 of file: ./support_plain.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 13 row: 2 of file: ./support_plain.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_2"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 13 row: 1 of file: ./support_plain.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 13 row: 1 of file: ./support_plain.xeb"
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
				-- line: 3 row: 3 of file: ./support_plain.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 3 row: 3 of file: ./support_plain.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 8 row: 1 of file: ./support_plain.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 1 of file: ./support_plain.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "full_content")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 4 row: 4 of file: ./support_plain.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 4 of file: ./support_plain.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 5 row: 1 of file: ./support_plain.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 5 row: 1 of file: ./support_plain.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "prop")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
				-- line: 5 row: 4 of file: ./support_plain.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 4 of file: ./support_plain.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 6 row: 1 of file: ./support_plain.xeb
			create {XTAG_PAGE_NOOP_TAG} temp.make
			temp.debug_information := "line: 6 row: 1 of file: ./support_plain.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "main_content")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "declare_region"
			stack.put (temp)
				-- line: 4 row: 4 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 4 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 218 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 218 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 5 row: 5 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 5 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 9 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 9 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "title_box")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 6 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 9 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 9 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "h1"
			stack.put (temp)
				-- line: 8 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/Problem Report Edition%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 9 row: 5 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 5 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 10 row: 5 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 5 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 10 row: 51 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 10 row: 51 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "NoText")
			temp.put_value_attribute("css_class", "error")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 11 row: 5 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 5 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%/9/%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_F_FORM_TAG} temp.make
			temp.debug_information := "line: 69 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("variable", "query")
			temp.put_value_attribute("class", "PROBLEM_REPORT_QUERY")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "form"
			stack.put (temp)
				-- line: 12 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 67 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 67 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "responsible_filter")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "table"
			stack.put (temp)
				-- line: 13 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 13 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 66 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 66 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tbody"
			stack.put (temp)
				-- line: 14 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 14 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 33 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 33 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 15 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 22 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 22 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "field_name")
			temp.put_value_attribute("valign", "top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 16 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 16 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 19 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 19 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 18 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 18 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/Submitter:%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 19 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 21 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 21 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltip_container")
			temp.put_value_attribute("width", "400px")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 20 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 20 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 21 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 22 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 22 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 25 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 25 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("valign", "top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 23 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 23 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_F_INPUT_TAG} temp.make
			temp.debug_information := "line: 24 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "submitter_input")
			temp.put_value_attribute("value", "submitter")
			temp.put_variable_attribute("text", "query.submitter")
			temp.put_value_attribute("max_length", "101")
			temp.put_value_attribute("size", "15")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input_text"
				-- line: 24 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 24 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 25 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 25 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 28 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 28 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "field_name")
			temp.put_value_attribute("valign", "top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 27 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 27 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/Category:%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 28 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 28 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 32 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 32 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("valign", "top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 29 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 29 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_F_DROP_DOWN_LIST_TAG} temp.make
			temp.debug_information := "line: 30 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "a_category")
			temp.put_dynamic_attribute("items", "categories")
			temp.put_value_attribute("value", "category")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "drop_down_list"
				-- line: 30 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 30 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_F_CHECK_BOX_TAG} temp.make
			temp.debug_information := "line: 31 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("value", "open")
			temp.put_value_attribute("name", "a_open")
			temp.put_value_attribute("label", "Open")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "check_box"
				-- line: 31 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 31 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 32 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 32 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 33 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 33 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 49 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 49 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 34 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 34 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 38 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 38 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "field_name")
			temp.put_value_attribute("valign", "top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 35 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 35 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 36 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 36 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 35 row: 33 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 35 row: 33 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Responsible:")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 36 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 36 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 37 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 37 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltip_container")
			temp.put_value_attribute("width", "400px")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 37 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 37 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 38 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 38 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 41 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 41 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("valign", "top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 39 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 39 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_F_INPUT_TAG} temp.make
			temp.debug_information := "line: 40 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "a_responsible")
			temp.put_value_attribute("max_length", "101")
			temp.put_value_attribute("value", "responsible")
			temp.put_variable_attribute("text", "query.responsible")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input_text"
				-- line: 40 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 40 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 41 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 41 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 45 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 45 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "field_name")
			temp.put_value_attribute("valign", "top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 43 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 43 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/Severity:%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 44 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 44 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltip_container")
			temp.put_value_attribute("width", "135px")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 44 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 44 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 45 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 45 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 48 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 48 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("valign", "top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 46 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 46 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_F_DROP_DOWN_LIST_TAG} temp.make
			temp.debug_information := "line: 47 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "a_severity")
			temp.put_dynamic_attribute("items", "severities")
			temp.put_value_attribute("value", "severity")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "drop_down_list"
				-- line: 47 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 47 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 48 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 48 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 49 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 49 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 65 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 65 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 50 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 50 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 53 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 53 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "field_name")
			temp.put_value_attribute("valign", "top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 52 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 52 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/Page Size:%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 53 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 53 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 57 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 57 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("valign", "top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 54 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 54 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_F_INPUT_TAG} temp.make
			temp.debug_information := "line: 55 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "a_page_size")
			temp.put_value_attribute("max_length", "3")
			temp.put_value_attribute("size", "3")
			temp.put_value_attribute("value", "page_size")
			temp.put_variable_attribute("text", "query.page_size")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input_text"
				-- line: 55 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 55 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 56 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 56 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "error")
			temp.put_value_attribute("style", "color: Red; visibility: hidden;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 55 row: 71 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 55 row: 71 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "*")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 56 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 56 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 57 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 57 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 61 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 61 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "field_name")
			temp.put_value_attribute("valign", "top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 59 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 59 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/Priority:%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 60 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 60 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "tooltip_container")
			temp.put_value_attribute("width", "135px")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 60 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 60 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 61 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 61 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 64 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 64 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("valign", "top")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 62 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 62 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_F_DROP_DOWN_LIST_TAG} temp.make
			temp.debug_information := "line: 63 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("name", "a_priority")
			temp.put_dynamic_attribute("items", "priorities")
			temp.put_value_attribute("value", "priority")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "drop_down_list"
				-- line: 63 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 63 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 64 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 64 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 65 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 65 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 66 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 66 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 67 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 67 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_F_BUTTON_TAG} temp.make
			temp.debug_information := "line: 68 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Search")
			temp.put_value_attribute("action", "search")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "button"
				-- line: 68 row: 5 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 68 row: 5 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 69 row: 5 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 69 row: 5 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 217 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 217 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "reports_div")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 70 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 70 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 72 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 72 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "pager_div")
			temp.put_value_attribute("id", "pager_div")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 71 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 71 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 72 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 72 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 101 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 101 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "ctl00_ctl00_default_main_content_main_content_pager_pager")
			temp.put_value_attribute("class", "pager")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 73 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 73 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 79 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 79 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "pager_label")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 74 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 74 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 78 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 78 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 75 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 75 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 76 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 76 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("text", "overall_count.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 77 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 77 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/Reports%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 78 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 78 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 79 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 79 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 100 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 100 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "pager_buttons")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 80 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 80 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 99 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 99 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("width", "374px")
			temp.put_value_attribute("style", "table-layout:fixed;")
			temp.put_value_attribute("cellpadding", "0")
			temp.put_value_attribute("cellspacing", "0")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "table"
			stack.put (temp)
				-- line: 81 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 81 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 98 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 98 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 82 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 82 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 86 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 86 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("width", "37px")
			temp.put_value_attribute("align", "left")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 83 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 83 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 84 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 84 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "image")
			temp.put_value_attribute("disabled", "disabled")
			temp.put_value_attribute("src", "https://www2.eiffel.com/images/grid/first_inactive.gif")
			temp.put_value_attribute("style", "border-width:0px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input"
				-- line: 84 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 84 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 85 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 85 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "image")
			temp.put_value_attribute("disabled", "disabled")
			temp.put_value_attribute("src", "https://www2.eiffel.com/images/grid/previous_inactive.gif")
			temp.put_value_attribute("style", "border-width:0px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input"
				-- line: 85 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 85 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 86 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 86 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 93 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 93 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("align", "center")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 87 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 87 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 92 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 92 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("width", "300px")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 88 row: 12 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 88 row: 12 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_LOOP_TAG} temp.make
			temp.debug_information := "line: 91 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("times", "10")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "loop"
			stack.put (temp)
				-- line: 89 row: 12 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 89 row: 12 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 90 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 90 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "active_page")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 89 row: 39 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 89 row: 39 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "1")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 90 row: 12 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 90 row: 12 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 91 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 91 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 92 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 92 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 93 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 93 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 97 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 97 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("align", "right")
			temp.put_value_attribute("width", "37px")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 94 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 94 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 95 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 95 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "image")
			temp.put_value_attribute("src", "https://www2.eiffel.com/images/grid/next_active.gif")
			temp.put_value_attribute("style", "border-width:0px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input"
				-- line: 95 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 95 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 96 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 96 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "image")
			temp.put_value_attribute("name", "ctl00$ctl00$default_main_content$main_content$pager$last_button")
			temp.put_value_attribute("id", "ctl00_ctl00_default_main_content_main_content_pager_last_button")
			temp.put_value_attribute("src", "https://www2.eiffel.com/images/grid/last_active.gif")
			temp.put_value_attribute("style", "border-width:0px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input"
				-- line: 96 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 96 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 97 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 97 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 98 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 98 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 99 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 99 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 100 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 100 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 101 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 101 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 185 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 185 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "responsible_grid")
			temp.put_value_attribute("style", "width: 897px; border-collapse: collapse; display: block;")
			temp.put_value_attribute("border", "0")
			temp.put_value_attribute("cellspacing", "0")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "table"
			stack.put (temp)
				-- line: 102 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 102 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 135 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 135 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 103 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 103 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 106 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 106 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("scope", "col")
			temp.put_value_attribute("style", "width:35px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 105 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 105 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/#%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 106 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 106 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 109 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 109 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "image_header")
			temp.put_value_attribute("scope", "col")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 107 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 107 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 108 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 108 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "image")
			temp.put_value_attribute("src", "https://www2.eiffel.com/images/grid/grid_header.gif")
			temp.put_value_attribute("style", "border-width:0px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input"
				-- line: 108 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 108 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 109 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 109 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 112 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 112 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "image_header")
			temp.put_value_attribute("scope", "col")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 110 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 110 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 111 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 111 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "image")
			temp.put_value_attribute("src", "https://www2.eiffel.com/images/grid/grid_header.gif")
			temp.put_value_attribute("style", "border-width:0px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input"
				-- line: 111 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 111 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 112 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 112 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 115 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 115 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "image_header")
			temp.put_value_attribute("scope", "col")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 113 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 113 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 114 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 114 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "image")
			temp.put_value_attribute("src", "https://www2.eiffel.com/images/grid/grid_header.gif")
			temp.put_value_attribute("style", "border-width:0px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input"
				-- line: 114 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 114 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 115 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 115 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 118 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 118 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("scope", "col")
			temp.put_value_attribute("style", "width:333px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 117 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 117 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/Synopsis%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 118 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 118 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 121 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 121 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("scope", "col")
			temp.put_value_attribute("style", "width:100px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 120 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 120 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/Submitter%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 121 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 121 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 124 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 124 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("scope", "col")
			temp.put_value_attribute("style", "width:85px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 123 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 123 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/Responsible%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 124 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 124 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 127 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 127 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("scope", "col")
			temp.put_value_attribute("style", "width:105px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 126 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 126 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/Category%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 127 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 127 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 130 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 130 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("scope", "col")
			temp.put_value_attribute("style", "width:65px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 129 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 129 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/Release%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 130 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 130 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 134 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 134 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("scope", "col")
			temp.put_value_attribute("style", "width:66px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "th"
			stack.put (temp)
				-- line: 132 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 132 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/Date%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 133 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 133 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "sort_glyph")
			temp.put_value_attribute("src", "https://www2.eiffel.com/images/grid/down.gif")
			temp.put_value_attribute("alt", "Descending Order")
			temp.put_value_attribute("style", "border-width:0px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "img"
				-- line: 133 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 133 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 134 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 134 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 135 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 135 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_ITERATE_TAG} temp.make
			temp.debug_information := "line: 184 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("css_class", "responsible_grid")
			temp.put_dynamic_attribute("list", "problem_reports")
			temp.put_value_attribute("variable", "problem_report")
			temp.put_value_attribute("type", "PROBLEM_REPORT_BEAN")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "iterate"
			stack.put (temp)
				-- line: 136 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 136 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%/9/%/9/%/9/%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 183 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 183 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tbody"
			stack.put (temp)
				-- line: 137 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 137 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 182 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 182 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 138 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 138 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 141 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 141 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 139 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 139 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 140 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 140 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 139 row: 69 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 139 row: 69 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "problem_report.number")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
			stack.remove
				-- line: 140 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 140 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 141 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 141 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 147 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 147 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 142 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 142 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 146 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 146 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "centered")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 143 row: 12 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 143 row: 12 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 144 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 144 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("class", "problem_report.status")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 145 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 145 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/<!--img src=%"support/images/support/status_closed.gif%" style=%"border-width: 0px;%"/-->%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 146 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 146 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 147 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 147 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 153 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 153 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 148 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 148 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 152 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 152 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "centered")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 149 row: 12 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 149 row: 12 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 150 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 150 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("class", "problem_report.priority")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 151 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 151 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/<!--img src=%"support/images/support/priority_high.gif%" style=%"border-width: 0px;%" /-->%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 152 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 152 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 153 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 153 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 159 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 159 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 154 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 154 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 158 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 158 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "centered")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 155 row: 12 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 155 row: 12 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 156 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 156 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("class", "problem_report.severity")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
				-- line: 157 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 157 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/<!--img src=%"support/images/support/severity_critical.gif%" style=%"border-width: 0px;%"/-->%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 158 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 158 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 159 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 159 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 162 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 162 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 160 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 160 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 161 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 161 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "problem_report.synopsis")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 161 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 161 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 162 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 162 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 167 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 167 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 163 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 163 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 166 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 166 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("disabled", "disabled")
			temp.put_value_attribute("class", "disabled")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "a"
			stack.put (temp)
				-- line: 164 row: 12 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 164 row: 12 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 165 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 165 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "problem_report.submitter")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 165 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 165 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 166 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 166 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 167 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 167 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 172 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 172 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 168 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 168 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_F_FORM_TAG} temp.make
			temp.debug_information := "line: 171 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("variable", "drop_down_temp")
			temp.put_value_attribute("class", "PROBLEM_REPORT_BEAN")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "form"
			stack.put (temp)
				-- line: 169 row: 12 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 169 row: 12 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_F_DROP_DOWN_LIST_TAG} temp.make
			temp.debug_information := "line: 170 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("items", "all_responsibles")
			temp.put_value_attribute("name", "responsible")
			temp.put_value_attribute("value", "responsible")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "drop_down_list"
				-- line: 170 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 170 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 171 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 171 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 172 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 172 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 175 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 175 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 173 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 173 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 174 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 174 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "problem_report.category")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 174 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 174 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 175 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 175 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 178 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 178 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 176 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 176 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 177 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 177 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "problem_report.release")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 177 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 177 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 178 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 178 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 181 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 181 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 179 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 179 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 180 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 180 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_variable_attribute("text", "problem_report.date")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 180 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 180 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 181 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 181 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 182 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 182 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 183 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 183 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 184 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 184 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 185 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 185 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 214 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 214 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "pager")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 186 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 186 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 192 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 192 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "ctl00_ctl00_default_main_content_main_content_pager_pager_label")
			temp.put_value_attribute("class", "pager_label")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 187 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 187 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 191 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 191 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 188 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 188 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 189 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 189 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("text", "overall_count.out")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 190 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 190 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/Reports%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 191 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 191 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 192 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 192 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 213 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 213 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "pager_buttons")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 193 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 193 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 212 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 212 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("width", "374px")
			temp.put_value_attribute("style", "table-layout:fixed;")
			temp.put_value_attribute("cellpadding", "0")
			temp.put_value_attribute("cellspacing", "0")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "table"
			stack.put (temp)
				-- line: 194 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 194 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 211 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 211 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "tr"
			stack.put (temp)
				-- line: 195 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 195 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 199 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 199 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("width", "37px")
			temp.put_value_attribute("align", "left")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 196 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 196 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 197 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 197 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "image")
			temp.put_value_attribute("disabled", "disabled")
			temp.put_value_attribute("src", "https://www2.eiffel.com/images/grid/first_inactive.gif")
			temp.put_value_attribute("style", "border-width:0px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input"
				-- line: 197 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 197 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 198 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 198 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "image")
			temp.put_value_attribute("disabled", "disabled")
			temp.put_value_attribute("src", "https://www2.eiffel.com/images/grid/previous_inactive.gif")
			temp.put_value_attribute("style", "border-width:0px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input"
				-- line: 198 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 198 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 199 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 199 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 206 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 206 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("align", "center")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 200 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 200 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 205 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 205 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("width", "300px")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 201 row: 12 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 201 row: 12 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_LOOP_TAG} temp.make
			temp.debug_information := "line: 204 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("times", "10")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "loop"
			stack.put (temp)
				-- line: 202 row: 13 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 202 row: 13 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 203 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 203 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "active_page")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "span"
			stack.put (temp)
				-- line: 202 row: 40 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 202 row: 40 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "1")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 203 row: 12 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 203 row: 12 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 204 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 204 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 205 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 205 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 206 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 206 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 210 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 210 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("align", "right")
			temp.put_value_attribute("width", "37px")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "td"
			stack.put (temp)
				-- line: 207 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 207 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 208 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 208 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "image")
			temp.put_value_attribute("src", "https://www2.eiffel.com/images/grid/next_active.gif")
			temp.put_value_attribute("style", "border-width:0px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input"
				-- line: 208 row: 11 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 208 row: 11 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 209 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 209 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("type", "image")
			temp.put_value_attribute("src", "https://www2.eiffel.com/images/grid/last_active.gif")
			temp.put_value_attribute("style", "border-width:0px;")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "input"
				-- line: 209 row: 10 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 209 row: 10 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 210 row: 9 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 210 row: 9 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 211 row: 8 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 211 row: 8 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 212 row: 7 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 212 row: 7 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 213 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 213 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 214 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 214 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 216 row: 1 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 216 row: 1 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "pager_div")
			temp.put_value_attribute("id", "bottom_pager_div")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 215 row: 6 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 215 row: 6 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 216 row: 5 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 216 row: 5 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 217 row: 4 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 217 row: 4 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 218 row: 3 of file: ./protected/responsibles/default.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 218 row: 3 of file: ./protected/responsibles/default.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 6 row: 4 of file: ./support_plain.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 4 of file: ./support_plain.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
				-- line: 7 row: 1 of file: ./support_plain.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 7 row: 1 of file: ./support_plain.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("class", "spacer")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "div"
				-- line: 7 row: 3 of file: ./support_plain.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 3 of file: ./support_plain.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/")
			temp.current_controller_id := "controller_2"
			temp.tag_id := "content"
			stack.remove
				-- line: 8 row: 2 of file: ./support_plain.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 2 of file: ./support_plain.xeb"
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
				-- line: 11 row: 2 of file: ./support_plain.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 2 of file: ./support_plain.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/You are not logged in!%N")
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
