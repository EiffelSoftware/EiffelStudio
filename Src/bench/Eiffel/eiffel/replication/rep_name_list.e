-- List of rep_name. It is sorted for efficiency (for process_replicated
-- INHERIT_TABLE). This records a list REP_NAME for a given parent clause.
-- This class updates the new_feature and old_feature attributes of 
-- REP_NAME. This class also records the dependency between the origin
-- and the replicated routines.
class REP_NAME_LIST

inherit

	SORTED_TWO_WAY_LIST [REP_NAME]
		rename
			make as old_make
		end
	SHARED_SERVER
		undefine
			is_equal
		end

	SHARED_WORKBENCH
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

creation

	make

feature

	parent_clause: PARENT_C;
			-- Parent clause where replication took place

	make (p: PARENT_C) is
			-- Make current with parent `p'.
		do
			parent_clause := p
		end;

	has_feature_name (f_name: STRING): BOOLEAN is
			-- Does `f_name' exists in rep_name in Current? 
		local
			name: STRING
		do
			from
				start
			until
				after or else Result
			loop
				if item.old_feature /= Void then
					name := item.old_feature.feature_name;
					Result := name.is_equal (f_name);
				end;
				if not Result then
					forth
				end;
			end;
		end;

	has_parent_clause (p: PARENT_C): BOOLEAN is
			-- Is parent_clause equal to `p'?
		do
			Result := (parent_clause = p)
		end;

	has_calls (c_list: CALLS_LIST): BOOLEAN is
			-- Does Current have any calls found
			-- in`c_list'? (Do not move cursor position)
		local
			cur: CURSOR;
			f_name: STRING;
			not_selected: BOOLEAN;
			old_feat: FEATURE_I;
			new_feat: FEATURE_I;
				-- Replicated feature
		do
debug ("HAS_CALLS")
			io.error.putstring ("in has calls %N ");
end;
			cur := cursor;
			from
				start;
			until
				after or else Result
			loop
				old_feat := item.old_feature;
				new_feat := item.new_feature;
				if old_feat /= Void then
					f_name := old_feat.feature_name;
					not_selected := not_selected or else 
							not new_feat.is_selected;
debug ("HAS_CALLS")
					io.error.putstring ("feature name ");
					io.error.putstring (f_name);
					io.error.putstring (" selected: ");
					io.error.putbool (new_feat.is_selected);
					io.error.putstring (" ");
					io.error.putstring (new_feat.generator);
					io.error.new_line;
end;
					Result := c_list.has_equal (f_name) and then
								not_selected; 
				end;
				forth
			end;
			go_to (cur)
		end;

	update_new_features (f_table: FEATURE_TABLE;
						orig_written_in: INTEGER) is
			-- Update Current list using f_table. (update
			-- the new feature attribute of rep_name); 
			-- Record the dependencies between the origin (old_feature)
			-- and the replicated routine (new_feature).
		local
			old_feat, new_feat: FEATURE_I;
			cur: CURSOR;
			old_name, new_name: STRING;
			dependencies: REP_CLASS_DEPEND;
			feat_dependence: REP_FEATURE_DEPEND;
			depend_unit: REP_DEPEND_UNIT;
			written_in: INTEGER;
		do
debug ("REPLICATION")
	--io.error.putstring ("in update new features%N");
end;
			written_in := f_table.feat_tbl_id;
			if Tmp_rep_depend_server.has (orig_written_in) then
				dependencies := Tmp_rep_depend_server.item (orig_written_in);
			elseif Rep_depend_server.server_has (orig_written_in) then
				dependencies := Rep_depend_server.server_item (orig_written_in);
			else
				!!dependencies.make (2);
				dependencies.set_class_id (orig_written_in);
			end;
			cur := cursor;
			from
				start
			until
				after
			loop
				new_feat := f_table.item (item.rep_feature.feature_name);
debug ("REPLICATION")
	--io.error.putstring ("retrieving new feature: ");
	--io.error.putstring (new_feat.feature_name);
	--io.error.putstring (" ");
	--io.error.putstring (new_feat.generator);
	--io.error.new_line;
end;
				item.set_new_feature (new_feat);
				old_feat := item.old_feature;
				if 
					old_feat /= Void and then
					not old_feat.is_deferred and then
					old_feat.written_in = orig_written_in
				then
debug ("REPLICATION")
	--io.error.putstring ("%Tcreating rep depend unit for: ");
	--io.error.putstring (old_feat.feature_name);
	--io.error.putstring ("%N in class: ");
	--io.error.putstring (System.class_of_id (orig_written_in).name);
	--io.error.new_line;
end;
					old_name := old_feat.feature_name;
					new_name := new_feat.feature_name;
					!!depend_unit.make (written_in, new_name,
										clone (new_feat.rout_id_set));
					feat_dependence := dependencies.item (old_name);
					if feat_dependence = Void then
						!!feat_dependence.make;
						dependencies.put (feat_dependence, old_name);
					end;
					feat_dependence.put_front (depend_unit);
				end;
				forth
			end;
			if 
				feat_dependence /= Void and then 
				feat_dependence.count > 0
			then
				Tmp_rep_depend_server.put (dependencies)
			end;
			go_to (cur)	
		end;

	update_old_features (f_table: FEATURE_TABLE;
						orig_written_in: INTEGER) is
			-- Update old features of Current list.
		require
			not_empty: not is_empty
		local
			cur: CURSOR;
			old_feat: FEATURE_I;
		do
			cur := cursor;
debug ("REPLICATION")
	io.error.putstring ("update old features%N");
	io.error.putstring ("feature name: ");
	io.error.putstring (item.rep_feature.feature_name);
	io.error.putstring (item.rep_feature.generator);
	io.error.putstring ("written in: ");
	io.error.putstring (item.rep_feature.written_class.name);
	io.error.new_line;
end;
			from
				start
			until
				after
			loop
---!!!!!! Need to loop through all routine ids
				old_feat := old_feature_from_table (item.rep_feature,
									orig_written_in);
debug ("REPLICATION")
	io.error.putstring ("rep feat: ");
	io.error.putstring (item.rep_feature.feature_name);
	io.error.putstring (" ");
	io.error.putstring ("old feat: ");
				if old_feat = Void then
	io.error.putstring (" Void" );
				else
	io.error.putstring (old_feat.feature_name);
				end;
	io.error.new_line;
end;
				item.set_old_feature (old_feat);
				forth
			end;
				
			go_to (cur)
		end;

	old_feature_from_table (rep_feat: FEATURE_I; 
							written_in: INTEGER): FEATURE_I is
			-- Feature in `written_in' using rep_feat routine id
			-- set.
		local
			s_table: SELECT_TABLE;
			rout_id_set: ROUT_ID_SET;
			i: INTEGER;
			rout_id: INTEGER;
		do
			s_table := Feat_tbl_server.item (written_in).origin_table;
			rout_id_set := rep_feat.rout_id_set;
			from
				count := rout_id_set.count;
				i := 1;
			until
				i > count or else Result /= Void	
			loop
				rout_id := rout_id_set.item (i);
				Result := s_table.item (rout_id);
				i := i + 1;
			end;
		end;

end

