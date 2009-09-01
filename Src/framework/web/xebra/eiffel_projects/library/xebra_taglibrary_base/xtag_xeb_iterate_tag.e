note
	description: "[
		With this tag one can iterate over a {LIST [A]}. One has to provide the type A and
		the name of the used variable as well as a controller feature which returns the
		list. The tag will then iterate over every element in the list and render its
		children.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_ITERATE_TAG

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
			create {XTAG_TAG_VALUE_ARGUMENT} list.make ("list_not_set")
			create {XTAG_TAG_VALUE_ARGUMENT} variable.make ("variable_not_set")
			create {XTAG_TAG_VALUE_ARGUMENT} type.make ("type_not_set")
		ensure
			list_attached: attached list
			variable_attached: attached variable
			type_attached: attached type
		end

feature {NONE} -- Access

	list: XTAG_TAG_ARGUMENT
			-- The items over which we want to iterate

	variable: XTAG_TAG_ARGUMENT
			-- Name of the variable

	type: XTAG_TAG_ARGUMENT
			-- Type of the variable

feature {NONE} -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			temp_list: STRING
			l_list_value: STRING
		do
			--a_servlet_class.add_variable_by_name_type (variable.value (current_controller_id), "detachable " + type.value (current_controller_id))
			--a_servlet_class.make_feature.append_expression ("create " + variable.value (current_controller_id) + ".make")
			temp_list := a_servlet_class.render_html_page.new_local ("LIST [" + type.value (current_controller_id) + "]")
			if list.is_dynamic or list.is_variable then
				l_list_value := list.plain_value (current_controller_id)
			else
				l_list_value := "%"" + list.value (current_controller_id) + "%""
			end

			a_servlet_class.render_html_page.append_expression (temp_list + " := " + l_list_value)
			a_servlet_class.render_html_page.append_expression ("from --" + temp_list)
			a_servlet_class.render_html_page.append_expression (temp_list + ".start")
			a_servlet_class.render_html_page.append_expression ("until")
			a_servlet_class.render_html_page.append_expression (temp_list + ".after")
			a_servlet_class.render_html_page.append_expression ("loop")
			a_servlet_class.render_html_page.append_expression ("if attached {" +
				type.value (current_controller_id) + "} " + temp_list + ".item as " + 					variable.value (current_controller_id) + " then")
			generate_children (a_servlet_class, a_variable_table)
			a_servlet_class.render_html_page.append_expression (temp_list + ".forth")
			a_servlet_class.render_html_page.append_expression ("end -- if attached " + variable.value (current_controller_id))
			a_servlet_class.render_html_page.append_expression ("end -- from " + temp_list)
		end

	internal_put_attribute (id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			if id.is_equal ("list") then
				list := a_attribute
			end
			if id.is_equal ("variable") then
				variable := a_attribute
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
