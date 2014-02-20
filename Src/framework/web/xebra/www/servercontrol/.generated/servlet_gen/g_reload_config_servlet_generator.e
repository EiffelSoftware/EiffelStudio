note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_RELOAD_CONFIG_SERVLET_GENERATOR

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
				-- line: 23 row: 2 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 23 row: 2 of file: ./reload_config.xeb"
			l_root_tag := temp
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 22 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 22 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 2 row: 2 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 2 row: 2 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 8 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "head"
			stack.put (temp)
				-- line: 3 row: 2 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 3 row: 2 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 4 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 4 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "title"
			stack.put (temp)
				-- line: 3 row: 29 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 3 row: 29 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Xebra Server Control")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 4 row: 2 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 4 row: 2 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 5 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 5 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "controller"
				-- line: 5 row: 2 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 2 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 6 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 6 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("http-equiv", "Content-Type")
			temp.put_value_attribute("content", "text/html; charset=utf-8")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "meta"
				-- line: 6 row: 2 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 2 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 7 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 7 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("href", "base.css")
			temp.put_value_attribute("rel", "stylesheet")
			temp.put_value_attribute("type", "text/css")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "link"
				-- line: 7 row: 2 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 2 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 8 row: 2 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 2 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 21 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 21 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "body"
			stack.put (temp)
				-- line: 9 row: 2 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 2 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 20 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 20 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "main")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 10 row: 4 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 4 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N  ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 13 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 13 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "header")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 11 row: 6 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 6 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N    ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 12 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 12 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "title")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 11 row: 43 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 43 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", " Xebra Server Control")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 12 row: 4 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 12 row: 4 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N  ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 13 row: 4 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 13 row: 4 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N  ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 16 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 16 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "content")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 15 row: 4 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 15 row: 4 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N%/9/%N  ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 16 row: 4 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 16 row: 4 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N  ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 19 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 19 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "footer")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 17 row: 6 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 6 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N    ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 18 row: 1 of file: ./reload_config.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 18 row: 1 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("id", "footertext")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "div"
			stack.put (temp)
				-- line: 17 row: 47 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 17 row: 47 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Xebra Server Control")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 18 row: 4 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 18 row: 4 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N  ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 19 row: 2 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 19 row: 2 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 20 row: 2 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 20 row: 2 of file: ./reload_config.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 21 row: 2 of file: ./reload_config.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 21 row: 2 of file: ./reload_config.xeb"
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
