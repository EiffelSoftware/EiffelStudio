indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class SELECTION_LIST

inherit
	SORTED_TWO_WAY_LIST [INHERIT_INFO]

	COMPILER_EXPORTER
		undefine
			is_equal
		end

	SHARED_WORKBENCH
		undefine
			is_equal
		end

	SHARED_ERROR_HANDLER
		undefine
			is_equal
		end

	SHARED_SELECTED
		undefine
			is_equal
		end

	SHARED_ORIGIN_TABLE
		undefine
			is_equal
		end

	SHARED_INHERITED
		undefine
			is_equal
		end

create
	make

create {SELECTION_LIST}
	make_sublist

feature -- Access

	selected_rout_id_set: ROUT_ID_SET

feature -- Selection

	process_selection (parents: PARENT_LIST; old_t, new_t: FEATURE_TABLE) is
			-- Process Feature selected in the list.
		require
			not is_empty
		local
			l_selected_feature: FEATURE_I
			vmrc3: VMRC3
			l_replicated_features_present: BOOLEAN
			l_has_old_feature_replication: BOOLEAN
		do
			l_has_old_feature_replication := System.has_old_feature_replication
			l_replicated_features_present := count > 1
			if l_replicated_features_present then
					-- There is more than one inheritance info object in `Current'
					-- so therefore we process a feature replication.
				process_replication (old_t, new_t)
			elseif first.parent /= Void and then first.parent.is_non_conforming then
					-- If the feature is solely coming from a non-conforming class
					-- then it must be replicated in the current class
				process_replication (old_t, new_t)
				l_replicated_features_present := True
			end
				-- Set the selected feature to the first element in the selection list.
			l_selected_feature := first.a_feature

			if
				not (one_body_only and then (l_selected_feature.written_class.generics = Void or else same_parent_type))
			then
					-- Look for a valid selection
				l_selected_feature := parent_selection (parents);
					-- Selected feature is add to front of `Current' in `parent_selection'

				if l_selected_feature /= Void then

						-- Add selected feature name id to `Selected', this is used for tracking redundant 'selection'
						-- when checking PARENT_C validity.
					Selected.put_front (l_selected_feature.feature_name_id);

						-- Iterate through remaining features and initialize them as 'unselected' features.
					from
							-- Set `selected_rout_id' for comparison in `unselect'
							-- No twin is needed as there are no side effects.
						selected_rout_id_set := l_selected_feature.rout_id_set

							-- Move to the second item in the list as the first is 'selected'.
						start
						forth
					until
						after
					loop
						unselect (item, new_t, old_t)
						forth
					end;
					selected_rout_id_set := Void

						--| Merge routine ids from unselected features
debug ("REPLICATION", "ACTUAL_REPLICATION")
	io.error.put_string ("Selected feature is: ");
	io.error.put_string (l_selected_feature.feature_name);
	io.error.put_string (l_selected_feature.generator);
	io.error.put_new_line;
