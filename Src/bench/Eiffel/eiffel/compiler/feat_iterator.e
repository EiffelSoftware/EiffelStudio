
-- Iterator on features

deferred class FEAT_ITERATOR

inherit

	SHARED_SERVER;
	COMPILER_EXPORTER

feature

	used_table: ARRAY [ROUT_ID_SET];
			-- Table of used body ids

	make is
			-- Initialization
		do
			!!used_table.make (1, System.body_id_counter.value);
		end;

feature {NONE}

	mark (f: FEATURE_I; static_class: CLASS_C; rout_id_val: ROUTINE_ID) is
			-- Mark feature and its redefinitions
		require
			not_is_attribute: not f.is_attribute;
			rout_id_not_void: rout_id_val /= Void
		local
			other_body_id: INTEGER;
			descendant_class: CLASS_C;
			descendant_feature: FEATURE_I;
			des_feat_table: FEATURE_TABLE;
			des_orig_table: SELECT_TABLE;
			table: ROUT_UNIT_TABLE;
			c: CURSOR;
			body_table: BODY_INDEX_TABLE;
			unit: ROUT_UNIT;
			redef_unit: TRAVERSAL_UNIT;
--			assert_id_set: ASSERT_ID_SET;
			inh_assert: INH_ASSERT_INFO;
			i, nb: INTEGER;
			ancestor_feature: FEATURE_I;
			written_class, ancestor_class: CLASS_C;
		do
			mark_and_record (f, static_class, rout_id_val);

			check
				(not Tmp_poly_server.has (rout_id_val.id)) implies f.is_deferred;
					-- Case for an non existing routine table: a deferred
					-- feature without any implementation in descendant classes
					-- leads to NO routine table.
			end;

-- FIXME
-- If the assertions are on for at least a class in the system,
-- The dead code removal is turned off

--			if f.assert_id_set /= Void then
--				-- The routine has chained assertions.
--				-- mark all the previous definitions with assertions
--				-- as used.
--				from
--					assert_id_set := f.assert_id_set;
--					i := 1;
--					nb := assert_id_set.count
--				until
--					i > nb
--				loop
--					inh_assert := assert_id_set.item (i);
--					if inh_assert.has_assertion then
--						ancestor_class := System.class_of_id (inh_assert.written_in);
--						ancestor_feature := ancestor_class.feature_table.feature_of_rout_id
--														(f.rout_id_set);
--						mark_and_record (ancestor_feature, ancestor_class);
--					end;
--					i := i + 1;
--				end;
--			end;

			if Tmp_poly_server.has (rout_id_val.id) then
					-- If routine id available: this is not a deferred feature
					-- without any implementation
				written_class := f.written_class;
				table ?= Tmp_poly_server.item (rout_id_val.id);
				check
					table_exists: table /= Void;
				end;
				from
					body_table := System.body_index_table;
					table.start
				until
					table.after
				loop
					unit := table.item;
					if System.class_of_id (unit.id).conform_to (written_class) then
						c := table.cursor;
						other_body_id := body_table.item (unit.body_index);
						if not bid_rid_is_marked (other_body_id, rout_id_val) then
							descendant_class := System.class_of_id (unit.id);
							des_feat_table := descendant_class.feature_table;
							des_orig_table := des_feat_table.origin_table;
							descendant_feature := des_orig_table.item(rout_id_val);
							if not  (descendant_feature.is_none_attribute
									or else
									descendant_class.is_basic)
							then
								if descendant_feature.is_attribute then
									mark_alive (descendant_feature, rout_id_val);
								else
									mark
										(descendant_feature, descendant_class, rout_id_val);
								end;
							end;
						end;
						table.go_to (c);
					end;
					table.forth
				end;
			end;
		end;

	mark_and_record (feat: FEATURE_I; actual_class: CLASS_C; rout_id_val: ROUTINE_ID) is
			-- Mark feature `feat' alive.
		require
			feat_exists: feat /= Void;
			actual_class_exists: actual_class /= Void;
			consistency: actual_class.conform_to (feat.written_class);
			rout_id_not_void: rout_id_val /= Void
		local
			depend_list: FEATURE_DEPENDANCE;
			original_feature: FEATURE_I;
			written_class: CLASS_C;
			just_born: BOOLEAN;
		do
			just_born := not is_alive (feat);
				-- Mark feature alive
			mark_alive (feat, rout_id_val);

			if just_born then

					-- Take care of dependances
				written_class := feat.written_class;
				if actual_class = written_class then
					original_feature := feat;
				else
					original_feature :=
						written_class.feature_table.feature_of_body_id
																(feat.body_id);
					check
						original_feature_exists: original_feature /= Void
					end;
				end;
debug ("MARKING")
    io.error.putstring (original_feature.feature_name);
    io.error.putstring (" from ");
    io.error.putstring (actual_class.class_name);
    io.error.putstring (" written in ");
    io.error.putstring (written_class.class_name);
    io.error.new_line;
end;
				depend_list := Depend_server.item (written_class.id.id).item
									(original_feature.feature_name);
				if depend_list /= Void then
					propagate_feature (written_class, original_feature, depend_list);
				end;
			end;
		end;

	propagate_feature (a_class: CLASS_C; a_feature: FEATURE_I; dep: FEATURE_DEPENDANCE) is
		deferred
		end

	mark_alive (feat: FEATURE_I; rout_id_val: ROUTINE_ID) is
			-- Record feature `feat'
		require
			good_argument: feat /= Void;
			rout_id_not_void: rout_id_val /= Void
		local
			class_name: STRING;
			temp: ROUT_ID_SET
		do
