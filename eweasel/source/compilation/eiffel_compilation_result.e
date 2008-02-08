indexing
	description: "An Eiffel compilation result"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class EIFFEL_COMPILATION_RESULT

inherit
	STRING_UTILITIES;
	EIFFEL_COMPILER_CONSTANTS

feature -- Properties

	syntax_errors: SORTED_TWO_WAY_LIST [EIFFEL_SYNTAX_ERROR];
			-- Syntax errors reported by compiler

	validity_errors: SORTED_TWO_WAY_LIST [EIFFEL_VALIDITY_ERROR];
			-- Validity errors reported by compiler

	last_validity_error: EIFFEL_VALIDITY_ERROR
			-- Last validity error being inserted

	had_panic: BOOLEAN;
			-- Did a panic occur during compilation?

	had_exception: BOOLEAN;
			-- Did an exception occur during compilation?

	execution_failure: BOOLEAN;
			-- Did a system execution failure occur during
			-- compilation?

	illegal_instruction: BOOLEAN;
			-- Was an illegal instruction executed
			-- during compilation?

	updt_failure: BOOLEAN;
			-- Was the compiler unable to write the .UPDT file,
			-- which contains the melted code?

	c_generation_failure: BOOLEAN;
			-- Was the compiler unable to generate C code?

	compilation_paused: BOOLEAN;
			-- Did compilation pause and await user input
			-- before resuming?

	compilation_aborted: BOOLEAN;
			-- Was compilation aborted prematurely, usually
			-- due to an exception?

	compilation_finished: BOOLEAN;
			-- Did compilation finish normally?

	exception_tag: STRING;
			-- Tag of exception which aborted compilation,
			-- if any

	summary: STRING is
			-- Summary of `Current'
		local
			status: STRING;
		do
			create Result.make (0);
			if syntax_errors /= Void then
				from
					syntax_errors.start;
				until
					syntax_errors.after
				loop
					Result.extend ('%T');
					Result.append (syntax_errors.item.summary);
					Result.extend ('%N');
					syntax_errors.forth;
				end
			end;
			if validity_errors /= Void then
				from
					validity_errors.start;
				until
					validity_errors.after
				loop
					Result.extend ('%T');
					Result.append (validity_errors.item.summary);
					Result.extend ('%N');
					validity_errors.forth;
				end;
			end;

			create status.make (0);
			if updt_failure then
				status.append (".UPDT_file_error ");
			end;
			if c_generation_failure then
				status.append ("c_generation_failed ");
			end;
			if compilation_paused then
				status.append ("paused ");
			end;
			if compilation_aborted then
				status.append ("aborted ");
			end;
			if compilation_finished then
				status.append ("completed ");
			end;
			if execution_failure then
				status.append ("system_failed ");
			end;
			if had_exception then
				status.append ("had_exception ");
				if (exception_tag /= Void) then
					status.append ("(");
					status.append (exception_tag);
					status.append (") ");
				end
			end;
			if had_panic then
				status.append ("had_panic ");
			end;
			if illegal_instruction then
				status.append ("illegal_instruction ");
			end;
			if status.count = 0 then
				status.append ("unknown	");
			end;
			status.prepend ("%TFinal status:  ");
			Result.append (status);
		end;

feature -- Update

	update (line: STRING) is
			-- Update `Current' to reflect the presence of
			-- `line' as next line in compiler output.
		local
			s: SEQ_STRING;
		do
			create s.make (line.count);
			s.append (line);
			if is_prefix (Pass_prefix, line) then
				s.start;
				s.search_string_after (Pass_string, 0);
				if not s.after then
					in_error := False;
				end;
			elseif is_prefix (Syntax_error_prefix, line) then
				analyze_syntax_error (line);
			elseif is_prefix (Syntax_warning_prefix, line) then
				analyze_syntax_warning (line);
			elseif is_prefix (Validity_error_prefix, line) or
			       is_prefix (Validity_warning_prefix, line) then
				in_error := True;
				analyze_validity_error (line);
			elseif is_prefix (Resume_prompt, line)
			    or is_prefix (C_failure_prompt, line) then
				compilation_paused := True;
			elseif is_prefix (C_failure_prefix, line) then
				c_generation_failure := True;
			elseif is_prefix (Updt_failure_prefix, line) then
				updt_failure := True;
			elseif is_prefix (Aborted_prefix, line) then
				compilation_aborted := True;
			elseif is_prefix (Exception_prefix, line) then
				had_exception := True;
				if exception_tag = Void then
					create exception_tag.make(0);
				end;
				line.keep_tail(line.count - Exception_prefix.count);
				exception_tag.copy(line);
			elseif is_prefix (Exception_occurred_prefix, line) then
				had_exception := True;
				if exception_tag = Void then
					create exception_tag.make(0);
				end;
				if exception_tag.count = 0 then
					line.keep_tail (line.count - Exception_occurred_prefix.count);
					exception_tag.copy (line);
				end
			elseif is_prefix (Failure_prefix, line) then
				execution_failure := True;
			elseif is_prefix (Illegal_inst_prefix, line) then
				illegal_instruction := True;
			elseif is_prefix (Finished_prefix, line) then
				compilation_finished := True;
			elseif in_error then
				analyze_error_line (line);
			end;
			s.to_lower;
			s.start;
			s.search_string_after (Panic_string, 0);
			if not s.after then
				had_panic := True;
			end;
		end;

feature {NONE} -- State

	in_error: BOOLEAN;
			-- Are we analyzing lines which are part of
			-- a syntax or validity error?


feature -- Modification

	set_compilation_paused is
		do
			compilation_paused := True;
		end;

	set_compilation_finished is
		do
			compilation_finished := True;
		end;

	add_syntax_error (err: EIFFEL_SYNTAX_ERROR) is
		require
			error_not_void: err /= Void;
		do
			if syntax_errors = Void then
				create syntax_errors.make;
			end;
			syntax_errors.extend (err);
		end;

	add_validity_error (err: EIFFEL_VALIDITY_ERROR) is
		require
			error_not_void: err /= Void;
		do
			if validity_errors = Void then
				create validity_errors.make;
			end;
			validity_errors.extend (err);
			last_validity_error := err
		end;


feature -- Comparison

	matches (other: EIFFEL_COMPILATION_RESULT): BOOLEAN is
			-- Do `Current' and `other' represent the
			-- same compilation result?
		require
			other_not_void: other /= Void;
		do
			Result := had_panic = other.had_panic and
				had_exception = other.had_exception and
				updt_failure = other.updt_failure and
				c_generation_failure = other.c_generation_failure and
				execution_failure = other.execution_failure and
				illegal_instruction = other.illegal_instruction
				and compilation_paused = other.compilation_paused
				and compilation_aborted = other.compilation_aborted
				and compilation_finished = other.compilation_finished
				and equal(exception_tag, other.exception_tag)
				and linked_list_matches (syntax_errors, other.syntax_errors)
				and linked_list_matches (validity_errors, other.validity_errors)
		end;


