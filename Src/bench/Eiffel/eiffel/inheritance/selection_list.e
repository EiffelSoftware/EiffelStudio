class SELECTION_LIST 
	
inherit

	SORTED_TWO_WAY_LIST [INHERIT_INFO];
	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;
	SHARED_SELECTED;
	SHARED_ORIGIN_TABLE

creation

	make
	
feature 

	selection (parents: PARENT_LIST; old_t, new_t: FEATURE_TABLE): FEATURE_I is
			-- Feautre selected in the list.
		require
			not empty;
		local
			a_feature, old_feature: FEATURE_I;
			rout_id_set: ROUT_ID_SET;
			new_rout_id: INTEGER;
			feat_table: SELECT_TABLE;
			first_feature: FEATURE_I;
			stop: BOOLEAN;
			id, first_body_id: INTEGER;
		do
			first_feature := first.a_feature;
			if 	one_body_only
				and then
				(	first_feature.written_class.generics = Void
					or else
					same_parent_type
				)
			then
				Result := first_feature;
			else
					-- Look for a valid selection
				Result := parent_selection (parents);

				if Result /= Void then
						-- Keep track of the selection
					Selected.start;
					Selected.put_right (Result.feature_name);
					from
                        start;
                        feat_table := Origin_table.computed;
                    until
                        empty
                    loop
                        unselect (new_t, old_t, feat_table);
                    end;
					Result.set_is_selected (True);
				end;
			end;
		end;

	Routine_id_counter: COUNTER is
			-- Routine id counter
		once
			Result := System.routine_id_counter;
		end;

	parent_selection (parents: PARENT_LIST): FEATURE_I is
			-- Manual selected feature
		require
			not empty
		local
			feature_i: FEATURE_I;
			vmrc2: VMRC2;
		do
			from
				start
			until
				offright or else Result /= Void
			loop
				feature_i := item.a_feature;
				if parents.is_selecting (feature_i.feature_name) then
					Result := feature_i;
				end;
				forth;
			end;
			if Result /= Void then
					-- Check if there is no second selection
				from
					back;
						-- Remove result information
					remove;
				until
					offright
				loop
					feature_i := item.a_feature;
					if parents.is_selecting (feature_i.feature_name) then
						!!vmrc2;
						vmrc2.set_class_id (System.current_class.id);
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
			not empty
		do
			Result := 	first.a_feature.code_id
						= 
						last.a_feature.code_id;
		end;

	same_parent_type: BOOLEAN is
			-- Are all the feature comming form the same written type ?
		require
			not empty;
			one_body_only;
			has_generics: first.a_feature.written_class.generics /= Void;
		local
			instantiator, written_actual_type, written_type, to_compair: TYPE_A;
			written_class: CLASS_C;
			written_id, pos: INTEGER;
			info: INHERIT_INFO;
		do
			pos := position;
			from
				info := first;
				Result := True;
				written_class := info.a_feature.written_class;
				written_id := written_class.id;
				written_actual_type := written_class.actual_type;
				to_compair := written_actual_type.duplicate;
				if info.parent = Void then
						-- Redeclaration
					instantiator := written_actual_type;
				else
					instantiator := info.parent.parent_type;
				end;
				to_compair := to_compair.instantiation_in
													(instantiator, written_id);
				go (2);
			until
				offright or else not Result
			loop
				written_type := written_actual_type.duplicate;
				info := item;
				if info.parent = Void then
						-- Redeclaration
                    instantiator := written_actual_type;
                else
                    instantiator := info.parent.parent_type;
                end;
				written_type := written_type.instantiation_in
													(instantiator, written_id);
				Result := deep_equal (to_compair, written_type);
				forth;
			end;
			go (pos);
		end;
	
	unselect (new_t, old_t: FEATURE_TABLE; select_table: SELECT_TABLE) is
			-- Process first unselected feature
		require
			good_arguments: not (new_t = Void or old_t = Void);
			not_off: not off
		local
			info: INHERIT_INFO;
			a_feature, old_feature: FEATURE_I;
			info_parent: PARENT_C;
			rout_id_set: ROUT_ID_SET;
			cond, in_generic_class: BOOLEAN;
			first_body_id, new_rout_id, written_id, id: INTEGER;
			instantiator, to_compair, written_type, written_actual_type: TYPE_A;
			written_class: CLASS_C;
			feature_name: STRING;
			old_pos: INTEGER
		do		
			id := new_t.feat_tbl_id;
			info := first;
			a_feature := info.a_feature;
			first_body_id := a_feature.body_id;
				-- New unselected feature
			a_feature := a_feature.unselected (id);
				-- Process new routine id set
			!!rout_id_set.make (1);
			feature_name := a_feature.feature_name;	
			old_feature := old_t.item (feature_name);
				-- Process a new routine id
			if 	old_feature /= Void and then
				old_feature.is_unselected and old_feature.access_in = id
			then
					-- Take an old one
				new_rout_id := old_feature.rout_id_set.first;
			else
					-- Take a new one
				new_rout_id := a_feature.new_rout_id;
			end;
			rout_id_set.put (new_rout_id);
			if new_rout_id < 0 then
					-- Attribute routine id
				new_rout_id := - new_rout_id;
			end;
				-- Insertion into thwe routine info table
			System.rout_info_table.put (new_rout_id, System.current_class);	
			a_feature.set_rout_id_set (rout_id_set);
			a_feature.set_is_selected (False);
			a_feature.set_is_origin (True);
			select_table.put (a_feature, new_rout_id);
			new_t.replace (a_feature, feature_name);

				-- Remove unselection
			remove;

			if not offright then
				written_class := a_feature.written_class;
				in_generic_class := written_class.generics /= Void;
				if in_generic_class then
						-- Prepare an instantiated type
					written_id := written_class.id;
					written_actual_type := written_class.actual_type;
					info_parent := info.parent;
					to_compair := written_actual_type.duplicate;
					if info_parent = Void then
						instantiator := written_actual_type;
					else
						instantiator := info_parent.parent_type;
					end;
					to_compair := to_compair.instantiation_in
													(instantiator, written_id);
				end;
			end;
			
			from
				old_pos := position
			until
				offright
			loop
				info := item;
				a_feature := info.a_feature;
					-- First condition for unselection: same body id
				cond := a_feature.body_id = first_body_id;
				if cond and then in_generic_class then
						-- Second condition if written in a generic class: same
						-- instantiated written actual type.
					info_parent := info.parent;
					if info_parent = Void then
                        instantiator := written_actual_type;
                    else
                        instantiator := info_parent.parent_type;
                    end;
					written_type := written_actual_type.duplicate;
					written_type := written_type.instantiation_in
													(instantiator, written_id);
					cond := to_compair.same_as (written_type);
				end;
				if cond then
					a_feature := a_feature.unselected (id);	
					a_feature.set_is_selected (False);
					a_feature.set_is_origin (True);
					a_feature.set_rout_id_set (rout_id_set.duplicate);
					new_t.replace (a_feature, a_feature.feature_name);
					remove
				else
					forth
				end
			end;
			go (old_pos)
		end;

	trace is
			-- Debug purpose
		do
			from
				start
			until
				offright
			loop
				if item.parent = Void then
					io.error.putstring ("VOID");
				else
					io.error.putstring (item.parent.class_name);
				end;
				io.error.putstring (": ");
				io.error.putstring (item.a_feature.feature_name);
				io.error.putchar (' ');
				item.a_feature.rout_id_set.trace;
				io.error.putstring (" {body_id = ");
				io.error.putint (item.a_feature.body_id);
				io.error.putstring ("}%N");
				forth;
			end;
		end;

end
