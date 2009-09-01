note
	description: "[
		Sets the value of variable.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_SET_VARIABLE_TAG

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
			create {XTAG_TAG_VALUE_ARGUMENT} variable.make ("variable_not_set")
			create {XTAG_TAG_VALUE_ARGUMENT} value.make ("value_not_set")
		ensure
			variable_attached: attached variable
			value_attached: attached value
		end

feature {NONE} -- Access

	variable: XTAG_TAG_ARGUMENT
			-- Name of the variable

	value: XTAG_TAG_ARGUMENT
			-- Value of variable
	
	type: detachable XTAG_TAG_ARGUMENT
			-- The type of the variable

feature {NONE} -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do
			if attached type as l_type then
				a_servlet_class.render_html_page.append_local_if_not_exists (variable.plain_value (current_controller_id), l_type.plain_value (current_controller_id))
			end
			if value.is_dynamic or value.is_variable then
				a_servlet_class.render_html_page.append_expression (variable.value (current_controller_id) + " := " + value.plain_value (current_controller_id))
			else
				a_servlet_class.render_html_page.append_expression (variable.value (current_controller_id) + " := %"" + value.value (current_controller_id) + "%"")
			end
			
		end

	internal_put_attribute (id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			if id.is_equal ("variable") then
				variable := a_attribute
			end
			if id.is_equal ("value") then
				value := a_attribute
			end
			if id.is_equal ("type") then
				type := a_attribute
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
