class ARRAY_OPTIMIZER

inherit
	SHARED_OPTIMIZATION_TABLES;
	SHARED_SERVER;
	SHARED_TMP_SERVER;
	SHARED_BYTE_CONTEXT

creation
	make

feature

	make is
		do
			array_optimization_on := System.array_optimization_on

			!!optimized_features.make;
			optimized_features.compare_objects;

			!!used_table.make (1, System.body_id_counter.value);

			!!context_stack.make
		end

feature

	record_array_descendants is
		local
			array_class: CLASS_C;
			ftable: FEATURE_TABLE;
		do
			array_class := System.array_class.compiled_class;

			ftable := array_class.feature_table;
				-- get the rout_ids of the special/unsafe features
			put_rout_id := ftable.item ("put").rout_id_set.first
			item_rout_id := ftable.item ("item").rout_id_set.first
			infix_at_rout_id := ftable.item ("_infix_@").rout_id_set.first
			make_area_rout_id := ftable.item ("make_area").rout_id_set.first
			set_area_rout_id := ftable.item ("set_area").rout_id_set.first
			lower_rout_id := - ftable.item ("lower").rout_id_set.first
			area_rout_id := - ftable.item ("area").rout_id_set.first
			
			!!array_descendants.make;

			!!special_features.make;
			special_features.compare_objects;

			!!unsafe_features.make;
			unsafe_features.compare_objects;

			!!lower_and_area_features.make;
			lower_and_area_features.compare_objects;

				-- Record descendants of ARRAY and some of the special features
			record_descendants (array_class);

				-- Record the rest of the unsafe features
			record_unsafe_features;
		end;

feature

	special_features: TWO_WAY_SORTED_SET [DEPEND_UNIT]
			-- Set of all the special features
			-- A set is used so that we can use the basic intersection
			-- with the FEATURE_DEPENDANCE

feature {NONE} -- Array optimization

	array_optimization_on: BOOLEAN

	put_rout_id, item_rout_id, infix_at_rout_id: INTEGER
	make_area_rout_id, set_area_rout_id, lower_rout_id, area_rout_id: INTEGER;
			-- rout_ids of the special/unsafe features

	array_descendants: LINKED_LIST [CLASS_C];
			-- Descendants of ARRAY

	lower_and_area_features: TWO_WAY_SORTED_SET [DEPEND_UNIT]
			-- Set of all the features `lower' and `area' from ARRAY
			-- and descendants

	record_unsafe_features is
		local
			a_class: CLASS_C;
			ftable: FEATURE_TABLE;
			select_table: SELECT_TABLE;
			a_feature: FEATURE_I;
			feature_name: STRING;
			class_depend: CLASS_DEPENDANCE;
			depend_list: FEATURE_DEPENDANCE;
			byte_code: BYTE_CODE;
			dep: DEPEND_UNIT;
			lower, area: FEATURE_I;
			b_id: INTEGER
		do
				-- Callers of area, lower with assignment
			from
				!!unsafe_body_ids.make
				array_descendants.start
			until
				array_descendants.after
			loop
				a_class := array_descendants.item;
				ftable := a_class.feature_table;
				select_table := ftable.origin_table;
				class_depend := Depend_server.item (a_class.id);

				from
					ftable.start
				until
					ftable.after
				loop
					feature_name := ftable.key_for_iteration;
					a_feature := ftable.item_for_iteration;
					if a_feature.written_class = a_class then

						depend_list := class_depend.item (feature_name);
						if
							depend_list /= Void
						and then
							not lower_and_area_features.disjoint (depend_list)
						then
								-- Calls to `lower' or `area'
								-- See if assignment
							b_id := a_feature.body_id;
							byte_code := Byte_server.item (b_id);
							if lower = Void then
								lower := select_table.item (lower_rout_id);
								area := select_table.item (area_rout_id);
							end;
							if
								byte_code.assigns_to (lower.feature_id)
							or else
								byte_code.assigns_to (area.feature_id)
							then
								unsafe_body_ids.extend (b_id);
							end;
						end
					end;
					ftable.forth
				end;
				array_descendants.forth
			end;

				-- record
			from
				array_descendants.start
			until
				array_descendants.after
			loop
				a_class := array_descendants.item;
				ftable := a_class.feature_table;
				from
					ftable.start
				until
					ftable.after
				loop
					a_feature := ftable.item_for_iteration
					if unsafe_body_ids.has (a_feature.body_id) then
