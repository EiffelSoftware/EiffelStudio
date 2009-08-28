note
	description: "[
		Base implementation of {TEST_SESSION_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_SESSION

inherit
	TEST_SESSION_I

	SHARED_LOCALE

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- Initizialize `Current'.
			--
			-- `a_test_suite': Test suite instanciating `Current'.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_test_suite_usable: a_test_suite.is_interface_usable
		do
			test_suite := a_test_suite
			create proceeded_event
			create error_event
		ensure
			test_suite_set: test_suite = a_test_suite
		end

feature -- Access

	test_suite: TEST_SUITE_S
			-- <Precursor>

feature -- Basic operations

	append_output (a_procedure: PROCEDURE [ANY, TUPLE [TEXT_FORMATTER]])
			-- Append output for `Current'.
			--
			-- `a_precedure': Procedure called with corresponding {TEXT_FORMATTER} instance.
		require
			a_procedure_attached: a_procedure /= Void
		local
			l_formatter: TEXT_FORMATTER
			l_tuple: TUPLE [TEXT_FORMATTER]
		do
			if attached test_suite.output (Current) as l_output then
				l_output.lock
				l_formatter := l_output.formatter
				l_tuple := a_procedure.empty_operands
				check
					valid_operands: l_tuple.count = 1 and then
						l_tuple.is_reference_item (1) and then
						l_tuple.valid_type_for_index (l_formatter, 1)
				end
				l_tuple.put (l_formatter, 1)
				a_procedure.call (l_tuple)
				l_output.unlock
			end
		end

feature {NONE} -- Events

	proceeded_event: EVENT_TYPE [TUPLE [TEST_SESSION_I]]
			-- <Precursor>

	error_event: EVENT_TYPE [TUPLE [session: TEST_SESSION_I; error: READABLE_STRING_GENERAL]]
			-- <Precursor>

;note
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
