note
	description: "An Eiffel compilation result"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EW_EIFFEL_COMPILATION_RESULT

inherit
	EW_PROCESS_RESULT
		redefine
			update
		end

	EW_STRING_UTILITIES
	EW_EIFFEL_COMPILER_CONSTANTS

feature -- Properties

	has_command_line_option_error: BOOLEAN
			-- Is there a command-line option error?

	syntax_errors: SORTED_TWO_WAY_LIST [EW_EIFFEL_SYNTAX_ERROR]
			-- Syntax errors reported by compiler

	validity_errors: SORTED_TWO_WAY_LIST [EW_EIFFEL_VALIDITY_ERROR]
			-- Validity errors reported by compiler

	last_validity_error: EW_EIFFEL_VALIDITY_ERROR
			-- Last validity error being inserted

	missing_precompile: BOOLEAN
			-- Was a missing precompile detected during
			-- compilation?

	had_panic: BOOLEAN
			-- Did a panic occur during compilation?

	had_exception: BOOLEAN
			-- Did an exception occur during compilation?

	execution_failure: BOOLEAN
			-- Did a system execution failure occur during
			-- compilation?

	illegal_instruction: BOOLEAN
			-- Was an illegal instruction executed
			-- during compilation?

	compilation_paused: BOOLEAN
			-- Did compilation pause and await user input
			-- before resuming?

	compilation_aborted: BOOLEAN
			-- Was compilation aborted prematurely, usually
			-- due to an exception?

	compilation_finished: BOOLEAN
			-- Did compilation finish normally?

	exception_tag: STRING
			-- Tag of exception which aborted compilation,
			-- if any

	is_status_known: BOOLEAN
			-- Is status of compilation known?
		do
			Result := compilation_paused or compilation_aborted
				or compilation_finished or missing_precompile
				or execution_failure or had_exception
				or had_panic or illegal_instruction or
				has_command_line_option_error
		end

	raw_compiler_output: STRING
			-- Raw output of compiler, if not Void

	summary: STRING_32
			-- Summary of `Current'
		local
			status: STRING_32
		do
			create Result.make_empty
			if attached syntax_errors as errors then
				across
					errors as e
				loop
					Result.extend ('%T')
					Result.append (e.item.summary)
					Result.extend ('%N')
				end
			end
			if attached validity_errors as errors then
				across
					errors as e
				loop
					Result.extend ('%T')
					Result.append (e.item.summary)
					Result.extend ('%N')
				end
			end

			create status.make_empty
			if has_command_line_option_error then
				status.append ({STRING_32} "command_line_option_error ")
			end
			if compilation_paused then
				status.append ({STRING_32} "paused ");
			end;
			if compilation_aborted then
				status.append ({STRING_32} "aborted ");
			end;
			if compilation_finished then
				status.append ({STRING_32} "completed ");
			end;
			if missing_precompile then
				status.append ({STRING_32} "missing_precompile ")
			end
			if execution_failure then
				status.append ({STRING_32} "system_failed ")
			end
			if had_exception then
				status.append ({STRING_32} "had_exception ")
				if exception_tag /= Void then
					status.append ({STRING_32} "(")
					status.append (from_utf_8 (exception_tag))
					status.append ({STRING_32} ") ")
				end
			end
			if had_panic then
				status.append ({STRING_32} "had_panic ")
			end
			if illegal_instruction then
				status.append ({STRING_32} "illegal_instruction ")
			end
			if status.is_empty then
				status.append ({STRING_32} "unknown	")
				if raw_compiler_output /= Void then
					status.extend ('%N')
					status.append ({STRING_32} "Raw compiler output:")
					status.extend ('%N')
					status.append (from_utf_8 (raw_compiler_output))
				end
			end
			status.prepend ({STRING_32} "%TFinal status:  ")
			Result.append (status)
		end

feature -- Update

	update (line: STRING)
			-- Update `Current' to reflect the presence of
			-- `line' as next line in compiler output.
		local
			s: SEQ_STRING
		do
			create s.make (line.count)
			s.append (line)
			if is_prefix (Pass_prefix, line) then
				s.start
				s.search_string_after (Pass_string, 0);
				if not s.after then
					in_error := False
				end
			elseif is_prefix (Command_line_option_error_prefix, line) then
				in_error := False
				has_command_line_option_error := True
			elseif is_prefix (Syntax_error_prefix, line) then
				in_error := False
				analyze_syntax_error (line)
			elseif is_prefix (Syntax_warning_prefix, line) then
				in_error := False
				analyze_syntax_warning (line)
			elseif is_prefix (validity_error_prefix, line) then
				in_error := True
				analyze_validity_error (line, validity_error_prefix.count)
			elseif is_prefix (validity_warning_prefix, line) then
				in_error := True
				analyze_validity_error (line, validity_warning_prefix.count)
			elseif is_prefix (Resume_prompt, line) then
				in_error := False
				compilation_paused := True
			elseif is_prefix (Missing_precompile_prompt, line) then
				in_error := False
				missing_precompile := True
				compilation_paused := True
			elseif is_prefix (Aborted_prefix, line) then
				in_error := False
				compilation_aborted := True
			elseif is_prefix (Exception_prefix, line) then
				in_error := False
				analyze_exception_line (line)
			elseif is_prefix (Exception_occurred_prefix, line) then
				in_error := False
				analyze_exception_occurred_line (line)
			elseif is_prefix (Failure_prefix, line) then
				in_error := False
				execution_failure := True
			elseif is_prefix (Illegal_inst_prefix, line) then
				in_error := False
				illegal_instruction := True
			elseif is_prefix (Finished_prefix, line) then
				in_error := False
				compilation_finished := True
			elseif in_error then
				analyze_error_line (line)
			end
			s.to_lower
			s.start
			s.search_string_after (Panic_string, 0)
			if not s.after then
				had_panic := True
			end
		end

feature {NONE} -- State

	in_error: BOOLEAN;
			-- Are we analyzing lines which are part of
			-- a syntax or validity error?


feature -- Modification

	set_has_command_line_option_error
			-- Record an error in command line options.
		do
			has_command_line_option_error := True
		ensure
			has_command_line_option_error: has_command_line_option_error
		end

	set_compilation_paused
			-- Set the `compilation_paused' status flag to True.
		do
			compilation_paused := True
		ensure
			compilation_paused
		end;

	set_compilation_finished
			-- Set the `compilation_finished' status flag to True.
		do
			compilation_finished := True
		ensure
			compilation_finished
		end;

	add_syntax_error (err: EW_EIFFEL_SYNTAX_ERROR)
		require
			error_not_void: err /= Void
		do
			if syntax_errors = Void then
				create syntax_errors.make
			end;
			syntax_errors.extend (err)
		end;

	add_validity_error (err: EW_EIFFEL_VALIDITY_ERROR)
		require
			error_not_void: err /= Void
		do
			if validity_errors = Void then
				create validity_errors.make
			end
			validity_errors.extend (err)
			last_validity_error := err
		end

	set_raw_compiler_output (s: STRING)
		require
			s_not_void: s /= Void
		do
			raw_compiler_output := s
		end;

	sort
			-- Sort `syntax_errors' and `validity_errors'.
			-- Even though they are sorted lists, they may
			-- not be correctly sorted because items may
			-- have been added before full key was set
		do
			if syntax_errors /= Void and then syntax_errors.count > 1 then
				syntax_errors.sort
			end
			if validity_errors /= Void and then validity_errors.count > 1 then
				validity_errors.sort
			end
		end

