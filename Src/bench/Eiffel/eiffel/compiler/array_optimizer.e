class ARRAY_OPTIMIZER

inherit
	FEAT_ITERATOR
		redefine
			make
		end
	SHARED_OPTIMIZATION_TABLES

	SHARED_INST_CONTEXT

	SHARED_BYTE_CONTEXT

	SHARED_TABLE

	COMPILER_EXPORTER

creation
	make

feature

	make is
		do
			array_optimization_on := System.array_optimization_on

			!! optimized_features.make
			optimized_features.compare_objects

			{FEAT_ITERATOR} Precursor

			!! context_stack.make
		end

feature

	record_array_descendants is
		local
			array_class: CLASS_C
			ftable: FEATURE_TABLE
		do
			array_class := System.array_class.compiled_class

			ftable := array_class.feature_table
				-- get the rout_ids of the special/unsafe features
			put_rout_id := ftable.item ("put").rout_id_set.first
			item_rout_id := ftable.item ("item").rout_id_set.first
			infix_at_rout_id := ftable.item ("_infix_@").rout_id_set.first
			make_area_rout_id := ftable.item ("make_area").rout_id_set.first
			set_area_rout_id := ftable.item ("set_area").rout_id_set.first
			lower_rout_id := ftable.item ("lower").rout_id_set.first
			area_rout_id := ftable.item ("area").rout_id_set.first
			
			!!array_descendants.make

			!!special_features.make
			special_features.compare_objects

			!!unsafe_features.make
			unsafe_features.compare_objects

			!!lower_and_area_features.make
			lower_and_area_features.compare_objects

				-- Record descendants of ARRAY and some of the special features
			record_descendants (array_class)

				-- Record the rest of the unsafe features
			record_unsafe_features
		end

feature

	special_features: TWO_WAY_SORTED_SET [DEPEND_UNIT]
			-- Set of all the special features
			-- A set is used so that we can use the basic intersection
			-- with the FEATURE_DEPENDANCE

feature {NONE} -- Array optimization

	array_optimization_on: BOOLEAN

	put_rout_id, item_rout_id, infix_at_rout_id: ROUTINE_ID
	make_area_rout_id, set_area_rout_id, lower_rout_id, area_rout_id: ROUTINE_ID
			-- rout_ids of the special/unsafe features

	array_descendants: LINKED_LIST [CLASS_C]
			-- Descendants of ARRAY

	lower_and_area_features: TWO_WAY_SORTED_SET [DEPEND_UNIT]
			-- Set of all the features `lower' and `area' from ARRAY
			-- and descendants

	record_unsafe_features is
		local
			a_class: CLASS_C
			ftable: FEATURE_TABLE
			select_table: SELECT_TABLE
			a_feature: FEATURE_I
			feature_name: STRING
			class_depend: CLASS_DEPENDANCE
			depend_list: FEATURE_DEPENDANCE
			byte_code: BYTE_CODE
			dep: DEPEND_UNIT
			lower, area: FEATURE_I
			b_id: BODY_ID
		do
				-- Callers of area, lower with assignment
			from
				!!unsafe_body_ids.make
				unsafe_body_ids.compare_objects
				array_descendants.start
			until
				array_descendants.after
			loop
				a_class := array_descendants.item
				ftable := a_class.feature_table
				select_table := ftable.origin_table
				class_depend := Depend_server.item (a_class.id)

				from
					ftable.start
				until
					ftable.after
				loop
					feature_name := ftable.key_for_iteration
					a_feature := ftable.item_for_iteration
					if a_feature.written_class = a_class then

						depend_list := class_depend.item (feature_name)
						if
							depend_list /= Void
						and then
							not lower_and_area_features.disjoint (depend_list)
						then
								-- Calls to `lower' or `area'
								-- See if assignment
							b_id := a_feature.body_id
							byte_code := Byte_server.item (b_id)
							if lower = Void then
									-- Optimization: get the FEATURE_Is only
									-- if the sets are not disjoint
								lower := select_table.item (lower_rout_id)
								area := select_table.item (area_rout_id)
							end
							if
								byte_code.assigns_to (lower.feature_id)
							or else
								byte_code.assigns_to (area.feature_id)
							then
								unsafe_body_ids.extend (b_id)
							end
						end
					end
					ftable.forth
				end
					-- Reset the `unsafe' FEATURE_Is
				lower := Void
				area := Void
				array_descendants.forth
			end

				-- record
			from
				array_descendants.start
			until
				array_descendants.after
			loop
				a_class := array_descendants.item
				ftable := a_class.feature_table
				from
					ftable.start
				until
					ftable.after
				loop
					a_feature := ftable.item_for_iteration
					if unsafe_body_ids.has (a_feature.body_id) then
debug ("OPTIMIZATION")
	io.error.putstring ("Inserting ")
	io.error.putstring (a_feature.feature_name)
	io.error.putstring (" from ")
	io.error.putstring (a_class.name)
	io.error.new_line
end
						!!dep.make (a_class.id, a_feature.feature_id)
						unsafe_features.extend (dep)
						mark_alive (a_feature, a_feature.rout_id_set.first)
					end
					ftable.forth
				end
				array_descendants.forth
			end
				-- FIXME
				-- features from GENERAL (hints to stop propagation)
				-- Does it work?
			a_class := System.general_class.compiled_class
			a_feature := a_class.feature_table.item ("clone")
			!!dep.make (a_class.id, a_feature.feature_id)
			unsafe_features.extend (dep)
			unsafe_body_ids.extend (a_feature.body_id)
			mark_alive (a_feature, a_feature.rout_id_set.first)
		end

	record_descendants (a_class: CLASS_C) is
			-- Recursively records `a_class' and its descendants in `descendants'
		local
			d: LINKED_LIST [CLASS_C]
			an_id: CLASS_ID
			ftable: FEATURE_TABLE
			select_table: SELECT_TABLE
			dep: DEPEND_UNIT
		do
			if not array_descendants.has (a_class) then
