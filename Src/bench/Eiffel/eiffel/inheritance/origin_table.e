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
			l: SELECTION_LIST
		do
			from
				rout_id_set := info.a_feature.rout_id_set
				nb := rout_id_set.count
				i := 1
			until
				i > nb
			loop
				rout_id := rout_id_set.item (i)
				l := item (rout_id)
				if l = Void then
					create l.make
					put (l, rout_id)
				end
				l.extend (info)

				i := i + 1
			end
		end

	delete (info: INHERIT_INFO) is
			-- Delete information `info' in the table.
		require
			good_argument: info /= Void
			good_context: not (info.a_feature = Void or else info.a_feature.rout_id_set = Void)
		local
			rout_id_set: ROUT_ID_SET
			i, nb: INTEGER
			rout_id: INTEGER
			l: SELECTION_LIST
		do
			from
				rout_id_set := info.a_feature.rout_id_set
				nb := rout_id_set.count
				i := 1
			until
				i > nb
			loop
				rout_id := rout_id_set.item (i)
				l := item (rout_id)
				l.start
				l.compare_references
				l.search (info)
				check
					not l.after
				end
				l.remove

				i := i + 1
			end
		end
				
	compute_feature_table (parents: PARENT_LIST; old_t, new_t: FEATURE_TABLE) is
			-- Origin table for instance of FEATURE_TABLE resulting
			-- of an analysis of possible repeated inheritance
		local
			selected: FEATURE_I
			vmrc3: VMRC3
			l_computed: like computed
		do
			debug
				io.error.put_string ("========= START TRACE, class ")
				io.error.put_string (new_t.associated_class.name)
				io.error.put_string (" ============%N")
			end
			from
				create l_computed.make (count)
				computed := l_computed
				start
			until
				after
			loop
				selected := item_for_iteration.selection (parents, old_t, new_t)
				if selected /= Void then
					l_computed.put (selected, key_for_iteration)
				else
							-- No selected feature
					create vmrc3
					vmrc3.set_class (System.current_class)
					vmrc3.set_selection_list (item_for_iteration)
					Error_handler.insert_error (vmrc3)
				end
				forth
			end
			debug
				io.error.put_string ("========= END TRACE ==========%N")
			end
		end

	computed: SELECT_TABLE;
			-- Feature table computed by `compute_feature_table'.
			-- Selection: if all the parents in the informations are all the same, then
			-- a selection is not needed if either all the body id's are the same or
			-- one of them is selected. If there are differrent parent, a selection is
			-- not needed if all the body ids are the same.

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
