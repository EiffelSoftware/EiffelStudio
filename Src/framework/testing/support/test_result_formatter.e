note
	description: "[
		Shared routines for formatted printing of test results
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_RESULT_FORMATTER

inherit
	EXCEPTION_CODE_MEANING

	SHARED_EIFFEL_PROJECT

feature {NONE} -- Access

	project_access: EC_PROJECT_ACCESS
		once
			create Result.make (eiffel_project)
		end

feature -- Basic operations

	print_result (a_formatter: TEXT_FORMATTER; a_result: EQA_RESULT)
			-- Print formatted result information for given result on a single line.
			--
			-- Note: descendants which are aware of specialized output should redefine to provide more
			--       information on `a_result' by doing an object test.
			--
			-- `a_formatted': Formatter to which output should be printed to.
		require
			a_formatter_attached: a_formatter /= Void
			a_result_attached: a_result /= Void
		do
			if a_result.is_pass then
				a_formatter.process_basic_text ("pass")
			else
				if a_result.is_fail then
					a_formatter.process_basic_text ("FAIL")
				else
					a_formatter.process_basic_text ("unresolved")
				end
				if not a_result.tag.is_empty then
					a_formatter.process_basic_text (" (")
					a_formatter.process_basic_text (a_result.tag.as_string_8)
					a_formatter.process_basic_text (")")
				end
			end
		end

	print_result_details (a_formatter: TEXT_FORMATTER; a_result: EQA_RESULT; a_indent: NATURAL; a_verbose: BOOLEAN)
			-- Print formatted result details for given result on multiple lines.
			--
			-- Note: descendants which are aware of specialized output should redefine to provide more
			--       information on `a_result' by doing an object test.
			--
			-- `a_formatted': Formatter to which output should be printed to.
			-- `a_result': Result to be printed.
			-- `a_indent': Indentation of printed details.
			-- `a_verbose': True if all possible information should be printed (call stack)
		require
			a_formatter_attached: a_formatter /= Void
			a_result_attached: a_result /= Void
		local
			l_output: READABLE_STRING_8
		do
			l_output := a_result.information
			if not l_output.is_empty then
				a_formatter.add_indents (a_indent.as_integer_32)
				a_formatter.process_basic_text ("output:")
				a_formatter.add_new_line
				print_multiline_string (l_output.as_string_32, a_formatter, a_indent + 1)
				a_formatter.add_new_line
			end
			if attached {EQA_ETEST_PARTIAL_RESULT} a_result as l_part_result then
				a_formatter.add_indents (a_indent.as_integer_32)
				a_formatter.process_basic_text ("on_prepare: ")
				print_invocation_details (a_formatter, l_part_result.setup_response, a_indent, a_verbose)
				if attached {EQA_ETEST_RESULT} a_result as l_result then
					a_formatter.add_indents (a_indent.as_integer_32)
					a_formatter.process_basic_text ("test routine: ")
					print_invocation_details (a_formatter, l_result.test_response, a_indent, a_verbose)
					a_formatter.add_indents (a_indent.as_integer_32)
					a_formatter.process_basic_text ("on_clean: ")
					print_invocation_details (a_formatter, l_result.teardown_response, a_indent, a_verbose)
				end
			end
		end

feature {NONE} -- Implementation

	print_multiline_string (a_string: STRING_32; a_formatter: TEXT_FORMATTER; a_indent: NATURAL)
			-- Print given text on multiple lines respecting indentation.
			--
			-- Note: no new line character at end.
		require
			a_string_attached: a_string /= Void
			a_formatter_attached: a_formatter /= Void
		local
			l_newline: CHARACTER_32
			l_pos, l_previous: INTEGER
		do
			l_newline := '%N'
			l_pos := a_string.index_of (l_newline, 1)
			if l_pos > 0 then
				from
					l_previous := 1
				until
					l_previous > a_string.count
				loop
					if l_previous > 1 then
						a_formatter.add_new_line
					end
					a_formatter.add_indents (a_indent.to_integer_32)
					if l_pos = 0 then
						print_multiline_string (a_string.substring (l_previous, a_string.count), a_formatter, a_indent)
						l_previous := a_string.count + 1
					else
						print_multiline_string (a_string.substring (l_previous, l_pos - 1), a_formatter, a_indent)
						l_previous := l_pos + 1
						l_pos := a_string.index_of (l_newline, l_previous)
					end
				end
			else
				a_formatter.process_string_text (a_string, Void)
			end
		end

	print_invocation_details (a_formatter: TEXT_FORMATTER; an_invocation: EQA_TEST_INVOCATION_RESPONSE; a_indent: NATURAL_32; a_verbose: BOOLEAN)
			-- Print routine invocation details.
		local
			l_exception: EQA_TEST_INVOCATION_EXCEPTION
		do
			if an_invocation.is_exceptional then
				l_exception := an_invocation.exception
				a_formatter.process_basic_text ("exceptional (")
				a_formatter.process_comment_text (description_from_code (l_exception.code), Void)
				a_formatter.process_basic_text (" in ")
				if attached project_access.class_from_name (l_exception.class_name, Void) as l_class then
					a_formatter.add_class (l_class)
					a_formatter.process_basic_text (".")
					if attached project_access.feature_of_name (l_class, l_exception.recipient_name) as l_feature then
						a_formatter.add_feature (l_feature.e_feature, l_exception.recipient_name.as_string_8)
					else
						a_formatter.process_basic_text (l_exception.recipient_name.as_string_8)
					end
				else
					a_formatter.process_basic_text (l_exception.class_name.as_string_8)
					a_formatter.process_basic_text (".")
					a_formatter.process_basic_text (l_exception.recipient_name.as_string_8)
				end
				a_formatter.process_basic_text (")")
				a_formatter.add_new_line
				if a_verbose then
					print_multiline_string (l_exception.trace.as_string_32, a_formatter, a_indent + 1)
					a_formatter.add_new_line
				end
			else
				a_formatter.process_basic_text ("ok")
				a_formatter.add_new_line
			end
		end

feature {NONE} -- Implementation: etest results


note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