debug ("OPTIMIZATION")
	io.error.putstring ("Adding ")
	io.error.putstring (a_class.name)
	io.error.putstring (" as a descendant of ARRAY%N")
end
				array_descendants.extend (a_class)
				an_id := a_class.id
				ftable := a_class.feature_table
				select_table := ftable.origin_table

				!!dep.make (an_id, select_table.item (put_rout_id).feature_id)
				special_features.extend (dep)
				!!dep.make (an_id, select_table.item (item_rout_id).feature_id)
				special_features.extend (dep)
				!!dep.make (an_id, select_table.item (infix_at_rout_id).feature_id)
				special_features.extend (dep)

					-- Record `lower' and `area'
				!!dep.make (an_id, select_table.item (lower_rout_id).feature_id)
				lower_and_area_features.extend (dep)
				!!dep.make (an_id, select_table.item (area_rout_id).feature_id)
				lower_and_area_features.extend (dep)

					-- Record unsafe features
				!!dep.make (an_id, select_table.item (make_area_rout_id).feature_id)
				unsafe_features.extend (dep)
				!!dep.make (an_id, select_table.item (set_area_rout_id).feature_id)
				unsafe_features.extend (dep)
				from
					d := a_class.descendants
					d.start
				until
					d.after
				loop
					record_descendants (d.item)
					d.forth
				end
			end
		end

feature

	process (a_class: CLASS_C; a_feature: FEATURE_I; depend_list: FEATURE_DEPENDANCE) is
		local
			opt_unit: OPTIMIZE_UNIT
			byte_code: BYTE_CODE
		do
			if array_optimization_on then
				!!opt_unit.make (a_class.id, a_feature.body_index)
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
					byte_code := Byte_server.disk_item (a_feature.body_id)
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
							Context.init (a_class.types.first)
							Context.set_byte_code (byte_code)
							Inst_context.set_cluster (a_class.cluster)

							current_feature_optimized := False
							byte_code := byte_code.optimized_byte_node

							if current_feature_optimized then
									-- Mark the feature
								optimized_features.extend (opt_unit)
									-- Store the new byte code
								tmp_opt_byte_server.put (byte_code)
debug ("OPTIMIZATION", "RECORD")
	io.error.new_line
	io.error.putstring (a_class.name)
	io.error.putstring (" ")
	io.error.putstring (a_feature.feature_name)
	io.error.putstring (" is recorded%N")
