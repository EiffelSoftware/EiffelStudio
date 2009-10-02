note
	description: "[
		Objects implementing {TEST_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST

inherit
	TEST_I
		redefine
			print_test,
			print_result_details
		end

	EXCEPTION_CODE_MEANING

	DISPOSABLE_SAFE

create {TEST_PROJECT_I, ETEST_CLASS_SYNCHRONIZER}
	make

feature {NONE} -- Initialization

	make (a_name: like routine_name; a_class: like eiffel_class; a_test_suite: like test_suite)
			-- Initialize `Current'
			--
			-- `a_name': name of test routine
			-- `a_class': Class in which `Current' is defined
			-- `a_test_suite': Test suite which retrieved `Current'.
		require
			a_name_attached: a_name /= Void
			a_class_attached: a_class /= Void
		local
			l_name: STRING
		do
			routine_name := a_name
			eiffel_class := a_class
			test_suite := a_test_suite
			create l_name.make (class_name.count + routine_name.count + 1)
			l_name.append (class_name)
			l_name.append_character ('.')
			l_name.append (routine_name.as_string_8)
			create name.make_from_string (l_name)
		ensure
			name_set: routine_name = a_name
			eiffel_class_set: eiffel_class = a_class
			test_suite_set: test_suite = a_test_suite
		end

feature -- Access

	name: IMMUTABLE_STRING_8
			-- <Precursor>

	eiffel_class: EIFFEL_CLASS_I
			-- Class in which test is defined

	routine_name: STRING
			-- <Precursor>

	class_name: STRING
			-- <Precursor>
		do
			Result := eiffel_class.name
		end

	routine: detachable FEATURE_I
			-- {FEATURE_I} instance representing `Current' if compiled.
		do
			Result := feature_of_name (eiffel_class, routine_name)
		end

feature {NONE} -- Access

	test_suite: ETEST_SUITE
			-- Test suite which retrieved `Current'

feature -- Basic operations

	print_test (a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			if attached routine as l_routine then
				a_formatter.add_feature (l_routine.e_feature, routine_name)
			else
				a_formatter.add_classi (eiffel_class, routine_name)
			end
			a_formatter.process_basic_text (" (")
			a_formatter.add_class (eiffel_class)
			a_formatter.process_basic_text (")")
		end

	print_result_details (a_formatter: TEXT_FORMATTER; a_result: EQA_RESULT; a_indent: NATURAL_32)
			-- <Precursor>
		do
			if attached {EQA_ETEST_PARTIAL_RESULT} a_result as l_part_result then
				a_formatter.add_indents (a_indent.as_integer_32)
				a_formatter.process_basic_text ("on_prepare: ")
				print_invocation_details (a_formatter, l_part_result.setup_response, a_indent)
				if attached {EQA_ETEST_RESULT} a_result as l_result then
					a_formatter.add_indents (a_indent.as_integer_32)
					a_formatter.process_basic_text (routine_name)
					a_formatter.process_basic_text (": ")
					print_invocation_details (a_formatter, l_result.test_response, a_indent)
					a_formatter.add_indents (a_indent.as_integer_32)
					a_formatter.process_basic_text ("on_clean: ")
					print_invocation_details (a_formatter, l_result.teardown_response, a_indent)
				end
			end
		end

feature {NONE} -- Basic operations

	print_invocation_details (a_formatter: TEXT_FORMATTER; an_invocation: EQA_TEST_INVOCATION_RESPONSE; a_indent: NATURAL_32)
			-- Print routine invocation details.
		local
			l_exception: EQA_TEST_INVOCATION_EXCEPTION
		do
			if an_invocation.is_exceptional then
				l_exception := an_invocation.exception
				a_formatter.process_basic_text ("exceptional (")
				a_formatter.process_comment_text (description_from_code (l_exception.code), Void)
				a_formatter.process_basic_text (" in ")
				if attached test_suite.project_access.class_from_name (l_exception.class_name, Void) as l_class then
					a_formatter.add_class (l_class)
					a_formatter.process_basic_text (".")
					if attached feature_of_name (l_class, l_exception.recipient_name) as l_feature then
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
				print_multiline_string (l_exception.trace.as_string_32, a_formatter, a_indent + 1)
				a_formatter.add_new_line
			else
				a_formatter.process_basic_text ("ok")
				a_formatter.add_new_line
			end
		end

feature {TEST_EXECUTION_I} -- Factory

	new_executor (an_execution: TEST_EXECUTION_I): ETEST_COMPILATION_EXECUTOR
			-- <Precursor>
		do
			create Result.make (test_suite, an_execution)
		end

feature {NONE} -- Implementation

	feature_of_name (a_class: CLASS_I; a_feature: READABLE_STRING_8): detachable FEATURE_I
			-- {FEATURE_I} instance from given class for given name, Void if class is not compiled or no
			-- feature with that name exists.
		do
			if attached a_class.compiled_representation as l_class then
				if attached l_class.feature_named (a_feature.as_string_8) as l_feature then
					Result := l_feature
				end
			end
		end

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
