indexing
	description: "Class for description of a read-only server"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	READ_SERVER [T -> IDABLE]

inherit
	ISE_SERVER [READ_INFO, T]

feature -- Access

	item, frozen server_item (an_id: INTEGER): T is
			-- Object of id `an_id'
		do
			Result := cache.item_id (an_id)
			if Result = Void then
				Result := disk_item (an_id)
				if Result /= Void then
					cache.force (Result)
				end
			end
		end

	disk_item (an_id: INTEGER): T is
			-- Object of id `an_id'
		local
			info: READ_INFO
			server_file: SERVER_FILE
		do
			info := tbl_item (an_id)
			if info /= Void then
				server_file := Server_controler.file_of_id (info.file_id)
				check
						-- Server file should exist since we are getting it from a READ_INFO.
					server_file_not_void: server_file /= Void
				end
				if not server_file.is_open then
					Server_controler.open_file (server_file)
				end
				Result := partial_retrieve (server_file.descriptor, info.position, info.object_count)
				Result.set_id (an_id)
			end
		end

	remove (an_id: INTEGER) is
			-- Simply remove element from server structures
			-- This is as read server, nothing id removed from disk.
			--|Note: the O_N_TABLE table should also be updated but
			--|we are sick and tired of this problem
		do
			tbl_remove (an_id)
			cache.remove_id (an_id)
		end

	offsets: HASH_TABLE [SERVER_INFO, INTEGER] is
			-- Class offsets in the corresponding server
		deferred
		end

feature -- Size

	Chunk: INTEGER is 500
			-- Chunk size when updating the READ_SERVER

feature -- Trace

	trace is
		do
		end

invariant
	cache_not_void: cache /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
