class ORIGIN_TABLE 

inherit

	EXTEND_TABLE [SELECTION_LIST, INTEGER];
	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			twin
		end;
	SHARED_ERROR_HANDLER
		export
			{NONE} all
		undefine
			twin
		end;


creation

	make
	
feature 

	insert (info: INHERIT_INFO) is
			-- Insert information `info' in the table.
		require
			good_argument: info /= Void;
			good_context: not (	info.a_feature = Void
								or else
								info.a_feature.rout_id_set = Void);
		local
			rout_id_set: ROUT_ID_SET;
			i, nb, rout_id: INTEGER;
			l: SELECTION_LIST;
		do
			from
				rout_id_set := info.a_feature.rout_id_set;
				nb := rout_id_set.count;
				i := 1;
			until
				i > nb
			loop
				rout_id := rout_id_set.item (i);
				if rout_id < 0 then
					rout_id := - rout_id;
				end;
				l := item (rout_id);
				if l = Void then
					!!l.make;
					put (l, rout_id);
				end;
				l.add (info);

				i := i + 1;
			end;
		end;

	delete (info: INHERIT_INFO) is
			-- Insert information `info' in the table.
		require
			good_argument: info /= Void;
			good_context: not	(	info.a_feature = Void
									or else
									info.a_feature.rout_id_set = Void);
		local
			rout_id_set: ROUT_ID_SET;
			i, nb, rout_id: INTEGER;
			l: SELECTION_LIST;
		do
			from
				rout_id_set := info.a_feature.rout_id_set;
				nb := rout_id_set.count;
				i := 1;
			until
				i > nb
			loop
				rout_id := rout_id_set.item (i);
				if rout_id < 0 then
					rout_id := - rout_id;
				end;
				l := item (rout_id);
				l.start;
				l.search_same (info);
				check
					not l.after
				end;
				l.remove;

				i := i + 1;
			end;
		end;
				
	compute_feature_table (parents: PARENT_LIST; old_t, new_t: FEATURE_TABLE) is
			-- Origin table for instance of FEATURE_TABLE resulting
			-- of an analysis of possible repeated inheritance
		local
			rout_id: INTEGER;
			selected: FEATURE_I;
			vmrc3: VMRC3;
		do
			from
				!!computed.make (count);
				start;
			until
				after
			loop
				rout_id := key_for_iteration;
				selected := item_for_iteration.selection
												(parents, old_t, new_t);
				if selected = Void then
						-- No selected feature
					!!vmrc3;
					vmrc3.set_class (System.current_class);
					vmrc3.set_selection_list (item_for_iteration);
					Error_handler.insert_error (vmrc3);
				else
					computed.put (selected, key_for_iteration);
				end;
				forth;
			end;
		end;

	computed: SELECT_TABLE;
				-- Feature table computed by `compute_feature_table'.
		
-- Selection: if all the parents in the informations are all the same, then
-- a selection is not needed if either all the body id's are the same or
-- one of them is selected. If there are differrent parent, a selection is
-- not needed if all the body ids are the same.

end
