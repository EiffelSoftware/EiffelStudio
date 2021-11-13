note
	description: "[
			Abstract synax tree server on temporary file for AST used during the compilation.
			The goal is to merge this Tmp_ast_file and Ast_file if the compilation is successful.
			Indexed by class id.
		]"

class TMP_AST_SERVER

inherit
	COMPILER_SERVER [CLASS_AS]
		redefine
			make_index, need_index, make,
			has, item, put, remove, flush
		end

	INTERNAL
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	AST_NULL_VISITOR
		export
			{NONE} all
		undefine
			copy, is_equal
		redefine
			process_class_as,
			process_eiffel_list,
			process_feature_as,
			process_feature_clause_as
		end

create
	make

feature {NONE} --  Initialization

	make
			-- Initialization
		do
			Precursor {COMPILER_SERVER}
			create storage.make (Chunk)
			create invariant_info.make (Chunk)
			create invariants_to_remove.make
			create discardable_classes.make (chunk)
		end

feature -- AST Element change

	put (t: CLASS_AS)
			-- Put class `t' in memory.
		require else
			t_not_void: t /= Void
		local
			i: INTEGER_32
		do
			i := t.class_id
			storage.force (t, i)
			invariant_info.remove (i)
			discardable_classes.remove (i)
		ensure then
			has: has (t.class_id)
		end

	remove (a_class_id: INTEGER)
			-- Remove the class with `a_class_id'.
		require else
			a_class_id_positive: a_class_id >= 0
		do
			storage.remove (a_class_id)
			invariant_info.remove (a_class_id)
		ensure then
			not_has_invariant: not invariant_info.has (a_class_id)
		end

	load (c: CLASS_C)
			-- Ensure AST of a class `c' is in this server as well as the corresponding feature bodies.
		require
			c_attached: attached c
			is_c_present: has (c.class_id) or else system.ast_server.has (c.class_id)
		local
			a: detachable CLASS_AS
			i: INTEGER_32
		do
				-- Set `loaded_class' before processing as it is used to collect feature bodies.
			loaded_class := c
			i := c.class_id
			if not storage.has (i) then
				a := item (i)
				if a = Void then
					a := system.ast_server.item (i)
				end
				check attached a then
						-- Ensure AST of a class `c' is in memory.
					put (a)
						-- Record that there is no reason to store AST of this class.
					discardable_classes.put (i, i)
						-- Put feature bodies in `body_storage'.
					a.process (Current)
				end
			end
		ensure
			is_c_loaded: is_loaded (c.class_id)
			is_loaded_class_set: loaded_class = c
		end

	touch (class_id: INTEGER_32)
			-- Record AST of a class identified by `class_id' is modified and needs to be saved.
		require
			is_class_id_positive: class_id > 0
			is_loaded: is_loaded (class_id)
		do
			discardable_classes.remove (class_id)
		ensure
			not_is_discardable: not discardable_classes.has (class_id)
		end

feature -- Status report

	is_loaded (class_id: INTEGER): BOOLEAN
			-- Is class identified by `class_id' loaded into memory?
		require
			is_class_id_positive: class_id > 0
		do
			Result := storage.has (class_id)
		end

feature {NONE} -- Access

	discardable_classes: HASH_TABLE [INTEGER, INTEGER]
			-- IDs of classes that should not be stored by `finalize'

feature {NONE} -- Visitor

	loaded_class: detachable CLASS_C
			-- Class which is just loaded by `load'

	process_eiffel_list (a: EIFFEL_LIST [AST_EIFFEL])
			-- <Precursor>
		local
			i: INTEGER
		do
			from
				i := a.index
				a.start
			until
				a.after
			loop
				a.item.process (Current)
				a.forth
			end
			a.go_i_th (i)
		end

	process_class_as (a: CLASS_AS)
			-- <Precursor>
		do
			safe_process (a.features)
		end

	process_feature_clause_as (a: FEATURE_CLAUSE_AS)
			-- <Precursor>
		do
			safe_process (a.features)
		end

	process_feature_as (a: FEATURE_AS)
			-- <Precursor>
		do
			a.feature_names.do_all (
				agent (t: FEATURE_AS; n: FEATURE_NAME)
					do
						if
							attached loaded_class as c and then
							attached c.feature_of_name_id (n.feature_name.name_id) as f
						then
							body_force (c.class_id, t, f.body_index)
						end
					end
				(a, ?)
			)
		end

feature -- Body element change

	body_force (a_class_id: INTEGER; a_body: FEATURE_AS; a_body_index: INTEGER)
			-- Put `a_body' under `a_body_index'.
		require
			has_class_id: has (a_class_id)
			a_body_not_void: a_body /= Void
			a_body_index_positive: a_body_index >= 0
		local
			l_ast: CLASS_AS
		do
			l_ast := item (a_class_id)
			l_ast.body_indexes.force (a_body, a_body_index)
		ensure
			has: body_has (a_class_id, a_body_index)
		end

