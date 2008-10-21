indexing
	description: "Server abstract synax tree on temporary file for AST. This server is%
				%used during the compilation. The goal is to merge the file Tmp_ast_file%
				%and Ast_file if the compilation is successful. Indexed by class id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TMP_AST_SERVER

inherit
	COMPILER_SERVER [CLASS_AS]
		redefine
			make_index, need_index, make,
			has, item, put, remove
		end

	INTERNAL
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} --  Initialization

	make is
			-- Initialization
		do
			Precursor {COMPILER_SERVER}
			create storage.make (Chunk)
			create body_storage.make (Chunk)
			create body_info.make (Chunk)
			create tmp_body_info.make (Chunk)
			create invariant_info.make (Chunk)
			create useless_body_indexes.make (Chunk)
			create unique_values.make (Chunk)
			create invariants_to_remove.make
		end

feature -- AST Element change

	put (t: CLASS_AS) is
			-- Put class `t' in memory.
		require else
			t_not_void: t /= Void
		do
			storage.force (t, t.class_id)
			invariant_info.remove (t.class_id)
		ensure then
			has: has (t.class_id)
		end

	remove (a_class_id: INTEGER) is
			-- Remove the class with `a_class_id'.
		require else
			a_class_id_positive: a_class_id >= 0
		do
			storage.remove (a_class_id)
			invariant_info.remove (a_class_id)
		ensure then
			not_has_invariant: not invariant_info.has (a_class_id)
		end

feature -- Body element change

	body_force (a_body: FEATURE_AS; a_body_index: INTEGER) is
			-- Put `a_body' under `a_body_index'.
		require
			a_body_not_void: a_body /= Void
			a_body_index_positive: a_body_index >= 0
		do
			body_storage.force (a_body, a_body_index)
		ensure
			has: body_has (a_body_index)
		end

	body_replace (an_old_body_index, a_new_body_index: INTEGER) is
			-- Replace the id of the body with `an_old_body_index' with `a_new_body_index'.
		require
			an_old_body_index_positive: an_old_body_index >= 0
			a_new_body_index_positive: a_new_body_index >= 0
		local
			body: FEATURE_AS
			body_disk: READ_INFO
		do
			body_storage.search (an_old_body_index)
			if body_storage.found then
				body := body_storage.found_item
				body_storage.remove (an_old_body_index)
				body_storage.force (body, a_new_body_index)
			end
			body_info.search (an_old_body_index)
			if body_info.found then
				body_disk := body_info.found_item
				body_info.remove (an_old_body_index)
				body_info.force (body_disk, a_new_body_index)
			end
		ensure
			not_has_old: not body_has (an_old_body_index)
			has_new: body_has (a_new_body_index)
		end

	desactive (a_body_index: INTEGER) is
			-- Put `a_body_index' in `useless_body_indexes'.
		require
			body_index_positive: a_body_index >= 0
		do
			if a_body_index > 0 then
				debug
					io.error.put_string ("TMP_AST_SERVER.desactivate ")
					io.error.put_integer (a_body_index)
					io.error.put_new_line
				end
				useless_body_indexes.force (a_body_index)
			end
		end

	reactivate (a_body_index: INTEGER) is
			-- Remove `a_body_index' from `useless_body_indexes' if
			-- present, otherwise nothing.
		require
			body_index_positive: a_body_index >= 0
		do
			if a_body_index > 0 then
				debug
					io.error.put_string ("TMP_AST_SERVER.reactivate ")
					io.error.put_integer (a_body_index)
					io.error.put_new_line
				end
				if useless_body_indexes.count > 0 then
					useless_body_indexes.remove (a_body_index)
				end
			end
		end

