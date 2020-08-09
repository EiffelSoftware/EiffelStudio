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

feature -- Access

	breakpoints_data_from_storage: detachable BREAK_LIST
			-- Breakpoints data from storage
		local
			l_value: detachable ANY
		do
			l_value := session_data.value (Breakpoints_session_data_id)
			if attached {CELL_SESSION_DATA [like breakpoints_data_from_storage]} l_value as c then
				data_cells.force (c, Breakpoints_session_data_id)
				Result := c.item
			elseif attached {like breakpoints_data_from_storage} l_value as v then
				Result := v
			end
		end

	exceptions_handler_data_from_storage: detachable DBG_EXCEPTION_HANDLER
			-- <Precursor>
		local
			l_value: detachable ANY
		do
			l_value := session_data.value (Exception_handler_session_data_id)
			if attached {CELL_SESSION_DATA [like exceptions_handler_data_from_storage]} l_value as c then
				data_cells.force (c, Exception_handler_session_data_id)
				Result := c.item
			elseif attached {like exceptions_handler_data_from_storage} l_value as v then
				Result := v
			end
		end

	profiles_data_from_storage: detachable DEBUGGER_PROFILE_MANAGER
			-- <Precursor>
		local
			l_value: detachable ANY
		do
			l_value := profiles_session_data.value (Profiles_session_data_id)
			if attached {CELL_SESSION_DATA [like profiles_data_from_storage]} l_value as c then
				data_cells.force (c, Profiles_session_data_id)
				Result := c.item
			elseif attached {like profiles_data_from_storage} l_value as v then
				Result := v
			end
		end

feature {NONE} -- Persistence

	breakpoints_data_to_storage (a_data: like breakpoints_data_from_storage)
			-- <Precursor>
		local
			dbg_session: SESSION_I
			c: CELL_SESSION_DATA [like breakpoints_data_from_storage]
		do
				-- Effective saving
			dbg_session := session_data

				--| Set breakpoints (this is a copy, thus new object, and then it will be stored)
			if attached {CELL_SESSION_DATA [like breakpoints_data_from_storage]} data_cells.item (Breakpoints_session_data_id) as cl then
				c := cl
			end
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
			if attached {CELL_SESSION_DATA [like exceptions_handler_data_from_storage]} data_cells.item (Exception_handler_session_data_id) as cl then
				c := cl
			end
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
			if attached {CELL_SESSION_DATA [like profiles_data_from_storage]} data_cells.item (Profiles_session_data_id) as cl then
				c := cl
			end
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

feature -- File access.		

	profiles_data_to_file (a_data: like profiles_data_from_storage; a_path: PATH)
			-- Profiles saved into `a_path'.
		do
				-- Not relevant
				-- FIXME
		end

	profiles_data_from_file (a_path: PATH): like profiles_data_from_storage
			-- Profiles data from file `a_path', if any.
		do
				-- Not relevant
				-- FIXME
		end

feature {NONE} -- Access: session

	session_manager: SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Session manager consumer
		once
			create Result
		end

	session_data: SESSION_I
			-- Session data
		do
			Result := internal_session_data
			if
				Result = Void and then
				attached session_manager.service as s
			then
				Result := s.retrieve_extended (True, once "dbg")
				internal_session_data := Result
			end
		end

	profiles_session_data: SESSION_I
			-- Session data
		do
			Result := internal_profiles_session_data
			if
				Result = Void and then
				attached session_manager.service as s
			then
				Result := s.retrieve_extended (True, once "dbg-profiles")
				internal_profiles_session_data := Result
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

feature {NONE} -- Element change: session

	force_save_session_data (a_session_data: SESSION_I)
			-- Force storing of `a_session_data'
		do
			if attached session_manager.service as s then
				s.store (a_session_data)
			end
		end

feature {NONE} -- Implementation

	data_cells: HASH_TABLE [CELL_SESSION_DATA [DEBUGGER_STORABLE_DATA_I], STRING]
			-- Cached cell session data.

;note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
