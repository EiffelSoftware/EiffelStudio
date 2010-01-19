note
	description: "[
		Test result representing what has been received from the executor.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_RESULT

inherit
	TEST_RESULT

	EXCEPTION_CODE_MEANING

	EC_SHARED_PROJECT_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_result: like original_result)
			-- Initialize `Current' with corresponding {EQA_RESULT}.
			--
			-- `a_result': Result originally received from executor.
		do
			original_result := a_result
		end

feature -- Access

	start_date: DATE_TIME
			-- <Precursor>
		do
			Result := original_result.start_date
		end

	finish_date: DATE_TIME
			-- <Precursor>
		do
			Result := original_result.finish_date
		end

	is_pass: BOOLEAN
			-- <Precursor>
		do
			Result := original_result.is_pass
		end

	is_fail: BOOLEAN
			-- <Precursor>
		do
			Result := original_result.is_fail
		end

	tag: READABLE_STRING_8
			-- <Precursor>
		do
			Result := original_result.tag
		end

feature {NONE} -- Access

	original_result: EQA_PARTIAL_RESULT
			-- Result originally received from executor

feature -- Basic operations

	print_details_indented (a_formatter: TEXT_FORMATTER; a_verbose: BOOLEAN; an_indent: NATURAL_32)
			-- <Precursor>
		local
			l_output: READABLE_STRING_8
		do
			l_output := original_result.output
			if not l_output.is_empty then
				a_formatter.add_indents (an_indent.as_integer_32)
				a_formatter.process_basic_text ("output:")
				a_formatter.add_new_line
				print_multiline_string (l_output.as_string_32, a_formatter, an_indent + 1)
				a_formatter.add_new_line
			end
			if attached {EQA_PARTIAL_RESULT} original_result as l_part_result then
				a_formatter.add_indents (an_indent.as_integer_32)
				a_formatter.process_basic_text ("on_prepare: ")
				print_invocation_details (a_formatter, l_part_result.setup_response, an_indent, a_verbose)
				if attached {EQA_RESULT} l_part_result as l_result then
					a_formatter.add_indents (an_indent.as_integer_32)
					a_formatter.process_basic_text ("test routine: ")
					print_invocation_details (a_formatter, l_result.test_response, an_indent, a_verbose)
					a_formatter.add_indents (an_indent.as_integer_32)
					a_formatter.process_basic_text ("on_clean: ")
					print_invocation_details (a_formatter, l_result.teardown_response, an_indent, a_verbose)
				end
			end
		end

feature {NONE} -- Implementation

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

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
