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
	
	SHARED_GENERATION

	COMPILER_EXPORTER

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

creation
	make

feature

	make is
		local
			nb: INTEGER
		do
			array_optimization_on := System.array_optimization_on

			create optimized_features.make (300)

			nb := System.body_index_counter.count
			!!unsafe_body_indexes.make (1, nb)

			{FEAT_ITERATOR} Precursor

			!! context_stack.make
		end

feature

	record_array_descendants is
		local
			array_class: CLASS_C
			ftable: FEATURE_TABLE
			l_names_heap: like Names_heap
		do
			array_class := System.array_class.compiled_class

			ftable := array_class.feature_table
			l_names_heap := Names_heap

				-- get the rout_ids of the special/unsafe features
			put_rout_id := ftable.item_id (l_names_heap.put_name_id).rout_id_set.first
			item_rout_id := ftable.item_id (l_names_heap.item_name_id).rout_id_set.first
			infix_at_rout_id := ftable.item_id (l_names_heap.infix_at_name_id).rout_id_set.first
			make_area_rout_id := ftable.item_id (l_names_heap.make_area_name_id).rout_id_set.first
			set_area_rout_id := ftable.item_id (l_names_heap.set_area_name_id).rout_id_set.first
			lower_rout_id := ftable.item_id (l_names_heap.lower_name_id).rout_id_set.first
			area_rout_id := ftable.item_id (l_names_heap.area_name_id).rout_id_set.first
			
			!!array_descendants.make

			!! special_features.make
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

	put_rout_id, item_rout_id, infix_at_rout_id: INTEGER
	make_area_rout_id, set_area_rout_id, lower_rout_id, area_rout_id: INTEGER
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
			class_depend: CLASS_DEPENDANCE
			depend_list: FEATURE_DEPENDANCE
			byte_code: BYTE_CODE
			dep: DEPEND_UNIT
			lower, area: FEATURE_I
			body_index: INTEGER
		do
				-- Callers of area, lower with assignment
			from
				array_descendants.start
			until
				array_descendants.after
			loop
				a_class := array_descendants.item
				ftable := a_class.feature_table
				select_table := ftable.origin_table
				class_depend := Depend_server.item (a_class.class_id)

				from
					ftable.start
				until
					ftable.after
				loop
					a_feature := ftable.item_for_iteration
					if a_feature.written_class = a_class then
						depend_list := class_depend.item (a_feature.body_index)
						if
							depend_list /= Void
						and then
							not lower_and_area_features.disjoint (depend_list)
						then
								-- Calls to `lower' or `area'
								-- See if assignment
							body_index := a_feature.body_index
							byte_code := Byte_server.item (body_index)
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
								unsafe_body_indexes.put (True, body_index)
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
					if unsafe_body_indexes.item (a_feature.body_index) then
debug ("OPTIMIZATION")
	io.error.putstring ("Inserting ")
	io.error.putstring (a_feature.feature_name)
	io.error.putstring (" from ")
	io.error.putstring (a_class.name)
	io.error.new_line
end
						!!dep.make (a_class.class_id, a_feature)
						unsafe_features.extend (dep)
						mark_alive (a_feature.body_index)
					end
					ftable.forth
				end
				array_descendants.forth
			end
				-- FIXME
				-- features from ANY (hints to stop propagation)
				-- Does it work?
			a_class := System.any_class.compiled_class
			a_feature := a_class.feature_table.item_id (Names_heap.clone_name_id)
			!!dep.make (a_class.class_id, a_feature)
			unsafe_features.extend (dep)
			unsafe_body_indexes.put (True, a_feature.body_index)
			mark_alive (a_feature.body_index)
		end

	record_descendants (a_class: CLASS_C) is
			-- Recursively records `a_class' and its descendants in `descendants'
		local
			d: LINKED_LIST [CLASS_C]
			an_id: INTEGER
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
				array_descendants.forth
				an_id := a_class.class_id
				ftable := a_class.feature_table
				select_table := ftable.origin_table

				!! dep.make (an_id, select_table.item (put_rout_id))
				special_features.extend (dep)
				!! dep.make (an_id, select_table.item (item_rout_id))
				special_features.extend (dep)
				!! dep.make (an_id, select_table.item (infix_at_rout_id))
				special_features.extend (dep)

					-- Record `lower' and `area'
				!! dep.make (an_id, select_table.item (lower_rout_id))
				lower_and_area_features.extend (dep)
				!! dep.make (an_id, select_table.item (area_rout_id))
				lower_and_area_features.extend (dep)

					-- Record unsafe features
				!! dep.make (an_id, select_table.item (make_area_rout_id))
				unsafe_features.extend (dep)
				!! dep.make (an_id, select_table.item (set_area_rout_id))
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

	process (a_class: CLASS_C; body_index: INTEGER; depend_list: FEATURE_DEPENDANCE) is
		local
			opt_unit: OPTIMIZE_UNIT
			byte_code: BYTE_CODE
		do
			if array_optimization_on then
				!! opt_unit.make (a_class.class_id, body_index)
				if
						-- The feature was marked during the type check
						-- and hasn't been processed yet
					optimization_tables.has (opt_unit)
					and then not optimized_features.has (opt_unit)
				then
						-- See if the routine really has a loop
						-- (incrementality can mess up everything) and
						-- then if the routine has a descendant of ARRAY
						-- as a local variable, an argument or Result and then
						-- calls put or item on this local/argument/Result
					byte_code := Byte_server.disk_item (body_index)
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
								optimized_features.force (opt_unit)
									-- Store the new byte code
								tmp_opt_byte_server.put (byte_code)

							end

							check
								context_stack.is_empty
							end
							current_feature_optimized := False

								-- Clean byte context
							Context.array_opt_clear
						end
					end
				end
			end
		end

	optimized_features: SEARCH_TABLE [OPTIMIZE_UNIT]

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
			type_a := type_a.instantiation_in (array_type_a, array_type.base_class.class_id)
								--(array_type_a, System.current_class.class_id)

			if type_a.is_formal then
				formal_a ?= type_a
				Result := Context.class_type.type.meta_generic.item
						(formal_a.position).c_type
			else
				Result := type_a.type_i.c_type
			end
		end

	generate_plug_declarations (buffer: GENERATION_BUFFER) is
		do
			generate_feature_table (buffer, "eif_lower_table", lower_rout_id)
			generate_feature_table (buffer, "eif_area_table", area_rout_id)
		end

	generate_feature_table (buffer: GENERATION_BUFFER; table_name: STRING
			rout_id: INTEGER) is
		local
			entry: POLY_TABLE [ENTRY]
			temp: STRING
		do
			entry := Eiffel_table.poly_table (rout_id)
			Eiffel_table.mark_used (rout_id)
			temp := Encoder.table_name (rout_id)
			buffer.putstring ("extern long ")
			buffer.putstring (temp)
			buffer.putstring ("[];%Nlong *")
			buffer.putstring (table_name)
			buffer.putstring (" = ")
			buffer.putstring (temp)
			buffer.putstring (" - ")
			buffer.putint (entry.min_type_id - 1)
			buffer.putstring (";%N")
		end

