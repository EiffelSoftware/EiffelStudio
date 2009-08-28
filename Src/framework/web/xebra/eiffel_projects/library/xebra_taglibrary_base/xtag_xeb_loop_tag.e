note
	description: "[
		Repeats its children `times' times.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_LOOP_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_base
			create {XTAG_TAG_VALUE_ARGUMENT} times.make ("0")
		end

feature {NONE} -- Access

	times: XTAG_TAG_ARGUMENT
			-- Number of repetitions of the body

	index_variable: detachable XTAG_TAG_ARGUMENT
			-- Index variable of the current loop cycle

feature {NONE} -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_temp_var_name: STRING
		do
			if attached index_variable as l_index_variable then
				a_servlet_class.render_html_page.append_local
					(l_index_variable.value (current_controller_id), "NATURAL")
			end
			l_temp_var_name := a_servlet_class.render_html_page.new_local ("NATURAL")
			a_servlet_class.render_html_page.append_expression ("from")
			a_servlet_class.render_html_page.append_expression (l_temp_var_name + " := 1")
			a_servlet_class.render_html_page.append_expression ("until")
			a_servlet_class.render_html_page.append_expression (l_temp_var_name + " > " + times.value (current_controller_id))
			a_servlet_class.render_html_page.append_expression ("loop")
			if attached index_variable as l_index_variable then
				a_servlet_class.render_html_page.append_expression (l_index_variable.value (current_controller_id) + " := " + l_temp_var_name)
			end
			generate_children (a_servlet_class, a_variable_table)
			a_servlet_class.render_html_page.append_expression (l_temp_var_name + " := " + l_temp_var_name + " + 1")
			a_servlet_class.render_html_page.append_expression ("end")
		end

	internal_put_attribute (id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			if id.is_equal ("times") then
				times := a_attribute
			end
			if id.is_equal ("variable") then
				index_variable := a_attribute
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