debug ("OPTIMIZATION")
	io.error.putstring ("Inserting ");
	io.error.putstring (a_feature.feature_name);
	io.error.putstring (" from ");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
end
						!!dep.make (a_class.id, a_feature.feature_id)
						unsafe_features.extend (dep);
						mark_alive (a_feature);
					end;
					ftable.forth
				end
				array_descendants.forth
			end;

io.error.putstring ("FIXME: features from GENERAL (hints to stop propagation)%N");
			a_class := System.general_class.compiled_class
			a_feature := a_class.feature_table.item ("clone");
			!!dep.make (a_class.id, a_feature.feature_id);
			unsafe_features.extend (dep);
			unsafe_body_ids.extend (a_feature.body_id)
			mark_alive (a_feature);
		end;

	record_descendants (a_class: CLASS_C) is
			-- Recursively records `a_class' and its descendants in `descendants'
		local
			d: LINKED_LIST [CLASS_C];
			an_id: INTEGER;
			ftable: FEATURE_TABLE;
			select_table: SELECT_TABLE;
			dep: DEPEND_UNIT;
		do
			if not array_descendants.has (a_class) then
debug ("OPTIMIZATION")
	io.error.putstring ("Adding ");
	io.error.putstring (a_class.class_name);
	io.error.putstring (" as a descendant of ARRAY%N");
end;
				array_descendants.extend (a_class);
				an_id := a_class.id;
				ftable := a_class.feature_table;
				select_table := ftable.origin_table;

				!!dep.make (an_id, select_table.item (put_rout_id).feature_id);
				special_features.extend (dep);
				!!dep.make (an_id, select_table.item (item_rout_id).feature_id);
				special_features.extend (dep);
				!!dep.make (an_id, select_table.item (infix_at_rout_id).feature_id);
				special_features.extend (dep);

					-- Record `lower' and `area'
				!!dep.make (an_id, select_table.item (lower_rout_id).feature_id);
				lower_and_area_features.extend (dep);
				!!dep.make (an_id, select_table.item (area_rout_id).feature_id);
				lower_and_area_features.extend (dep);

					-- Record unsafe features
				!!dep.make (an_id, select_table.item (make_area_rout_id).feature_id);
				unsafe_features.extend (dep);
				!!dep.make (an_id, select_table.item (set_area_rout_id).feature_id);
				unsafe_features.extend (dep);
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

feature

	process (a_class: CLASS_C; a_feature: FEATURE_I; depend_list: FEATURE_DEPENDANCE) is
		local
			opt_unit: OPTIMIZE_UNIT;
			byte_code: BYTE_CODE
		do
			if array_optimization_on then
				!!opt_unit.make (a_class.id, a_feature.body_index);
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
						-- as a local variable, an argument or Result and then
						-- calls put or item on this local/argument/Result
					byte_code := Byte_server.disk_item (a_feature.body_id);
						-- `disk_item' is used because the byte code will be modified and
						-- we don't want the modified byte code to remain in the cache
					if
						byte_code.has_loop
					and then
						(byte_code.has_array_as_argument or else
						 byte_code.has_array_as_local or else
						 byte_code.has_array_as_result)
					then
							-- The routine calls `put' or `item' on a descendant of ARRAY
						if not special_features.disjoint (depend_list) then

								-- Initialization of the BYTE_CONTEXT
								-- => the types of the targets will be
								-- defined in calls a.f
							Context.init (a_class.types.first);
							Context.set_byte_code (byte_code);

							current_feature_optimized := False;
							byte_code := byte_code.optimized_byte_node;

							if current_feature_optimized then
									-- Mark the feature
								optimized_features.extend (opt_unit);
									-- Store the new byte code
								tmp_opt_byte_server.put (byte_code);
--debug ("OPTIMIZATION")
	io.error.putstring (a_class.class_name);
	io.error.putstring (" ");
	io.error.putstring (a_feature.feature_name);
	io.error.putstring (" is recorded%N");
--end
							end;

							check
								context_stack.empty
							end;
							current_feature_optimized := False;

								-- Clean byte context
							Context.array_opt_clear
						end
					end;
				end
			end;
		end;

	optimized_features: TWO_WAY_SORTED_SET [OPTIMIZE_UNIT];

	current_feature_optimized: BOOLEAN;

	set_current_feature_optimized is
		do
			current_feature_optimized := True
		end;

