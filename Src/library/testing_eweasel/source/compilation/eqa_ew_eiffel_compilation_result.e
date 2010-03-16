note
	description: "[
					An Eiffel compilation result
					
					For old version, please check {EW_EIFFEL_COMPILATION_RESULT}
																							]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EW_EIFFEL_COMPILATION_RESULT

feature -- Query

	had_panic: BOOLEAN
			-- Did a panic occur during compilation?

	had_exception: BOOLEAN
			-- Did an exception occur during compilation?

	missing_precompile: BOOLEAN
			-- Was a missing precompile detected during
			-- compilation?

	execution_failure: BOOLEAN
			-- Did a system execution failure occur during
			-- compilation?

	illegal_instruction: BOOLEAN
			-- Was an illegal instruction executed
			-- during compilation?
			-- FIXME: This feature should be removed in new testing tool eweasel?

	compilation_paused: BOOLEAN
			-- Did compilation pause and await user input
			-- before resuming?

	compilation_aborted: BOOLEAN
			-- Was compilation aborted prematurely, usually
			-- due to an exception?

	compilation_finished: BOOLEAN
			-- Did compilation finish normally?

	exception_tag: detachable STRING
			-- Tag of exception which aborted compilation,
			-- if any

	syntax_errors: detachable SORTED_TWO_WAY_LIST [EQA_EW_EIFFEL_SYNTAX_ERROR]
			-- Syntax errors reported by compiler

	validity_errors: detachable SORTED_TWO_WAY_LIST [EQA_EW_EIFFEL_VALIDITY_ERROR]
			-- Validity errors reported by compiler

	summary: STRING
			-- Summary of `Current'
		local
			l_status: STRING
		do
			create Result.make (0)
			if attached syntax_errors as l_syntax_errors then
				from
					l_syntax_errors.start
				until
					l_syntax_errors.after
				loop
					Result.extend ('%T')
					Result.append (l_syntax_errors.item.summary)
					Result.extend ('%N')
					l_syntax_errors.forth
				end
			end
			if attached validity_errors as l_validity_errors then
				from
					l_validity_errors.start
				until
					l_validity_errors.after
				loop
					Result.extend ('%T')
					Result.append (l_validity_errors.item.summary)
					Result.extend ('%N')
					l_validity_errors.forth
				end
			end

			create l_status.make (0)
			if compilation_paused then
				l_status.append ("paused ")
			end
			if compilation_aborted then
				l_status.append ("aborted ")
			end
			if compilation_finished then
				l_status.append ("completed ")
			end
			if missing_precompile then
				l_status.append ("missing_precompile ")
			end
			if execution_failure then
				l_status.append ("system_failed ")
			end
			if had_exception then
				l_status.append ("had_exception ")
				if attached exception_tag as l_exception_tag then
					l_status.append ("(")
					l_status.append (l_exception_tag)
					l_status.append (") ")
				end
			end
			if had_panic then
				l_status.append ("had_panic ")
			end
			if illegal_instruction then
				l_status.append ("illegal_instruction ")
			end
			if l_status.count = 0 then
				l_status.append ("unknown	")
				if attached raw_compiler_output as l_raw_compiler_output then
					l_status.extend ('%N')
					l_status.append ("Raw compiler output:")
					l_status.extend ('%N')
					l_status.append (l_raw_compiler_output)
				end
			end
			l_status.prepend ("%TFinal status:  ")
			Result.append (l_status)
		end

feature -- Command

	update (a_line: STRING)
			-- Update `Current' to reflect the presence of
			-- `a_line' as next line in compiler output.
		local
			l_s: SEQ_STRING
			l_exception_tag: like exception_tag
		do
			create l_s.make (a_line.count)
			l_s.append (a_line)
			if string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Pass_prefix, a_line) then
				l_s.start
				l_s.search_string_after ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Pass_string, 0)
				if not l_s.after then
					in_error := False
				end
			elseif string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Syntax_error_prefix, a_line) then
				analyze_syntax_error (a_line)

			elseif string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Syntax_warning_prefix, a_line) then
				analyze_syntax_warning (a_line)
			elseif string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Validity_error_prefix, a_line) or
			       string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Validity_warning_prefix, a_line) then
				in_error := True
				analyze_validity_error (a_line)
			elseif string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Resume_prompt, a_line) then
				compilation_paused := True
			elseif string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Missing_precompile_prompt, a_line) then
				missing_precompile := True
				compilation_paused := True
			elseif string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Aborted_prefix, a_line) then
				compilation_aborted := True
			elseif string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Exception_prefix, a_line) then
				had_exception := True
				if exception_tag = Void then
					create exception_tag.make(0)
				end
				a_line.keep_tail(a_line.count - {EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Exception_prefix.count)
				l_exception_tag := exception_tag
				check attached l_exception_tag end -- Implied by previous if clause
				l_exception_tag.copy (a_line)
			elseif string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Exception_occurred_prefix, a_line) then
				had_exception := True
				if exception_tag = Void then
					create exception_tag.make(0)
				end
				l_exception_tag := exception_tag
				check attached l_exception_tag end -- Implied by previous if clause
				if l_exception_tag.count = 0 then
					a_line.keep_tail (a_line.count - {EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Exception_occurred_prefix.count)
					l_exception_tag.copy (a_line)
				end
			elseif string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Failure_prefix, a_line) then
				execution_failure := True
			elseif string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Illegal_inst_prefix, a_line) then
				illegal_instruction := True
			elseif string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Finished_prefix, a_line) then
				compilation_finished := True
			elseif in_error then
				analyze_error_line (a_line)
			end
			l_s.to_lower
			l_s.start
			l_s.search_string_after ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Panic_string, 0)
			if not l_s.after then
				had_panic := True
			end
		end

feature {EQA_EW_COMPILE_RESULT_INST} -- Internal command

	add_validity_error (a_err: EQA_EW_EIFFEL_VALIDITY_ERROR)
			-- Add validity error
		require
			error_not_void: a_err /= Void
		local
			l_validity_errors: like validity_errors
		do
			if validity_errors = Void then
				create validity_errors.make
			end
			l_validity_errors := validity_errors
			check attached l_validity_errors end -- Implied by previous if clause
			l_validity_errors.extend (a_err)
			last_validity_error := a_err
		end

	add_syntax_error (a_err: EQA_EW_EIFFEL_SYNTAX_ERROR)
			-- Add syntax error
		require
			error_not_void: a_err /= Void
		local
			l_syntax_errors: like syntax_errors
		do
			if syntax_errors = Void then
				create syntax_errors.make
			end
			l_syntax_errors := syntax_errors
			check attached l_syntax_errors end -- Implied by previous if clause
			l_syntax_errors.extend (a_err)
		end

	sort
			-- Sort `syntax_errors' and `validity_errors'.
			-- Even though they are sorted lists, they may
			-- not be correctly sorted because items may
			-- have been added before full key was set
		do
			if attached syntax_errors as l_syntax_errors and then l_syntax_errors.count > 1 then
				l_syntax_errors.sort
			end
			if attached validity_errors as l_validity_errors and then l_validity_errors.count > 1 then
				l_validity_errors.sort
			end
		end

	matches (a_other: EQA_EW_EIFFEL_COMPILATION_RESULT): BOOLEAN
			-- Do `Current' and `a_other' represent the
			-- same compilation result?
		require
			other_not_void: a_other /= Void
		do
			Result := had_panic = a_other.had_panic and
				had_exception = a_other.had_exception and
				missing_precompile = a_other.missing_precompile and
				execution_failure = a_other.execution_failure and
				illegal_instruction = a_other.illegal_instruction
				and compilation_paused = a_other.compilation_paused
				and compilation_aborted = a_other.compilation_aborted
				and compilation_finished = a_other.compilation_finished
				and equal(exception_tag, a_other.exception_tag)
				and linked_list_matches (syntax_errors, a_other.syntax_errors)
				and linked_list_matches (validity_errors, a_other.validity_errors)
		end

	set_compilation_paused
			-- Set `compilation_paused' with True
		do
			compilation_paused := True
		end;

	set_compilation_finished
			-- Set `compilation_finished' with True
		do
			compilation_finished := True
		end