end;
				end
			end

			if l_selected_feature = Void then
					-- Raise a VMRC3 error as no feature is selected.
				create vmrc3
				vmrc3.set_class (System.current_class)
				vmrc3.set_selection_list (Current)
				Error_handler.insert_error (vmrc3)
			end

			if not l_replicated_features_present then
					-- We want to leave the list of replicated features in the list so that we can
					-- use this for inheritance branch determination.
				wipe_out
			elseif l_has_old_feature_replication then
				wipe_out
			end
		end;

	Routine_id_counter: ROUTINE_COUNTER is
			-- Routine id counter
		once
			Result := System.routine_id_counter;
		end;

	parent_selection (parents: PARENT_LIST): FEATURE_I is
			-- Return selected feature of `Current'.
		require
			has_multiple_features: count > 1
		local
			vmrc2: VMRC2;
			l_non_conforming_count: INTEGER
			l_implicit_selection: FEATURE_I
		do
			from
				start
			until
				after
			loop
				if parents.is_explicitly_selecting (item.a_feature.feature_name_id) then
					if Result = Void then
						Result := item.a_feature
						if active /= first_element then
								-- Add selected feature to the front of the selection list.
							put_front (item)
							remove
						else
							forth
						end
					else
							-- We have multiple selection so we raise a VMRC2 error.
						create vmrc2;
						vmrc2.set_class (System.current_class)
						vmrc2.init (Result, item.a_feature)
						Error_handler.insert_error (vmrc2)
						forth
					end
				else
					if item.parent /= Void and then item.parent.is_non_conforming then
							-- We have a non-conforming parent so increase the counter
							-- so that implicit selection may be determined
						l_non_conforming_count := l_non_conforming_count + 1
					else
							-- This routine will be selected should every other routine come from a non-conforming branch.
						l_implicit_selection := item.a_feature
					end
					forth
				end
			end

			if Result = Void and then l_non_conforming_count >= (count - 1) then
					-- We have an implicit selection
				if l_implicit_selection /= Void then
					Result := l_implicit_selection
				else
					Result := first.a_feature
				end
			end
		end

	one_body_only: BOOLEAN is
			-- Is only one body id involved in the selection list?
		require
			not is_empty
		local
			l_active: like active
			l_code_id: INTEGER
		do
			Result := True
			if count > 1 then
				from
					l_active := first_element
					l_code_id := l_active.item.a_feature.code_id
						-- Go to the second item so we don't compare the code id with itself.
					l_active := l_active.right
				until
					l_active = Void or else not Result
				loop
					Result := l_code_id = l_active.item.a_feature.code_id
					l_active := l_active.right
				end
			end
		end;

	same_parent_type: BOOLEAN is
			-- Are all the features coming from the same written type?
		require
			not is_empty;
			one_body_only;
			has_generics: first.a_feature.written_class.generics /= Void;
		local
			instantiator, written_actual_type, l_comparison_type: TYPE_A;
			written_class: CLASS_C;
			written_id: INTEGER;
			l_active: like active
		do
			Result := True
			if count > 1 then
				from
						-- Set up the first parent type as the one to compare all other parent types
					l_active := first_element
					written_class := l_active.item.a_feature.written_class;
					written_id := written_class.class_id;
					written_actual_type := written_class.actual_type;
					if l_active.item.parent /= Void then
						instantiator := l_active.item.parent.parent_type
					else
							-- Redeclaration
						instantiator := written_actual_type
					end
					l_comparison_type := written_actual_type.instantiation_in (instantiator, written_id);

						-- Move to the second element in the list.
					l_active := l_active.right
				until
					l_active = Void or else not Result
				loop
					if l_active.item.parent /= Void then
						instantiator := l_active.item.parent.parent_type
					else
							-- Redeclaration
						instantiator := written_actual_type
					end
					Result := l_comparison_type.is_safe_equivalent (
								written_actual_type.instantiation_in (instantiator, written_id)
							)
					l_active := l_active.right
				end;
			end

		end;

	unselect (a_info: INHERIT_INFO; new_t, old_t: FEATURE_TABLE) is
			-- Process first unselected feature
		require
			good_arguments: a_info /= Void and new_t /= Void and old_t /= Void
			not_off: not off
		local
			a_feature		: FEATURE_I
			old_feature		: FEATURE_I
			rout_id_set		: ROUT_ID_SET
			id				: INTEGER
			feature_name_id	: INTEGER
			r_id_set		: ROUT_ID_SET
			i				: INTEGER
			nb				: INTEGER
			new_rout_id		: INTEGER
			rid				: INTEGER
			attribute_i: ATTRIBUTE_I
		do
			id := new_t.feat_tbl_id;
			a_feature := a_info.a_feature;
				-- New unselected feature
			r_id_set := a_feature.rout_id_set;
			a_feature := a_feature.unselected (id);

				-- Process new routine id set
			create rout_id_set.make
			feature_name_id := a_feature.feature_name_id;
debug ("REPLICATION", "ACTUAL_REPLICATION")
	io.error.put_string ("unselecting :");
	io.error.put_string (a_feature.feature_name);
	io.error.put_new_line;
end;
			old_feature := old_t.item_id (feature_name_id);
				-- Process a new routine id
			if old_feature /= Void and then
				old_feature.is_attribute = a_feature.is_attribute and then
				(old_feature.is_unselected and old_feature.access_in = id)
			then
					-- Take an old one
				new_rout_id := old_feature.rout_id_set.first;
			else
					-- Take a new one
				new_rout_id := a_feature.new_rout_id;
			end;
			rout_id_set.put (new_rout_id);

			from
				nb := r_id_set.count;
				i := 1;
			until
				i > nb
			loop
				rid := r_id_set.item (i);
				if not selected_rout_id_set.has (rid) then
					rout_id_set.force (rid);
debug ("REPLICATION", "ACTUAL_REPLICATION")
	io.error.put_string ("%T");
	io.error.put_string (System.current_class.class_signature);
	io.error.put_string (", ");
	io.error.put_string (a_feature.feature_name);
	io.error.put_string (" is unselected and has a history%N");
end;
				end;
				i := i + 1;
			end

				-- Insertion into the routine info table
			System.rout_info_table.put (new_rout_id, System.current_class);
			a_feature.set_rout_id_set (rout_id_set);
			a_feature.set_is_origin (True);

			if a_feature.is_attribute and then a_feature.type.is_formal then
					-- A wrapper has to be generated for the attribute.
				attribute_i ?= a_feature
					-- Set generate_in value of `attribute' to the current class's class id.
					-- (stored as the feature table id in the newly generated feature table)
				attribute_i.set_generate_in (new_t.feat_tbl_id)
			end

				-- Set inheritance info object with unselected info so that this can be
				-- used for replication processing.
			a_info.set_a_feature (a_feature)

				-- Add unselected feature to feature table, replacing the previous one.
			new_t.replace (a_feature, feature_name_id);
		end;

