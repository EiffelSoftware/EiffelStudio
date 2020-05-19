note
	description: "The result of an execution of the code analysis."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class
	EW_CODE_ANALYSIS_RESULT

inherit

	EW_EIFFEL_COMPILATION_RESULT
		redefine
			is_status_known,
			update,
			summary,
			sort,
			matches
		end

	EW_CODE_ANALYSIS_CONSTANTS

feature -- Properties

	not_run: BOOLEAN
			-- The code analysis has not been run
		do
				-- The code is run if and only if the compilation was successful.
			Result := not compilation_finished
		end

	analysis_clean: BOOLEAN
			-- No violations, the "No issues." message was printed.

	has_violations: BOOLEAN
			-- One or more violations were reported
		do
			Result := attached violations
		ensure
			violation_list_not_empty: Result implies (attached violations as vs and then not vs.is_empty)
		end

	analysis_argument_warning: BOOLEAN
			-- The code analysis tool reported an unrecognized argument

	analysis_class_warning: BOOLEAN
			-- One of the specified classes was not found or not compiled

	analysis_rule_warning: BOOLEAN
			-- One of the specified forced rules was not found

	analysis_preference_warning: BOOLEAN
			-- One of the specified forced preferences was not found

	has_warnings: BOOLEAN
			-- The code analysis threw a warning
		do
			Result := analysis_argument_warning or analysis_class_warning or analysis_rule_warning
		end

	eweasel_parse_error: BOOLEAN
			-- There was some error or inconsistency in parsing the output and the state is unknown.

	is_status_known: BOOLEAN
			-- Is the status of compilation and analysis known?
		local
			l_count: INTEGER
		do
			if Precursor and not eweasel_parse_error then
					-- Check that we have exactly one analysis status.
				if not_run then
					l_count := l_count + 1
				end
				if analysis_clean then
					l_count := l_count + 1
				end
				if has_violations then
					l_count := l_count + 1
				end
			end
			Result := l_count = 1
		end

	status: STRING_32
		do
			if not is_status_known then
				Result := {STRING_32} "Unknown status or parse error"
			elseif analysis_clean then
				Result := {STRING_32} "No violations"
			elseif has_violations then
				Result := {STRING_32} "One or more violations found"
			elseif not_run then
				Result := {STRING_32} "Analysis not run"
			else
				check is_status_known: False then end
			end
			if analysis_argument_warning then
				Result.append ({STRING_32} "; unrecognized argument warning")
			end
			if analysis_class_warning then
				Result.append ({STRING_32} "; class not found warning")
			end
			if analysis_rule_warning then
				Result.append ({STRING_32} "; forced rule not found warning")
			end
			if analysis_preference_warning then
				Result.append ({STRING_32} "; forced preference not found warning")
			end
		ensure
			result_exists: Result /= Void
		end

	violations: SORTED_TWO_WAY_LIST [EW_CODE_ANALYSIS_VIOLATION];
		-- Validity errors reported by compiler

	summary: STRING_32
			-- String summarizing the status of `Current'
		do
			Result := Precursor
			Result.append ({STRING_32} "%N%T")
			Result.append ({STRING_32} "Code analysis summary: ")
			Result.append (status + {STRING_32} "%N%T")
			if has_violations then
				across
					violations as ic
				loop
					Result.append (ic.item.summary + {STRING_32} "%N%T")
				end
				Result.append ({STRING_32} "%N")
			end
		end

feature -- Update

	update (line: STRING)
			-- Update `Current' to reflect the presence of
			-- `line' as next line in compiler output.
		do
				-- The code analysis output only starts after a successful compilation.
			if not compilation_finished then
				Precursor (line)
			else
				if is_prefix (Analysis_clean_message, line) then
					analysis_clean := True
				elseif is_prefix (In_class_prefix, line) then
					parse_in_class_line (line)
				elseif is_prefix (Violation_prefix, line) then
					parse_violation_line (line)
				elseif is_prefix (Class_not_found_prefix, line) then
					analysis_class_warning := True
				elseif is_prefix (Rule_not_found_prefix, line) then
					analysis_rule_warning := True
				elseif is_prefix (Preference_not_found_prefix, line) then
					analysis_preference_warning := True
				elseif is_prefix (Argument_not_recognized_prefix, line) then
					analysis_argument_warning := True
				elseif is_prefix (Exception_prefix, line) then
					analyze_exception_line (line)
				elseif is_prefix (Exception_occurred_prefix, line) then
					analyze_exception_occurred_line (line)
				end
			end
		end

feature -- Modification

	set_analysis_clean
			-- Set the `analysis_clean' status flag to True.
		do
			analysis_clean := True
		ensure
			analysis_clean
		end

	set_argument_warning
			-- Set the `analysis_argument_warning' status flag to True.
		do
			analysis_argument_warning := True
		ensure
			analysis_argument_warning
		end

	set_class_warning
			-- Set the `analysis_class_warning' status flag to True.
		do
			analysis_class_warning := True
		ensure
			analysis_class_warning
		end

	set_rule_warning
			-- Sets the `analysis_rule_warning' status flag to True.
		do
			analysis_rule_warning := True
		ensure
			analysis_rule_warning
		end

	set_preference_warning
			-- Sets the `analysis_preference_warning' status flag to True.
		do
			analysis_preference_warning := True
		ensure
			analysis_preference_warning
		end

	add_violation (a_violation: EW_CODE_ANALYSIS_VIOLATION)
		local
			vs: like violations
		do
			vs := violations
			if not attached vs then
				create vs.make
				violations := vs
			end
			vs.extend (a_violation)
		end

	sort
			-- Call Precursor and, additionally, make sure violations are also sorted.
		do
			Precursor
			if attached violations as l_violation and then l_violation.count > 1 then
				l_violation.sort
			end
		end

