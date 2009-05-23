note
	description: "Summary description for {XEB_DISPLAY_TAG}."
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_FORM_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render,
			generates_postrender,
			generates_afterrender
		end

create
	make

feature -- Initialization

	make
		do
			make_base
			data_class := ""
		end

feature -- Access

	data_class: STRING
			-- Name of the class which holds the data of the form

	variable: STRING
			-- The name for the variable

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_data_var: STRING
			l_redirect_var: STRING
			l_agent_var: STRING
			l_form_id: STRING
			l_validation_booleans: LIST [STRING]
			l_validation_table: HASH_TABLE [STRING, STRING]
		do
			if attached variable then
				a_servlet_class.add_variable_by_name_type (variable, data_class)
				a_servlet_class.make_feature.append_expression ("create " + variable + ".make")
			end
			l_form_id := a_servlet_class.prerender_post_feature.new_uid
			l_data_var := a_servlet_class.render_feature.new_uid
			--l_redirect_var := a_servlet_class.get_unique_identifier
			--a_servlet_class.add_variable_by_name_type (l_redirect_var, "STRING")
			l_redirect_var := a_servlet_class.prerender_post_feature.new_local ("STRING")
			l_agent_var := a_servlet_class.prerender_post_feature.new_local ("FUNCTION [ANY, TUPLE [" + data_class + "], STRING]")

			a_servlet_class.prerender_post_feature.append_expression ("if " + request_variable + ".arguments.has_key (%"" + l_data_var + "%") then")

			create l_validation_table.make (2)

			a_variable_table.put (variable, Form_var_key)
			a_variable_table.put (l_redirect_var, Form_var_redirect)
			a_variable_table.put (l_form_id, Form_id)
			a_variable_table.put (l_agent_var, Form_agent_var)
			a_variable_table.put (l_validation_table, Form_lazy_validation_table)

			a_servlet_class.render_feature.append_expression (Response_variable + ".append (%"<form id=%%%"" + l_form_id + "%%%" action=%%%"%" +"
				+ Request_variable + ".target_uri + %"%%%" method=%%%"post%%%">%")")

			create {ARRAYED_LIST [STRING]} l_validation_booleans.make (2)
			a_variable_table.put (l_validation_booleans, Form_validation_booleans)
			generate_children (a_servlet_class, a_variable_table)
			a_variable_table.remove (Form_validation_booleans)

			a_servlet_class.render_feature.append_expression (response_variable_append + "(%"<input type=%%%"hidden%%%" name=%%%"" + l_data_var + "%%%" />%")")
			write_string_to_result ("</form>", a_servlet_class.render_feature)
			if not l_validation_booleans.is_empty then
				a_servlet_class.prerender_post_feature.append_expression ("if not (" + concatenate_with ("and", l_validation_booleans) + ") then")
				a_servlet_class.prerender_post_feature.append_expression (l_redirect_var + " := %"%"")
				a_servlet_class.prerender_post_feature.append_expression ("end")
			end

			a_servlet_class.prerender_post_feature.append_expression ("if attached " + l_agent_var + " then")
			a_servlet_class.prerender_post_feature.append_expression (l_redirect_var + " := " + l_agent_var + ".item ([" + variable + "])")
			a_servlet_class.prerender_post_feature.append_expression ("end")

			a_servlet_class.prerender_post_feature.append_expression ("if attached " + l_redirect_var + " and then not " + l_redirect_var + ".is_empty then")
			a_servlet_class.prerender_post_feature.append_expression (response_variable + ".set_goto_request (" + l_redirect_var + ")")
			a_servlet_class.prerender_post_feature.append_expression ("end")
			a_servlet_class.prerender_post_feature.append_expression ("end")

			a_variable_table.remove (Form_var_key)
			a_variable_table.remove (Form_var_redirect)
			a_variable_table.remove (Form_id)
			a_variable_table.remove (Form_agent_var)
			a_variable_table.remove (Form_lazy_validation_table)
		ensure then
			a_variable_table_immuted: a_variable_table.count = old a_variable_table.count
		end

	internal_put_attribute (a_id: STRING; a_attribute: STRING)
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
	generates_postrender: BOOLEAN = True
	generates_afterrender: BOOLEAN = False

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
