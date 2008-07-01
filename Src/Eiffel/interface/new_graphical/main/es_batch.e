indexing
	description: "Main class for Batch mode in EiffelStudio."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_BATCH

inherit
	ES
		redefine
			initialize
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initializes batch compiler
		do
			Precursor {ES}
			initialize_services
			initialize_debugger
		end

feature {NONE} -- Initialization: Services

	initialize_services
			-- Initializes tty services
		local
			l_container: SERVICE_CONSUMER [SERVICE_CONTAINER_S]
		do
			create l_container
			check is_service_available: l_container.is_service_available end
			if l_container.is_service_available and then {l_service: SERVICE_CONTAINER_S} l_container.service then
				service_initializer.add_core_services (l_service)
			end
		end

	initialize_debugger is
			-- Initialize debugger
		local
			ttydbgm: TTY_DEBUGGER_MANAGER
		do
			create ttydbgm.make
			ttydbgm.set_events_handler (create {TTY_DEBUGGER_EVENTS_HANDLER}.make)
			ttydbgm.register
		end

feature {NONE} -- Access

	service_initializer: !SERVICE_INITIALIZER
			-- Initializer used to register all services.
		once
			create Result
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
