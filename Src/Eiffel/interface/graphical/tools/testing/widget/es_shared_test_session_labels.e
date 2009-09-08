note
	description: "[
		Label and pixmaps describing type and state of test sessions/records.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SHARED_TEST_SESSION_LABELS

inherit
	ES_SHARED_LOCALE_FORMATTER

	EB_SHARED_PIXMAPS

feature {NONE} -- Access

	session_label (a_session: TEST_SESSION_I): STRING_32
			-- Label describing type and state of given test session
			--
			-- `a_session': Session for which label should be returned.
		require
			a_session_attached: a_session /= Void
			a_session_usable: a_session.is_interface_usable
		do
			if a_session.has_next_step then
				if attached {TEST_EXECUTION_I} a_session as l_execution then
					if l_execution.is_debugging then
						Result := locale_formatter.formatted_translation (l_debugging_tests, [l_execution.initial_test_count])
					else
						Result := locale_formatter.formatted_translation (l_executing_tests, [l_execution.initial_test_count])
					end
				elseif attached {TEST_RETRIEVAL_I} a_session as l_retrieval then
					Result := locale_formatter.translation (l_retrieving_tests)
				else
					Result := record_label (a_session.record)
				end
			else
				Result := locale_formatter.translation (l_test_session)
			end
		ensure
			result_attached: Result /= Void
		end

	record_label (a_record: TEST_SESSION_RECORD): STRING_32
			-- Label describing type and state of given record.
			--
			-- `a_record': Record for which label should be returned.
		require
			a_record_attached: a_record /= Void
		do
			create Result.make_empty
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Internationalization

	l_test_session: STRING = "Test session"

	l_executing_tests: STRING = "Execute $1 tests"
	l_debugging_tests: STRING = "Debug $1 tests"
	l_retrieving_tests: STRING = "Updating test suite"

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