feature -- Comparison

	matches (other: EW_EIFFEL_COMPILATION_RESULT): BOOLEAN
			-- Does the actual compilation result `Current' match the expected result `other'?
		require
			other_not_void: other /= Void
		do
			Result := had_panic = other.had_panic and
				had_exception = other.had_exception and
				missing_precompile = other.missing_precompile and
				has_command_line_option_error = other.has_command_line_option_error and
				execution_failure = other.execution_failure and
				illegal_instruction = other.illegal_instruction
				and compilation_paused = other.compilation_paused
				and compilation_aborted = other.compilation_aborted
				and compilation_finished = other.compilation_finished
				and equal(exception_tag, other.exception_tag)
				and linked_list_matches (syntax_errors, other.syntax_errors)
				and linked_list_matches (validity_errors, other.validity_errors)
		end

feature {NONE} -- Implementation

	analyze_exception_line (line: STRING)
		require
			exception_prefix: is_prefix (Exception_prefix, line)
		do
			had_exception := True;
			if exception_tag = Void then
				create exception_tag.make(0);
			end;
			line.keep_tail(line.count - Exception_prefix.count);
			exception_tag.append (line);
				-- Remove all newlines characters so that the exception tag appears on a single line.
			exception_tag.replace_substring_all ("%N", "")
			exception_tag.replace_substring_all ("%R", "")
		end

	analyze_exception_occurred_line (line: STRING)
		require
			exception_occurred_prefix: is_prefix (Exception_occurred_prefix, line)
		do
			had_exception := True;
			if exception_tag = Void then
				create exception_tag.make(0)
			end
			if exception_tag.is_empty then
				line.keep_tail (line.count - Exception_occurred_prefix.count)
				exception_tag.append (line)
					-- Remove all newlines characters so that the exception tag appears on a single line.
				exception_tag.replace_substring_all ("%N", "")
				exception_tag.replace_substring_all ("%R", "")
			end
		end

	analyze_syntax_error (line: STRING)
		require
			line_not_void: line /= Void;
		do
			add_syntax_error (new_syntax_error (line));
		end;

	analyze_syntax_warning (line: STRING)
		require
			line_not_void: line /= Void;
		do
			add_syntax_error (new_syntax_warning (line))
		end;

	new_syntax_error (line: STRING): EW_EIFFEL_SYNTAX_ERROR
		require
			line_not_void: line /= Void;
		local
			words: LIST [STRING]
			line_no, kind: STRING
			class_name: STRING
			count: INTEGER
		do
			words := broken_into_words_8 (line)
			count := words.count
			if count >= 5 then
				line_no := words [5]
			end
			if count >= 7 then
				kind := words [7]
				kind.to_lower
				if kind.same_string ("class") then
					if count >= 8 then
						class_name := words [8]
					else
						class_name := ""
					end
				elseif kind.same_string ("ace") then
					class_name := ""
				elseif kind.same_string ("cluster_properties") then
					class_name := "_USE_FILE"
				else
					class_name := "%"UNKNOWN%""
				end
			else
				create class_name.make_empty
			end
			create Result.make (from_utf_8 (class_name))
			if attached line_no and then line_no.is_integer then
				Result.set_line_number (line_no.to_integer)
			end
		end

	new_syntax_warning (line: STRING): EW_EIFFEL_SYNTAX_ERROR
		require
			line_not_void: line /= Void
		local
			words: LIST [STRING]
			line_no, kind: STRING
			class_name: STRING
			count: INTEGER
		do
			words := broken_into_words_8 (line)
			count := words.count
			if count >= 6 then
				line_no := words.i_th (6)
			end
			if count >= 8 then
				kind := words.i_th (8)
				kind.to_lower
				if kind.same_string ("class") then
					if count >= 9 then
						class_name := words.i_th (9)
					else
						create class_name.make (0)
					end
				elseif kind.same_string ("ace") then
					create class_name.make (0)
				elseif kind.same_string ("cluster_properties") then
					create class_name.make (0)
					class_name.append ("_USE_FILE")
				else
					create class_name.make (0)
					class_name.append ("%"UNKNOWN%"")
				end
			else
				create class_name.make (0)
			end
			create Result.make (from_utf_8 (class_name))
			if attached line_no and then line_no.is_integer then
				Result.set_line_number (line_no.to_integer)
			end
		end

	analyze_validity_error (line: STRING; prefix_count: like {STRING}.count)
		require
			line_not_void: line /= Void
			prefix_count <= line.count
		do
			add_validity_error (new_validity_error (line, prefix_count))
		end

	new_validity_error (line: STRING; prefix_count: like {STRING}.count): EW_EIFFEL_VALIDITY_ERROR
		require
			line_not_void: line /= Void
			prefix_count <= line.count
		local
			message: STRING_32
		do
			message := from_utf_8 (line).tail (line.count - prefix_count)
			message.adjust
			create Result.make (create {STRING_32}.make_empty, message)
		end

	analyze_error_line (line: STRING)
		require
			line_not_void: line /= Void;
		local
			words: LIST [STRING]
			value: STRING
		do
			if is_prefix (Class_name_prefix, line) then
				words := broken_into_words_8 (line)
				if words.count >= 2 then
					value := words [2]
					check
						last_validity_error_not_void: last_validity_error /= Void
					end
					last_validity_error.set_class_name (from_utf_8 (value))
				end
			elseif is_prefix (line_prefix, line) then
				words := broken_into_words_8 (line)
				if words.count >= 2 then
					value := words [2]
					check
						last_validity_error_not_void: last_validity_error /= Void
					end
					if value.is_integer and then value.to_integer > 0 then
						last_validity_error.set_line_number (value.to_integer)
					end
				end
			elseif is_prefix (Next_message_prefix, line) then
				in_error := False
			end
		end

	linked_list_matches (actual_list, expected_list: SORTED_TWO_WAY_LIST [EW_EIFFEL_ERROR]): BOOLEAN
		local
			actual: SORTED_TWO_WAY_LIST [EW_EIFFEL_ERROR]
		do
			if attached actual_list and attached expected_list then
				actual := actual_list.twin
				actual.compare_objects
				across
					expected_list as e
				from
					Result := actual.count = expected_list.count
					e.reverse
					e.start
				until
					not Result
				loop
					check
						from_count_comparison: not actual.is_empty
					end
						-- Test if the matching item is at the end of the actual list.
					actual.finish
					if actual.item.matches_pattern (e.item) then
							-- Found: remove the item.
						actual.remove
					elseif e.item.has_line_number then
							-- The item may appear before last item if there are other expected items without line number information.
						actual.start
						actual.search (e.item)
						if actual.exhausted then
								-- Not found: mismatch.
							Result := False
						else
								-- Found: remove the item.
							actual.remove
						end
					else
							-- Not found: mismatch.
						Result := False
					end
				end
			else
					-- One of the lists is Void, so it is sufficient to check that the other is Void too.
				Result := actual_list = expected_list
			end
		end
note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	revised_by: "Alexander Kogtenkov"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
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
