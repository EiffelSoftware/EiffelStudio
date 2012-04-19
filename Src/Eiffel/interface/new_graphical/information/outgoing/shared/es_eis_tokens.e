note
	description: "All tokens used by EIS parsers"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_TOKENS

feature -- Access

	eis_string: STRING = "EIS"

	name_string: STRING = "name"

	protocol_string: STRING = "protocol"

	source_string: STRING = "src"

	tag_string: STRING = "tag"

	override_string: STRING = "override"

	true_string: STRING = "true"

	false_string: STRING = "false"

	auto_string: STRING = "auto"

	value_assignment: STRING = "="

	void_string: STRING = "@@@"
			-- Used to hold the place of value of single identifier in storage table

	attribute_seperator: CHARACTER = ','

	tag_seperator: CHARACTER = ','

	space: CHARACTER = ' '

feature -- Built in variables

	target_name_var_name: STRING_8 = "target_name"
	group_name_var_name: STRING_8 = "group_name"
	class_name_var_name: STRING_8 = "class_name"
	feature_name_var_name: STRING_8 = "feature_name"
	unique_id_var_name: STRING_8 = "unique_id"
	system_path_var_name: STRING_8 = "system_path"
	;

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
