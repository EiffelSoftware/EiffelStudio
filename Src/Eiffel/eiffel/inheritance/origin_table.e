indexing
	description: "[
		Duplication (conceptual) and actual duplication (code duplication is handled here).
		Each line of the ORIGIN_TABLE is processes separately.
		Each line correponds to a routine id, in other words, each line represents one
		routine (the notion of routine corresponds to a feature introduced into a class
		without ant predecessors, and all its evolutions throughout the various inheritance
		adaptations and branches).

		Before repeated inheritance was implemented, the routine `compute_feature_table'
		performed the following operations:
		1) For each line pick one FEATURE_I that would be the selected one.
		1.a) If the FEATURE_I's all have the same body id, the first feature is chosen
			arbritrarily
		1.b) Otherwise, go through the parent clauses and find the selection. If several
			selections ---> VMRC2, otherwise insert the selected name into the global
			"Selected" string list. Unselect the other FEATURE_I's, i.e. compute a new routine
			id set for them (one element) and insert them as new routines into the SELECT_TABLE
		1.c) If nothing found ---> VMRC3
		Modifications for correct implementation of the semantics of repeated inheritance:
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ORIGIN_TABLE

inherit
	HASH_TABLE [SELECTION_LIST, INTEGER]

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end

create
	make

feature

	insert (info: INHERIT_INFO) is
			-- Insert information `info' in the table.
		require
			good_argument: info /= Void
			good_context: not (info.a_feature = Void or else info.a_feature.rout_id_set = Void)
		local
			rout_id_set: ROUT_ID_SET
			i, nb: INTEGER
			rout_id: INTEGER
		do
			from
				rout_id_set := info.a_feature.rout_id_set
				nb := rout_id_set.count
				i := 1
			until
				i > nb
			loop
				rout_id := rout_id_set.item (i)
				search (rout_id)
				if found_item = Void then
						-- We are adding the first feature corresponding to `rout_id'
						-- so we create a new selection list.
					put (create {SELECTION_LIST}.make, rout_id)
				end
				found_item.extend (info)
				i := i + 1
			end
		end

	compute_feature_table (parents: PARENT_LIST; old_t, new_t: FEATURE_TABLE) is
			-- Origin table for instance of FEATURE_TABLE resulting
			-- of an analysis of possible repeated inheritance
		require
			parents_not_void: parents /= Void
		local
			i, l_iteration_position: INTEGER
			l_keys: like keys
			l_process_replication: BOOLEAN
			l_replicated_feature_set: LINKED_LIST [SELECTION_LIST]
			l_selection_list: SELECTION_LIST
			l_feature_replication_generator: AST_FEATURE_REPLICATION_GENERATOR
			l_current_class: CLASS_C
			l_class_as: CLASS_AS
		do
			from
					-- If we perform 'count' iterations this means we exit
					-- immediately after the last item has been processed
					-- instead of calling a needless extra 'forth'
				i := count
				l_keys := keys
			until
				i = 0
			loop
					-- Move 'iteration' position to the next usable 'content' slot.
				if l_keys [l_iteration_position] /= 0 then
					content [l_iteration_position].process_selection (parents, old_t, new_t)

						-- Check if replication was processed.
						-- All non replicated features get removed during selection processing.
					if content [l_iteration_position].count > 0 then
						if l_replicated_feature_set = Void then
							create l_replicated_feature_set.make
						end
						l_replicated_feature_set.extend (content [l_iteration_position])
					end
						-- Decrement processed selection list counter.
					i := i - 1
				end
				l_iteration_position := l_iteration_position + 1
			end

			if l_replicated_feature_set /= Void then
					-- There are features replicated at the level of the current class that have been processed.

					-- A full type check is needed to detect replication.
				l_current_class := System.current_class
				l_current_class.set_need_type_check (True)
				l_class_as := l_current_class.ast
				create l_feature_replication_generator
				from
					l_replicated_feature_set.start
				until
					l_replicated_feature_set.after
				loop
					l_selection_list := l_replicated_feature_set.item
					from
							-- Iterate through the replicated features and adjust AST as necessary.
						l_selection_list.start
					until
						l_selection_list.after
					loop
						l_feature_replication_generator.process_replicated_feature (l_selection_list.item.a_feature, l_selection_list.item.parent, l_current_class, old_t, new_t)
						l_selection_list.forth
					end
					l_replicated_feature_set.forth
				end
			end
			debug
				io.error.put_string ("========= END TRACE ==========%N")
			end
		end

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
