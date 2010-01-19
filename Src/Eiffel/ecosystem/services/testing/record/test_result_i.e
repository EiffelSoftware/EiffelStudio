note
	description: "[
		Interface representing the result of an execution of a single {TEST_I}.
		
		A {TEST_RESULT_I} only provides high level information about a test results but
		provides functionality to print all information to some {TEXT_FOMATTER}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_RESULT_I

feature -- Access

	start_date: DATE_TIME
			-- Date/time when test was launched
		deferred
		ensure
			result_attached: Result /= Void
		end

	finish_date: DATE_TIME
			-- Date and time when `Current' was obtained
		deferred
		ensure
			result_attached: Result /= Void
		end

	frozen duration: DATE_TIME_DURATION
			-- Duration of test execution
		do
			Result := finish_date.relative_duration (start_date)
		ensure
			result_attached: Result /= Void
		end

	tag: READABLE_STRING_8
			-- Short tag describing the status of `Current'
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_pass: BOOLEAN
			-- Did test pass?
		deferred
		ensure
			result_implies_not_fail_or_unresolved: Result implies not (is_fail or is_unresolved)
		end

	is_fail: BOOLEAN
			-- Did test fail?
		deferred
		ensure
			result_implies_not_pass_or_unresolved: Result implies not (is_pass or is_unresolved)
		end

	is_unresolved: BOOLEAN
			-- Is test judgment unresolvable?
		do
			Result := not (is_pass or is_fail)
		ensure
			definition: Result = not (is_pass or is_fail)
		end

feature -- Basic operations

	print_result (a_formatter: TEXT_FORMATTER)
			-- Print status of `Current' to given formatter.
			--
			-- `a_formatter': Text formatter in which the state of `Current' should be printed.
		do
			if is_pass then
				a_formatter.process_basic_text ("pass")
			else
				if is_fail then
					a_formatter.process_basic_text ("FAIL")
				else
					a_formatter.process_basic_text ("unresolved")
				end
				if not tag.is_empty then
					a_formatter.process_basic_text (" (")
					a_formatter.process_basic_text (tag.as_string_32)
					a_formatter.process_basic_text (")")
				end
			end
		end

	print_details (a_formatter: TEXT_FORMATTER; a_verbose: BOOLEAN)
			-- Print formatted representation of `Current'.
			--
			-- `a_formatter': Text formatter in which `Current' should be printed.
			-- `a_verbose': If True all details of `Current' are printed, otherwise a short readable
			--              version is printed.
		do
			print_details_indented (a_formatter, a_verbose, {NATURAL_32} 0)
		end

	print_details_indented (a_formatter: TEXT_FORMATTER; a_verbose: BOOLEAN; an_indent: NATURAL)
			-- Print formatted representation of `Current' by prefixing every line with some indent.
			--
			-- `a_formatter': Text formatter in which `Current' should be printed.
			-- `a_verbose': If True all details of `Current' are printed, otherwise a short readable
			--              version is printed.
			-- `an_indent': Number of spaces with which every line should be prefixed.
		deferred
		end

invariant
	pass_or_fail_or_unresolved: is_pass or is_fail or is_unresolved

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
