indexing
	description: "Byte code for a routine."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class BYTE_CODE

inherit
	IDABLE
		rename
			id as body_index,
			set_id as set_body_index
		export
			{NONE} all
			{ANY} body_index, set_body_index
		end

	BYTE_CONST
		export
			{NONE} all
		end

	BYTE_NODE
		redefine
			enlarge_tree
		end

	SHARED_C_LEVEL

	SHARED_PATTERN_TABLE

	ASSERT_TYPE

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_BN_STATELESS_VISITOR
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			-- Do nothing as BYTE_CODE is not really a BYTE_NODE.
		end

feature -- Access

	real_body_id: INTEGER
			-- Real body id of the feature to which current byte code belongs

	feature_name_id: INTEGER
			-- Name ID of the feature to which the current byte code tree
			-- belongs to

	start_line_number: INTEGER
			-- Line where feature name is located.

	end_location: LOCATION_AS
			-- Position where `end' keyword is located.

	feature_name: STRING is
			-- Final name of the feature
		require
			feature_name_id_set: feature_name_id > 0
		do
			Result := Names_heap.item (feature_name_id)
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

	rout_id: INTEGER
			-- Routine id of the feature

	written_class_id: INTEGER
			-- Class ID where feature is written.

	pattern_id: INTEGER
			-- Pattern id of the feature

	-- The corresponding C name of the generated feature in the concatenation
	-- of the body_index (which is the id for the byte code server) and of
	-- the current type id in final mode only. for the workbench mode, we
	-- used the feature id instead of the body index.

	arguments: ARRAY [TYPE_A]
			-- List of argument types of the feature: can be Void

	result_type: TYPE_A
			-- Result type of the feature: can be Void.

	locals: ARRAY [TYPE_A]
			-- List of local types of the feature, including its object test locals: can be Void.

	local_count: INTEGER
			-- Number of local variables declared in the feature

	precondition: ASSERTION_BYTE_CODE
			-- List of ASSERT_B instances: can be Void.

	postcondition: ASSERTION_BYTE_CODE
			-- List of ASSERT_B instances: can be Void.

	old_expressions: LINKED_LIST [UN_OLD_B]
			-- List of UN_OLD_B instances: can be Void.

	rescue_clause: BYTE_LIST [BYTE_NODE]
			-- List of INSTR_B instances: can be Void.

	property_name_id: INTEGER
			-- Name ID of an associated property (if any)

	property_name: STRING is
			-- Name of an associated property (if any)
		do
			if property_name_id > 0 then
				Result := Names_heap.item (property_name_id)
			elseif property_name_id /= 0 then
				Result := once ""
			end
		ensure
			Result_not_void: property_name_id /= 0 implies Result /= Void
			Result_not_empty: property_name_id > 0 implies not Result.is_empty
			Result_empty: property_name_id < 0 implies Result.is_empty
		end

	clear_old_expressions is
			-- Clear old_expressions
		require
			valid_old_exp: old_expressions /= Void
		do
			old_expressions.wipe_out
		end

	compound: BYTE_LIST [BYTE_NODE] is
			-- Compound byte code
		do
			-- Do nothing: to be redefined in STD_BYTE_CODE
		end; -- compound

	custom_attributes: BYTE_LIST [BYTE_NODE]
			-- Custom attributes if any.

	interface_custom_attributes: BYTE_LIST [BYTE_NODE]
			-- Interface custom attributes if any.

	class_custom_attributes: BYTE_LIST [BYTE_NODE]
			-- Class custom attributes if any.

	property_custom_attributes: BYTE_LIST [BYTE_NODE]
			-- Property custom attributes (if any)

	is_external: BOOLEAN is
			-- Is the current byte code relative to an external feature ?
		do
			-- Do nothing
		end

	is_deferred: BOOLEAN is
			-- Is the current byte code relative to a deferred feature ?
		do
			-- Do nothing
		end

	is_once: BOOLEAN is
			-- Is the current byte code relative to a once feature ?
		do
			-- Do nothing
		end

	once_manifest_string_count: INTEGER
			-- Number of once manifest strings in immediate (i.e., not inherited)
			-- precondition, body, postcondition and rescue clause

feature -- Settings

	set_feature_name_id (id: INTEGER) is
			-- Assign `id' to `feature_name_id'.
		require
			valid_id: id > 0
		do
			feature_name_id := id
		ensure
			feature_name_id_set: feature_name_id = id
		end

	set_property_name (n: STRING) is
			-- Set `property_name' to `n'.
		require
			n_attached: n /= Void
		do
			if n.is_empty then
				property_name_id := -1
			else
				names_heap.put (n)
				property_name_id := names_heap.found_item
			end
		ensure
			property_name_set: equal (property_name, n)
		end

	set_real_body_id (i: INTEGER) is
			-- Assign `i' to `real_body_id'.
		do
			real_body_id := i
		end

	set_start_line_number (l: like start_line_number) is
			-- Assign `l' to `start_line_number'.
		do
			start_line_number := l
		ensure
			start_line_number_set: start_line_number = l
		end

	set_end_location (e: like end_location) is
			-- Assign `e' to `end_location'.
		require
			e_not_void: e /= Void
		do
			end_location := e
		ensure
			end_location_set: end_location = e
		end

	set_rout_id (i: INTEGER) is
			-- Assign `i' to `rout_id'.
		do
			rout_id := i
		end

	set_written_class_id (i: like written_class_id) is
			-- Assign `i' to `rout_id'.
		do
			written_class_id := i
		ensure
			written_class_id_set: written_class_id = i
		end

	set_pattern_id (i: INTEGER) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i
		end

	set_result_type (t: TYPE_A) is
			-- Assign `t' to `result_type'.
		do
			result_type := t
		end

	set_precondition (var: like precondition) is
			-- Assign `var' to `precondition'.
		do
			precondition := var
		end

	set_postcondition (var: like postcondition) is
			-- Assign `var' to `postcondition'.
		do
			postcondition := var
		end

	set_old_expressions (var: like old_expressions) is
			-- Assign `var' to old_expressions.
		require
			exp_not_empty: (var /= Void) implies not var.is_empty
		do
			old_expressions := var
		end

	set_custom_attributes (cas: like custom_attributes) is
			-- Assign `cas' to `custom_attributes'.
		do
			custom_attributes := cas
		ensure
			custom_attributes_set: custom_attributes = cas
		end

	set_class_custom_attributes (cas: like class_custom_attributes) is
			-- Assign `cas' to `class_custom_attributes'.
		do
			class_custom_attributes := cas
		ensure
			class_custom_attributes_set: class_custom_attributes = cas
		end

	set_interface_custom_attributes (cas: like interface_custom_attributes) is
			-- Assign `cas' to `interface_custom_attributes'.
		do
			interface_custom_attributes := cas
		ensure
			interface_custom_attributes_set: interface_custom_attributes = cas
		end

	set_property_custom_attributes (cas: like property_custom_attributes) is
			-- Assign `cas' to `property_custom_attributes'.
		do
			property_custom_attributes := cas
		ensure
			property_custom_attributes_set: property_custom_attributes = cas
		end

	set_rescue_clause (var: like rescue_clause) is
			-- Assign `var' to `rescue_clause'.
		do
			rescue_clause := var
		end

	set_arguments (a: like arguments) is
			-- Assing `a' to `arguments'.
		do
			arguments := a
		end

	set_locals (l: like locals; n: like local_count)
			-- Assign `l' to `locals' and `n' to `local_count'.
		require
			l_attached: n > 0 implies l /= Void
			n_non_negative: n >= 0
			n_small_enough: l /= Void implies n <= l.count
		do
			locals := l
			local_count := n
		ensure
			locals_set: locals = l
			local_count_set: local_count = n
		end

	set_once_manifest_string_count (oms_count: like once_manifest_string_count) is
			-- Set `once_manifest_string_count' to `oms_count'.
		require
			valid_oms_count: oms_count >= 0
		do
			once_manifest_string_count := oms_count
		ensure
			once_manifest_string_count_set: once_manifest_string_count = oms_count
		end

	enlarge_tree is
			-- Enlarges byte code tree for C code generation
		do
			enlarge_body_tree (True, True)
		end

	enlarge_body_tree (a_has_precond, a_has_postcond: BOOLEAN) is
			-- Enlarges byte code tree for C code generation
		local
			inh_assert: INHERITED_ASSERTION
		do
			if a_has_precond then
				inh_assert := Context.inherited_assertion
				if inh_assert.has_precondition then
					inh_assert.enlarge_precondition_tree
				end
				if precondition /= Void then
					Context.set_assertion_type (In_precondition)
					precondition.enlarge_tree
					Context.set_assertion_type (0)
				end
			end
			if compound /= Void then
				compound.enlarge_tree
			end
			if a_has_postcond then
				if inh_assert = Void then
					inh_assert := Context.inherited_assertion
				end
				if inh_assert.has_postcondition then
					inh_assert.enlarge_postcondition_tree
				end
				if old_expressions /= Void then
					--! Wipe out old expression and rebuild
					--! it with enlarged function through
					--! postconditions enlargement.
					--! (Look at enlarged in class UN_OLD_B)
					old_expressions.wipe_out
				end
				if postcondition /= Void then
					postcondition.enlarge_tree
				end
			end
			if rescue_clause /= Void then
				rescue_clause.enlarge_tree
			end
		end

	feature_origin (buf: GENERATION_BUFFER) is
			-- Value of the dynamic type where the feature is written
		do
			if Context.workbench_mode then
				buf.put_string ("RTUD(")
				buf.put_static_type_id (context.class_type.static_type_id)
				buf.put_character (')')
			else
				buf.put_type_id (context.class_type.type_id)
			end
		end

	argument_names: ARRAY [STRING] is
			-- Names of the arguments
		local
			i, j, count: INTEGER
			temp: STRING
		do
			if arguments /= Void then
				count := arguments.count
				if generate_current then
					create Result.make (1, count + 1)
					Result.put ("Current", 1)
					j := 2
				else
					create Result.make (1, count)
					j := 1
				end
				from
					i := 1
				until
					i > count
				loop
					temp := "arg"
					temp.append_integer (i)
					if context.workbench_mode and then not system.il_generation then
						temp.append_character ('x')
					end
					Result.put (temp, j)
					i := i + 1
					j := j + 1
				end
			elseif generate_current then
				create Result.make (1, 1)
				Result.put ("Current", 1)
			else
				create Result.make (1, 0)
			end
		end

	generate_current: BOOLEAN is True
			-- Is Current included in argument generation?

	argument_types: ARRAY [STRING] is
			-- Declare C parameters, if any, as part of the definition.
		local
			type_name: STRING
			i, j, count: INTEGER
		do
			if arguments /= Void then
				count := arguments.count
				if generate_current then
					create Result.make (1, count + 1)
					Result.put ("EIF_REFERENCE", 1)
					j := 2
				else
					create Result.make (1, count)
					j := 1
				end
				from
					i := 1
				until
					i > count
				loop
					if context.workbench_mode then
						type_name := once "EIF_TYPED_VALUE"
					else
						type_name := real_type (arguments.item (i)).c_type.c_string
					end
					Result.put (type_name, j)
					i := i + 1
					j := j + 1
				end
			elseif generate_current then
				create Result.make (1, 1)
				Result.put ("EIF_REFERENCE", 1)
			else
				create Result.make (1, 0)
			end
		ensure
			argument_types_not_void: Result /= Void
		end

	finish_compound is
			-- Generate the end of the compound
		do
			-- Do nothing
		end

	generate_old_variables is
			-- Generate value for old variables
		local
			inh_assert: INHERITED_ASSERTION
			item: UN_OLD_BL
			buf: GENERATION_BUFFER
		do
			inh_assert := Context.inherited_assertion
			if
				Context.has_postcondition and then (old_expressions /= Void
				or else inh_assert.has_old_expression)
			then
				buf := buffer
				buf.put_new_line
				buf.put_string ("if (RTAL & CK_ENSURE) {")
				buf.indent
				buf.put_new_line
				buf.put_string ("in_assertion = ~0;")
				if old_expressions /= Void then
					from
						old_expressions.start
					until
						old_expressions.after
					loop
						item ?= old_expressions.item
						item.initialize; -- Cannot fail
						old_expressions.forth
					end
				end
				if inh_assert.has_old_expression then
						-- Generate old assertions
					inh_assert.generate_old_variables
				end

				buf.put_new_line
				buf.put_string ("in_assertion = 0;")

				buf.exdent
				buf.put_new_line
				buf.put_character ('}')
			end
		end

