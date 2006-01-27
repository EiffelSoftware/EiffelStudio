indexing
	description: "Check if a given feature can be renamed without any problems in the class hierarchy. Also computes the classes that will have to be modified."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_CHK_FEATURE_RENAME

inherit
	ERF_CHECK

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_feature: FEATURE_I; a_new_name: STRING; a_refactoring: ERF_FEATURE_RENAME) is
			-- Create check for `a_feature' that gets renamed into `a_new_name' and
			-- report the classes that have to be changed to `a_refactoring'.
		require
			a_feature_not_void: a_feature /= Void
			a_new_name_not_void: a_new_name /= Void
			a_refactoring_not_void: a_refactoring /= Void
		do
			feature_i := a_feature
			old_name := a_feature.feature_name
			new_name := a_new_name
			refactoring := a_refactoring
			create recursive_descendants.make (Chunk)
			create syntactical_clients.make
			create topological.make (Chunk)
			create topological_mapping.make (Chunk)
			create type_checker
		end

feature -- Basic operation

	execute is
            -- Execute a check.
		local
			l_class: CLASS_C
			l_id: INTEGER
        do
        	success := true
			recursive_descendants.wipe_out
			topological.wipe_out
			topological_mapping.wipe_out

	       		-- check classes in topological order
			from
		       	l_class := feature_i.written_class
		       	topological_mapping.put (l_class, l_class.topological_id)
	        	topological.put (l_class.topological_id)
			until
				not success or topological.is_empty
			loop
				l_id := topological.item
				l_class := topological_mapping.item (l_id)
        		topological.remove
        		topological_mapping.remove (l_id)
				syntactical_clients.put (l_class.lace_class)
				recursive_descendants.put (l_class.class_id)

				check_class (l_class)
			end

			refactoring.set_affected_classes (syntactical_clients)
			refactoring.set_recursive_descendants (recursive_descendants)
        end

feature {NONE} -- Implementation

	check_class (a_class: CLASS_C) is
			-- Check `a_class' and add all its descendants in `l_topological'. Add the clients to `a_clients'.
		require
			a_class_not_void: a_class /= Void
		local
			l_descendants: ARRAYED_LIST [CLASS_C]
			l_clients: ARRAYED_LIST [CLASS_C]
			l_class: CLASS_C
			l_feature: E_FEATURE
		do
			is_stop_hierarchy := false

				-- handle the class itself

				-- check if the feature gets undefined or renamed
				-- and if it gets renamed check if it is the new name or another
			check_undefine_rename (a_class.ast)

				-- check if there is another feature with the new_name that conflicts
			if not is_undefined and not is_renamed then
				l_feature := a_class.feature_with_name (new_name.as_lower)
				if l_feature /= Void then
					error_message := "The descending class " + a_class.name.as_upper + " already has another feature with the new name."
					success := false
				end
			end

				-- only if there wasn't an error and the feature wasn't renamed or undefined we have to change anything in descendants or clients.
			if success and not is_stop_hierarchy then
					-- add clients
				from
					l_clients := a_class.syntactical_clients
					l_clients.start
				until
					l_clients.after
				loop
					syntactical_clients.extend (l_clients.item.lace_class)
					l_clients.forth
				end

					-- add the descendants
				from
					l_descendants := a_class.descendants
					l_descendants.start
				until
					l_descendants.after
				loop
					l_class := l_descendants.item
					topological.force (l_class.topological_id)
					topological_mapping.put (l_class, l_class.topological_id)
					l_descendants.forth
				end
			end
		end

	check_undefine_rename (a_class: CLASS_AS) is
			-- Check if the feature gets undefined or renamed.
		require
			a_class_not_void: a_class /= Void
		local
			l_parents: EIFFEL_LIST [PARENT_AS]
			l_inherit: PARENT_AS
			l_undefines: EIFFEL_LIST [FEATURE_NAME]
			l_renames: EIFFEL_LIST [RENAME_AS]
			l_rename_as: RENAME_AS
			l_id: INTEGER
		do
			is_undefined := False
			is_renamed := False
			l_parents := a_class.parents
			if l_parents /= Void then
				from
					l_parents.start
				until
					l_parents.after
				loop
					l_inherit := l_parents.item

						-- we only look at classes that are descendants of the class where the feature gets renamed
					l_id := type_checker.solved_type (l_inherit.type).associated_class.class_id
					if recursive_descendants.has (l_id) then
							-- at the start of each inherit clause we have the feature (until it is undefined or renamed)
						is_stop_hierarchy := false

							-- check undefining
						l_undefines := l_inherit.undefining
						if l_undefines /= Void then
							from
								l_undefines.start
							until
								is_stop_hierarchy or else l_undefines.after
							loop
								if l_undefines.item.visual_name.is_case_insensitive_equal (old_name) then
									is_undefined := true
									is_stop_hierarchy := true
								end
								l_undefines.forth
							end
						end

							-- check renaming
						l_renames := l_inherit.renaming
						if l_renames /= Void then
							from
								l_renames.start
							until
								is_stop_hierarchy or else l_renames.after
							loop
								l_rename_as := l_renames.item
								if l_rename_as.old_name.visual_name.is_case_insensitive_equal (old_name) then
									is_renamed := True
									is_stop_hierarchy := True
								end
								l_renames.forth
							end
						end
					end
					l_parents.forth
				end
			end
		end



	feature_i: FEATURE_I
			-- The feature that gets renamed.

	old_name: STRING
			-- The old name of the feature.

	new_name: STRING
			-- The new name of the feature.

	refactoring: ERF_FEATURE_RENAME
			-- The refactoring to report the classes to modify.

	is_stop_hierarchy: BOOLEAN
			-- Is this the last class in the hierarchy we have to handle (we don't have to handle descendants and childs)?

	is_undefined: BOOLEAN
			-- Is the feature completely undefined?

	is_renamed: BOOLEAN
			-- Is the feature renamed in the new name?

	type_checker: AST_TYPE_CHECKER
			-- Type checker to get some type informations.

	recursive_descendants: SEARCH_TABLE [INTEGER]
			-- Table with all class_ids of all the classes in the hierarchy under the class where the feature gets changed.

	topological: HEAP_PRIORITY_QUEUE [INTEGER]
			-- The priority queue of the topological ids.

	topological_mapping: HASH_TABLE [CLASS_C, INTEGER]
			-- Map topological ids to CLASS_C.

	syntactical_clients: LINKED_SET [CLASS_I]
			-- Clients and descendands we have to process during the refactoring.

feature {NONE} -- Implementation constants

	Chunk: INTEGER is 100


invariant
	feature_i_not_void: feature_i /= Void
	old_name_ok: old_name /= Void and not old_name.is_empty
	new_name_ok: new_name /= Void and not new_name.is_empty
	refactoring_not_void: refactoring /= Void
	recursive_descendants_not_void: recursive_descendants /= Void
	topological_not_void: topological /= Void
	topological_mapping_not_void: topological_mapping /= Void
	syntactical_clients_not_void: syntactical_clients /= Void
	type_checker_not_void: type_checker /= Void

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
