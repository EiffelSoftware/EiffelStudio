indexing
	description: "Server of features on temporary file. This server is used%
				%during the compilation. The goal is to merge the file Tmp_feature_file%
				%and Feature_file if the compilation is successful.%
				%Indexed by body index."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TMP_FEATURE_SERVER

inherit
	COMPILER_SERVER [FEATURE_I]
		rename
			put as server_put
		redefine
			item, has, flush, make,
			remove
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			Precursor
			create storage.make (chunk)
		end

feature -- Element access

	has (a_id: INTEGER): BOOLEAN is
			-- Does the server contain a class with `a_id'?
		do
			Result := storage.has (a_id) or else Precursor (a_id)
		end

	item (a_id: INTEGER): FEATURE_I is
			-- Get class with `a_id'.
		do
			Result := storage.item (a_id)
			if Result = Void then
				Result := Precursor (a_id)
			end
		end

feature -- Element change

	put (t: FEATURE_I) is
			-- Put feature `t' in memory.
		require
			t_not_void: t /= Void
			t_id_set: t.id > 0
		do
			storage.force (t, t.id)
		ensure
			has: has (t.id)
		end

	remove (an_id: INTEGER_32)
			-- <Precursor>
		do
			storage.remove (an_id)
			Precursor (an_id)
		end

feature -- Server

	flush is
			-- Flush all FEATURE_I objects at once on disk.
		local
			l_server_file_id, l_server_file_descriptor: INTEGER
			pos: INTEGER
			l_server_file: SERVER_FILE
			l_storage: like storage
			l_item: FEATURE_I
			l_null: POINTER
			l_controler: like server_controler
		do
			l_controler := Server_controler
			l_server_file := l_controler.file_of_id (current_file_id)
			if
				l_server_file = Void
				or else l_server_file.last_offset > Size_limit * l_controler.block_size
				or else l_server_file.precompiled
			then
				set_current_file_id
				l_server_file := l_controler.file_of_id (current_file_id)
			end
			if not l_server_file.is_open then
				l_controler.open_file (l_server_file)
			end

			from
				l_storage := storage
				l_server_file_id := l_server_file.file_id
				l_server_file_descriptor := l_server_file.descriptor
				l_storage.start
			until
				l_storage.after
			loop
				l_item := l_storage.item_for_iteration
				l_server_file.add_occurrence
				pos := store_append (l_server_file_descriptor, $l_item, l_null, l_null, $Current)
					-- Not that we do not perform any cleaning here. This is because, it has to
					-- be done when the new feature table is going to replace the old one.
				tbl_force (create {SERVER_INFO}.make (pos, l_server_file_id), l_item.id)
				l_storage.forth
			end
			l_storage.wipe_out
		end

feature -- Access

	cache: CACHE [FEATURE_I] is
			-- Cache for routine tables
		once
			create Result.make
		end

feature {NONE} -- Implementation (in memory)

	storage: HASH_TABLE [FEATURE_I, INTEGER]
			-- In memory storage for class.

	Chunk: INTEGER is 500;
			-- Size of a HASH_TABLE block

invariant
	storage_not_void: storage /= Void

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
