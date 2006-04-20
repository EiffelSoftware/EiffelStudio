indexing
	description: "Server for invariant byte code on temporary file. This server is%
				%used during the compilation. The goal is to merge the file Tmp_inv_byte_file%
				%and Inv_byte_file if the compilation is successful.%
				%Indexed by class id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TMP_INV_BYTE_SERVER 

inherit
	DELAY_SERVER [INVARIANT_B]
		redefine
			flush, make
		end

create
	make

feature

	to_remove: LINKED_LIST [INTEGER];
			-- Ids to remove during finalization

	id (t: INVARIANT_B): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	make is
			-- Hash table creation
		do
			Precursor {DELAY_SERVER};
			create to_remove.make;
			to_remove.compare_objects
		end;

	cache: INV_BYTE_CACHE is
			-- Cache for routine tables
		once	
			create Result.make
		end

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		once
			create Result.make ((3 * Cache.cache_size) // 2)
		end

	remove_id (i: INTEGER) is
			-- Insert `i' in `to_remove'.
		do
			if not to_remove.has (i) then
				to_remove.put_front (i);
			end;
		end;

	flush is
			-- Finalization after a successful recompilation.
		do
			Precursor {DELAY_SERVER};
			from
				to_remove.start;
			until
				to_remove.after
			loop
				Inv_byte_server.remove (to_remove.item);
				to_remove.forth;
			end;
		end;

feature -- Server size configuration

	Size_limit: INTEGER is 200
			-- Size of the TMP_INV_BYTE_SERVER file (200 Ko)

	Chunk: INTEGER is 500;
			-- Size of a HASH_TABLE block

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
