indexing
	description: "[
					Analyze eweasel result output.
					Descendants will generate a {EWEASEL_TEST_RESULT_ITEM} if they find related eweasel out string.
					Chain of responsibility pattern.
																														]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_EWEASEL_RESULT_HANDLER

feature -- Command

	handle_output (a_eweasel_output: STRING): ES_EWEASEL_TEST_RESULT_ITEM
			-- Analyze `a_eweasel_output' if possible.
			-- If success, Result not Void.
		require
			not_void: a_eweasel_output /= Void
		do
			pre_process (a_eweasel_output)
			if one_block /= Void then
				check not_void: lines /= Void end
				Result := process_imp (lines)
			end
		end

	handle_output_on_exit (a_eweasel_output: STRING): ES_EWEASEL_TEST_RESULT_ITEM
			-- Just after eweasel executable exited, analyze `a_eweasel_output' if possible.
			-- If success, Result not Void.
		require
			not_void: a_eweasel_output /= Void
		do
			pre_process_on_exit (a_eweasel_output)
			check not_void: lines /= Void end
			if a_eweasel_output /= Void and then not a_eweasel_output.is_empty then
				Result := process_imp (lines)
			end
		end

feature {NONE} -- Tempory results

	one_block: TUPLE [content: STRING_GENERAL; end_index: INTEGER]
			-- Result set by `pre_process'
		do
			Result := result_analyzer.one_block
		end

	lines: LIST [STRING]
			-- Result set by `pre_process'
		do
			Result := result_analyzer.lines_cell.item
		end

feature {NONE} -- Implementation

	process_imp (a_lines: LIST [STRING]): ES_EWEASEL_TEST_RESULT_ITEM
			-- Parse information in `a_lines'
			-- Result may be void if `a_lines' not related with any descendants handlers.
		require
			not_void: a_lines /= Void
		deferred
		ensure
			cleared: Result /= Void implies (lines = Void and one_block = Void)
		end

	to_one_string (a_lines: !LIST [STRING]): !STRING is
			-- Join each lines of string in `a_line' to one string.
		do
			create Result.make_empty
			from
				a_lines.start
			until
				a_lines.after
			loop
				Result.append (a_lines.item)

				a_lines.forth
			end
		end

	set_with_current_item (a_item: !ES_EWEASEL_TEST_RESULT_ITEM) is
			-- Set `a_item' with Current date and time.
		local
			l_date_time: DT_DATE_TIME
			l_date: DATE
			l_time: TIME
		do
			create l_date.make_now
			create l_time.make_now
			create l_date_time.make (l_date.year, l_date.month, l_date.day, l_time.hour, l_time.minute, l_time.second)

			a_item.set_test_run_time (l_date_time)
		ensure
			setted: a_item.test_run_time /= Void
		end

feature {NONE} -- Implementation

	pre_process (a_eweasel_buffer_output: STRING) is
			-- Find one result block in `a_eweasel_output'.
			-- The block means ONE test case result, other test cases results will be excluded.
			-- If found, the result is avaliable in `one_block'
		require
			not_void: a_eweasel_buffer_output /= Void
		do
			if one_block = Void then
				result_analyzer.one_block_cell.put (one_result_block (a_eweasel_buffer_output))
				if one_block /= Void then
					a_eweasel_buffer_output.remove_head (one_block.end_index)
				end
			end

			if one_block /= Void and lines = Void then
				result_analyzer.lines_cell.put (separate_lines (one_block.content))
			end
		end

	pre_process_on_exit (a_eweasel_buffer_output: STRING) is
				-- Find one result block in `a_eweasel_buffer_output'.
				-- Almost same as `pre_process' except it handle special cases on eweasel exit
		require
			not_void: a_eweasel_buffer_output /= Void
		local
			l_lines: like separate_lines
		do
			if not a_eweasel_buffer_output.is_empty then
				if lines = Void then
					l_lines := separate_lines (a_eweasel_buffer_output)
					-- Find last two statistic line, remove them
					if l_lines.count > 1 then
						if l_lines.last.has_substring ("Failed: ") then
							l_lines.finish
							l_lines.remove
						end
					end
					if l_lines.count > 1 then
						if l_lines.last.has_substring ("Passed: ") then
							l_lines.finish
							l_lines.remove
						end
					end
					if not l_lines.is_empty then
						-- Clear "Test" at the beginning
						if l_lines.first.starts_with ("Test ") then
							l_lines.first.remove_head (5)
						end
					end
					result_analyzer.lines_cell.put (l_lines)
				end
			end
		end

	one_result_block (a_string: STRING): TUPLE [STRING_GENERAL, INTEGER] is
			-- Text block between two "Test " tag. Void if not found.
		require
			not_voidP: a_string /= Void
		local
			l_finder: ES_EWEASEL_OUTPUT_REGULAR_EXPRESSION_FINDER
		do
			create l_finder
			Result := l_finder.one_result_block (a_string)
		end

	class_name_in_string (a_string: STRING): STRING_GENERAL is
			-- Find class names in `a_string'
		require
			not_void: a_string /= Void
		local
			l_finder: ES_EWEASEL_OUTPUT_REGULAR_EXPRESSION_FINDER
		do
			create l_finder
			Result := l_finder.class_name_in (a_string)
		end

feature {NONE} -- Non string implementation

	result_analyzer: !ES_EWEASEL_RESULT_ANALYZER is
			-- Manager of Current
		local
			l_shared: ES_EWEASEL_SINGLETON_FACTORY
		do
			create l_shared
			Result := l_shared.result_analyzer
		end

	separate_lines (a_result_content: STRING_GENERAL): LIST [STRING] is
			-- Separate `a_result_content' to list of lines base on `%N'.
		require
			not_void: a_result_content /= Void
		local
			l_string: STRING
		do
			l_string := a_result_content.as_string_8

			Result := l_string.split ('%N')

			from
				Result.start
			until
				Result.after
			loop
				if Result.item = Void or else Result.item.is_empty or else Result.item.is_equal ("%R") then
					Result.remove
				else
					Result.forth
				end
			end
		ensure
			not_void: Result /= Void
			no_empty_string: Result.for_all (agent (a_string: STRING): BOOLEAN do
														Result := a_string /= Void and then not a_string.is_empty and then not a_string.is_equal ("%R")
													end)
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
