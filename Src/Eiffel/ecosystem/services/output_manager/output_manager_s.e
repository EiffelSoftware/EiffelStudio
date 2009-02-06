note
	description: "[
		A environment manager for acessing one or more outputs, segregating tool output.
		
		Check {OUTPUT_MANAGER_KINDS} for the common output UUID keys.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OUTPUT_MANAGER_S

inherit
	USABLE_I

	DISPOSABLE_I

	SERVICE_I

	REGISTRAR_I [OUTPUT_I, UUID]
		rename
			registrations as outputs,
			active_registrations as active_outputs,
			is_valid_registration as is_valid_output,
			registration as output,
			registered_event as output_registered_event,
			unregistered_event as output_unregistered_event,
			registration_activated_event as output_activated_event,
			registrar_connection as output_manager_event_connection
		export
			{ANY} output_manager_event_connection
		redefine
			is_valid_registration_key
		end

feature -- Access

	general_output: !OUTPUT_I
			-- The default, general purpose output pane.
		require
			is_interface_usable: is_interface_usable
		local
			l_id: UUID
		do
			l_id := (create {OUTPUT_MANAGER_KINDS}).general
			if is_registered (l_id) then
				Result := output (l_id)
			else
				Result := new_output (l_id)
				register (Result, l_id)
			end
		ensure
			is_interface_usable: {l_usable: USABLE_I} Result implies l_usable.is_interface_usable
			result_is_valid_output: is_valid_output (Result)
			result_consistent: Result ~ general_output
		end

feature {NONE} -- Factory

	new_output (a_key: !UUID): !OUTPUT_I
			-- Creates a new output, used for the `general_output' feature
		require
			is_interface_usable: is_interface_usable
			a_key_is_valid_registration_key: is_valid_registration_key (a_key)
			not_a_key_is_registered: not is_registered (a_key)
		deferred
		ensure
			is_interface_usable: {l_usable: USABLE_I} Result implies l_usable.is_interface_usable
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
