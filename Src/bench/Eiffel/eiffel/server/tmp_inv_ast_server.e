indexing
	description: "Invariant server. Remember also the body ids to erase from the%
				%erase from the table (body ids from changed features).%
				%Indexed by class id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TMP_INV_AST_SERVER 

inherit
	READ_SERVER [INVARIANT_AS]
		rename
			tmp_ast_server as offsets
		redefine
			clear, make
		end

create
	make
	
feature

	to_remove: LINKED_LIST [INTEGER];
			-- Id of invariants to remove from the invariant server
			-- when finalization

	make is
			-- Hash table creation
		do
			Precursor {READ_SERVER};
			create to_remove.make;
			to_remove.compare_objects
		end;

	cache: INV_AST_CACHE is
			-- Cache for routine tables
		once
			create Result.make
		end
		
	remove_id (i: INTEGER) is
			-- Insert `i' in `to_remove'.
		do
			if not to_remove.has (i) then
				to_remove.put_front (i);
			end;
			remove (i);
		end;

	finalize is
			-- Finalization after a successful recompilation.
		do
				-- first remove ids
			from
				to_remove.start
			until
				to_remove.after
			loop
				Inv_ast_server.remove (to_remove.item);
				to_remove.forth;
			end;

			Inv_ast_server.merge (Current);

				-- Update cache
			Inv_ast_server.cache.copy (cache);
			cache.make;

			clear;
		end;

	clear is
			-- Clear the structure
		do
			Precursor {READ_SERVER}
			to_remove.wipe_out;
		end;

invariant

	to_remove_exists: to_remove /= Void;

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
