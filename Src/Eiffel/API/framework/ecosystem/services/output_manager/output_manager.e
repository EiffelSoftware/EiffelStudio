note
	description: "[
		The default {OUTPUT_MANAGER_S} implementation for accessing multiple outputs, segregating tool
		output.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT_MANAGER

inherit
	OUTPUT_MANAGER_S

	REGISTRAR [OUTPUT_I, UUID]
		rename
			registrations as outputs,
			active_registrations as active_outputs,
			is_valid_registration as is_valid_output,
			is_registered as is_output_available,
			registration as output,
			registered_event as output_registered_event,
			unregistered_event as output_unregistered_event,
			registration_activated_event as output_activated_event,
			registrar_connection as output_manager_event_connection
		redefine
			is_valid_registration_key
		end

create
	make

feature -- Status report

	is_valid_registration_key (a_key: UUID): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_key) and then not a_key.is_null
		ensure then
			not_a_key_is_null: Result implies not a_key.is_null
		end

feature {NONE} -- Factory

	new_output (a_key: UUID; a_name: READABLE_STRING_GENERAL): OUTPUT_I
			-- <Precursor>
		do
			create {OUTPUT_TTY} Result
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
