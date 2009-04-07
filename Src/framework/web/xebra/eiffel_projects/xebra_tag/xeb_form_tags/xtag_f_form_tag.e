note
	description: "Summary description for {XEB_DISPLAY_TAG}."
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_FORM_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generate
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

feature -- Implementation

	generate (a_render_feature, a_prerender_post_feature, a_prerender_get_feature, a_afterrender_feature: XEL_FEATURE_ELEMENT; variable_table: TABLE [STRING, STRING])
			-- <Precursor>
		local
			data_var: STRING
		do
			data_var := a_render_feature.get_temp_variable
			a_render_feature.append_local (data_var, data_class)
			variable_table.put (data_var, Form_var_key)
			a_render_feature.append_expression ("create " + data_var)
			a_render_feature.append_expression (Response_variable + ".append (%"<form action=%%%"+"
				+ Request_variable + ".target_uri + %" method=%"post%")")
			generate_body (a_render_feature)
			write_string_to_result ("</form>")
			variable_table.remove (Form_var_key)
		end

	put_attribute (id: STRING; a_attribute: STRING)
			-- <Precusor>
		do
			if id.is_equal ("class") then
				data_class := a_attribute
			end
		end

feature -- Constants

	Form_var_key: STRING = "Form_var_key"

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