end
							end

							check
								context_stack.empty
							end
							current_feature_optimized := False

								-- Clean byte context
							Context.array_opt_clear
						end
					end
				end
			end
		end

	optimized_features: TWO_WAY_SORTED_SET [OPTIMIZE_UNIT]

	current_feature_optimized: BOOLEAN

	set_current_feature_optimized is
		do
			current_feature_optimized := True
		end

feature -- Contexts

	optimization_context: OPTIMIZATION_CONTEXT is
			-- Current loop context
		do
			Result := context_stack.item
		end

	push_optimization_context (c: OPTIMIZATION_CONTEXT) is
		do
			context_stack.put (c)
		end

	pop_optimization_context is
		do
			context_stack.remove
		end

	array_item_type (id: INTEGER): TYPE_C is
		local
			array_type: CL_TYPE_I
			type_a: TYPE_A
			bc: BYTE_CODE
			array_type_a: TYPE_A
			f: FEATURE_I
			formal_a: FORMAL_A
		do
			bc := context.byte_code
			if id = 0 then
					-- Result
				array_type ?= bc.result_type
			elseif id < 0 then
					-- local
				array_type ?= bc.locals.item (-id)
			else
					-- Argument
				array_type ?= bc.arguments.item (id)
			end
			array_type_a := array_type.type_a
			f := array_type.base_class.feature_table.origin_table.item (item_rout_id)

			type_a ?= f.type
			type_a := type_a.instantiation_in
				(array_type_a, array_type.base_class.id)
				--(array_type_a, System.current_class.id)

			if type_a.is_formal then
				formal_a ?= type_a
				Result := Context.class_type.type.meta_generic.item
						(formal_a.position).c_type
			else
				Result := type_a.type_i.c_type
			end
		end

	generate_plug_declarations (plug_file: INDENT_FILE; table_prefix: STRING) is
		do
			generate_feature_table (plug_file, "eif_lower_table", lower_rout_id, table_prefix)
			generate_feature_table (plug_file, "eif_area_table", area_rout_id, table_prefix)
		end

	generate_feature_table (plug_file: INDENT_FILE; table_name: STRING
			rout_id: ROUTINE_ID; table_prefix: STRING) is
		local
			entry: POLY_TABLE [ENTRY]
			temp: STRING
		do
			entry := Eiffel_table.poly_table (rout_id)
			temp := rout_id.table_name
			Plug_file.putstring ("extern long ")
			Plug_file.putstring (table_prefix)
			Plug_file.putstring (temp)
			Plug_file.putstring ("[];%Nlong *")
			Plug_file.putstring (table_name)
			Plug_file.putstring (" = ")
			Plug_file.putstring (table_prefix)
			Plug_file.putstring (temp)
			Plug_file.putstring (" - ")
			Plug_file.putint (entry.min_type_id - 1)
			Plug_file.putstring (";%N")
		end

feature {NONE} -- Contexts

	context_stack: LINKED_STACK [OPTIMIZATION_CONTEXT]

feature -- Detection of safe/unsafe features

	unsafe_features: TWO_WAY_SORTED_SET [DEPEND_UNIT]
			-- Set of all the features that cannot be called
			-- within a loop

	unsafe_body_ids: TWO_WAY_SORTED_SET [BODY_ID]

	test_safety (a_feature: FEATURE_I; a_class: CLASS_C) is
			-- Insert the feature in the safe or unsafe set
			-- depending if it calls unsafe features
		require
			good_feature: a_feature /= Void
			good_class: a_class /= Void
		do
			if not (a_feature.is_attribute or else is_marked (a_feature)) then
				mark (a_feature, a_class, a_feature.rout_id_set.first)
			end
		end

	is_safe (f: FEATURE_I): BOOLEAN is
			-- Can the feature be safely called within an optimized loop?
		local
			table: ROUT_UNIT_TABLE
			rout_id_val: ROUTINE_ID
			unit: ROUT_UNIT
			written_class, descendant_class: CLASS_C
			body_table: BODY_INDEX_TABLE
			other_body_id: BODY_ID
		do
			if f.is_external then
				Result := False
			else
				rout_id_val := f.rout_id_set.first

				if
					not rout_id_val.is_attribute and then
					Tmp_poly_server.has (rout_id_val)
				then	
					written_class := f.written_class
					table ?= Tmp_poly_server.item (rout_id_val)
					from
						Result := True
						body_table := System.body_index_table
						table.start
					until
						table.after or else not Result
					loop
						unit := table.item
						descendant_class := System.class_of_id (unit.id)
						if descendant_class.conform_to (written_class) then
							other_body_id := body_table.item (unit.body_index)
							Result := not unsafe_body_ids.has (other_body_id)
						end
						table.forth
					end
				else
					Result := not unsafe_body_ids.has (f.body_id)
				end
			end
