indexing
	description: "[
						Handler which remove first two lines of eWeasel output.
						The two lines are `signature' and `signature_2'	
						This handler will not generate {EWEASEL_TEST_RESULT_ITEM}
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_BEGIN_RESULT_HANDLER

inherit
	ES_EWEASEL_RESULT_HANDLER
		redefine
			handle_output,
			handle_output_on_exit
		end

feature -- Redefine

	handle_output (a_eweasel_output: STRING): ES_EWEASEL_TEST_RESULT_ITEM is
			-- Redefine
		do
			process (a_eweasel_output)
		end

	handle_output_on_exit (a_eweasel_output: STRING): ES_EWEASEL_TEST_RESULT_ITEM is
			-- Redefine
		do
			process (a_eweasel_output)
		end

feature {NONE} -- Implementation

	process (a_string: STRING) is
			-- This feature only remove strings from `a_string'
		local
			l_index, l_end_index: INTEGER
		do
			if a_string.has_substring (signature) and a_string.has_substring (signature_2) then
				l_index := a_string.substring_index (signature, 1)
				l_end_index := a_string.substring_index (signature_2, 1) + signature_2.count

				check found: l_index /= 0 end
				a_string.remove_substring (l_index, l_end_index)
			end
		end

	process_imp (a_lines: LIST [STRING]): ES_EWEASEL_TEST_RESULT_ITEM is
			-- Redefine
		do
		end

	signature: STRING is "EiffelWeasel test execution manager%R"
			-- eWeasel first line of output

	signature_2: STRING is "(version 1.0.001)%R";
			-- eWeasel second line of output
			-- FIXIT: This value have to be changed if eWeasel version changed.

indexing
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
