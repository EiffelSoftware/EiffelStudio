note
	description:

		"Abstract ancestor to all interpreter requests"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class AUT_REQUEST

feature {NONE} -- Initialization

	make (a_system: like system)
			-- Create new request.
		require
			a_system_not_void: a_system /= Void
		do
			system := a_system
		ensure
			system_set: system = a_system
		end

feature -- Status report

	has_response: BOOLEAN
			-- Does this request have a corresponding response
			-- from the interpreter?
		do
			Result := response /= Void
		ensure
			definition: Result = (response /= Void)
		end

	is_type_request: BOOLEAN
			-- Is Current a type request?
		do
		end

feature -- Access

	response: AUT_RESPONSE
			-- Interpreter's response to current request;
			-- Void if request is without response.

	system: SYSTEM_I
			-- system

	test_case_index: INTEGER
			-- 1-based number indicating that current request is
			-- the `test_case_index'-th test case in associated test run
			-- A 0 value means that current request is not a test case request.
			-- only creation request and execute request are test case request.

feature -- Change

	set_response (a_response: like response)
			-- Set `response' to `a_response'.
		require
			a_response_not_void: a_response /= Void
		do
			response := a_response
		ensure
			response_set: response = a_response
		end

	remove_response
			-- Set `response' to Void.
		do
			response := Void
		ensure
			response_set: response = Void
		end

	set_test_case_index (a_index: like test_case_index) is
			-- Set `test_case_index' with `a_index'.
		require
			a_index_non_negative: a_index >= 0
		do
			test_case_index := a_index
		ensure
			test_case_index_set: test_case_index = a_index
		end

feature -- Processing

	process (a_processor: AUT_REQUEST_PROCESSOR)
			-- Process current request.
		require
			a_processor_not_void: a_processor /= Void
		deferred
		end

feature -- Duplication

	fresh_twin: like Current
			-- New request equal to `Current', but no response.
			-- Ready to be used for testing again.
		do
			Result := twin
			Result.remove_response
		ensure
			fresh_twin_not_void: Result /= Void
		end

invariant

	system_not_void: system /= Void

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
