indexing
	description: "[
						Default hanlder for eweasel output.
						This handler is the LAST one hanlde eweasel output.
						This handler will generate {EWEASEL_TEST_RESULT_ITEM} definitely on eweasel test exit.
																												]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_RESULT_DEFAULT_HANDLER

inherit
	ES_EWEASEL_RESULT_HANDLER
		redefine
			handle_output,
			handle_output_on_exit
		end

feature {NONE} -- Redefine

	handle_output (a_eweasel_output: STRING): ES_EWEASEL_TEST_RESULT_ITEM
			-- Redefine
		do
			is_on_exit := False
			Result := Precursor {ES_EWEASEL_RESULT_HANDLER}(a_eweasel_output)
		end

	handle_output_on_exit (a_eweasel_output: STRING): ES_EWEASEL_TEST_RESULT_ITEM
			-- Redefine
		do
			is_on_exit := True
			pre_process_on_exit (a_eweasel_output)
			if lines /= Void and then not lines.is_empty then
				Result := process_imp (lines)
			else
				Result := process_imp (create {ARRAYED_LIST [STRING]}.make (0))
			end
		ensure then
			not_void: Result /= Void
		end

	process_imp (a_lines: LIST [STRING]): ES_EWEASEL_TEST_RESULT_ITEM is
			-- Redefine
		local
			l_first_line: STRING
		do
			if is_on_exit then
				create Result
				l_first_line := first_non_empty_line (a_lines)
				if l_first_line /= Void then
					Result.set_title (l_first_line)
				else
					Result.set_title (eweasel_unknow_result)
				end
				if {l_lines: !LIST [STRING]} a_lines then
					Result.set_original_eweasel_ouput (to_one_string (l_lines))
				end
				if {l_test: ES_EWEASEL_TEST_RESULT_ITEM} Result then
					set_with_current_item (l_test)
				end
				Result.set_result_type ({ES_EWEASEL_RESULT_TYPE}.error)
				result_analyzer.reset_cache
			end
		ensure then
			not_void: is_on_exit implies (Result /= Void and Result.result_type = {ES_EWEASEL_RESULT_TYPE}.error)
		end

feature {NONE} -- Implementation

	is_on_exit: BOOLEAN
			-- If exiting eweasel?

	eweasel_unknow_result: STRING_GENERAL is
			-- String for unhandled eweasel output
		local
			l_shared: SHARED_BENCH_NAMES
		do
			create l_shared
			Result := l_shared.names.t_eweasel_unhandled_output
		ensure
			valid: Result /= Void and then not Result.is_empty
		end

	first_non_empty_line (a_lines: LIST [STRING]): STRING is
			-- Find first non empty string item in `a_lines'
			-- Result void if not found
		local
			l_item: STRING
		do
			if a_lines /= Void then
				from
					a_lines.start
				until
					a_lines.after or Result /= Void
				loop
					l_item := a_lines.item
					if l_item /= Void and then not l_item.is_empty and then not l_item.same_string ("%R") then
						Result := l_item
					end

					a_lines.forth
				end
			end
		end

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
