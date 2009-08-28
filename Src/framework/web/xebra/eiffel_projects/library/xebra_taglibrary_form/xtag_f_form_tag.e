note
	description: "[
		Renders a html form. It defines the variable that should be wrapped and manages
		its creation and definition in the servlet. It passes along a couple of variables
		which is used by buttons, inputs and validators. The latter cannot be used out
		of a form context. Forms cannot be nested.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_FORM_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render,
			generates_handle_form,
			generates_clean_up
		end

create
	make

feature -- Initialization

	make
		do
			make_base
			create {XTAG_TAG_VALUE_ARGUMENT}data_class.make_default
			create {XTAG_TAG_VALUE_ARGUMENT}variable.make_default
		ensure
			data_class_attached: attached data_class
			variable_attached: attached variable
		end

feature -- Access

	data_class: XTAG_TAG_ARGUMENT
			-- Name of the class which holds the data of the form

	variable: XTAG_TAG_ARGUMENT
			-- The name for the variable

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_id: STRING
			l_variable_exists: BOOLEAN
			l_agent_expressions: LIST [STRING]
		do
			l_variable_exists := not variable.is_empty
			if l_variable_exists then
				a_servlet_class.add_variable_by_name_type (variable.plain_value (current_controller_id), data_class.plain_value (current_controller_id))
				a_servlet_class.make_feature.append_expression ("create " + variable.plain_value (current_controller_id) + ".make")
			end

			l_id := a_servlet_class.render_html_page.new_local ("STRING")
			a_servlet_class.render_html_page.append_expression (l_id + ":= unique_id")
			a_servlet_class.render_html_page.append_expression (Response_variable + ".append (%"<form id=%%%"" + l_id + "%%%" action=%%%"%" +"
				+ Request_variable + ".uri + %"%%%" method=%%%"post%%%">%")")

			create {ARRAYED_LIST [STRING]} l_agent_expressions.make (2)
			a_variable_table.put (l_id, Form_id)
			a_variable_table.put (l_agent_expressions, Form_agent_var)
			if l_variable_exists then
				a_variable_table.put (variable.plain_value (current_controller_id), Form_var_key)
			end
				-- Needs to be initialized BEFORE the children are rendered
			a_servlet_class.render_html_page.append_expression ("agent_table [%"" + l_id + "%"] := create {HASH_TABLE [PROCEDURE [ANY, TUPLE], STRING]}.make (" + children.count.out + ")")
			generate_children (a_servlet_class, a_variable_table)

			a_variable_table.remove (Form_agent_var)
			a_variable_table.remove (Form_id)
			if l_variable_exists then
				a_variable_table.remove (Form_var_key)
			end

			a_servlet_class.render_html_page.append_expression (Response_variable_append + "(%"<input type=%%%"hidden%%%" name=%%%"" + l_id + "%%%" value=%%%"%"+" + l_id + "+%"%%%" />%")")
			write_string_to_result ("</form>", a_servlet_class.render_html_page)

			a_servlet_class.handle_form_internal.append_expression ("if attached a_request.argument_table [%"" + l_id + "%"] as form_argument then")
			a_servlet_class.handle_form_internal.append_expression ("if attached agent_table [%"" + l_id + "%"] as l_agent_table then")
			a_servlet_class.handle_form_internal.append_expression ("from")
			a_servlet_class.handle_form_internal.append_expression ("a_request.argument_table.start")
			a_servlet_class.handle_form_internal.append_expression ("until")
			a_servlet_class.handle_form_internal.append_expression ("a_request.argument_table.after")
			a_servlet_class.handle_form_internal.append_expression ("loop")
			a_servlet_class.handle_form_internal.append_expression ("if attached l_agent_table [a_request.argument_table.key_for_iteration] as l_agent " +
					"and then not a_request.argument_table.item_for_iteration.is_empty then")
			a_servlet_class.handle_form_internal.append_expression ("l_agent.call ([a_request])")
			a_servlet_class.handle_form_internal.append_expression ("end")
			a_servlet_class.handle_form_internal.append_expression ("a_request.argument_table.forth")
			a_servlet_class.handle_form_internal.append_expression ("end")
			a_servlet_class.handle_form_internal.append_expression ("end")
			a_servlet_class.handle_form_internal.append_expression ("end")

			if l_variable_exists then
				a_servlet_class.clean_up_after_render.append_expression_to_end ("if validation_errors.empty then")
				a_servlet_class.clean_up_after_render.append_expression_to_end ("create " + variable.plain_value (current_controller_id) + ".make")
				a_servlet_class.clean_up_after_render.append_expression_to_end ("end")
			end

		ensure then
			a_variable_table_immuted: a_variable_table.count = old a_variable_table.count
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			if a_id.is_equal ("class") then
				data_class := a_attribute
			end
			if a_id.is_equal ("variable") then
				variable := a_attribute
			end
		end

	generates_render: BOOLEAN = True
	generates_handle_form: BOOLEAN = True
	generates_clean_up: BOOLEAN = True

feature -- Constants

	Form_var_key: STRING = "Form_var_key"
	Form_var_redirect: STRING = "Form_var_redirect"
	Form_id: STRING = "Form_id"
	Form_validation_booleans: STRING = "Form_validation_booleans"
	Form_agent_var: STRING = "Form_agent_var"
	Form_lazy_validation_table: STRING = "Form_lazy_validation_table"

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