feature -- Invariant element change

	invariant_remove (a_class_id: INTEGER)
			-- Remove the invariant of `a_class_id' in INV_AST_SERVER upon finalization.
		require
			a_class_id_positive: a_class_id >= 0
		do
			if not invariants_to_remove.has (a_class_id) then
				invariants_to_remove.put_front (a_class_id)
			end
		end

feature -- Element access

	has (a_class_id: INTEGER): BOOLEAN
			-- Does the server contain a class with `a_class_id'?
		require else
			a_class_id_positive: a_class_id >= 0
		do
			Result := storage.has (a_class_id) or else Precursor (a_class_id)
		end

	item (a_class_id: INTEGER): detachable CLASS_AS
			-- Get class with `a_class_id'.
		do
			Result := storage.item (a_class_id)
			if Result = Void then
				Result := Precursor (a_class_id)
			end
		end

	body_has (a_class_id, a_body_id: INTEGER): BOOLEAN
			-- Does the server contain a feature with `a_body_id'?
		require
			has_a_class_id: has (a_class_id)
			a_body_id_positive: a_body_id >= 0
		local
			l_ast: CLASS_AS
		do
			l_ast := item (a_class_id)
			Result := l_ast.body_indexes.has (a_body_id)
		end

	body_item (a_class_id, a_body_id: INTEGER): FEATURE_AS
			-- Get feature with `a_body_id'.
		require
			has_a_class_id: has (a_class_id)
			a_body_id_positive: a_body_id >= 0
		local
			l_ast: CLASS_AS
		do
			l_ast := item (a_class_id)
			Result := l_ast.body_indexes.item (a_body_id)
		end

	invariant_has (a_class_id: INTEGER): BOOLEAN
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

	invariant_item (a_class_id: INTEGER): INVARIANT_AS
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

feature -- Finalization

	finalize
			-- Finalization after a successful recompilation.
		do
			debug
				io.error.put_string ("TMP_AST_SERVER.finalize%N")
			end

				-- Flush all classes to disk
			from
				storage.start
			until
				storage.after
			loop
				current_class_id := storage.item_for_iteration.class_id
				if not discardable_classes.has (current_class_id) then
					write (storage.item_for_iteration)
				end
				storage.forth
			end
				-- Remove the stored data from memory
			discardable_classes.wipe_out
			storage.wipe_out

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
		end

feature {NONE} -- Implementation (in memory)

	storage: HASH_TABLE [CLASS_AS, INTEGER]
			-- In memory storage for class.

	unique_values: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER]
			-- Mapping of unique values per class.

feature -- Implementation (disk cache)

	cache: CACHE [CLASS_AS]
			-- Cache for classes.
		once
			create Result.make
		end

feature {NONE} -- Implementation (on disk)

	invariant_info: HASH_TABLE [READ_INFO, INTEGER]
			-- Offsets of the objects tracked by the store append if
			-- saved to disk. Allows fast access to the objects.
			-- Maps class_id to the position of INVARIANT_AS

feature {NONE} -- Store to disk

	current_class_id: INTEGER
			-- The current class id (used to insert invariants during file saving).

	make_index (obj: ANY; file_position, object_count: INTEGER)
			-- Store object `obj' and track the instances
			-- of INVARIANT_AS
		local
			read_info: READ_INFO
		do
				-- Put `obj' in the index.
			create read_info.make (file_position, current_file_id)
			read_info.set_object_count (object_count)
			invariant_info.put (read_info, current_class_id)
		end

	need_index (obj: ANY): BOOLEAN
			-- Is an index needed for `obj'?
		do
			Result := {ISE_RUNTIME}.dynamic_type (obj) = invariant_as_type
		end

	flush
			-- Flush server
		do
			do_nothing
		end

feature {NONE} -- Implementation

	invariants_to_remove: LINKED_LIST [INTEGER];
			-- Id of invariants to remove from the invariant server
			-- when finalization

feature {NONE} -- Implementation of dynamic type checking

	invariant_as_type: INTEGER
			-- Dynamic type of objects of type INVARIANT_AS.
		once
			Result := dynamic_type_from_string ("INVARIANT_AS")
		end

	feature_as_type: INTEGER
			-- Dynamic type of objects of type INVARIANT_AS.
		once
			Result := dynamic_type_from_string ("FEATURE_AS")
		end

feature {NONE} -- Implementation Constants

	Chunk: INTEGER = 500
			-- Size of a HASH_TABLE block

feature {NONE} -- Implementation disk read

	partial_retrieve_body (file_desc: INTEGER; pos, nb_obj: INTEGER): FEATURE_AS
			-- (export status {NONE})
		external
			"C | %"pretrieve.h%""
		alias
			"partial_retrieve"
		end

	partial_retrieve_invariant (file_desc: INTEGER; pos, nb_obj: INTEGER): INVARIANT_AS
			-- (export status {NONE})
		external
			"C | %"pretrieve.h%""
		alias
			"partial_retrieve"
		end

invariant
	cache_not_void: cache /= Void
	storage_not_void: storage /= Void
	invariant_info_not_void: invariant_info /= Void
	invariants_to_remove_not_void: invariants_to_remove /= Void
	discardable_classes_attached: attached discardable_classes

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