feature -- Comparison

	matches (other: EW_CODE_ANALYSIS_RESULT): BOOLEAN
			-- Does the `Current' actual code analysis result match the `other' expected result?
		do
			Result := Precursor (other) and
				analysis_clean.is_equal (other.analysis_clean) and
				eweasel_parse_error.is_equal (other.eweasel_parse_error) and
				status.is_equal (other.status) and
				list_matches_pattern (violations, other.violations)
		end

feature {NONE} -- Implementation

	last_class_with_messages: detachable STRING

	parse_in_class_line (a_line: STRING)
		require
			is_prefix (in_class_prefix, a_line)
		local
			l_substring_info: TUPLE [char_1_index, char_2_index: INTEGER; substring: detachable STRING]
		do
			l_substring_info := substring_between (a_line, '%'', '%'', in_class_prefix.count)
			if attached l_substring_info.substring as s implies s.is_empty then
				last_class_with_messages := Void
				eweasel_parse_error := True
			else
				last_class_with_messages := s
			end
		end

	parse_violation_line (a_line: STRING)
		require
			is_prefix (violation_prefix, a_line)
		local
			l_line_number: INTEGER
			l_short_type, l_rule_id, l_message: STRING
			l_substring_info: TUPLE [char_1_index, char_2_index: INTEGER; substring: detachable STRING]
			l_violation: EW_CODE_ANALYSIS_VIOLATION
		do
			l_substring_info := substring_between (a_line, '[', ':', 1)
			if attached l_substring_info.substring as s implies s.is_empty then
				eweasel_parse_error := True
				l_line_number := 0
			else
				l_line_number := s.to_integer
			end
			l_substring_info := substring_between (a_line, ']', ':', l_substring_info.char_2_index + 1)
			l_short_type := l_substring_info.substring
			if l_short_type /= Void then
				l_short_type.adjust
			end
			if not is_valid_short_violation_type (l_short_type) then
				eweasel_parse_error := True
				l_short_type := Unknown_violation_type_short
			end
			l_substring_info := substring_between (a_line, ':', '-', l_substring_info.char_2_index)
			l_rule_id := l_substring_info.substring
			if l_rule_id /= Void then
				l_rule_id.adjust
			end
			if l_rule_id = Void or else l_rule_id.is_empty then
				eweasel_parse_error := True
			end
			l_message := a_line.substring (l_substring_info.char_2_index + 1, a_line.count)
			l_message.adjust
			create l_violation.make_with_everything (last_class_with_messages, l_line_number, from_utf_8 (l_rule_id), long_violation_type (l_short_type), from_utf_8 (l_message))
			add_violation (l_violation)
		end

	substring_between (a_line: STRING; a_char1, a_char2: CHARACTER; a_start_index: INTEGER): TUPLE [char_1_index, char_2_index: INTEGER; substring: detachable STRING]
			-- Returns the substring between `a_char1' and `a_char2' in the given index, starting from `a_start_index'.
			-- The returned tuple contains the indices of the two characters and the actual substring.
			-- If the separators are not found, [0, 0, Void] is returned.
		local
			i1, i2: INTEGER
			l_parse_error: BOOLEAN
		do
			i1 := a_line.index_of (a_char1, a_start_index)
			if i1 = 0 then
				l_parse_error := True
				i1 := a_start_index
			end
			i2 := a_line.index_of (a_char2, i1 + 1)
			if i2 = 0 then
				l_parse_error := True
				i2 := i1
			end
			if l_parse_error then
				Result := [0, 0, Void]
			else
				Result := [i1, i2, a_line.substring (i1 + 1, i2 - 1)]
			end
		end

	list_matches_pattern (a_main_list, a_pattern_list: LIST [EW_CODE_ANALYSIS_VIOLATION]): BOOLEAN
			-- Does the list of violation `a_main_list' match the list of violation patterns `a_pattern_list'?
		do
			if attached a_main_list then
				if attached a_pattern_list then
					if a_main_list.count = a_pattern_list.count then
						Result := True
						from
							a_main_list.start
							a_pattern_list.start
						until
							a_main_list.after or a_pattern_list.after
						loop
							Result := Result and a_main_list.item.matches_pattern (a_pattern_list.item)
							a_main_list.forth
							a_pattern_list.forth
						end
						check
							a_main_list.after and a_pattern_list.after
						end
					end
				else
					Result := a_main_list.is_empty
				end
			else
				Result := attached a_pattern_list implies a_pattern_list.is_empty
			end
		end

invariant
	violation_list_not_empty: attached violations implies not violations.is_empty

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	revised_by: "Alexander Kogtenkov"
	license: "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
					This file is part of the EiffelWeasel Eiffel Regression Tester.
		
					The EiffelWeasel Eiffel Regression Tester is free
					software; you can redistribute it and/or modify it under
					the terms of the GNU General Public License version 2 as published
					by the Free Software Foundation.
		
					The EiffelWeasel Eiffel Regression Tester is
					distributed in the hope that it will be useful, but
					WITHOUT ANY WARRANTY; without even the implied warranty
					of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
					See the GNU General Public License version 2 for more details.
		
					You should have received a copy of the GNU General Public
					License version 2 along with the EiffelWeasel Eiffel Regression Tester
					if not, write to the Free Software Foundation,
					Inc., 51 Franklin St, Fifth Floor, Boston, MA
	]"

end