feature {NONE} -- Syntax error implementation

	new_syntax_error (a_line: STRING): EQA_EW_EIFFEL_SYNTAX_ERROR
			-- Create a syntax error object
		require
			line_not_void: a_line /= Void
		local
			l_words: LIST [STRING]
			l_line_no: detachable STRING
			l_kind: STRING
			l_class_name: STRING
			l_count: INTEGER
		do
			l_words := string_util.broken_into_words (a_line)
			l_count := l_words.count
			if l_count >= 5 then
				l_line_no := l_words.i_th (5)
			end
			if l_count >= 7 then
				l_kind := l_words.i_th (7)
				l_kind.to_lower
				if equal (l_kind, "class") then
					if l_count >= 8 then
						l_class_name := l_words.i_th (8)
					else
						create l_class_name.make (0)
					end
				elseif equal (l_kind, "ace") then
					create l_class_name.make (0)
				elseif equal (l_kind, "cluster_properties") then
					create l_class_name.make (0)
					l_class_name.append ("_USE_FILE")
				else
					create l_class_name.make (0)
					l_class_name.append ("%"UNKNOWN%"")
				end
			else
				create l_class_name.make (0)
			end
			create Result.make (l_class_name)
			if attached l_line_no and then string_util.is_integer (l_line_no) then
				Result.set_line_number (l_line_no.to_integer)
			end
		end

	new_syntax_warning (a_line: STRING): EQA_EW_EIFFEL_SYNTAX_ERROR
				-- Create a syntax warning object
		require
			line_not_void: a_line /= Void
		local
			l_words: LIST [STRING]
			l_line_no: detachable STRING
			l_kind: STRING
			l_class_name: STRING
			l_count: INTEGER
		do
			l_words := string_util.broken_into_words (a_line)
			l_count := l_words.count
			if l_count >= 6 then
				l_line_no := l_words.i_th (6)
			end
			if l_count >= 8 then
				l_kind := l_words.i_th (8)
				l_kind.to_lower
				if equal (l_kind, "class") then
					if l_count >= 9 then
						l_class_name := l_words.i_th (9)
					else
						create l_class_name.make (0)
					end
				elseif equal (l_kind, "ace") then
					create l_class_name.make (0)
				elseif equal (l_kind, "cluster_properties") then
					create l_class_name.make (0)
					l_class_name.append ("_USE_FILE")
				else
					create l_class_name.make (0)
					l_class_name.append ("%"UNKNOWN%"")
				end
			else
				create l_class_name.make (0)
			end
			create Result.make (l_class_name)
			if attached l_line_no and then string_util.is_integer (l_line_no) then
				Result.set_line_number (l_line_no.to_integer)
			end
		end

	new_validity_error (a_line: STRING): EQA_EW_EIFFEL_VALIDITY_ERROR
			-- Create a validity error object
		require
			line_not_void: a_line /= Void
		local
			l_words: LIST [STRING]
			l_code: STRING
			l_class_name: STRING
		do
			l_words := string_util.broken_into_words (a_line)
			l_code := l_words.i_th (3)
			create l_class_name.make (0)
			create Result.make (l_class_name, l_code)
		end

	analyze_syntax_error (a_line: STRING)
			-- Analyze syntax error
		require
			line_not_void: a_line /= Void
		do
			add_syntax_error (new_syntax_error (a_line))
		end

	analyze_syntax_warning (a_line: STRING)
			-- Analyze syntax warning
		require
			line_not_void: a_line /= Void
		do
			add_syntax_error (new_syntax_warning (a_line))
		end

	analyze_validity_error (a_line: STRING)
			-- Analyze validity error
		require
			line_not_void: a_line /= Void
		do
			add_validity_error (new_validity_error (a_line))
		end

	last_validity_error: detachable EQA_EW_EIFFEL_VALIDITY_ERROR
			-- Last validity error being inserted