feature -- Conceptual Replication

	process_replication (old_t, new_t: FEATURE_TABLE) is
			-- Process conceptual replication. The only routines left under the
			-- same routine_id will have different feature names. Hence, all
			-- these features will be replicated.
		local
			replication: FEATURE_I
			inh_info: INHERIT_INFO
			l_inheriting_class_id: INTEGER
			l_has_old_feature_replication: BOOLEAN
		do
			from
				l_has_old_feature_replication := system.has_old_feature_replication
				l_inheriting_class_id := new_t.feat_tbl_id
				start
			until
				after
			loop
				inh_info := item
				if l_has_old_feature_replication then
					replication := inh_info.a_feature.replicated (inh_info.a_feature.written_in)
				else
					replication := inh_info.a_feature.replicated (l_inheriting_class_id)
				end
				new_t.replace (replication, replication.feature_name_id)
				inh_info.set_a_feature (replication)
				forth
			end
		end

feature -- Trace

	trace is
			-- Debug purpose
		do
			from
				start
			until
				after
			loop
if item.a_feature.written_class > System.any_class.compiled_class and
		item.a_feature /= Void then
				if item.parent = Void then
					io.error.put_string ("VOID");
				else
					io.error.put_string (item.parent.class_name);
				end;
				io.error.put_string (": ");
				io.error.put_string (item.a_feature.generator);
				io.error.put_string (item.a_feature.feature_name);
				--io.error.put_character (' ');
				item.a_feature.rout_id_set.trace;
				io.error.put_string (" {body_index = ");
				io.error.put_integer (item.a_feature.body_index)
				io.error.put_string ("} written class: ");
				io.error.put_string (item.a_feature.written_class.name);
				io.error.put_new_line;
				io.error.put_string ("Written in feature name: ");

	if item.a_feature.written_class.has_feature_table then
				io.error.put_string
(item.a_feature.written_class.feature_table.feature_of_body_index
(item.a_feature.body_index).feature_name);
	else
				io.error.put_string ("Dunno");
	end;
				io.error.put_new_line;
end;
				forth;
			end;
		end;
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
