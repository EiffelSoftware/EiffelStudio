indexing
	description: "Objects that represents a debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DEBUGGER_STORAGE

feature {NONE} -- Initialization

	make (m: like manager) is
			-- Instanciate Current with `m' as `manager'
		do
			manager := m
		end

	manager: DEBUGGER_MANAGER
			-- Associated debugger's manager

feature -- Access

	breakpoints_data_from_storage: BREAK_LIST
			-- Exceptions handler data from storage
		deferred
		end

	exceptions_handler_data_from_storage: DBG_EXCEPTION_HANDLER
			-- Exceptions handler data from storage
		deferred
		end

	profiles_data_from_storage: DEBUGGER_PROFILES
			-- Profiles data from storage
		deferred
		end

feature -- Write

	breakpoints_data_to_storage (a_data: like breakpoints_data_from_storage) is
			-- Breakpoints data to storage
		deferred
		end

	exceptions_handler_data_to_storage (a_data: like exceptions_handler_data_from_storage) is
			-- Exceptions handler data to storage
		deferred
		end

	profiles_data_to_storage (a_data: like profiles_data_from_storage) is
			-- Profiles data to storage
		deferred
		end

;indexing
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