feature -- Inherited Assertions

	formulate_inherited_assertions (assert_id_set: ASSERT_ID_SET) is
			-- Formulate inherited post and pre conditions
			-- from the precursor definition of feature `feat'
			-- and save the details in inherited_assertion.
		require
			valid_arg: assert_id_set /= Void
			current_not_basic: not Context.associated_class.is_basic
		local
			byte_code: BYTE_CODE
			inh_f: INH_ASSERT_INFO
			ct: CLASS_TYPE
			inh_c: CLASS_C
			i: INTEGER
			gen_prec: BOOLEAN
			has_assertion: BOOLEAN
		do
				--| Check to see if origin feature has precondition
			gen_prec := assert_id_set.has_precondition
			Context.set_origin_has_precondition (gen_prec)

			from
				i := 1
			until
				i > assert_id_set.count
			loop
				inh_f := assert_id_set.item (i)
					-- Do not include assertions with the same `body_index'
					-- as current feature, because they are generated as
					-- non-inherited ones. This situation happens when
					-- the feature code is regenerated in the context of a
					-- descendant (e.g., in the expanded class).
					--| Only generate precondition if the origin of
					--| the feature has a precondition
				has_assertion := inh_f.body_index /= body_index and then
					(inh_f.has_postcondition or else
					(inh_f.has_precondition and then gen_prec))
				if has_assertion then
					--! Has assertion
					inh_c := System.class_of_id (inh_f.written_in)
					ct := inh_c.meta_type (Context.original_class_type)
					byte_code := System.byte_server.disk_item (inh_f.body_index)
					if inh_f.has_precondition and gen_prec then
						Context.inherited_assertion.add_precondition_type (ct, byte_code)
					end
					if inh_f.has_postcondition then
						Context.inherited_assertion.add_postcondition_type (ct, byte_code)
					end
				end
				i := i + 1
			end
		end