feature {NONE} -- Implementation

	analyze_error_line (a_line: STRING)
			-- Analyze error line
		require
			line_not_void: a_line /= Void
		local
			l_words: LIST [STRING]
			l_class_name: STRING
			l_last_validity_error: like last_validity_error
		do
			if string_util.is_prefix ({EQA_EW_EIFFEL_COMPILER_CONSTANTS}.Class_name_prefix, a_line) then
				l_words := string_util.broken_into_words (a_line)
				if l_words.count >= 2 then
					l_class_name := l_words.i_th (2)
					l_last_validity_error := last_validity_error
					check
						last_validity_error_not_void: l_last_validity_error /= Void
					end
					l_last_validity_error.set_class_name (l_class_name)
				end
				in_error := False
			end
		end

	string_util: EQA_EW_STRING_UTILITIES
			-- String utilities
		once
			create Result
		end

	in_error: BOOLEAN
			-- Are we analyzing lines which are part of
			-- a syntax or validity error?

	linked_list_matches (a_list1, a_list2: detachable SORTED_TWO_WAY_LIST [EQA_EW_EIFFEL_ERROR]): BOOLEAN
			-- Dose list match?
		local
			l_count1, l_count2: INTEGER
			l_different: BOOLEAN
		do
			if a_list1 = Void then
				l_count1 := 0
			else
				l_count1 := a_list1.count
			end
			if a_list2 = Void then
				l_count2 := 0
			else
				l_count2 := a_list2.count
			end
			if l_count1 = 0 and l_count2 = 0 then
				Result := True
			elseif l_count1 /= l_count2 then
				Result := False
			else
				check attached a_list1 end -- Implied by previous if clause
				check attached a_list2 end -- Implied by previous if clause
				from
					a_list1.start
					a_list2.start
				until
					a_list1.after or a_list2.after or l_different
				loop
					if not equal (a_list1.item, a_list2.item) then
						l_different := True
					else
						a_list1.forth
						a_list2.forth
					end
				end
				Result := not l_different
			end
		end

	raw_compiler_output: detachable STRING
			-- Raw output of compiler, if not Void

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
