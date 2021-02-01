note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class SELECTION_LIST

inherit
	ARRAYED_LIST [INHERIT_INFO]
		undefine
			is_equal
		end

	COMPARABLE
		undefine
			copy
		end

	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end

	SHARED_WORKBENCH
		undefine
			is_equal, copy
		end

	SHARED_ERROR_HANDLER
		undefine
			is_equal, copy
		end

	SHARED_SELECTED
		undefine
			is_equal, copy
		end

	SHARED_ORIGIN_TABLE
		undefine
			is_equal, copy
		end

	SHARED_INHERITED
		undefine
			is_equal, copy
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		undefine
			is_equal, copy
		end

	SHARED_DEGREES
		export
			{NONE} all
		undefine
			is_equal, copy
		end

create
	make

create {SELECTION_LIST}
	make_filled

feature -- Selection

	process_selection (parents: PARENT_LIST; old_t, new_t: FEATURE_TABLE)
			-- Process Feature selected in the list.
		require
			not is_empty
		local
			l_selected_feature: FEATURE_I
			vmrc3: VMRC3
			l_replicated_features_present: BOOLEAN
			l_has_old_feature_replication: BOOLEAN
			l_selected_rout_id_set: ROUT_ID_SET
			replication: FEATURE_I
			l_inheriting_class_id: INTEGER_32
		do
			l_has_old_feature_replication := System.has_old_feature_replication
			l_replicated_features_present := count > 1

				-- Process replicated features
			if l_replicated_features_present then
				from
					l_inheriting_class_id := new_t.feat_tbl_id
					start
				until
					after
				loop
					replication := item.a_feature.replicated
						(if item.a_feature.has_replicated_ast then
								-- Parent feature was already replicated, we need to keep its `access_in'
								-- it will be modified later in
								-- `{AST_FEATURE_REPLICATION_GENERATOR}.process_replicated_feature'.
							item.internal_a_feature.access_in
						elseif l_has_old_feature_replication then
								-- Use legacy replication if set.
							item.internal_a_feature.written_in
						else
							l_inheriting_class_id
						end)
						-- Check if we need to update replicated feature descriptor.
					if replication.is_type_evaluation_delayed then
							-- Replicated feature descriptor should be updated to use types computed with a delay.
						degree_4.put_action (
							agent (destination, source: FEATURE_I)
								do
									destination.set_type (source.type, destination.assigner_name_id)
									destination.set_arguments (source.arguments)
									destination.set_pattern_id (source.pattern_id)
								end
							(replication, item.internal_a_feature)
						)
					end
					item.set_a_feature (replication)
					forth
				end

				if not l_has_old_feature_replication then
						-- We only want replication processing enabled for legacy replication
						-- for non-conforming features.
					set_has_replicated_features
				end
			end

			if
				not (one_body_only and then (first.a_feature.written_class.generics = Void or else same_parent_type))
			then
					-- Look for a valid selection
				l_selected_feature := parent_selection (parents);
					-- Selected feature is add to front of `Current' in `parent_selection'

				if l_selected_feature /= Void then

						-- Add selected feature name id to `Selected', this is used for tracking redundant 'selection'
						-- when checking PARENT_C validity.
					Selected.extend (l_selected_feature.feature_name_id);

						-- Iterate through remaining features and initialize them as 'unselected' features.
					from
							-- Set `selected_rout_id' for comparison in `unselect'
							-- No twin is needed as there are no side effects.
						l_selected_rout_id_set := l_selected_feature.rout_id_set
							-- Move to the second item in the list as the first is 'selected'.
						start
						forth
					until
						after
					loop
						unselect (item, new_t, old_t, l_selected_rout_id_set)

						forth
					end;
				end
			else
				l_selected_feature := first.a_feature
					-- Remove all discarded features, ie: those after 'first'.
					-- We do this so that post-processing of `Current' doesn't go over redundant types.
				from
					start
					forth
				until
					after
				loop
					item.reset
					remove
				end
			end

			if l_selected_feature = Void then
					-- Raise a VMRC3 error as no feature is selected.
				create vmrc3
				vmrc3.set_class (System.current_class)
				vmrc3.set_selection_list (Current)
				Error_handler.insert_error (vmrc3)
			else
				if l_replicated_features_present then
						-- Make sure that the code id is reset so feature is not treated as a new seed.
					l_selected_feature.set_code_id (new_t.item_id (l_selected_feature.feature_name_id).code_id)
					new_t.replace (l_selected_feature, l_selected_feature.feature_name_id)
				end
				--l_selected_feature.set_is_selected (True)
				check
					is_replicated_directly_correctly_set: l_selected_feature.is_replicated_directly implies l_selected_feature.access_class = system.current_class
				end
			end
		end;

	parent_selection (parents: PARENT_LIST): FEATURE_I
			-- Return selected feature of `Current'.
		require
			has_multiple_features: count > 1
		local
			vmrc2: VMRC2;
			l_implicit_selection: INHERIT_INFO
		do
			from
				start
			until
				after
			loop
				if parents.is_explicitly_selecting (item.internal_a_feature.feature_name_id) then
					if Result = Void then
						Result := item.a_feature
						if item /= first then
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
						-- This routine will be selected.
					l_implicit_selection := item
					if Result = Void and then l_implicit_selection /= first then
							-- Add selected feature to the front of the selection list.
						put_front (l_implicit_selection)
						remove
					else
						forth
					end
				end
			end

			if Result = Void and then count <= 1 then
					-- We have an implicit selection.
				if l_implicit_selection /= Void then
					Result := l_implicit_selection.a_feature
				else
					Result := first.a_feature
				end
			end
			check
				selected_is_first: Result /= Void implies Result = first.a_feature
			end
		end

	one_body_only: BOOLEAN
			-- Is only one body id involved in the selection list?
		require
			not is_empty
		local
			i, l_count: INTEGER
			l_code_id: INTEGER
		do
			Result := True
			l_count := count
			if l_count > 1 then
				from
					l_code_id := first.internal_a_feature.code_id
						-- Go to the second item so we don't compare the code id with itself.
					i := 2
				until
					i > l_count or else not Result
				loop
					Result := l_code_id = i_th (i).internal_a_feature.code_id
					i := i + 1
				end
			end
		end;

	same_parent_type: BOOLEAN
			-- Are all the features coming from the same written type?
		require
			not is_empty;
			one_body_only;
			has_generics: first.internal_a_feature.written_class.generics /= Void;
		local
			instantiator, written_actual_type, l_comparison_type: TYPE_A;
			written_class: CLASS_C;
			written_id: INTEGER;
			i, l_count : INTEGER
		do
			Result := True
			l_count := count
			if l_count > 1 then
				from
						-- Set up the first parent type as the one to compare all other parent types
					written_class := first.internal_a_feature.written_class;
					written_id := written_class.class_id;
					written_actual_type := written_class.actual_type;
					if first.parent /= Void then
						instantiator := first.parent.parent_type
					else
							-- Redeclaration
						instantiator := written_actual_type
					end
					l_comparison_type := written_actual_type.instantiation_in (instantiator, written_id);

						-- Move to the second element in the list.
					i := 2
				until
					i > l_count or else not Result
				loop
					if i_th (i).parent /= Void then
						instantiator := i_th (i).parent.parent_type
					else
							-- Redeclaration
						instantiator := written_actual_type
					end
					Result := l_comparison_type.is_safe_equivalent (
								written_actual_type.instantiation_in (instantiator, written_id)
							)
					i := i + 1
				end;
			end

		end;

	unselect (a_info: INHERIT_INFO; new_t, old_t: FEATURE_TABLE; a_selected_rout_id_set: ROUT_ID_SET)
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
		do
			a_feature := a_info.a_feature
				-- If AST was replicated, we need to preserve the access_in of the inherited routine
				-- since this is where we find the associated AST for `a_feature'. This fixes test#incr295
				-- when compiling in full class checking mode.
			if a_feature.has_replicated_ast then
				id := a_feature.access_in
			else
				id := new_t.feat_tbl_id
			end
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
			rout_id_set.extend (new_rout_id);

			from
				nb := r_id_set.count;
				i := 1;
			until
				i > nb
			loop
				rid := r_id_set.item (i);
				if not a_selected_rout_id_set.has (rid) then
					rout_id_set.extend (rid);
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
				if attached {ATTRIBUTE_I} a_feature as attribute_i then
						-- Set generate_in value of `attribute' to the current class's class id.
						-- (stored as the feature table id in the newly generated feature table)
					attribute_i.set_generate_in (new_t.feat_tbl_id)
				else
					check is_attribute_i: False end
				end
			end

			if a_feature.is_type_evaluation_delayed then
					-- Use post-evaluated types.
				degree_4.put_action (
					agent (destination, source: FEATURE_I)
						do
							destination.set_type (source.type, destination.assigner_name_id)
							destination.set_arguments (source.arguments)
							destination.set_pattern_id (source.pattern_id)
						end
					(a_feature, a_info.internal_a_feature)
				)
			end
				-- Set inheritance info object with unselected info so that this can be
				-- used for replication processing.
			a_info.set_a_feature (a_feature)

				-- Add unselected feature to feature table, replacing the previous one.
			a_feature.set_is_selected (False)
			new_t.replace (a_feature, feature_name_id)

			check
				is_replicated_directly_correctly_set: a_feature.is_replicated_directly implies a_feature.access_class = System.current_class
			end
		end;

feature -- Conceptual Replication

	set_has_replicated_features
			-- Set `has_replicated_features' to True.
		do
			status_flags := status_flags.set_bit_with_mask (True, has_replicated_features_mask)
		end

	has_replicated_features: BOOLEAN
			-- Does `Current' contain directly replicated features?
		do
			Result := status_flags & has_replicated_features_mask = has_replicated_features_mask
		end

	is_less alias "<" (other: SELECTION_LIST): BOOLEAN
			-- Is `other' less than `Current'
		do
			Result := other /= Current
		end

feature -- Removal

	reset
			-- Reset `Current' for reuse.
		do
			wipe_out
			status_flags := 0
		end

feature {NONE} -- Implementation

	status_flags: NATURAL_8
		-- Status flags for `Current'.

	has_replicated_features_mask: NATURAL_8 = 0x1

feature -- Trace

	trace
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
(item.a_feature.written_class.feature_of_body_index
(item.a_feature.body_index).feature_name);
	else
				io.error.put_string ("Dunno");
	end;
				io.error.put_new_line;
end;
				forth;
			end;
		end;
note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