feature {NONE} -- Contexts

	context_stack: LINKED_STACK [OPTIMIZATION_CONTEXT]

feature -- Detection of safe/unsafe features

	unsafe_features: TWO_WAY_SORTED_SET [DEPEND_UNIT]
			-- Set of all the features that cannot be called
			-- within a loop

	unsafe_body_indexes: ARRAY [BOOLEAN]

	test_safety (a_feature: FEATURE_I; a_class: CLASS_C) is
			-- Insert the feature in the safe or unsafe set
			-- depending if it calls unsafe features
		require
			good_feature: a_feature /= Void
			good_class: a_class /= Void
		do
			if not (a_feature.is_attribute or else is_treated (a_feature.body_index, a_feature.rout_id_set.first)) then
				mark (a_feature.feature_id, a_feature.body_index, a_class.class_id, a_feature.written_in, a_feature.rout_id_set.first)
			end
		end

	is_safe (dep: DEPEND_UNIT): BOOLEAN is
			-- Can the feature be safely called within an optimized loop?
		local
			table: ROUT_TABLE
			rout_id_val: INTEGER
			other_body_index: INTEGER
			unit: ROUT_ENTRY
			descendant_class, written_class: CLASS_C
		do
			if dep.is_external then
				Result := False
			else
				rout_id_val := dep.rout_id

				if
					not System.routine_id_counter.is_attribute (rout_id_val) and then
					Tmp_poly_server.has (rout_id_val)
				then	
					written_class := System.class_of_id (dep.written_in)
					table ?= Tmp_poly_server.item (rout_id_val)
					from
						Result := True
						table.start
					until
						table.after or else not Result
					loop
						unit := table.item
						descendant_class := System.class_of_id (unit.class_id)
						if descendant_class.simple_conform_to (written_class) then
							other_body_index := unit.body_index
							Result := not unsafe_body_indexes.item (other_body_index)
						end
						table.forth
					end
				else
					Result := not unsafe_body_indexes.item (dep.body_index)
				end
			end
		end

feature {NONE} -- Detection of safe/unsafe features

	propagate_feature (written_class_id: INTEGER; original_body_index: INTEGER; depend_list: FEATURE_DEPENDANCE) is
		local
			depend_unit: DEPEND_UNIT
			body_index: INTEGER
			unsafe: BOOLEAN
		do
			from
				depend_list.start
			until
				depend_list.after or else unsafe
			loop
				depend_unit := depend_list.item
				if not depend_unit.is_special then
					body_index := depend_unit.body_index
					if
						not (System.routine_id_counter.is_attribute (depend_unit.rout_id) or else
						is_treated (body_index, depend_unit.rout_id))
					then
						mark_treated (body_index, depend_unit.rout_id)
						mark (depend_unit.feature_id, body_index, depend_unit.class_id, depend_unit.written_in, depend_unit.rout_id)
					end
						-- get the status ...
					if not is_safe (depend_unit) then
						unsafe := True
						unsafe_body_indexes.put (True, body_index)
					end
				end
				depend_list.forth
			end
		end

end