feature -- Contexts

	optimization_context: OPTIMIZATION_CONTEXT is
			-- Current loop context
		do
			Result := context_stack.item
		end;

	push_optimization_context (c: OPTIMIZATION_CONTEXT) is
		do
			context_stack.put (c)
		end;

	pop_optimization_context is
		do
			context_stack.remove
		end;

feature {NONE} -- Contexts

	context_stack: LINKED_STACK [OPTIMIZATION_CONTEXT];

feature -- Detection of safe/unsafe features

	unsafe_features: TWO_WAY_SORTED_SET [DEPEND_UNIT];
			-- Set of all the features that cannot be called
			-- within a loop

	unsafe_body_ids: TWO_WAY_SORTED_SET [INTEGER];

	test_safety (a_feature: FEATURE_I; a_class: CLASS_C) is
			-- Insert the feature in the safe or unsafe set
			-- depending if it calls unsafe features
		require
			good_feature: a_feature /= Void
			good_class: a_class /= Void
		do
			if not (a_feature.is_attribute or else is_marked (a_feature)) then
				mark (a_feature, a_class);
			end;
		end;

	is_safe (f: FEATURE_I): BOOLEAN is
			-- Can the feature be safely called within an optimized loop?
		do
			Result := not unsafe_body_ids.has (f.body_id)
		end

feature {NONE} -- Detection of safe/unsafe features

	mark (f: FEATURE_I; static_class: CLASS_C) is
			-- Mark feature and its redefinitions
		require
			not_is_attribute: not f.is_attribute;
		local
			rout_id_val, other_body_id: INTEGER;
			descendant_class: CLASS_C;
			descendant_feature: FEATURE_I;
			des_feat_table: FEATURE_TABLE;
			des_orig_table: SELECT_TABLE;
			table: ROUT_UNIT_TABLE;
			body_table: BODY_INDEX_TABLE;
			unit: ROUT_UNIT;
			redef_unit: TRAVERSAL_UNIT;
			inh_assert: INH_ASSERT_INFO;
			i, nb: INTEGER;
			ancestor_feature: FEATURE_I;
			written_class, ancestor_class: CLASS_C;
			c: CURSOR;
		do
			mark_and_record (f, static_class);

			rout_id_val := f.rout_id_set.first;

			check
				(not Tmp_poly_server.has (rout_id_val)) implies f.is_deferred;
					-- Case for an non existing routine table: a deferred
					-- feature without any implementation in descendant classes
					-- leads to NO routine table.
			end;

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
									mark_alive (descendant_feature);
								else
									mark_and_record
										(descendant_feature, descendant_class);
								end;
							end;
						end;
						table.go_to (c);
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
			depend_list: FEATURE_DEPENDANCE;
			depend_unit: DEPEND_UNIT;
			depend_feature, original_feature: FEATURE_I;
			written_class, static_class: CLASS_C;
			just_born, unsafe: BOOLEAN;
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
debug ("MARKING")
    io.error.putstring (original_feature.feature_name);
    io.error.putstring (" from ");
    io.error.putstring (written_class.class_name);
    io.error.new_line;
end;
				depend_list := Depend_server.item (written_class.id).item
										(original_feature.feature_name);
				if depend_list /= Void then
					from
						depend_list.start;
					until
						depend_list.after or else unsafe
					loop
						depend_unit := depend_list.item;
						if not depend_unit.is_special then
							static_class := System.class_of_id (depend_unit.id);
							depend_feature := static_class.feature_table.feature_of_feature_id
														(depend_unit.feature_id);
							if
								not (depend_feature.is_attribute or else is_marked (depend_feature))
							then
debug ("MARKING")
	io.error.putstring ("Propagated to ");
	io.error.putstring (depend_feature.feature_name);
	io.error.putstring (" from ");
	io.error.putstring (static_class.class_name);
	io.error.new_line;
end;
								mark (depend_feature, static_class);
							end;
								-- get the status ...
							if unsafe_body_ids.has (depend_feature.body_id) then
								unsafe := True;
								unsafe_body_ids.extend (original_feature.body_id);
debug ("OPTIMIZATION")
	io.error.putstring (original_feature.feature_name);
	io.error.putstring (" from ");
	io.error.putstring (actual_class.class_name);
	io.error.putstring (" calls unsafe features!!!!!%N");
end;
							end;
						end;
						depend_list.forth
					end;
				end;
			end;
		end;

	mark_alive (feat: FEATURE_I) is
			-- Record feature `feat'
		require
			good_argument: feat /= Void
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
			temp.force (feat.rout_id_set.first);
		end;

	used_table: ARRAY [ROUT_ID_SET];

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
