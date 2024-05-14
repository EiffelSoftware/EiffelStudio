note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	NETFMWK_CLI_DEBUGGER

inherit
	CLI_DEBUGGER

create
	make

feature {NONE} -- Initialization

	make (a_useless_clr_runtime_version: STRING_32; a_integration: like integration)
			-- Initialize `Current'.
		do
			integration := a_integration
		end

feature -- Access

	integration: CLI_DEBUGGER_INTEGRATION

feature -- Status

	is_debugging: BOOLEAN = False

	last_call_success: INTEGER

	last_call_succeed: BOOLEAN = False

feature -- Factory		

	icor_debug_factory: ICOR_DEBUG_FACTORY_I
		do
			check False then
			end
		end

feature -- Execution

	create_process (a_command_line: READABLE_STRING_GENERAL; a_working_directory: PATH; a_ns_env: NATIVE_STRING): POINTER
			-- Pointer on the freshly creared ICorDebugProcess
		do
			check False then
			end
		end

	clean_data
		do
		end

feature {ICOR_EXPORTER} -- Access

	last_icor_debug_process_handle: POINTER

invariant

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