feature -- Invariant element change

	invariant_remove (a_class_id: INTEGER) is
			-- Remove the invariant of `a_class_id' in INV_AST_SERVER upon finalization.
		require
			a_class_id_positive: a_class_id >= 0
		do
			if not invariants_to_remove.has (a_class_id) then
				invariants_to_remove.put_front (a_class_id)
			end
		end

feature -- Unique values element change

	unique_values_put (a_unique_values: HASH_TABLE [INTEGER, STRING]; a_class_id: INTEGER) is
			-- Put the `a_unique_values' of `a_class_id'.
		require
			a_unique_values_not_void: a_unique_values /= Void
			a_class_id_positive: a_class_id >= 0
		do
				-- We use `force' since we could replace the unique values of a class
				-- each time the class is recompiled and that we haven't reached a successful
				-- compilation yet.
			unique_values.force (a_unique_values, a_class_id)
		end

feature -- Element access

	has (a_class_id: INTEGER): BOOLEAN is
			-- Does the server contain a class with `a_class_id'?
		require else
			a_class_id_positive: a_class_id >= 0
		do
			Result := storage.has (a_class_id) or else Precursor (a_class_id)
		end

	item (a_class_id: INTEGER): CLASS_AS is
			-- Get class with `a_class_id'.
		do
			Result := storage.item (a_class_id)
			if Result = Void then
				Result := Precursor (a_class_id)
			end
		end

	body_has (a_body_id: INTEGER): BOOLEAN is
			-- Does the server contain a feature with `a_body_id'?
		require
			a_body_id_positive: a_body_id >= 0
		do
			Result := body_storage.has (a_body_id) or else body_info.has (a_body_id)
		end

	body_item (a_body_id: INTEGER): FEATURE_AS is
			-- Get feature with `a_body_id'.
		require
			a_body_id_positive: a_body_id >= 0
		local
			info: READ_INFO
			server_file: SERVER_FILE
		do
			Result := body_storage.item (a_body_id)
			if Result = Void then
				info := body_info.item (a_body_id)
				if info /= Void then
					server_file := Server_controler.file_of_id (info.file_id)
					check
							-- Server file should exist since we are getting it from a READ_INFO.
						server_file_not_void: server_file /= Void
					end
					if not server_file.is_open then
						Server_controler.open_file (server_file)
					end
					Result := partial_retrieve_body (server_file.descriptor, info.position, info.object_count)
						-- We set the `id' there because `Result.id' is actually the ID given at parsing
						-- time, it is not its body index.
					Result.set_id (a_body_id)
				end
			end
		end

	invariant_has (a_class_id: INTEGER): BOOLEAN is
			-- Does the server contain an invariant with `a_class_id'?
		require
			a_class_id_positive: a_class_id >= 0
		do
			if invariants_to_remove.has (a_class_id) then
				Result := false
			else
				Result := (storage.has (a_class_id) and then storage.item (a_class_id).invariant_part /= Void) or else invariant_info.has (a_class_id)
			end
		end

	invariant_item (a_class_id: INTEGER): INVARIANT_AS is
			-- Get invariant with `a_class_id'.
		require
			a_class_id_positive: a_class_id >= 0
		local
			info: READ_INFO
			server_file: SERVER_FILE
		do
			if invariants_to_remove.has (a_class_id) then
				Result := Void
			elseif storage.has (a_class_id) then
				Result := storage.item (a_class_id).invariant_part
			else
				info := invariant_info.item (a_class_id)
				if info /= Void then
					server_file := Server_controler.file_of_id (info.file_id)
					check
							-- Server file should exist since we are getting it from a READ_INFO.
						server_file_not_void: server_file /= Void
					end
					if not server_file.is_open then
						Server_controler.open_file (server_file)
					end
					Result := partial_retrieve_invariant (server_file.descriptor, info.position, info.object_count)
				end
			end
		end

	unique_values_item (a_class_id: INTEGER): HASH_TABLE [INTEGER, STRING] is
			-- Get the unique values of `a_class_id'.
		require
			a_class_id_positive: a_class_id >= 0
		do
			Result := unique_values.item (a_class_id)
		end

feature -- Finalization

	finalize is
			-- Finalization after a successful recompilation.
		local
			useless_body_index: INTEGER
			l_useless: like useless_body_indexes
		do
			debug
				io.error.put_string ("TMP_AST_SERVER.finalize%N")
			end

				-- Flush all classes to disk
			tmp_body_info.wipe_out
			from
				storage.start
			until
				storage.after
			loop
				current_class_id := storage.item_for_iteration.class_id
				write (storage.item_for_iteration)
				storage.forth
			end
				-- Convert the (read_info/id) touples into (read_info/body_index)
			from
				body_storage.start
			until
				body_storage.after
			loop
				body_info.put (tmp_body_info.item (body_storage.item_for_iteration.id), body_storage.key_for_iteration)
				body_storage.forth
			end
				-- Remove the stored data from memory
			storage.wipe_out
			body_storage.wipe_out
			tmp_body_info.wipe_out

				-- Desactive useless body ids
			from
				l_useless := useless_body_indexes
				l_useless.start
			until
				l_useless.after
			loop
				useless_body_index := l_useless.item_for_iteration
					-- Note: `remove' will get the updated id
					-- before performing the removal.
				debug
					io.error.put_string ("Useless body_index: ")
					io.error.put_integer (useless_body_index)
					io.error.put_new_line
				end
					-- Remove non-used `body_index' from both
					-- Current and BODY_SERVER, otherwise during
					-- `merge' we will add them back to BODY_SERVER
					-- making this step useless.
				body_info.remove (useless_body_index)
				Body_server.remove (useless_body_index)
				l_useless.forth
			end
				-- Wipeout useless body indexes as they are no longer required.
			useless_body_indexes.clear_all


				-- Clear cache and merge with server
			Body_server.cache.wipe_out
			Body_server.merge (body_info)
			body_info.wipe_out

				-- Remove invariants
			from
				invariants_to_remove.start
			until
				invariants_to_remove.after
			loop
				Inv_ast_server.remove (invariants_to_remove.item);
				invariants_to_remove.forth;
			end;
			invariants_to_remove.wipe_out

				-- Clear cache and merge with server
			Inv_ast_server.cache.wipe_out
			Inv_ast_server.merge (invariant_info);

				-- Remove unique values.
			unique_values.clear_all
		end

