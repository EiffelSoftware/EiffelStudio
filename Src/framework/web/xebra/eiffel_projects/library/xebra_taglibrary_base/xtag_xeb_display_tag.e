note
	description: "[
		Displays the out-string of the return value the specified feature. 
		Expects a function with no arguments.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_DISPLAY_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render
		end

create
	make

feature -- Initialization

	make
		do
			make_base
			create {XTAG_TAG_VALUE_ARGUMENT} text.make_default
		end

feature -- Access

	text: XTAG_TAG_ARGUMENT
			-- The text to display

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do
			if text.is_dynamic or text.is_variable then
				a_servlet_class.render_html_page.append_expression ("if attached {STRING} " + text.plain_value (current_controller_id) + " as l_text then ")
				a_servlet_class.render_html_page.append_output_expression ("l_text")
				a_servlet_class.render_html_page.append_expression ("else")
				a_servlet_class.render_html_page.append_output_expression (text.plain_value (current_controller_id) + ".out")
				a_servlet_class.render_html_page.append_expression ("end")				
			else
				a_servlet_class.render_html_page.append_output_expression ("%"" + text.value (current_controller_id) + "%"")
			end
		end

	internal_put_attribute (id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			if id.is_equal ("text") then
				text := a_attribute
			end
		end

	generates_render: BOOLEAN = True

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
		]"
end
