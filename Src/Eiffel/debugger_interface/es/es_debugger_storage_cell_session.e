note
	description: "Objects that represents a debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DEBUGGER_STORAGE_CELL_SESSION

inherit
	DEBUGGER_STORAGE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (m: like manager)
			-- <Precursor>
		do
			Precursor (m)
			create data_cells.make (3)
		end

feature {NONE} -- Debugger session data access

	session_manager: SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Session manager consumer
		once
			create Result
		end

	session_data: SESSION_I
			-- Session data
		local
			cons: like session_manager
		do
			Result := internal_session_data
			if Result = Void then
				cons := session_manager
				if cons.is_service_available then
					Result := cons.service.retrieve_extended (True, once "dbg")
					internal_session_data := Result

						-- Load debugger data when first access the session
					manager.load_all_debugger_data
				end
			end
		end

	profiles_session_data: SESSION_I
			-- Session data
		local
			cons: like session_manager
		do
			Result := internal_profiles_session_data
			if Result = Void then
				cons := session_manager
				if cons.is_service_available then
					Result := cons.service.retrieve_extended (True, once "dbg-profiles")
					internal_profiles_session_data := Result

						-- Load debugger data when first access the session
					manager.load_profiles_data
				end
			end
		end

	internal_session_data: like session_data
			-- cached version of `session_data'

	internal_profiles_session_data: like profiles_session_data
			-- cached version of `profiles_session_data'

	Profiles_session_data_id: STRING = "com.eiffel.debugger.profiles"
			-- Id for session data related to profiles

	Breakpoints_session_data_id: STRING = "com.eiffel.debugger.breakpoints"
			-- Id for session data related to breakpoints

	Exception_handler_session_data_id: STRING = "com.eiffel.debugger.exceptions_handler"
			-- Id for session data related to exception_handler

feature {NONE} -- Debugger session data change

	force_save_session_data (a_session_data: SESSION_I)
			-- Force storing of `a_session_data'
		local
			cons: like session_manager
		do
			cons := session_manager
			if cons.is_service_available then
				cons.service.store (a_session_data)
			end
		end

feature -- Access

	breakpoints_data_from_storage: BREAK_LIST
			-- Breakpoints data from storage
		local
			dbg_session: SESSION_I
		do
			dbg_session := session_data
			if {c: CELL_SESSION_DATA [like breakpoints_data_from_storage]} dbg_session.value (Breakpoints_session_data_id) then
				data_cells.force (c, Breakpoints_session_data_id)
				Result := c.item
			else
				Result ?= dbg_session.value (Breakpoints_session_data_id)
			end
		end

	exceptions_handler_data_from_storage: DBG_EXCEPTION_HANDLER
			-- <Precursor>
		local
			dbg_session: SESSION_I
		do
			dbg_session := session_data
			if {c: CELL_SESSION_DATA [like exceptions_handler_data_from_storage]} dbg_session.value (Exception_handler_session_data_id) then
				data_cells.force (c, Exception_handler_session_data_id)
				Result := c.item
			else
				Result ?= dbg_session.value (Exception_handler_session_data_id)
			end
		end

	profiles_data_from_storage: DEBUGGER_PROFILES
			-- <Precursor>
		local
			dbg_session: SESSION_I
		do
			dbg_session := profiles_session_data
			if {c: CELL_SESSION_DATA [like profiles_data_from_storage]} dbg_session.value (Profiles_session_data_id) then
				data_cells.force (c, Profiles_session_data_id)
				Result := c.item
			else
				Result ?= dbg_session.value (Profiles_session_data_id)
			end
		end

feature -- Write

	breakpoints_data_to_storage (a_data: like breakpoints_data_from_storage)
			-- <Precursor>
		local
			dbg_session: SESSION_I
			c: CELL_SESSION_DATA [like breakpoints_data_from_storage]
		do
				-- Effective saving
			dbg_session := session_data

				--| Set breakpoints (this is a copy, thus new object, and then it will be stored)
			c ?= data_cells.item (Breakpoints_session_data_id)
			if c = Void then
				create c.put (a_data)
				data_cells.force (c, Breakpoints_session_data_id)
			else
				c.replace (a_data)
			end
			dbg_session.set_value (c, Breakpoints_session_data_id)
			c.prepare_for_storage

   					--| Force storage
			force_save_session_data (dbg_session)
		end

	exceptions_handler_data_to_storage (a_data: like exceptions_handler_data_from_storage)
			-- <Precursor>
		local
			dbg_session: SESSION_I
			c: CELL_SESSION_DATA [like exceptions_handler_data_from_storage]
		do
			dbg_session := session_data
			c ?= data_cells.item (Exception_handler_session_data_id)
			if c = Void then
				create c.put (a_data)
				data_cells.force (c, Exception_handler_session_data_id)
			else
				c.replace (a_data)
			end
			dbg_session.set_value (c, Exception_handler_session_data_id)
			c.prepare_for_storage
			force_save_session_data (dbg_session)
		end

	profiles_data_to_storage (a_data: like profiles_data_from_storage)
			-- <Precursor>
		local
			dbg_session: SESSION_I
			c: CELL_SESSION_DATA [like profiles_data_from_storage]
		do
			dbg_session := profiles_session_data
			c ?= data_cells.item (Profiles_session_data_id)
			if c = Void then
				create c.put (a_data)
				data_cells.force (c, Profiles_session_data_id)
			else
				c.replace (a_data)
			end
			dbg_session.set_value (c, Profiles_session_data_id)
			c.prepare_for_storage
			force_save_session_data (dbg_session)
		end

feature {NONE} -- Implementation

	data_cells: HASH_TABLE [CELL_SESSION_DATA [DEBUGGER_STORABLE_DATA_I], STRING]
			-- Cached cell session data.

;note
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
