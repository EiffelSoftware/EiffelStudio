indexing
	description: "Server of class dependances for incremental type check indexed by class id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEPEND_SERVER

inherit
	COMPILER_SERVER [CLASS_DEPENDANCE]
		redefine
			make, item, has, remove
		end

create
	make

feature -- Initialisation

	make is
		-- Creation
		do
			Precursor{COMPILER_SERVER}
			create bindex_cid_table.make (200)
		end

feature -- Access

	cache: CACHE [CLASS_DEPENDANCE] is
			-- Cache for routine tables
		once
			create Result.make
		end

	bindex_cid_table: HASH_TABLE [INTEGER, INTEGER]
			-- you give it a body_index and it tells you in which
			-- class the corresponding feature is written

	remove_correspondance (bindex: INTEGER) is
		do
			bindex_cid_table.remove (bindex)
		end

	add_correspondance (bindex: INTEGER; cid: INTEGER) is
		do
			bindex_cid_table.put (cid, bindex)
		end

	item (an_id: INTEGER): CLASS_DEPENDANCE is
			-- Class dependance of id 'an_id' . Look first in the temporary
			-- depend server. It not present, look in itself.
		do
			Result := tmp_depend_server.item (an_id)
			if Result = Void then
				Result := Precursor (an_id)
			end
		end

	has (an_id: INTEGER): BOOLEAN is
			-- Is an item of id `an_id' present in the current server?
		do
			Result := Precursor (an_id) or else Tmp_depend_server.has (an_id);
		end

	remove (an_id: INTEGER_32) is
			-- <Precursor>
		do
			tmp_depend_server.remove (an_id)
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
