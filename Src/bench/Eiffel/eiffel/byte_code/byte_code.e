-- Byte code for a routine.

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

	BYTE_NODE
		redefine
			make_byte_code, enlarge_tree, generate_il
		end

	SHARED_C_LEVEL

	SHARED_PATTERN_TABLE

	ASSERT_TYPE

feature 

	real_body_id: INTEGER
			-- Real body id of the feature to which current byte code belongs

	feature_name: STRING
			-- Name of the feature to which the current byte code tree
			-- belongs to

	rout_id: INTEGER
			-- Routine id of the feature

	pattern_id: INTEGER
			-- Pattern id of the feature

	-- The corresponding C name of the generated feature in the concatenation
	-- of the body_index (which is the id for the byte code server) and of
	-- the current type id in final mode only. for the workbench mode, we
	-- used the feature id instead of the body index.

	arguments: ARRAY [TYPE_I]
			-- List of argument types of the feature: can be Void

	result_type: TYPE_I
			-- Result type of the feature: can be Void.

	locals: ARRAY [TYPE_I]
			-- List of local types of the feature: can be Void.

	precondition: BYTE_LIST [BYTE_NODE]
			-- List of ASSERT_B instances: can be Void.

	postcondition: BYTE_LIST [BYTE_NODE]
			-- List of ASSERT_B instances: can be Void.

	old_expressions: LINKED_LIST [UN_OLD_B]
			-- List of UN_OLD_B instances: can be Void.

	rescue_clause: BYTE_LIST [BYTE_NODE]
			-- List of INSTR_B instances: can be Void.

	has_default_rescue: BOOLEAN
			-- Is `rescue_clause' the default_rescue?

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

	is_once: BOOLEAN is
			-- Is the current byte code relative to a once feature ?
		do
			-- Do nothing
		end

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

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s
		end

	set_real_body_id (i: INTEGER) is
			-- Assign `i' to `real_body_id'.
		do
			real_body_id := i
		end

	set_rout_id (i: INTEGER) is
			-- Assign `i' to `rout_id'.
		do
			rout_id := i
		end

	set_pattern_id (i: INTEGER) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i
		end

	set_result_type (t: TYPE_I) is
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

	set_rescue_clause (var: like rescue_clause) is
			-- Assign `var' to `rescue_clause'.
		do
			rescue_clause := var
		end

	set_default_rescue (v: BOOLEAN) is
			-- Assign `v' to `has_default_rescue'.
		do
			has_default_rescue := v
		ensure
			default_rescue_set: has_default_rescue = v
		end

	set_arguments (a: like arguments) is
			-- Assing `a' to `arguments'.
		do
			arguments := a
		end

	set_locals (l: like locals) is
			-- Assign `l' to `locals'.
		do
			locals := l
		end

	enlarge_tree is
			-- Enlarges byte code tree for C code generation
		local
			inh_assert: INHERITED_ASSERTION
		do
			inh_assert := Context.inherited_assertion
			if inh_assert.has_assertion then
				inh_assert.enlarge_tree
			end
			if precondition /= Void then
				Context.set_assertion_type (In_precondition)
				precondition.enlarge_tree
				Context.set_assertion_type (0)
			end
			if compound /= Void then
				compound.enlarge_tree
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
			if rescue_clause /= Void then
				rescue_clause.enlarge_tree
			end
		end

	feature_origin (buf: GENERATION_BUFFER) is
			-- Value of the dynamic type where the feature is written
		do
			if Context.workbench_mode then
				buf.putstring ("RTUD(")
				buf.generate_type_id (context.class_type.static_type_id)
				buf.putchar (')')
			else
				buf.putint (context.class_type.type_id - 1)
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
					!! Result.make (1, count + 1)
					Result.put ("Current", 1)
					j := 2
				else
					!! Result.make (1, count)
					j := 1
				end
				from
					i := 1
				until
					i > count
				loop
					temp := "arg"
					temp.append_integer (i)
					Result.put (temp, j)
					i := i + 1
					j := j + 1
				end
			elseif generate_current then
				!! Result.make (1, 1)
				Result.put ("Current", 1)
			else
				!! Result.make (1, 0)
			end
		end

	generate_arguments is
			-- Generate C arguments, if any, in the definition.
		local
			i, count: INTEGER
			a: like argument_names
			buf: GENERATION_BUFFER
		do
			from
				a := argument_names
				i := 1
				count := a.count
				buf := buffer
				if i <= count then
					buf.putstring (a @ i)
					i := i + 1
				end
			until
				i > count
			loop
				buf.putstring (gc_comma)
				buf.putstring (a @ i)
				i := i + 1
			end
		end

	generate_current: BOOLEAN is
			-- Is Current included in argument generatin?
		do
			Result := True
		end

	argument_types: ARRAY [STRING] is
			-- Declare C parameters, if any, as part of the definition.
		local
			arg: TYPE_I
			i, j, count: INTEGER
		do
			if arguments /= Void then
				count := arguments.count
				if generate_current then
					!! Result.make (1, count + 1)
					Result.put ("EIF_REFERENCE", 1)
					j := 2
				else
					!! Result.make (1, count)
					j := 1
				end
				from
					i := 1
				until
					i > count
				loop
					arg := real_type (arguments.item (i))
					Result.put (arg.c_type.c_string, j)
					i := i + 1
					j := j + 1
				end
			elseif generate_current then
				!! Result.make (1, 1)
				Result.put ("EIF_REFERENCE", 1)
			else
				!! Result.make (1, 0)
			end
		end

	generate_arg_declarations is
			-- Declare C parameters, if any, as part of the definition.
		local
			i, count: INTEGER
			a_types: like argument_types
			a_names: like argument_names
			buf: GENERATION_BUFFER
		do
			from
				a_types := argument_types
				a_names := argument_names
				i := 1
				count := argument_names.count
				buf := buffer
				if i <= count then
					buf.putstring (argument_types @ i)
					buf.putchar (' ')
					buf.putstring (argument_names @ i)
					buf.putchar (';')
					i := i + 1
				end
			until
				i > count
			loop
				buf.putstring (gc_comma)
				buf.putstring (argument_types @ i)
				buf.putchar (' ')
				buf.putstring (argument_names @ i)
				buf.putchar (';')
				i := i + 1
			end
		end

	process_expanded is
			-- Enlarge expanded arguements
		local
			arg: TYPE_I
			i, count: INTEGER
		do
			if arguments /= Void then
				from
					i := arguments.lower
					count := arguments.count
				until
					i > count
				loop
					arg := real_type (arguments.item (i))
					if arg.is_true_expanded then
						context.inc_exp_args
						context.Arg_var.set_position (i)
						context.set_local_index (context.Arg_var.register_name,
							context.Arg_var.enlarged)
					end
					i := i + 1
				end
			end
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
				if Context.workbench_mode then
					buf.putstring ("if (RTAL & CK_ENSURE) {")
					buf.new_line
					buf.indent
				else
					buf.putstring ("if (~in_assertion) {");					
					buf.new_line
					buf.indent
				end
				buf.putstring ("in_assertion = ~0;")
				buf.new_line
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

				buf.putstring ("in_assertion = 0;")
				buf.new_line
				
				buf.exdent
				buf.putchar ('}')
				buf.new_line
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
					--| Only generate precondition if the origin of 
					--| the feature has a precondition
				has_assertion := inh_f.has_postcondition or else
								 (inh_f.has_precondition and then gen_prec)
				if has_assertion then
					--! Has assertion
					inh_c := System.class_of_id (inh_f.written_in)
					if inh_c.generics = Void then
						ct := inh_c.types.first
					else
						ct := inh_c.meta_type (Context.current_type).associated_class_type
					end
					byte_code := System.byte_server.item (inh_f.body_index)
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
			-- Generate IL byte code
		do
			generate_il_body
			generate_il_return (not context.real_type(result_type).is_void)
		end

	generate_il_body is
			-- Generate IL byte code
		local
			r_type: TYPE_I
			local_list: LINKED_LIST [TYPE_I]
			inh_assert: INHERITED_ASSERTION
			feat: FEATURE_I
			class_c: CLASS_C
			end_of_assertion: IL_LABEL
			end_of_routine: IL_LABEL
			exception_occurred: INTEGER
		do
			class_c := context.class_type.associated_class
			local_list := context.local_list
			local_list.wipe_out
			feat := Context.associated_class.feature_table.item (feature_name)
			inh_assert := Context.inherited_assertion
			inh_assert.init
			Context.set_origin_has_precondition (True)
			if not Context.associated_class.is_basic and then
				feat.assert_id_set /= Void 
			then
					--! Do not get inherited pre & post for basic types
				formulate_inherited_assertions (feat.assert_id_set)
			end

				-- Set up the local variables
			setup_local_variables

				-- Initialize use of local variables to IL side
			r_type := context.real_type(result_type)
			if not r_type.is_void then
				il_generator.put_result_info (r_type)
			end

			if not local_list.is_empty then
				generate_il_local_info (local_list)
			end

			if rescue_clause /= Void then
				context.add_local (Boolean_c_type)
				exception_occurred := context.local_list.count
				il_generator.put_dummy_local_info (Boolean_c_type, exception_occurred)
				il_label_factory.create_retry_label
				il_generator.mark_label (il_label_factory.retry_label)
				il_generator.generate_start_exception_block
				end_of_routine := Il_label_factory.new_label
			end

				-- Make IL code for preconditions
			if
				class_c.assertion_level.check_precond
			then
				context.set_assertion_type (In_precondition)
				end_of_assertion := il_label_factory.new_label
				il_generator.generate_in_assertion_test (end_of_assertion)
				il_generator.generate_set_assertion_status
				generate_il_precondition
				il_generator.generate_restore_assertion_status
				il_generator.mark_label (end_of_assertion)
			end
			
			if class_c.assertion_level.check_postcond then
				end_of_assertion := il_label_factory.new_label
				il_generator.generate_in_assertion_test (end_of_assertion)
				il_generator.generate_set_assertion_status
				if
					postcondition /= Void and then
					old_expressions /= Void
				then
					from
						old_expressions.start
					until
						old_expressions.after
					loop
						old_expressions.item.generate_il_init
						old_expressions.forth
					end
				end
				if inh_assert.has_postcondition then
					inh_assert.generate_il_old_exp_init
				end
				il_generator.generate_restore_assertion_status
				il_generator.mark_label (end_of_assertion)
			end

			if compound /= Void then
				compound.generate_il
			end

				-- Make IL code for postcondition
			if class_c.assertion_level.check_postcond then
				end_of_assertion := il_label_factory.new_label
				il_generator.generate_in_assertion_test (end_of_assertion)
				il_generator.generate_set_assertion_status
				context.set_assertion_type (In_postcondition)
				if postcondition /= Void then
					postcondition.generate_il
				end
				if inh_assert.has_postcondition then
					inh_assert.generate_il_postcondition
				end
				il_generator.generate_restore_assertion_status
				il_generator.mark_label (end_of_assertion)
			end
			
			if rescue_clause /= Void then
				il_generator.generate_start_rescue
				il_generator.put_boolean_constant (True)
				il_generator.generate_local_assignment (exception_occurred)
				il_generator.generate_end_exception_block

				il_generator.generate_local (exception_occurred)
				il_generator.branch_on_false (end_of_routine)
				il_generator.put_boolean_constant (False)
				il_generator.generate_local_assignment (exception_occurred)
				rescue_clause.generate_il
				il_generator.mark_label (end_of_routine)
			end
			inh_assert.wipe_out
		end
	
	generate_il_return (has_return_value: BOOLEAN) is
			-- Generate IL final return statement
		do
			if not has_return_value then
				il_generator.generate_return
			else
				il_generator.generate_return_value
			end
		end

	generate_il_precondition is
			-- Generate IL precondition checking blocks.
		local
			inh_assert: INHERITED_ASSERTION
			success_block, failure_block: IL_LABEL
			l_prec: like precondition
			assert_b: ASSERT_B
			need_end_label: BOOLEAN
		do
			inh_assert := Context.inherited_assertion
			if precondition /= Void then
				from
					need_end_label := True
					success_block := il_label_factory.new_label
					failure_block := il_label_factory.new_label
					l_prec := precondition
					l_prec.start
				until
					l_prec.after
				loop
					assert_b ?= l_prec.item
					check
						assert_b_not_void: assert_b /= Void
					end
					assert_b.generate_il_precondition (failure_block)
					l_prec.forth
				end
				il_generator.branch_to (success_block)
				il_generator.mark_label (failure_block)
			end

			if inh_assert.has_precondition then
				inh_assert.generate_il_precondition
				if need_end_label then
					il_generator.mark_label (success_block)
				end
			else
				if need_end_label then
					il_generator.generate_precondition_violation
					il_generator.mark_label (success_block)
				end
			end
		end

	generate_il_local_info (local_list: LINKED_LIST [TYPE_I]) is
			-- Generate IL info for local variables in `local_list'.
		require
			local_list_not_void: local_list /= Void
			local_list_not_empty: not local_list.is_empty
		local
			feature_as: FEATURE_AS
			routine_as: ROUTINE_AS
			id_list: ARRAYED_LIST [INTEGER]
			rout_locals: EIFFEL_LIST [TYPE_DEC_AS]
			debug_generation: BOOLEAN
			i: INTEGER
		do
				-- Do we generate debug information for local variables.
			debug_generation := System.line_generation

			if debug_generation then
				feature_as := System.Body_server.item (body_index)
				routine_as ?= feature_as.body.content
				if routine_as /= Void and then routine_as.locals /= Void then
						-- `local_list' is in the same order as `routine_as.locals'
						-- so this is easy to find for each element of `local_list'
						-- its name in `routine_as.locals'.
					rout_locals := routine_as.locals
					from
						rout_locals.start
						local_list.start
					until
						local_list.after
					loop
						if not rout_locals.after then
							from
								id_list := rout_locals.item.id_list
								id_list.start
							until	
								id_list.after
							loop
								il_generator.put_local_info (local_list.item, id_list.item)
								local_list.forth
								id_list.forth
							end
							rout_locals.forth
						else
							il_generator.put_nameless_local_info (local_list.item, i)
							i := i + 1
							local_list.forth
						end
					end
				else
						-- No local variables were found in routine text, therefore
						-- we have only temporary local variables that are generated
						-- using no debug information.
					debug_generation := False
				end
			end

			if not debug_generation then
					-- Generation of local variable without debug information
				from
					local_list.start
				until
					local_list.after
				loop
					il_generator.put_nameless_local_info (local_list.item, i)
					i := i + 1
					local_list.forth
				end				
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code
		require else
			not_external: not is_external
			valid_class_type: Context.class_type /= Void
		local
			i, nb: INTEGER
			r_type, formal_type: TYPE_I;	
			local_list: LINKED_LIST [TYPE_I]
			bit_i: BIT_I
			expanded_type: CL_TYPE_I
			gen_type: GEN_TYPE_I
			inh_assert: INHERITED_ASSERTION
			feat: FEATURE_I
		do
			local_list := context.local_list
			local_list.wipe_out
			feat := Context.associated_class.feature_table.item (feature_name)
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

			if is_once then
					-- The once mark
				Temp_byte_code_array.append ('%/001/')
					-- Allocate space for once key
				Temp_byte_code_array.allocate_space (Long_c_type)
			else
					-- Not a once routine
				Temp_byte_code_array.append ('%U')
			end

				-- Header for byte code.
			Temp_byte_code_array.append (Bc_start)

				-- Routine id
			Temp_byte_code_array.append_integer (rout_id)

				-- Real body id
			Temp_byte_code_array.append_integer (real_body_id - 1)

				-- Result SK value
			r_type := context.real_type(result_type)
			Temp_byte_code_array.append_integer (r_type.sk_value)

				-- Argument number
			Temp_byte_code_array.append_short_integer (argument_count)

				-- Set up the local variables
			setup_local_variables

				-- Feature name
			ba.append_raw_string (feature_name)

				-- Dynamic type where the feature is written in
			ba.append_short_integer (context.current_type.type_id - 1)

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
			make_body_code (ba)

			ba.append (Bc_null)

			if rescue_clause /= Void then
				ba.write_forward
				ba.append (Bc_rescue)
				rescue_clause.make_byte_code (ba)
				ba.append (Bc_end_rescue)
			end

			from
				Temp_byte_code_array.append_short_integer (local_list.count)
				local_list.start
			until
				local_list.after
			loop
				Temp_byte_code_array.append_integer (local_list.item.sk_value)

				formal_type := context.real_type (local_list.item)
				if formal_type.is_true_expanded and then not formal_type.is_bit then
					-- Generate full type info.
					expanded_type ?= formal_type

					Temp_byte_code_array.append_short_integer (expanded_type.expanded_type_id - 1)
					gen_type ?= expanded_type

					if gen_type /= Void then
						Temp_byte_code_array.append_short_integer (
									context.current_type.generated_id (False)
																  )
						gen_type.make_gen_type_byte_code (
												Temp_byte_code_array, true
														 )
					end
					Temp_byte_code_array.append_short_integer(-1)
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
					formal_type := context.real_type (arguments.item (i))
					if formal_type.is_true_expanded or else formal_type.is_bit
					then
						Temp_byte_code_array.append (Bc_clone_arg)
						Temp_byte_code_array.append_short_integer (i)
						if formal_type.is_bit then
							bit_i ?= formal_type
							Temp_byte_code_array.append_short_integer(bit_i.size)
						else
							expanded_type ?= formal_type
							Temp_byte_code_array.append_short_integer
										(expanded_type.expanded_type_id - 1)
							gen_type ?= expanded_type

							if gen_type /= Void then
								Temp_byte_code_array.append_short_integer (context.current_type.generated_id (False))
								gen_type.make_gen_type_byte_code 
										(Temp_byte_code_array, true)
							end
							Temp_byte_code_array.append_short_integer(-1)
						end
					end
					i := i + 1
				end
			end
			Temp_byte_code_array.append (Bc_no_clone_arg)

			if r_type.is_true_expanded and then not r_type.is_bit then
				-- Generate full type info.
				expanded_type ?= r_type

				Temp_byte_code_array.append_short_integer (expanded_type.expanded_type_id - 1)
				gen_type ?= expanded_type

				if gen_type /= Void then
					Temp_byte_code_array.append_short_integer (context.current_type.generated_id (False))
					gen_type.make_gen_type_byte_code (Temp_byte_code_array, true)
				end
				Temp_byte_code_array.append_short_integer(-1)
			end

			context.byte_prepend (ba, Temp_byte_code_array)

				-- Clean the context
			inh_assert.wipe_out

