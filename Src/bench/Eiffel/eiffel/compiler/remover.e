
-- Dead code removal

class REMOVER

inherit

	SHARED_SERVER;
	SHARED_OPTIMIZATION_TABLES

creation

	make

feature

	used_table: ARRAY [ROUT_ID_SET];
			-- Table of used body ids

	make is
			-- Initialization
		do
			!!control.make;
			!!used_table.make (1, System.body_id_counter.value);

			array_optimization_level := System.array_optimization_level
		end;

feature

	record (feat: FEATURE_I; in_class: CLASS_C) is
			-- Record Eiffel routines reachable by feature `feat' from
			-- static type `in_class'.
		do
			iterate (feat, in_class)
		end;

feature -- Array optimization

	array_optimization_level: INTEGER

	record_array_descendants is
		local
			array_class: CLASS_C;
		do
			array_class := System.array_class.compiled_class;
			!!array_descendants.make;
			!!array_descendant_ids.make;
			array_descendant_ids.compare_objects;
			!!put_feat_ids.make (10);
			!!item_feat_ids.make (10);

			record_descendants (array_class);
		end;

feature {NONE} -- Array optimization

	array_descendants: LINKED_LIST [CLASS_C];
			-- Descendants of ARRAY

	array_descendant_ids: TWO_WAY_SORTED_SET [INTEGER];
			-- `id' of all the descendants of ARRAY

	put_feat_ids: HASH_TABLE [INTEGER, INTEGER];
			-- `feature_id' of `put' for all the descendants of ARRAY

	item_feat_ids: HASH_TABLE [INTEGER, INTEGER];
			-- `feature_id' of `item' for all the descendants of ARRAY

	record_descendants (a_class: CLASS_C) is
			-- Recursively records `a_class' and its descendants in `descendants'
		local
			d: LINKED_LIST [CLASS_C];
			an_id: INTEGER;
			ftable: FEATURE_TABLE;
			put, item: FEATURE_I;
		do
			if not array_descendants.has (a_class) then
debug ("OPTIMIZATION")
	io.error.putstring ("Adding ");
	io.error.putstring (a_class.class_name);
	io.error.putstring (" as a descendant of ARRAY%N");
end;
				array_descendants.extend (a_class);
				an_id := a_class.id;
				array_descendant_ids.force (an_id);
				ftable := a_class.feature_table;
				put := ftable.item ("put");
				put_feat_ids.force (put.feature_id, an_id);
				item := ftable.item ("item");
				item_feat_ids.force (item.feature_id, an_id);
				from
					d := a_class.descendants;
					d.start
				until
					d.after
				loop
					record_descendants (d.item);
					d.forth
				end;
			end;
		end;

feature {NONE}

	control: LINKED_QUEUE [TRAVERSAL_UNIT];
			-- Control structure for traversal in breadth first order

	iterate (feat: FEATURE_I; a_class: CLASS_C) is
			--  Mark feature `feat' and dependends alive.
		require
			good_argument: feat /= Void and a_class /= Void;
			control_empty: control.empty
		local
			next: FEATURE_I;
			traversal_unit: TRAVERSAL_UNIT;
			a_feature: FEATURE_I;
		do
			from
				!!traversal_unit.make (feat, a_class);
				control.extend (traversal_unit)
			until
				control.empty
			loop
				traversal_unit := control.item;
				next := traversal_unit.a_feature;
				if not (next.is_attribute or else is_marked (next)) then
					mark (traversal_unit)
				end;
				control.remove
			end;
		ensure
			control_empty: control.empty
		end;

	mark (traversal_unit: TRAVERSAL_UNIT) is
			-- Mark feature and its redefinitions
		require
			good_argument: traversal_unit /= Void;
			not_is_attribute: not traversal_unit.a_feature.is_attribute;
		local
			rout_id_val, other_body_id: INTEGER;
			descendant_class, static_class: CLASS_C;
			f, descendant_feature: FEATURE_I;
			des_feat_table: FEATURE_TABLE;
			des_orig_table: SELECT_TABLE;
			table: ROUT_UNIT_TABLE;
			body_table: BODY_INDEX_TABLE;
			unit: ROUT_UNIT;
			redef_unit: TRAVERSAL_UNIT;
--			assert_id_set: ASSERT_ID_SET;
			inh_assert: INH_ASSERT_INFO;
			i, nb: INTEGER;
			ancestor_feature: FEATURE_I;
			written_class, ancestor_class: CLASS_C;
		do
			f := traversal_unit.a_feature;
			static_class := traversal_unit.static_class;
			mark_and_record (f, static_class);

			rout_id_val := f.rout_id_set.first;

			check
				(not Tmp_poly_server.has (rout_id_val)) implies f.is_deferred;
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

			if Tmp_poly_server.has (rout_id_val) then
					-- If routine id available: this is not a deferred feature
					-- without any implementation
				written_class := f.written_class;
				table ?= Tmp_poly_server.item (rout_id_val);
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
									mark_alive (descendant_feature);
								else
									mark_and_record
										(descendant_feature, descendant_class);
								end;
							end;
						end;
					end;
					table.forth
				end;
			end;
		end;

	mark_and_record (feat: FEATURE_I; actual_class: CLASS_C) is
			-- Mark feature `feat' alive.
		require
			feat_exists: feat /= Void;
			actual_class_exists: actual_class /= Void;
			consistency: actual_class.conform_to (feat.written_class);
		local
			class_depend: CLASS_DEPENDANCE;
			depend_list: FEATURE_DEPENDANCE;
			feature_table: FEATURE_TABLE;
			depend_unit: DEPEND_UNIT;
			depend_feature, original_feature: FEATURE_I;
			unit_to_traverse: TRAVERSAL_UNIT;
			static_class, written_class: CLASS_C;
			feature_name: STRING;
			just_born: BOOLEAN;
			opt_unit: OPTIMIZE_UNIT;
			body: FEATURE_AS;
			byte_code: BYTE_CODE;
		do
			just_born := not is_alive (feat);
				-- Mark feature alive
			mark_alive (feat);

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
				feature_name := original_feature.feature_name;
				class_depend := Depend_server.item (written_class.id);