feature -- IL code generation

	generate_il is
			-- Generate IL byte code.
		do
			cil_node_generator.generate_il (il_generator, Current)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code
		require else
			not_external: not is_external
			valid_class_type: Context.class_type /= Void
		local
			i, nb: INTEGER
			l_type, l_adapted_type: TYPE_A;
			local_list: ARRAYED_LIST [TYPE_A]
			bit_i: BITS_A
			inh_assert: INHERITED_ASSERTION
			feat: FEATURE_I
		do
			local_list := context.local_list
			local_list.wipe_out
			feat := Context.current_feature
			inh_assert := Context.inherited_assertion
			inh_assert.init
			Context.set_origin_has_precondition (True)
			if not Context.associated_class.is_basic and then
				feat.assert_id_set /= Void
			then
					--! Do not get inherited pre & post for basic types
				formulate_inherited_assertions (feat.assert_id_set)
			end

			Temp_byte_code_array.clear

				-- Once mark and reserved space for once key.
			append_once_mark (Temp_byte_code_array)

				-- Header for byte code.
			Temp_byte_code_array.append (Bc_start)

				-- Routine id
			Temp_byte_code_array.append_integer (rout_id)

				-- Real body id
			Temp_byte_code_array.append_integer (real_body_id - 1)

				-- Result SK value
			l_type := context.real_type (result_type)
			Temp_byte_code_array.append_integer (l_type.sk_value (context.context_class_type.type))

				-- Argument number
			Temp_byte_code_array.append_short_integer (argument_count)

				-- Set up the local variables
			setup_local_variables (True)

				-- Feature name
			ba.append_raw_string (feature_name)

				-- Dynamic type where the feature is written in
			ba.append_short_integer (context.class_type.type_id - 1)

				-- Rescue offset if any.
			if rescue_clause /= Void then
				ba.append ('%/001/')
				ba.mark_forward
			else
				ba.append ('%U')
			end

				-- Record retry offset
			ba.mark_retry

				-- Compound byte code
			make_body_code (ba, melted_generator)

			if rescue_clause /= Void then
					-- Jump to the end of the rescue clause in case of normal execution.
				ba.append (bc_jmp)
				ba.mark_forward2
					-- Mark the start of the rescue clause.
				ba.write_forward
				ba.append (Bc_rescue)
				melted_generator.generate (ba, rescue_clause)
				ba.append (Bc_end_rescue)
					-- Mark the end of the rescue clause.
				ba.write_forward2
			end

				-- Generate the hook corresponding to the final end.
			generate_melted_end_debugger_hook (ba)
			ba.append (Bc_null)

			from
				Temp_byte_code_array.append_short_integer (local_list.count)
				local_list.start
			until
				local_list.after
			loop
				l_type := local_list.item
				Temp_byte_code_array.append_integer (l_type.sk_value (context.context_class_type.type))
				l_adapted_type := context.real_type (l_type)
				if l_adapted_type.is_true_expanded and then not l_adapted_type.is_bit then
						-- Generate full type info.
					l_type.make_full_type_byte_code (Temp_byte_code_array, context.context_class_type.type)
				end
				local_list.forth
			end

				-- Expanded Clone
			if arguments /= Void then
				from
					i := 1
					nb := arguments.count
				until
					i > nb
				loop
					l_type := arguments.item (i)
					l_adapted_type := context.real_type (l_type)
					if l_adapted_type.is_bit then
						Temp_byte_code_array.append_natural_8 ({SHARED_GEN_CONF_LEVEL}.bit_tuple_code_extension)
						bit_i ?= l_adapted_type
						Temp_byte_code_array.append_integer(bit_i.bit_count)
					elseif l_adapted_type.is_true_expanded then
						Temp_byte_code_array.append_natural_8 ({SHARED_GEN_CONF_LEVEL}.expanded_tuple_code_extension)
						l_type.make_full_type_byte_code (Temp_byte_code_array, context.context_class_type.type)
					else
						Temp_byte_code_array.append_natural_8 (l_adapted_type.c_type.tuple_code)
					end
					i := i + 1
				end
			end

			l_adapted_type := context.real_type(result_type)
			if l_adapted_type.is_true_expanded and then not l_adapted_type.is_bit then
					-- Generate full type info.
				result_type.make_full_type_byte_code (Temp_byte_code_array, context.context_class_type.type)
			end

			context.byte_prepend (ba, Temp_byte_code_array)

				-- Clean the context
			inh_assert.wipe_out

