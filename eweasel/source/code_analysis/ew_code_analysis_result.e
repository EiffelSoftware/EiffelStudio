note
	description: "The result of an execution of the code analysis."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "05/2014"

class
	EW_CODE_ANALYSIS_RESULT

inherit

	EW_EIFFEL_COMPILATION_RESULT
		redefine
			is_status_known,
			update,
			summary
		end

	EW_CODE_ANALYSIS_CONSTANTS

feature -- Properties

	analysis_clean: BOOLEAN
			-- No violations, the "No issues." message was printed.

	has_violations: BOOLEAN
			-- One or more violations were reported

	eweasel_parse_error: BOOLEAN
			-- There was some error or inconsistency in parsing the output and the state is unknown.

	is_status_known: BOOLEAN
			-- Is the status of compilation and analysis known?
		do
			Result := Precursor and (analysis_clean xor has_violations) and not eweasel_parse_error
		end

	status: STRING
		do
			if not is_status_known then
				Result := "Unknown status or parse error"
			elseif analysis_clean then
				Result := "No violations"
			elseif has_violations then
				Result := "One or more violations found"
			end
		end

	violations: SORTED_TWO_WAY_LIST [EW_CODE_ANALYSIS_VIOLATION];
		-- Validity errors reported by compiler

	summary: STRING
			-- String summarizing the status of `Current'
		do
			Result := Precursor
			Result.append ("%N%N")
			Result.append ("------ Code analysis summary ------%N")
			Result.append (status + "%N%N")
			if (has_violations) then
				across violations as ic loop
					Result.append (ic.item.summary + "%N")
				end
				Result.append ("%N")
			end
		end

feature -- Update

	update (line: STRING)
			-- Update `Current' to reflect the presence of
			-- `line' as next line in compiler output.
		local
			s: SEQ_STRING;
		do
				-- The code analysis output only starts after a successful compilation.
			if not compilation_finished then
				Precursor (line)
			else
				create s.make (line.count);
				s.append (line);
				if line ~ Analysis_clean_message then
					analysis_clean := True
				elseif is_prefix (In_class_prefix, line) then
					parse_in_class_line (line)
				elseif is_prefix (Violation_prefix, line) then
					parse_violation_line (line)
				elseif is_prefix (Exception_prefix, line) or is_prefix (Exception_occurred_prefix, line) then
					analyze_exception (line)
				end
			end
		end

feature {NONE} -- Implementation

	last_class_with_messages: STRING

	parse_in_class_line (a_line: STRING)
		require
			is_prefix (in_class_prefix, a_line)
		local
			l_substring_info: TUPLE [char_1_index, char_2_index: INTEGER; substring: STRING]
		do
			l_substring_info := substring_between (a_line, '%'', '%'', in_class_prefix.count)
			if l_substring_info.substring = Void or else l_substring_info.substring.is_empty then
				last_class_with_messages := Void
				eweasel_parse_error := True
			else
				last_class_with_messages := l_substring_info.substring
			end
		end

	parse_violation_line (a_line: STRING)
		require
			is_prefix (violation_prefix, a_line)
		local
			l_line_number: INTEGER
			l_short_type, l_rule_id, l_message: STRING
			l_substring_info: TUPLE [char_1_index, char_2_index: INTEGER; substring: STRING]
			l_violation: EW_CODE_ANALYSIS_VIOLATION
		do
			l_substring_info := substring_between (a_line, '[', ':', 1)
			if l_substring_info.substring = Void or else l_substring_info.substring.is_empty then
				eweasel_parse_error := True
				l_line_number := 0
			else
				l_line_number := l_substring_info.substring.to_integer
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
			l_substring_info := substring_between (a_line, ':', '-', l_substring_info.char_2_index + 1)
			l_rule_id := l_substring_info.substring
			if l_rule_id /= Void then
				l_rule_id.adjust
			end
			if l_rule_id /= Void or else l_rule_id.is_empty then
				eweasel_parse_error := True
			end
			l_message := a_line.substring (l_substring_info.char_2_index + 1, a_line.count)
			l_message.adjust
			create l_violation.make_with_everything (last_class_with_messages, l_line_number, l_rule_id, l_short_type, l_message)
		end

	add_violation (a_violation: EW_CODE_ANALYSIS_VIOLATION)
		do
			if violations = Void then
				create violations.make
			end
			violations.extend (a_violation)
		end

	substring_between (a_line: STRING; a_char1, a_char2: CHARACTER; a_start_index: INTEGER): TUPLE [char_1_index, char_2_index: INTEGER; substring: STRING]
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
				Result := [i1, i2, a_line.substring (i1, i2)]
			end
		end

feature {NONE} -- Syntax ambiguity workaround, the compiler will not compile if a class note follows immediately an attribute.

note
	copyright: "[
		Copyright (c) 1984-2007, University of Southern California and contributors.
		All rights reserved.
	]"
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
