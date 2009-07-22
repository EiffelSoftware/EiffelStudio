note
	description: "[
		TTY testing command which launches background test execution.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_TEST_EXECUTION

inherit
	EWB_TEST_CMD
		redefine
			on_test_result_added
		end

	EXCEPTION_CODE_MEANING
		export
			{NONE} all
		end

feature -- Access

	name: STRING
		do
			Result := "Execute"
		end

	help_message: STRING_GENERAL
		do
			Result := locale.translation (h_run_tests)
		end

	abbreviation: CHARACTER
		do
			Result := 'e'
		end

feature {NONE} -- Basic operations

	execute_with_test_suite (a_test_suite: TEST_SUITE_S)
			-- <Precursor>
		local
			l_conf: TEST_EXECUTOR_CONF
			l_filter: like filtered_tests
		do
			print_current_expression (a_test_suite, False)
			print_current_prefix (a_test_suite, False)
			print_string ("%N")
			l_filter := filtered_tests (a_test_suite)
			if l_filter.has_expression then
				create l_conf.make_with_tests (l_filter.items, False)
			else
				create l_conf.make (False)
			end
			l_conf.set_sorter_prefix (tree_view (a_test_suite).tag_prefix)
			launch_ewb_processor (a_test_suite, background_executor_type, l_conf)
			print_statistics (a_test_suite, True)
		end

feature -- Events

	on_test_result_added (a_test_suite: TEST_SUITE_S; a_test: TEST_I; a_result: EQA_TEST_RESULT)
			-- <Precursor>
		do
			print_test (a_test, a_test.class_name + ".", tab_count)
			if not a_test.passed then
				print_outcome (a_result)
				print_string ("%N")
			end
		end

feature {NONE} -- Implementation

	print_outcome (a_outcome: EQA_TEST_RESULT)
			-- Print outcome information
			--
			-- `a_outcome': Outcome for which information shall be printed.
		local
			l_invocation: detachable EQA_TEST_INVOCATION_RESPONSE
		do
			if a_outcome.has_response then
				l_invocation := a_outcome.setup_response
				check l_invocation /= Void end
				print_invocation (l_invocation, "prepare")
				if a_outcome.is_setup_clean then
					l_invocation := a_outcome.test_response
					check l_invocation /= Void end
					print_invocation (l_invocation, "test")
					l_invocation := a_outcome.teardown_response
					check l_invocation /= Void end
					print_invocation (l_invocation, "clean")
				end
			else
				print_string ("%T")
				if a_outcome.is_user_abort then
					print_string (t_user_aborted)
				elseif a_outcome.is_communication_error then
					print_string (t_communication_error)
				else
					print_string (t_aborted)
				end
			end
		end

	print_invocation (a_invocation: EQA_TEST_INVOCATION_RESPONSE; a_name: STRING)
			-- Print information about a given test invocation.
			--
			-- `a_invocation': Invocation response for which information should be printed.
			-- `a_name': Name of invocation (e.g. prepare/test/clean)
		local
			l_exception: EQA_TEST_INVOCATION_EXCEPTION
		do
			print_string ("     ")
			print_string (a_name)
			if a_invocation.is_exceptional then
				l_exception := a_invocation.exception
				print_string (": exceptional%N")
				print_string ("          code:      ")
				print_string (description_from_code (l_exception.code))
				print_string ("%N          recipient: {")
				print_string (l_exception.class_name)
				print_string ("}.")
				print_string (l_exception.recipient_name)
				print_string ("%N          tag:       ")
				print_multiline_text (l_exception.tag_name, "               ")
				print_string ("          trace:     ")
				print_multiline_text (l_exception.trace, "               ")
			else
				print_string (": normal%N")
			end
			if not a_invocation.output.is_empty then
				print_string ("          output:    ")
				print_multiline_text (a_invocation.output, "               ")
			end
		end

	print_multiline_text (a_text, a_indentation: READABLE_STRING_8)
			-- Print string cotaining new line characters in a human readable format.
			--
			-- If text has not new line characters or only at very beginning and end, the actual content
			-- will be printed on a single line. Otherwise new line will be printed prefixed with a given
			-- indentation. In all cases a new line character will be printed at the end.
			--
			-- `a_text': Text to be printed
			-- `a_indenation': Indentation used before printing text after printing a new line character.
		require
			a_text_attached: a_text /= Void
			a_indentation_attached: a_indentation /= Void
		local
			l_buffer: STRING
			i: INTEGER
			c: CHARACTER
			l_multiline: BOOLEAN
		do
			create l_buffer.make (200)
			from
				i := 1
			until
				i > a_text.count
			loop
				c := a_text.item (i)
				if c /= '%R' then
					if c /= '%N' and not l_buffer.is_empty and then l_buffer.item (l_buffer.count) = '%N' then
						if not l_multiline then
							print ("%N")
						end
						print_string (a_indentation)
						print_string (l_buffer)
						l_buffer.wipe_out
						l_multiline := True
					end
					if c /= '%N' or (l_multiline or not l_buffer.is_empty) then
						l_buffer.append_character (c)
					end
				end
				i := i + 1
			end
			if not l_buffer.is_empty then
				if l_multiline then
					print_string (a_indentation)
				end
				l_buffer.right_adjust
				print_string (l_buffer)
				if l_multiline then
					print_string ("%N")
				end
			end
			print_string ("%N")
		end

feature {NONE} -- Internationalization

	h_run_tests: STRING = "run tests"

	t_aborted: STRING = "no response"
	t_user_aborted: STRING = "user abort"
	t_communication_error: STRING = "communication error"

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