debug ("MARKING")
				-- Verbose
			io.error.putstring ("%TMarking ");
			io.error.putstring (feat.feature_name);
			io.error.putstring (" from ");
			class_name := clone (feat.written_class.class_name)
			class_name.to_upper;
			io.error.putstring (class_name);
			io.error.new_line;
end;
			temp := used_table.item (feat.body_id);
			if (temp = Void) then
				!! temp.make (1);
				used_table.put (temp, feat.body_id);
			end;
			temp.force (rout_id_val);
		end;

feature

	is_marked (feat: FEATURE_I): BOOLEAN is
		require
			good_argument: feat /= Void
		local
			temp: ROUT_ID_SET
		do
			temp := used_table.item (feat.body_id);
			Result := (temp /= Void) and then
				temp.has (feat.rout_id_set.first)
		end;

	bid_rid_is_marked (bid: INTEGER; rid: ROUTINE_ID): BOOLEAN is
		require
			rid_not_void: rid /= Void
		local
			temp: ROUT_ID_SET
		do
			temp := used_table.item (bid);
			Result := (temp /= Void) and then
				temp.has (rid)
		end;

	is_alive (feat: FEATURE_I): BOOLEAN is
			-- Is the feature `feat' already recorded ?
		require
			good_argument: feat /= Void
		do
			Result := is_body_alive (feat.body_id)
		end;

	is_body_alive (body_id: INTEGER): BOOLEAN is
			-- Is the body id recorded in the `used_table' ?
		do
			Result := (used_table.item (body_id) /= Void)
		end;

feature -- DLE

	was_alive (feat: FEATURE_I): BOOLEAN is
			-- Was the feature `feat' already recorded in
			-- the static system?
		require
			dynamic_system: System.is_dynamic;
			final_mode: System.in_final_mode;
			feat_exists: feat /= Void
		do
			Result := was_body_alive (feat.body_id)
		end;

	was_body_alive (body_id: INTEGER): BOOLEAN is
			-- Was the body id recorded in the `used_table' of
			-- the static system?
		require
			dynamic_system: System.is_dynamic;
			final_mode: System.in_final_mode
		local
			old_body_id: INTEGER
		do
			old_body_id := System.dle_finalized_nobid_table.item (body_id);
			Result := used_table.valid_index (old_body_id) and then
				used_table.item (old_body_id) /= Void
		end;

end
