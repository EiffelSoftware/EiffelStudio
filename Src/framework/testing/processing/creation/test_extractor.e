note
	description: "{
		Implementation of {TEST_EXTRACTOR_I}.
	}"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXTRACTOR

inherit
	TEST_EXTRACTOR_I

	TEST_CREATOR
		redefine
			make,
			is_valid_typed_configuration
		end

	SHARED_DEBUGGER_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- <Precursor>
		do
			create capturer.make
			Precursor (a_test_suite)
		end

feature {NONE} -- Access

	capturer: attached TEST_CAPTURER
			-- Capturer retrieving objects from running application.

feature {TEST_PROCESSOR_SCHEDULER_I} -- Status report

	sleep_time: NATURAL = 0
			-- <Precursor>

feature {NONE} -- Status report

	is_creating_new_class: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {NONE} -- Status setting

	print_new_class (a_file: attached KL_TEXT_OUTPUT_FILE; a_class_name: attached STRING)
			-- <Precursor>
		local
			l_source_writer: attached TEST_EXTRACTED_SOURCE_WRITER
			l_app_stat: detachable APPLICATION_STATUS
			l_cs: detachable EIFFEL_CALL_STACK
		do
			create l_source_writer.make
			capturer.observers.force_last (l_source_writer)

			l_source_writer.prepare (a_file, a_class_name)
			l_app_stat := debugger_manager.application_status
			if l_app_stat /= Void then
				l_cs := l_app_stat.current_call_stack
				if l_cs /= Void then
					from
						capturer.prepare
						l_cs.start
					until
						l_cs.after
					loop
						if
							attached {EIFFEL_CALL_STACK_ELEMENT} l_cs.item as l_cse and then
							configuration.call_stack_elements.has (l_cse.level_in_stack)
						then
							capturer.capture_call_stack_element (l_cse)
						end
						l_cs.forth
					end
					capturer.capture_objects
				end
			else
				test_suite.propagate_error (e_no_application_status, [], Current)
			end

			capturer.observers.start
			capturer.observers.search_forth (l_source_writer)
			check
				observer_found: not capturer.observers.off
			end
			capturer.observers.remove_at
		end

	proceed_process
			-- <Precursor>
		local
		do
			create_new_class
			is_finished := True
		end

feature -- Query

	is_valid_typed_configuration (a_arg: like conf_type): BOOLEAN
			-- <Precursor>
		do
			if debugger_manager.application_is_executing and then debugger_manager.application_is_stopped then
				if a_arg.is_interface_usable then
					Result := a_arg.call_stack_elements.for_all (agent is_valid_call_stack_element)
				end
			end
		ensure then
			result_implies_debugger_running: Result implies debugger_manager.application_is_executing
			result_implies_debugger_stopped: Result implies debugger_manager.application_is_stopped
		end

	is_valid_call_stack_element (a_index: INTEGER): BOOLEAN
			-- <Precursor>
		local
			l_cs: EIFFEL_CALL_STACK
		do
			if debugger_manager.application_is_executing and then debugger_manager.application_is_stopped then
				l_cs := debugger_manager.application_status.current_call_stack
				if l_cs /= Void and then l_cs.count >= a_index then
					if attached {EIFFEL_CALL_STACK_ELEMENT} l_cs.i_th(a_index) as l_cse then
						Result := capturer.is_valid_call_stack_element (l_cse)
					end
				end
			end
		end

feature {NONE} -- Constants

	e_no_application_status: STRING = "Could not retrieve application status"

;note
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
