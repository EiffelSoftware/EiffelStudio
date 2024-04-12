note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_DEBUGGER

inherit
	ICOR_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (a_clr_runtime_version: STRING_32; a_integration: CLI_DEBUGGER_INTEGRATION)
			-- Initialize `Current'.
		do
			integration := a_integration
			clr_runtime_version := a_clr_runtime_version
			create_icor_debug
		end

feature -- Status

	is_debugging: BOOLEAN
		do
			Result := icor_debug /= Void
		end

	last_call_success: INTEGER
		do
			if attached icor_debug as dbg then
				Result := dbg.last_call_success
			end
		end

	last_call_succeed: BOOLEAN
		do
			if attached icor_debug as dbg then
				Result := dbg.last_call_succeed
			end
		end

feature -- Access

	integration: CLI_DEBUGGER_INTEGRATION

feature {NONE} -- Access

	icor_debug: detachable ICOR_DEBUG
			-- ICorDebug object used to control and access Dotnet debugger

feature {ICOR_EXPORTER} -- Access

	last_icor_debug_process_handle: POINTER
		do
			if attached icor_debug as dbg then
				Result := dbg.last_icor_debug_process_handle
			end
		end

feature -- Change

	create_process (a_command_line: READABLE_STRING_GENERAL; a_working_directory: PATH; a_ns_env: NATIVE_STRING): POINTER
			-- Pointer on the freshly creared ICorDebugProcess
		do
			if attached icor_debug as dbg then
				Result := dbg.create_process (a_command_line, a_working_directory, a_ns_env)
			end
		end

	clean_data
		do
			if attached icor_debug as dbg then
				dbg.clean_data
			end
		end

feature {NONE} -- Implementation

	clr_runtime_version: detachable STRING_32

	create_icor_debug
			-- Create icor_debug as ICorDebug
		local
			icor_debug_managed_callback_obj: ICOR_DEBUG_MANAGED_CALLBACK
			icor_debug_unmanaged_callback_obj: ICOR_DEBUG_UNMANAGED_CALLBACK
			l_icor_debug: ICOR_DEBUG
			last_icor_debug_pointer: POINTER -- Last ICorDebug created
			icor_debug_factory: ICOR_DEBUG_FACTORY
		do
			if icor_debug = Void then
					-- And now for the dotnet world			
				initialize_clr_host

				create icor_debug_factory

				last_icor_debug_pointer := icor_debug_factory.new_cordebug_pointer_for (clr_runtime_version)

				if last_icor_debug_pointer /= Default_pointer then
					create icor_debug.make_by_pointer (last_icor_debug_pointer)
					l_icor_debug := icor_debug
					l_icor_debug.add_ref

					l_icor_debug.initialize
					if l_icor_debug.last_call_succeed then
							--| We keep the callback server objects alive in the C/Cpp glue
							--| then let's add a ref, but we'll leave `dispose' the responsibility
							--| to Release the object
						icor_debug_managed_callback_obj := icor_debug_factory.new_cordebug_managed_callback
						icor_debug_managed_callback_obj.add_ref
						icor_debug_managed_callback_obj.initialize_callback
						l_icor_debug.set_managed_handler (icor_debug_managed_callback_obj)

						icor_debug_unmanaged_callback_obj := icor_debug_factory.new_cordebug_unmanaged_callback
						icor_debug_unmanaged_callback_obj.add_ref
						icor_debug_unmanaged_callback_obj.initialize_callback
						l_icor_debug.set_unmanaged_handler (icor_debug_unmanaged_callback_obj)

							--| Enable callback to update data in the estudio world.
						integration.enable_debugger_callback
					else
						l_icor_debug.release
						l_icor_debug := Void
					end
				end
			end
		end

	initialize_clr_host
			-- Initialize dotnet runtime, to be sure to use the correct version of the
			-- runtime after while
		local
			l_host: CLR_HOST
		once
			;(create {CLI_COM}).initialize_com
			l_host := (create {CLR_HOST_FACTORY}).runtime_host (clr_runtime_version)
		end


invariant
--	invariant_clause: True

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