feature {NONE} -- Implementation

	analyze_syntax_error (line: STRING) is
		require
			line_not_void: line /= Void;
		do
			add_syntax_error (new_syntax_error (line));
		end;

	analyze_syntax_warning (line: STRING) is
		require
			line_not_void: line /= Void;
		do
			add_syntax_error (new_syntax_warning (line));
		end;

	new_syntax_error (line: STRING): EIFFEL_SYNTAX_ERROR is
		require
			line_not_void: line /= Void;
		local
			words: LIST [STRING];
			line_no, kind: STRING;
			class_name: STRING;
			count: INTEGER;
		do
			words := broken_into_words (line);
			count := words.count;
			if count >= 5 then
				line_no := words.i_th (5);
			end;
			if count >= 7 then
				kind := words.i_th (7);
				kind.to_lower;
				if equal (kind, "class") then
					if count >= 8 then
						class_name := words.i_th (8);
					else
						create class_name.make (0);
					end
				elseif equal (kind, "ace") then
					create class_name.make (0);
				elseif equal (kind, "cluster_properties") then
					create class_name.make (0);
					class_name.append ("_USE_FILE");
				else
					create class_name.make (0);
					class_name.append ("%"UNKNOWN%"");
				end;
			else
				create class_name.make (0);
			end;
			create Result.make (class_name)
			if is_integer (line_no) then
				Result.set_line_number (line_no.to_integer);
			end;
		end;

	new_syntax_warning (line: STRING): EIFFEL_SYNTAX_ERROR is
		require
			line_not_void: line /= Void;
		local
			words: LIST [STRING];
			line_no, kind: STRING;
			class_name: STRING;
			count: INTEGER;
		do
			words := broken_into_words (line);
			count := words.count;
			if count >= 6 then
				line_no := words.i_th (6);
			end;
			if count >= 8 then
				kind := words.i_th (8);
				kind.to_lower;
				if equal (kind, "class") then
					if count >= 9 then
						class_name := words.i_th (9);
					else
						create class_name.make (0);
					end
				elseif equal (kind, "ace") then
					create class_name.make (0);
				elseif equal (kind, "cluster_properties") then
					create class_name.make (0);
					class_name.append ("_USE_FILE");
				else
					create class_name.make (0);
					class_name.append ("%"UNKNOWN%"");
				end;
			else
				create class_name.make (0);
			end;
			create Result.make (class_name)
			if is_integer (line_no) then
				Result.set_line_number (line_no.to_integer);
			end;
		end;

	analyze_validity_error (line: STRING) is
		require
			line_not_void: line /= Void;
		do
			add_validity_error (new_validity_error (line));
		end;

	new_validity_error (line: STRING): EIFFEL_VALIDITY_ERROR is
		require
			line_not_void: line /= Void;
		local
			words: LIST [STRING];
			code: STRING;
			class_name: STRING;
		do
			words := broken_into_words (line);
			code := words.i_th (3);
			create class_name.make (0);
			create Result.make (class_name, code)
		end;

	analyze_error_line (line: STRING) is
		require
			line_not_void: line /= Void;
		local
			words: LIST [STRING];
			class_name: STRING;
		do
			if is_prefix (Class_name_prefix, line) then
				words := broken_into_words (line);
				if words.count >= 2 then
					class_name := words.i_th (2);
					check
						last_validity_error_not_void: last_validity_error /= Void
					end
					last_validity_error.set_class_name (class_name);
				end;
				in_error := False;
			end
		end;

	linked_list_matches (list1, list2: SORTED_TWO_WAY_LIST [EIFFEL_ERROR]): BOOLEAN is
		local
			count1, count2: INTEGER;
			different: BOOLEAN;
		do
			if list1 = Void then
				count1 := 0;
			else
				count1 := list1.count;
			end;
			if list2 = Void then
				count2 := 0;
			else
				count2 := list2.count;
			end;
			if count1 = 0 and count2 = 0 then
				Result := True;
			elseif count1 /= count2 then
				Result := False;
			else
					-- List have to be sorted because when we insert the errors
					-- in the list the objects might be partially initialized.
					-- Now we know for sure that they are properly initialized, so
					-- sorting will yield the proper order.
				list1.sort
				list2.sort
				from
					list1.start; list2.start;
				until
					list1.after or list2.after or different
				loop
					if not equal (list1.item, list2.item) then
						different := True;
					else
						list1.forth; list2.forth;
					end
				end;
				Result := not different;
			end
		end
indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
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
