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

	SHARED_SERVICE_PROVIDER

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initializes batch compiler
		do
			initialize_services
		end

feature {NONE} -- Service initialization

	initialize_services is
			-- Initializes tty services
		local
			l_container: SERVICE_CONTAINER
		do
			l_container ?= service_provider.query_service ({SERVICE_CONTAINER})
			l_container.add_service_with_activator ({SESSION_MANAGER_S}, agent create_session_manager_service, False)
		end

	create_session_manager_service: SESSION_MANAGER_S
			-- Creates the session manager service
		do
			create {SESSION_MANAGER} Result
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
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