feature {NONE} -- Implementation (in memory)

	storage: HASH_TABLE [CLASS_AS, INTEGER]
			-- In memory storage for class.

	body_storage: HASH_TABLE [FEATURE_AS, INTEGER]
			-- In memory storage for features.

	unique_values: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER]
			-- Mapping of unique values per class.

feature -- Implementation (disk cache)

	cache: CACHE [CLASS_AS] is
			-- Cache for classes.
		once
			create Result.make
		end

feature {NONE} -- Implementation (on disk)

	body_info, tmp_body_info: HASH_TABLE [READ_INFO, INTEGER]
			-- Offsets of the objects tracked by the store append if
			-- saved to disk. Allows fast access to the objects.
			-- Maps body_id to the position of FEATURE_AS

	invariant_info: HASH_TABLE [READ_INFO, INTEGER]
			-- Offsets of the objects tracked by the store append if
			-- saved to disk. Allows fast access to the objects.
			-- Maps class_id to the position of INVARIANT_AS

feature {NONE} -- Store to disk

	current_class_id: INTEGER
			-- The current class id (used to insert invariants during file saving).

	make_index (obj: ANY; file_position, object_count: INTEGER) is
			-- Store object `obj' and track the instances
			-- of FEATURE_AS and INVARIANT_AS
		local
			read_info: READ_INFO
		do
				-- Put `obj' in the index.
			create read_info.make (file_position, current_file_id)
			read_info.set_object_count (object_count)

			if {feat: !FEATURE_AS} obj then
				tmp_body_info.force (read_info, feat.id)
			else
				invariant_info.put (read_info, current_class_id)
			end
		end

	need_index (obj: ANY): BOOLEAN is
			-- Is an index needed for `obj'?
		local
			l_dynamic_type: INTEGER
		do
			l_dynamic_type := {ISE_RUNTIME}.dynamic_type ($obj)
			Result := l_dynamic_type = feature_as_type or else l_dynamic_type = invariant_as_type
		end

feature {NONE} -- Implementation

	invariants_to_remove: LINKED_LIST [INTEGER];
			-- Id of invariants to remove from the invariant server
			-- when finalization

	useless_body_indexes: SEARCH_TABLE [INTEGER]
			-- Set of body_indexes ids which have to disappear after a successful
			-- recompilation

feature {NONE} -- Implementation of dynamic type checking

	invariant_as_type: INTEGER is
			-- Dynamic type of objects of type INVARIANT_AS.
		once
			Result := dynamic_type_from_string ("INVARIANT_AS")
		end

	feature_as_type: INTEGER is
			-- Dynamic type of objects of type INVARIANT_AS.
		once
			Result := dynamic_type_from_string ("FEATURE_AS")
		end

feature {NONE} -- Implementation Constants

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

feature {NONE} -- Implementation disk read

	partial_retrieve_body (file_desc: INTEGER; pos, nb_obj: INTEGER): FEATURE_AS is
			-- (export status {NONE})
		external
			"C | %"pretrieve.h%""
		alias
			"partial_retrieve"
		end

	partial_retrieve_invariant (file_desc: INTEGER; pos, nb_obj: INTEGER): INVARIANT_AS is
			-- (export status {NONE})
		external
			"C | %"pretrieve.h%""
		alias
			"partial_retrieve"
		end

invariant
	cache_not_void: cache /= Void
	unique_values_not_void: unique_values /= Void
	storage_not_void: storage /= Void
	body_storage_not_void: body_storage /= Void
	body_info_not_void: body_info /= Void
	invariant_info_not_void: invariant_info /= Void
	useless_body_indexes_not_void: useless_body_indexes /= Void
	invariants_to_remove_not_void: invariants_to_remove /= Void

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
