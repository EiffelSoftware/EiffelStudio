indexing
	description: "[
					Handler for failed eweasel output
					If eweasel have failed output, this handler will generate a {EWEASEL_TEST_RESULT_ITEM}
																											]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_FAILED_RESULT_HANDLER

inherit
	ES_EWEASEL_RESULT_HANDLER

feature {NONE} -- Implementation

	process_imp (a_lines: LIST [STRING]): ES_EWEASEL_TEST_RESULT_ITEM
			-- Redefine
		local
			l_class_name: STRING_GENERAL
		do
			if a_lines.first.has_substring (signature) then
				create Result
				if {l_lines: !LIST [STRING]} a_lines then
					Result.set_original_eweasel_ouput (to_one_string (l_lines))
				end
				Result.set_title (a_lines.first)
				if {l_test: ES_EWEASEL_TEST_RESULT_ITEM} Result then
					set_with_current_item (l_test)
				end

				l_class_name := class_name_in_string (a_lines.first)

				if l_class_name /= Void and then not l_class_name.is_empty then
					Result.set_root_class_name (l_class_name)
					Result.set_result_type ({ES_EWEASEL_RESULT_TYPE}.failed)
				else
					Result.set_result_type ({ES_EWEASEL_RESULT_TYPE}.error)
				end

				result_analyzer.reset_cache
			end
		ensure then
			valid: Result /= Void implies (Result.result_type = {ES_EWEASEL_RESULT_TYPE}.failed or Result.result_type = {ES_EWEASEL_RESULT_TYPE}.error)
		end

	signature: STRING is ": failed";
			-- eweasel output failed signature string.

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
