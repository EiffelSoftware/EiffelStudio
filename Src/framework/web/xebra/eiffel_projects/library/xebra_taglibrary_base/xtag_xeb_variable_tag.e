note
	description: "[
		This works only if a variable has been declared for instance in a {XTAG_XEB_ITERATE_TAG}.
		It works as a {XTAG_XEB_DISPLAY_TAG} but performs a message call on the specified variable
		to retrieve the value to be displayed.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_VARIABLE_TAG

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
			create feature_name.make ("")
			create variable_name.make ("")
		ensure
			feature_name_attached: attached feature_name
			variable_name_attached: attached variable_name
		end

feature

	feature_name: XTAG_TAG_ARGUMENT
			-- The name of the feature to be called on the variable

	variable_name: XTAG_TAG_ARGUMENT
			-- The name of the variable

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do
			a_servlet_class.render_feature.append_expression (Response_variable_append + " (" + variable_name.value (current_controller_id) + "." + feature_name.value (current_controller_id) + ")")
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			if a_id.is_equal ("id") then
				variable_name := a_attribute
			end
			if a_id.is_equal ("feature") then
				feature_name := a_attribute
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
