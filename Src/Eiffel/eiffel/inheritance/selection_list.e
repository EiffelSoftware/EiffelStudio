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

	selection (parents: PARENT_LIST; old_t, new_t: FEATURE_TABLE): FEATURE_I is
			-- Feautre selected in the list.
		require
			not is_empty
		local
			first_feature	: FEATURE_I
		do
			selected_rout_id_set := Void
			if count > 1 then
				detect_replication (parents, new_t)
			end
			first_feature := first.a_feature
			if
				one_body_only and then
				(first_feature.written_class.generics = Void or else same_parent_type)
			then
				Result := first_feature;
			else
					-- Look for a valid selection
				Result := parent_selection (parents);

				if Result /= Void then
					selected_rout_id_set := Result.rout_id_set.twin

						-- Keep track of the selection
					Selected.put_front (Result.feature_name_id);
					from
						start
					until
						is_empty
					loop
						unselect (new_t, old_t);
					end;
						--| Merge routine ids from unselected features
					Result.set_is_selected (True);
debug ("REPLICATION", "ACTUAL_REPLICATION")
	io.error.put_string ("Selected feature is: ");
	io.error.put_string (Result.feature_name);
	io.error.put_string (Result.generator);
	io.error.put_new_line;
end;
				end;
			end;
			selected_rout_id_set := Void;
		end;

	Routine_id_counter: ROUTINE_COUNTER is
			-- Routine id counter
		once
			Result := System.routine_id_counter;
		end;

	parent_selection (parents: PARENT_LIST): FEATURE_I is
			-- Manual selected feature
		require
			not is_empty
		local
			feature_i: FEATURE_I;
			vmrc2: VMRC2;
		do
			from
				start
			until
				after or else Result /= Void
			loop
				feature_i := item.a_feature;
				if parents.is_selecting (feature_i.feature_name_id) then
					Result := feature_i;
				else
					forth;
				end;
			end;
			if Result /= Void then
					-- Check if there is no second selection
				from
						-- Remove result information
					remove;
				until
					after
				loop
					feature_i := item.a_feature;
					if parents.is_selecting (feature_i.feature_name_id) then
						create vmrc2;
						vmrc2.set_class (System.current_class);
						vmrc2.init (Result, feature_i);
						Error_handler.insert_error (vmrc2);
					end;

					forth
				end;
			end;
		end;

	one_body_only: BOOLEAN is
			-- Is only one body id invloved in the selection list ?
		require
			not is_empty
		local
			l_cursor: like cursor
			l_code: INTEGER
		do
			Result := True
			if count > 1 then
				l_cursor := cursor
				from
					start
					l_code := first.a_feature.code_id
				until
					after or not Result
				loop
					Result := l_code = item.a_feature.code_id
					forth
				end
				go_to (l_cursor)
			end
		end;

	same_parent_type: BOOLEAN is
			-- Are all the feature comming form the same written type ?
		require
			not is_empty;
			one_body_only;
			has_generics: first.a_feature.written_class.generics /= Void;
		local
			instantiator, written_actual_type, written_type, to_compair: TYPE_A;
			written_class: CLASS_C;
			written_id: INTEGER;
			old_cursor: CURSOR;
			info: INHERIT_INFO;
		do
			old_cursor := cursor;
			from
				info := first;
				Result := True;
				written_class := info.a_feature.written_class;
				written_id := written_class.class_id;
				written_actual_type := written_class.actual_type;
				to_compair := written_actual_type.duplicate;
				if info.parent = Void then
						-- Redeclaration
					instantiator := written_actual_type;
				else
					instantiator := info.parent.parent_type;
				end;
				to_compair := to_compair.instantiation_in (instantiator, written_id);
				go_i_th (2);
			until
				after or else not Result
			loop
				written_type := written_actual_type.duplicate;
				info := item;
				if info.parent = Void then
						-- Redeclaration
					instantiator := written_actual_type;
				else
					instantiator := info.parent.parent_type;
				end;
				written_type := written_type.instantiation_in (instantiator, written_id);
				Result := written_type.is_safe_equivalent (to_compair);
				forth;
			end;
			go_to (old_cursor);
		end;

	unselect (new_t, old_t: FEATURE_TABLE) is
			-- Process first unselected feature
		require
			good_arguments: new_t /= Void and old_t /= Void
			not_off: not off
		local
			info			: INHERIT_INFO
			a_feature		: FEATURE_I
			old_feature		: FEATURE_I
			info_parent		: PARENT_C
			rout_id_set		: ROUT_ID_SET
			in_generic_class: BOOLEAN
			first_body_index: INTEGER
			written_id		: INTEGER
			id				: INTEGER
			instantiator	: TYPE_A
			to_compair		: TYPE_A
			written_actual_type: TYPE_A
			written_class	: CLASS_C
			feature_name_id	: INTEGER
			r_id_set		: ROUT_ID_SET
			i				: INTEGER
			nb				: INTEGER
			new_rout_id		: INTEGER
			rid				: INTEGER
			attribute_i: ATTRIBUTE_I
		do
			id := new_t.feat_tbl_id;
			info := first;
			a_feature := info.a_feature;
			first_body_index := a_feature.body_index;
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
			if 	old_feature /= Void and then
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
			a_feature.set_is_selected (False);
			a_feature.set_is_origin (True);
			attribute_i ?= a_feature
			if attribute_i /= Void and then attribute_i.type.is_formal then
					-- A wrapper has to be generated.
				attribute_i.set_generate_in (system.current_class.class_id)
			end
			new_t.replace (a_feature, feature_name_id);

				-- Remove unselection
			remove;

			if not after then
				written_class := a_feature.written_class;
				in_generic_class := written_class.generics /= Void;
				if in_generic_class then
						-- Prepare an instantiated type
					written_id := written_class.class_id;
					written_actual_type := written_class.actual_type;
					info_parent := info.parent;
					to_compair := written_actual_type.duplicate;
					if info_parent = Void then
						instantiator := written_actual_type;
					else
						instantiator := info_parent.parent_type;
					end;
					to_compair := to_compair.instantiation_in (instantiator, written_id);
				end;
			end;
		end;

feature -- Conceptual Replication

	detect_replication (parent_list: PARENT_LIST; new_t: FEATURE_TABLE) is
			-- Detect conceptual replication. The only routines left under the
			-- same routine_id will have different feature names. Hence, all
			-- these features will be replicated.
		require
			require_replication: count > 1
		local
			curr_feat: FEATURE_I
			replication: FEATURE_I
			inh_info: INHERIT_INFO
		do
			from
				start
			until
				after
			loop
				inh_info := item
				curr_feat := item.a_feature
				replication := curr_feat.replicated
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
