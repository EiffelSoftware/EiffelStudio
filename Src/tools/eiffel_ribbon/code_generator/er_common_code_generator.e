note
	description: "[
					Code generator's common ancestor
					]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_COMMON_CODE_GENERATOR

feature -- Command

	generate_all_codes
			-- Generate all ribbon codes
		deferred
		end

feature -- Query

	is_uicc_available: BOOLEAN
			-- Is UICC.exe available?
		deferred
		end

	command_name_constants: STRING_32 = "command_name_constants"
			-- Constants for command name file

	group_counter, button_counter: INTEGER
			-- When generating group classes , it count how many groups totally

feature {ER_CODE_GENERATOR_FOR_APPLICATION_MENU} -- Command

	generate_group_class (a_group_node: EV_TREE_NODE; a_index: INTEGER; a_file_name, a_imp_file_name, a_default_name: STRING_32)
			-- Generate ribbon group codes
		require
			not_void: a_group_node /= void
			valid: a_file_name /= void and then not a_file_name.is_empty
			valid: a_imp_file_name /= void and then not a_imp_file_name.is_empty
			valid: a_default_name /= void and then not a_default_name.is_empty
			valid: a_group_node.text.same_string ({ER_XML_CONSTANTS}.group) or else a_group_node.text.same_string ({ER_XML_CONSTANTS}.menu_group)
		deferred
		end

feature {ER_CODE_GENERATOR_FOR_QAT} -- Command

	increase_button_counter (a_item: INTEGER)
			-- Increase `button_counter'
		deferred
		end

	generate_item_class (a_item_node: EV_TREE_NODE; a_index: INTEGER; a_gen_data: ER_CODE_GENERATOR_INFO)
			-- Generate ribbon item codes
		require
			not_void: a_item_node /= void
			valid: ((create {ER_XML_CONSTANTS}).is_valid_ribbon_item (a_item_node.text))
			not_void: a_gen_data /= Void
		deferred
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
