class ARRAY_OPTIMIZER

inherit
	SHARED_OPTIMIZATION_TABLES;
	SHARED_SERVER

creation
	make

feature

	make is
		do
			array_optimization_level := System.array_optimization_level
		end

	process (a_class: CLASS_C; a_feature: FEATURE_I) is
		do
			if array_optimization_level > 0 then
			end;
		end;

feature

	record_array_descendants is
		local
			array_class: CLASS_C;
			ftable: FEATURE_TABLE;
		do
			array_class := System.array_class.compiled_class;

			ftable := array_class.feature_table;
				-- get the rout_ids of the special/forbidden features
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

			!!forbidden_features.make;
			forbidden_features.compare_objects;

			!!lower_and_area_features.make;
			lower_and_area_features.compare_objects;

				-- Record descendants of ARRAY and some of the special features
			record_descendants (array_class);

				-- Record the rest of the forbidden features
			record_forbidden_features;
		end;

feature {NONE} -- Array optimization

	array_optimization_level: INTEGER

	put_rout_id, item_rout_id, infix_at_rout_id: INTEGER
	make_area_rout_id, set_area_rout_id, lower_rout_id, area_rout_id: INTEGER;
			-- rout_ids of the special/forbidden features

	array_descendants: LINKED_LIST [CLASS_C];
			-- Descendants of ARRAY

	special_features: TWO_WAY_SORTED_SET [DEPEND_UNIT]
			-- Set of all the special features
			-- A set is used so that we can use the basic intersection
			-- with the FEATURE_DEPENDANCE

	forbidden_features: FORBIDDEN_FEATURES
			-- Set of all the features that cannot be called
			-- within a loop

	lower_and_area_features: TWO_WAY_SORTED_SET [DEPEND_UNIT]
			-- Set of all the features `lower' and `area' from ARRAY
			-- and descendants

	record_forbidden_features is
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
			body_indexes: LINKED_SET [INTEGER];
		do
				-- Callers of area, lower with assignment
			from
				!!body_indexes.make
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
							byte_code := Byte_server.item (a_feature.body_id);
							if lower = Void then
								lower := select_table.item (lower_rout_id);
								area := select_table.item (area_rout_id);
							end;
							if
								byte_code.assigns_to (lower.feature_id)
							or else
								byte_code.assigns_to (area.feature_id)
							then
								body_indexes.extend (a_feature.body_index);
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
					if body_indexes.has (a_feature.body_index) then
debug ("OPTIMIZATION")
	io.error.putstring ("Inserting ");
	io.error.putstring (a_feature.feature_name);
	io.error.putstring (" from ");
	io.error.putstring (a_class.class_name);
	io.error.new_line;
end
						!!dep.make (a_class.id, a_feature.feature_id)
						forbidden_features.extend (dep);
					end;
					ftable.forth
				end
				forbidden_features.extend (dep);
				array_descendants.forth
			end;

io.error.putstring ("FIXME: features from GENERAL%N");
			a_class := System.general_class.compiled_class
			!!dep.make (a_class.id,
						a_class.feature_table.item ("clone").feature_id);
			forbidden_features.extend (dep);
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

					-- Record forbidden features
				!!dep.make (an_id, select_table.item (make_area_rout_id).feature_id);
				forbidden_features.extend (dep);
				!!dep.make (an_id, select_table.item (set_area_rout_id).feature_id);
				forbidden_features.extend (dep);
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
						-- as a local variable, an argument or Result and then
						-- calls put or item on this local/argument/Result
					byte_code := Byte_server.item (original_feature.body_id);
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
--							context.init (written_class.types.first);

							byte_code.perform_array_optimization (Current);

							optimized_features.extend (opt_unit);
debug ("OPTIMIZION")
	io.error.putstring (written_class.class_name);
	io.error.putstring (" ");
	io.error.putstring (original_feature.feature_name);
	io.error.putstring (" is recorded%N");
end
						else
debug ("OPTIMIZATION")
    io.error.putstring (written_class.class_name);
    io.error.putstring (" ");
    io.error.putstring (original_feature.feature_name);
    io.error.putstring (" is NOT recorded%N");
end
						end

					end;
				end;
			end;
		end;

	optimized_features: TWO_WAY_SORTED_SET [OPTIMIZE_UNIT] is
		once
			!!Result.make;
			Result.compare_objects;
		end;

end
