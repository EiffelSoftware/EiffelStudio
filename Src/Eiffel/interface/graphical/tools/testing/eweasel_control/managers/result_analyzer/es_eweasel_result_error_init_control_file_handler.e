indexing
	description: "[
					Handler for eweasel initial control file error
																						]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_RESULT_ERROR_INIT_CONTROL_FILE_HANDLER

inherit
	ES_EWEASEL_RESULT_HANDLER

feature -- Redefine

	process_imp (a_lines: LIST [STRING]): ES_EWEASEL_TEST_RESULT_ITEM is
			-- Redefine
		do
			if not a_lines.is_empty and then a_lines.first.substring_index (signature_string, 1) = 1 then
				create Result
				Result.set_title (signature_string)
				Result.set_result_type ({ES_EWEASEL_RESULT_TYPE}.error)

				if {l_lines: LIST [STRING]} a_lines then
					Result.set_original_eweasel_ouput (to_one_string (l_lines))
				end

				result_analyzer.reset_cache
			end
		end

feature {NONE} -- Implementation

	signature_string: STRING is "Error in initial control file";
			-- Signature string for the error will be handled.

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