debug ("OPTIMIZATION")
	io.error.putstring ("ARRAY_OPTIMIZER: ")
    io.error.putstring (f.written_class.name)
    io.error.putstring (" ")
    io.error.putstring (f.feature_name)
    if Result then
		io.error.putstring (" is safe%N")
	else
    	io.error.putstring (" is NOT safe%N")
	end
end
		end

feature {NONE} -- Detection of safe/unsafe features

	propagate_feature (written_class: CLASS_C; original_feature: FEATURE_I
						depend_list: FEATURE_DEPENDANCE) is
		local
			depend_unit: DEPEND_UNIT
			depend_feature: FEATURE_I
			static_class: CLASS_C
			unsafe: BOOLEAN
		do
			from
				depend_list.start
			until
				depend_list.after or else unsafe
			loop
				depend_unit := depend_list.item
				if not depend_unit.is_special then
					static_class := System.class_of_id (depend_unit.id)
					depend_feature := static_class.feature_table.feature_of_feature_id
												(depend_unit.feature_id)
					if
						not (depend_feature.is_attribute or else is_marked (depend_feature))
					then
debug ("OPTIMIZATION")
	io.error.putstring ("Propagated to ")
	io.error.putstring (depend_feature.feature_name)
	io.error.putstring (" from ")
	io.error.putstring (static_class.name)
	io.error.new_line
end
						mark (depend_feature, static_class, depend_feature.rout_id_set.first)
					end
						-- get the status ...
					if not is_safe (depend_feature) then
						unsafe := True
						unsafe_body_ids.extend (original_feature.body_id)
debug ("OPTIMIZATION")
	io.error.putstring (original_feature.feature_name)
	io.error.putstring (" from ")
	io.error.putstring (written_class.name)
	io.error.putstring (" calls unsafe features!!!!!%N")
end
					end
				end
				depend_list.forth
			end
		end

feature -- DLE

	generate_dle_plug_extern (plug_file: INDENT_FILE) is
			-- Generate extern declarations in `plug_file'.
		require
			dynamic_system: System.is_dynamic
		local
			entry: POLY_TABLE [ENTRY]
			temp: STRING
		do
			entry := Eiffel_table.poly_table (lower_rout_id)
			temp := lower_rout_id.table_name
			plug_file.putstring ("extern long *")
			plug_file.putstring (temp)
			plug_file.putchar (';')
			plug_file.new_line
			entry := Eiffel_table.poly_table (area_rout_id)
			temp := area_rout_id.table_name
			plug_file.putstring ("extern long *")
			plug_file.putstring (temp)
			plug_file.putchar (';')
			plug_file.new_line
		end

	generate_dle_plug (plug_file: INDENT_FILE) is
			-- Generate code in `plug_file'. This part of the code will
			-- have to be called after the routine and attribute tables
			-- have been initialized.
		require
			dynamic_system: System.is_dynamic
		local
			entry: POLY_TABLE [ENTRY]
			temp: STRING
		do
			entry := Eiffel_table.poly_table (lower_rout_id)
			temp := lower_rout_id.table_name
			plug_file.putstring ("eif_lower_table = ")
			plug_file.putstring (temp)
			plug_file.putstring (" - ")
			plug_file.putint (entry.min_type_id - 1)
			plug_file.putchar (';')
			plug_file.new_line
			entry := Eiffel_table.poly_table (area_rout_id)
			temp := area_rout_id.table_name
			plug_file.putstring ("eif_area_table = ")
			plug_file.putstring (temp)
			plug_file.putstring (" - ")
			plug_file.putint (entry.min_type_id - 1)
			plug_file.putchar (';')
			plug_file.new_line
		end

end
