note
	description: "[
		Evaulator controller which launched the evaluator through the debugger.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_EVALUATOR_DEBUGGER_CONTROLLER

inherit
	ETEST_EVALUATOR_CONTROLLER

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

create
	make

feature -- Access

	last_output: STRING
			-- <Precursor>
		do
			create Result.make_empty
		end

feature {NONE} -- Access

	service: SERVICE_CONSUMER [TEST_SUITE_S]
		once
			create Result
		end

feature {NONE} -- Status report

	is_evaluator_launched: BOOLEAN
			-- <Precursor>

	is_evaluator_running: BOOLEAN
		do
			Result := debugger_manager.application_initialized and then debugger_manager.application.is_running
		end


feature {NONE} -- Status setting

	start_evaluator (a_argument: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			test_suite.project_helper.run (Void, a_argument, Void)
			is_evaluator_launched := True
		end

	stop_evaluator
		do
			if is_evaluator_running then
				debugger_manager.application.kill
			end
			is_evaluator_launched := False
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