debug ("DEBBUGGER_HOOK")
		-- ASSERTION TO CHECK THAT `number_of_breakpoint_slots' is correct
	if context.get_breakpoint_slot + 1 /= context.current_feature.number_of_breakpoint_slots then
		io.putstring ("STD_BYTE_CODE: Error in breakable line number computation for: %N")
		io.putstring ("{"+context.original_class_type.associated_class.lace_class.name+"}")
		io.putstring ("."+context.current_feature.feature_name+"%N%N")
	end
end
		end

	setup_local_variables is
			-- Set the local variable type (which includes old expressions)
			-- for the interpreter.
		local
			nb, i, position: INTEGER
			item: UN_OLD_B
		do
			from
				position := 1
				nb := local_count
			until
				position > nb
			loop
					-- Local SK value
				Context.add_local 
						(context.real_type (locals.item (position)))
				position := position + 1
			end
			if old_expressions /= Void then
				from
					nb := old_expressions.count
					old_expressions.start
					i := 1
				until
					i > nb
				loop
					item := old_expressions.item
					Context.add_local (context.real_type (item.type))
					item.set_position (position)
					position := position + 1
					old_expressions.forth
					i := i + 1
				end
			end
			Context.inherited_assertion.setup_local_variables (position)
		end

	make_body_code (ba: BYTE_ARRAY) is
			-- Generate compound byte code
		require
			good_argument: ba /= Void
		deferred
		end

	argument_count: INTEGER is
			-- Number of formal arguments
		do
			if arguments /= Void then
				Result := arguments.count
			end
		end

	local_count: INTEGER is
			-- Number of local variables
		do
			if locals /= Void then
				Result := locals.count
			end
		end

	Temp_byte_code_array: BYTE_ARRAY is
			-- Temporary byte code array
		once
			!!Result.make
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

	has_array_as_item (a: ARRAY [TYPE_I]): BOOLEAN is
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

end