debug ("DEAD_CODE_REMOVAL")
    io.error.putstring (feature_name);
    io.error.putstring (" from ");
    io.error.putstring (written_class.class_name);
    io.error.new_line;
end;
				if class_depend.has (feature_name) then
					from
						depend_list := class_depend.item (feature_name);
						depend_list.start
					until
						depend_list.after
					loop
						depend_unit := depend_list.item;
						if not depend_unit.is_special then
							static_class := System.class_of_id (depend_unit.id);
							feature_table := static_class.feature_table;
							depend_feature := feature_table.feature_of_feature_id
														(depend_unit.feature_id);
							if not is_marked (depend_feature) then
debug ("DEAD_CODE_REMOVAL")
	io.error.putstring ("Propagated to ");
	io.error.putstring (depend_feature.feature_name);
	io.error.putstring (" from ");
	io.error.putstring (static_class.class_name);
	io.error.new_line;
end;
								!!unit_to_traverse.make (depend_feature, static_class);
								control.extend (unit_to_traverse);
							end;
						end;
						depend_list.forth
					end;

						-- Array optimization
					if array_optimization_level > 0 then
						!!opt_unit.make (written_class.id, original_feature.body_index);
						if
								-- The feature was marked during the type check
								-- and hasn't been processed yet
							optimization_tables.feature_set.has (opt_unit)
						and then
							not optimized_features.has (opt_unit)
						then
								-- See if the routine really has a loop
								-- (incrementality can mess up everything) and
								-- then if the routine has a descendant of ARRAY
								-- as a local variable or an argument and then
								-- calls put or item on this local/argument
							byte_code := Byte_server.item (original_feature.body_id);
							if
								byte_code.has_loop
							and then
								(byte_code.has_array_as_argument or else
								 byte_code.has_array_as_local)
							then
								io.error.putstring ("Check uses of `put' and `item'%N");
								optimized_features.extend (opt_unit);
debug ("OPTIMIZATION")
	io.error.putstring (written_class.class_name);
	io.error.putstring (" ");
	io.error.putstring (original_feature.feature_name);
	io.error.putstring (" is recorded%N");
end
							end;
						end;
					end;
				end;
			end;
		end;

	optimized_features: TWO_WAY_SORTED_SET [OPTIMIZE_UNIT] is
		once
			!!Result.make;
			Result.compare_objects;
		end;

	dots: INTEGER;
		-- Number of dots on the current line

	features: INTEGER;
		-- Number of features for the current dot

	dots_per_line: INTEGER is 79;

	features_per_dot: INTEGER is 100;

	mark_alive (feat: FEATURE_I) is
			-- Record feature `feat'
		require
			good_argument: feat /= Void
		local
			class_name: STRING;
			temp: ROUT_ID_SET
		do
debug ("DEAD_CODE_REMOVAL")
				-- Verbose
			io.error.putstring ("%TMarking ");
			io.error.putstring (feat.feature_name);
			io.error.putstring (" from ");
			class_name := clone (feat.written_class.class_name)
			class_name.to_upper;
			io.error.putstring (class_name);
			io.error.new_line;
end;

			features := features + 1;
			if features = features_per_dot then
				io.error.putchar ('.');
				features := 0;
				dots := dots + 1;
				if dots = dots_per_line then
					io.error.new_line;
					dots := 0
				end;
			end;

			temp := used_table.item (feat.body_id);
			if (temp = Void) then
				!! temp.make (1);
				used_table.put (temp, feat.body_id);
			end;
			temp.force (feat.rout_id_set.first);
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

	bid_rid_is_marked (bid, rid: INTEGER): BOOLEAN is
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

end
