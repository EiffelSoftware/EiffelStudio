note
	description: "[
		Interface of a test that can be executed and contains a list of outcomes resulting from passed
		executions.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_I

inherit
	TAG_ITEM

	USABLE_I

feature -- Access

	name: IMMUTABLE_STRING_8
			-- <Precursor>
			--
			-- Note: this will be replaced by `routine_name'
		deferred
		end

feature -- Basic operations

	print_test (a_formatter: TEXT_FORMATTER)
			-- Print formatted output for `Current' on a single line.
			--
			-- `a_formatter': Formatter to which output should be printed to.
		require
			a_formatter_attached: a_formatter /= Void
		do
			a_formatter.process_basic_text (name.as_string_8)
		end

feature {TEST_EXECUTION_I} -- Factory

	new_executor (an_execution: TEST_EXECUTION_I): TEST_EXECUTOR_I [TEST_I]
			-- Create a new executor for running `Current' in the given session.
			--
			-- `an_execution': Execution session in which `Current' should be executed.
		require
			an_execution_attached: an_execution /= Void
			an_execution_usable: an_execution.is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_usable: Result.is_interface_usable
			result_valid: Result.is_test_compatible (Current)
		end

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
