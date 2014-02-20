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
				-- line: 12 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 12 row: 2 of file: ./index.xeb"
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
				-- line: 12 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 12 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("xmlns", "http://www.w3.org/1999/xhtml")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "html"
			stack.put (temp)
				-- line: 3 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 3 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 8 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 8 row: 1 of file: ./index.xeb"
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
			create {XTAG_XEB_CONTAINER_TAG} temp.make
			temp.debug_information := "line: 5 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "controller"
				-- line: 5 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 5 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 6 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 6 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("http-equiv", "Content-Type")
			temp.put_value_attribute("content", "text/html; charset=utf-8")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "meta"
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
			temp.current_controller_id := "controller_1"
			temp.tag_id := "title"
			stack.put (temp)
				-- line: 6 row: 38 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 6 row: 38 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "Xebra Hello World Application")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 7 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 7 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 8 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 8 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 11 row: 1 of file: ./index.xeb
			create {XTAG_XEB_HTML_TAG} temp.make
			temp.debug_information := "line: 11 row: 1 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.current_controller_id := "controller_1"
			temp.tag_id := "body"
			stack.put (temp)
				-- line: 9 row: 8 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 9 row: 8 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "%NHello ")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
				-- line: 9 row: 39 of file: ./index.xeb
			create {XTAG_XEB_DISPLAY_TAG} temp.make
			temp.debug_information := "line: 9 row: 39 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_dynamic_attribute("text", "world")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "display"
				-- line: 10 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 10 row: 2 of file: ./index.xeb"
			stack.item.add_to_body (temp)
			temp.put_value_attribute("text", "!%N")
			temp.current_controller_id := "controller_1"
			temp.tag_id := "content"
			stack.remove
				-- line: 11 row: 2 of file: ./index.xeb
			create {XTAG_XEB_CONTENT_TAG} temp.make
			temp.debug_information := "line: 11 row: 2 of file: ./index.xeb"
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
