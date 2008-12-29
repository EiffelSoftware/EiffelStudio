note
	description: "[
					Final step of test case creation wizard
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NEW_UNIT_TEST_WIZARD_FINAL

inherit
	EB_WIZARD_FINAL_STATE_WINDOW
		redefine
			make,
			wizard_information,
			proceed_with_current_info
		end

create
	make

feature {NONE} -- Initialization

	make (an_info: like wizard_information)
			-- Redefine
		do
			wizard_information := an_info
		ensure then
			set: wizard_information = an_info
		end

feature {NONE} -- Implementation

	display_state_text
			-- Redefine
		do
			title.set_text (title_string)
			message.set_text (message_string)
		end

	wizard_information: ES_NEW_UNIT_TEST_WIZARD_INFORMATION;
			-- Redefine

	proceed_with_current_info
			-- Redefine
		do
			Precursor {EB_WIZARD_FINAL_STATE_WINDOW}
		end

	title_string: STRING_GENERAL
			-- Title string
		do
			Result := interface_names.t_Unit_test_files_will_be_generated
		end

	message_string: STRING_GENERAL
			-- Message string
		local
			l_path: STRING
		do
			create {STRING_32} Result.make_from_string (interface_names.l_New_files_will_be_generated_at)
			Result.append ("%N%N")

			Result.append (interface_names.l_cluster)
			Result.append (": ")
			Result.append (wizard_information.cluster.cluster_name)

			l_path := wizard_information.cluster_path
			if l_path /= Void and then not l_path.is_empty then
				Result.append ("%N")
				Result.append (interface_names.l_path)
				Result.append (": ")
				Result.append (l_path)
			end
		end

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