debug ("DEBBUGGER_HOOK")
		-- ASSERTION TO CHECK THAT `number_of_breakpoint_slots' is correct
	if context.get_breakpoint_slot + 1 /= context.current_feature.number_of_breakpoint_slots then
		io.put_string ("STD_BYTE_CODE: Error in breakable line number computation for: %N")
		io.put_string ("{"+context.original_class_type.associated_class.lace_class.name+"}")
		io.put_string ("."+context.current_feature.feature_name+"%N%N")
	end
end
		end

	make_catcall_check (ba: BYTE_ARRAY) is
			-- Add a check for catcall at runtime.
		require
			ba_not_void: ba /= Void
		local
			i: INTEGER
			l_argument_types: like arguments
			l_type: TYPE_A
			l_any_type: CL_TYPE_A
			l_any_class_id, l_name_id: INTEGER
			l_arg: ARGUMENT_BL
			l_optimize_like_current: BOOLEAN
		do
				-- We do not have to generate a catcall detection for some features of ANY
				-- which are properly handled at runtime.
			l_name_id := context.current_feature.feature_name_id
			l_any_class_id := system.any_id
			if
				context.current_feature.written_in /= l_any_class_id or else
				(l_name_id /= {PREDEFINED_NAMES}.equal_name_id or
				l_name_id /= {PREDEFINED_NAMES}.standard_equal_name_id)
			then
				i := argument_count
				if i > 0 then
					from
						l_argument_types := arguments
						ba.append ({BYTE_CONST}.bc_start_catcall)
					until
						i <= 0
					loop
						l_type := l_argument_types [i]
							-- We instantiate `l_type' in current context to see if it is
							-- really a reference
						if context.real_type (l_type).c_type.is_pointer then
							l_any_type ?= l_type
								-- Only generate a catcall detection if the expected argument is different
								-- than ANY since ANY is the ancestor to all types.
							if l_any_type = Void or else l_any_type.class_id /= l_any_class_id then
								if l_arg = Void then
									create l_arg
									l_optimize_like_current := not attribute_assignment_detector.has_attribute_assignment (Current)
								end
									-- Push argument on stack.
								l_arg.set_position (i)
								melted_generator.generate (ba, l_arg)
									-- Perform catcall check
								context.make_catcall_check (ba, l_type, i, l_optimize_like_current)
									-- Remove argument from stack.
								ba.append ({BYTE_CONST}.bc_pop)
								ba.append_uint32_integer (1)
							end
						end
						i := i - 1
					end
					ba.append ({BYTE_CONST}.bc_end_catcall)
				end
			end
		end

	append_once_mark (ba: BYTE_ARRAY) is
			-- Append byte code indicating a kind of a once routine
			-- (not once, thread-relative once, process-relative once, etc.)
			-- and associated information (if required)
		require
			ba_not_void: ba /= Void
		do
				-- Append non-once mark by default
			ba.append ('%U')
		end

	setup_local_variables (is_old_expression_included: BOOLEAN)
			-- Set the local variable type (which includes old expressions
			-- if `is_old_expression_included' is true).
		local
			nb, i, position: INTEGER
			item: UN_OLD_B
			l_old_expressions: like old_expressions
			l_type: TYPE_A
			l_il_generation: BOOLEAN
			assert_chheck: BOOLEAN
		do
			context.add_locals (locals)
			assert_chheck := context.workbench_mode or
				context.system.keep_assertions
			if assert_chheck then
				Context.inherited_assertion.add_object_test_locals
			end
			if is_old_expression_included then
				position := context.local_list.count + 1
				l_old_expressions := old_expressions
				l_il_generation := System.il_generation
				if
					(not l_il_generation and then l_old_expressions /= Void) or else
					(l_il_generation and then l_old_expressions /= Void and then
					assert_chheck)
				then
					from
						nb := l_old_expressions.count
						l_old_expressions.start
						i := 1
					until
						i > nb
					loop
						item := l_old_expressions.item
						l_type := context.real_type (item.type)
						Context.add_local (l_type)
						item.set_position (position)
						position := position + 1
						Context.add_local (item.exception_type)
						item.set_exception_position (position)
						position := position + 1
						l_old_expressions.forth
						i := i + 1
					end
				end
				if assert_chheck then
					Context.inherited_assertion.setup_local_variables (position)
				end
			end
		end

	make_body_code (ba: BYTE_ARRAY; a_generator: MELTED_GENERATOR) is
			-- Generate compound byte code
		require
			good_argument: ba /= Void
			a_generator_not_void: a_generator /= Void
		deferred
		end

	argument_count: INTEGER is
			-- Number of formal arguments
		do
			if arguments /= Void then
				Result := arguments.count
			end
		end

	Temp_byte_code_array: BYTE_ARRAY is
			-- Temporary byte code array
		once
			create Result.make
		end

feature -- Array optimization

	has_loop: BOOLEAN
			-- Does the current byte code has a loop construct?
			--| Set during the creation of the byte code at degree 3.

	set_has_loop (v: BOOLEAN) is
			-- Assign `v' to `has_loop'.
		do
			has_loop := v
		ensure
			has_loop_set: has_loop = v
		end

	has_array_as_argument: BOOLEAN is
			-- Is ARRAY or one of its descendants used as an argument
		do
			Result := has_array_as_item (arguments)
		end

	has_array_as_local: BOOLEAN is
			-- Is ARRAY or one of its descendants used as an local
		do
			Result := has_array_as_item (locals)
		end

	has_array_as_result: BOOLEAN is
			-- Is ARRAY or one of its descendants used as result
		do
			Result := result_type /= Void and then
				Result_type.conforms_to_array
		end

feature {NONE} -- Array optimization

	has_array_as_item (a: ARRAY [TYPE_A]): BOOLEAN is
		local
			i, n: INTEGER
		do
			if a /= Void then
				from
					n := a.count
					i := 1
				until
					Result or else i > n
				loop
					Result := a.item (i).conforms_to_array
					i := i + 1
				end
			end
		end

feature -- Inlining

	has_inlined_code: BOOLEAN is
			-- Does the current byte code inline some of the calls ?
		do
		end

invariant

	valid_once_manifest_string_count: once_manifest_string_count >= 0

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
