indexing
	description: "Server for byte code routine indexed by body_index"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BYTE_SERVER

inherit
	COMPILER_SERVER [BYTE_CODE]
		redefine
			disk_item, has, item, remove
		end

create
	make

feature -- Update

	cache: CACHE [BYTE_CODE] is
			-- Cache for routine tables
		once
			create Result.make
		end

feature -- Access

	item (an_id: INTEGER): BYTE_CODE is
			-- Byte code of body index `an_id'. Look first in the temporary
			-- byte code server
		do
			Result := tmp_byte_server.item (an_id)
			if Result = Void then
				Result := Precursor (an_id)
			end
		end

	disk_item (an_id: INTEGER): BYTE_CODE is
			-- Byte code of body index `an_id'. Look first in the temporary
			-- byte code server
		do
			Result := tmp_byte_server.disk_item (an_id)
			if Result = Void then
				Result := Precursor {COMPILER_SERVER} (an_id)
			end
		end

	has (an_id: INTEGER): BOOLEAN is
			-- Is the id `an_id' present in `Tmp_byte_server' or
			-- Current ?
		require else
			positive_id: an_id /= 0;
		do
			Result := Precursor (an_id) or else Tmp_byte_server.has (an_id);
		end;

	remove (an_id: INTEGER_32) is
			-- <Original>
		do
			tmp_byte_server.remove (an_id)
			Precursor (an_id)
		end

feature -- Server size configuration

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

invariant
	cache_not_void: cache /= Void

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
