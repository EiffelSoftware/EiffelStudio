note
	description: "Summary description for {EWB_TEST_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_TEST_EXECUTION

inherit
	EWB_TEST_CMD

	TEST_SUITE_OBSERVER
		redefine
			on_test_changed,
			on_processor_error
		end

feature -- Access

	name: STRING
		do
			Result := "Execute"
		end

	help_message: STRING_GENERAL
		do
			Result := locale.translation ("run tests")
		end

	abbreviation: CHARACTER
		do
			Result := 'e'
		end

feature {NONE} -- Basic operations

	execute_with_test_suite
			-- <Precursor>
		local
			l_service: TEST_SUITE_S
			l_executor: !TEST_EXECUTOR_I
			l_conf: TEST_EXECUTOR_CONF
		do
			l_service := test_suite.service
			l_service.test_suite_connection.connect_events (Current)
			if l_service.processor_registrar.is_valid_type (background_executor_type, l_service) then
				l_executor := l_service.executor (background_executor_type)
				create l_conf.make
				if l_executor.is_ready and l_executor.is_valid_configuration (l_conf) then
					l_service.launch_processor (l_executor, l_conf, True)
				end
			else
				command_line_io.localized_print_error ("Executor not available%N")
			end
			l_service.test_suite_connection.disconnect_events (Current)
			print_statistics
		end

feature -- Events

	on_test_changed (a_collection: !ACTIVE_COLLECTION_I [!TEST_I]; a_item: !TEST_I)
			-- <Precursor>
		do
			if a_item.memento.is_outcome_added then
				command_line_io.localized_print (a_item.class_name)
				command_line_io.localized_print (".")
				command_line_io.localized_print (a_item.name)
				command_line_io.localized_print (": ")
				inspect a_item.last_outcome.status
				when {EQA_TEST_OUTCOME_STATUS_TYPES}.passed then
					command_line_io.localized_print ("passed")
				when {EQA_TEST_OUTCOME_STATUS_TYPES}.failed then
					command_line_io.localized_print ("failed")
				else
					command_line_io.localized_print ("unresovled")
				end
				command_line_io.localized_print ("%N")
			end
		end

	on_processor_error (a_test_suite: !TEST_SUITE_S; a_processor: !TEST_PROCESSOR_I; a_error: !STRING_8; a_token_values: TUPLE)
			-- <Precursor>
		do
			command_line_io.localized_print (locale.formatted_string (a_error, a_token_values))
			command_line_io.localized_print ("%N")
		end

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
