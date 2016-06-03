note
	description: "Enlarged access to an Eiffel feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FEATURE_BL

inherit
	FEATURE_B
		rename
			make as make_node
		redefine
			free_register, has_one_signature,
			is_feature_call, basic_register, generate_parameters_list,
			generate_access_on_type, is_polymorphic,
			set_register, register, set_parent, parent, generate_access,
			generate_on, analyze_on, analyze,
			generate_end, set_call_kind, call_kind
		end

	SHARED_DECLARATIONS

	SHARED_INCLUDE
		export
			{NONE} all
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

create
	fill_from

feature {NONE} --Initialisation

	fill_from (f: FEATURE_B)
			-- Fill in node with feature `f'
		do
			call_kind := call_kind_qualified
			feature_name_id := f.feature_name_id
			feature_id := f.feature_id
			type := f.type
			set_parameters (f.parameters)
			precursor_type := f.precursor_type
			routine_id := f.routine_id
			body_index := f.body_index
			is_once := f.is_once
			is_process_relative := f.is_process_relative
			is_object_relative := f.is_object_relative
			multi_constraint_static := f.multi_constraint_static
			enlarge_parameters
		end

feature

	parent: NESTED_BL
			-- Parent of access

	register: REGISTRABLE
			-- In which register the expression is stored

	basic_register: REGISTRABLE
			-- Register used to store the metamorphosed simple type

	set_register (r: REGISTRABLE)
			-- Set current register to `r'
		do
			register := r
		end

	set_parent (p: NESTED_BL)
			-- Assign `p' to `parent'
		do
			parent := p
		end

	is_feature_call: BOOLEAN = True
			-- Access is a feature call

	free_register
			-- Free registers
		do
			Precursor {FEATURE_B}
			if basic_register /= Void then
				basic_register.free_register
			end
		end

feature {CALL_B} -- C code generation: kind of a call

	call_kind: INTEGER
			-- <Precursor>

	set_call_kind (value: like call_kind)
			-- <Precursor>
		do
			call_kind := value
		end

feature -- C code generation

	analyze
			-- Build a proper context for code generation.
		do
debug
io.error.put_string ("In feature_bl%N")
end
			analyze_on (Current_register)
				-- Get a register if none were already propagated
			get_register
debug
io.error.put_string ("Out feature_bl%N")
end
		end

	analyze_on (reg: REGISTRABLE)
			-- Analyze feature call on `reg'
		local
			tmp_register: REGISTER
			access_b: ACCESS_B
			basic_i: BASIC_A
			l_optimizable: BOOLEAN
			l_nested: NESTED_B
		do
debug
io.error.put_string ("In feature_bl [analyze_on]: ")
io.error.put_string (feature_name)
io.error.put_new_line
end
			basic_i ?= context_type
			if basic_i /= Void and not is_feature_special (True, basic_i) then
					-- Get a register to store the metamorphosed basic type,
					-- on which the attribute access is made. The lifetime of
					-- this temporary is really short: just the time to make
					-- the call...
					-- We need it only when a metamorphose occurs or if we
					-- are handling BIT objects.
				create tmp_register.make (Reference_c_type)
				basic_register := tmp_register
			end
			if parameters /= Void then
				-- If we have only one parameter and it is a single access to
				-- an attribute, then expand it in-line.
				from
					l_optimizable := True
					parameters.start
				until
					parameters.after
				loop
					access_b ?= parameters.item.expression
					if access_b = Void or else not access_b.is_attribute then
						l_nested ?= parameters.item.expression
						if
							l_nested = Void or else
							(not (l_nested.target.is_predefined or l_nested.target.is_attribute) or not l_nested.message.is_attribute)
						then
							l_optimizable := False
							parameters.finish
						end
					end
					parameters.forth
				end
				if l_optimizable then
					from
						parameters.start
					until
						parameters.after
					loop
						context.init_propagation
						parameters.item.propagate (No_register)
						parameters.forth
					end
				end
				parameters.analyze
				check_dt_current (reg)
					-- If No_register has been propagated, then this call will
					-- be expanded in line. It might be part of a more complex
					-- expression, hence temporary registers used by the
					-- parameters may not be released now.
				if not perused then
					free_param_registers
				end
			else
				check_dt_current (reg)
			end
			if reg.is_current then
				context.mark_current_used
			end
debug
io.error.put_string ("Out feature_bl [analyze_on]: ")
io.error.put_string (feature_name)
io.error.put_new_line
end
		end

	generate_access
			-- Generate access call of feature in current on `current_register'
		do
				-- Reset value of variables.
			is_right_parenthesis_needed.put (False)
			is_deferred.put (False)
			is_direct_once.put (False)

			do_generate (Current_register)
		end

	generate_on (reg: REGISTRABLE)
			-- Generate access call of feature in current on `current_register'
		do
				-- Reset value of variables.
			is_right_parenthesis_needed.put (False)
			is_deferred.put (False)
			is_direct_once.put (False)

			do_generate (reg)
		end

	check_dt_current (reg: REGISTRABLE)
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			type_i: TYPE_A
			access: ACCESS_B
			void_register: REGISTER
			is_polymorphic_access: BOOLEAN
		do
			type_i := context_type
			is_polymorphic_access := not type_i.is_basic and then precursor_type = Void and then
					Eiffel_table.is_polymorphic (routine_id, type_i, context.context_class_type, True) >= 0
			if reg.is_current and is_polymorphic_access then
				context.add_dt_current
			end
			if not reg.is_predefined and is_polymorphic_access then
					-- BEWARE!! The function call is polymorphic hence we'll
					-- need to evaluate `reg' twice: once to get its dynamic
					-- type and once as a parameter for Current. Hence we
					-- must make sure it is not held in a No_register--RAM.
				access ?= reg;		-- Cannot fail
				if access.register = No_register then
					access.set_register (void_register)
					access.get_register
				end
			end
		end

	is_polymorphic: BOOLEAN
			-- Is access polymorphic ?
		local
			type_i: TYPE_A
		do
			type_i := context_type
			if not type_i.is_basic and then precursor_type = Void then
				Result := Eiffel_table.is_polymorphic (routine_id, type_i, context.context_class_type, True) >= 0
			end
		end

	has_one_signature: BOOLEAN
			-- <Precursor>
		do
			Result := Eiffel_table.poly_table (routine_id).has_one_signature
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_A)
			-- Generate final portion of C code.
		local
			buf: GENERATION_BUFFER
			l_type_c: TYPE_C
			has_generated: BOOLEAN
		do
			buf := buffer
			if
				System.in_final_mode and then
				System.inlining_on and then
				class_type.base_class.is_special and then
				not is_polymorphic
			then
				inspect feature_name_id
				when {PREDEFINED_NAMES}.base_address_name_id then
					buf.indent
					generate_special_base_address (Void, gen_reg)
					buf.exdent
					has_generated := True
				when {PREDEFINED_NAMES}.clear_all_name_id then
					if
						attached class_type.generics.first as parameter_type and then
						not parameter_type.is_true_expanded
					then
						generate_special_clear_all (gen_reg, parameter_type)
						has_generated := True
					end
				when {PREDEFINED_NAMES}.copy_data_name_id then
					if
						attached class_type.generics.first as parameter_type and then
						not is_special_actual_expanded_with_references (parameter_type)
					then
						generate_special_copy_data (gen_reg, parameter_type)
						has_generated := True
					end
				when {PREDEFINED_NAMES}.count_name_id then
					buf.indent
					generate_special_count (Void, gen_reg)
					buf.exdent
					has_generated := True
				when
					{PREDEFINED_NAMES}.item_name_id,
					{PREDEFINED_NAMES}.infix_at_name_id,
					{PREDEFINED_NAMES}.at_name_id
				then
					if attached class_type.generics.first as parameter_type then
						if not parameter_type.is_true_expanded then
							buf.indent
							generate_special_item_basic (Void, gen_reg, parameter_type)
							buf.exdent
							has_generated := True
						elseif
							attached parameter_type.associated_class_type (context.context_class_type.type) as argument_class_type and then
							argument_class_type.skeleton.has_references
						then
							buf.indent
							generate_special_item_with_references (Void, gen_reg, argument_class_type)
							buf.exdent
							has_generated := True
						end
					end
				when
					{PREDEFINED_NAMES}.move_data_name_id,
					{PREDEFINED_NAMES}.overlapping_move_name_id
				then
					if
						attached class_type.generics.first as parameter_type and then
						not is_special_actual_expanded_with_references (parameter_type)
					then
						generate_special_move (gen_reg, parameter_type, True)
						has_generated := True
					end
				when {PREDEFINED_NAMES}.non_overlapping_move_name_id then
					if
						attached class_type.generics.first as parameter_type and then
						not is_special_actual_expanded_with_references (parameter_type)
					then
						generate_special_move (gen_reg, parameter_type, False)
						has_generated := True
					end
				when {PREDEFINED_NAMES}.put_name_id then
					generate_special_put (gen_reg, class_type.generics.first)
					has_generated := True
				else
				end
			end
			if not has_generated then
				generate_access_on_type (gen_reg, class_type)
				if not is_deferred.item then
					if is_direct_once.item then
						if is_right_parenthesis_needed.item then
							buf.put_character (')')
						end
						buf.put_character (',')
						buf.put_character ('(')
						gen_reg.print_target_register
						if parameters /= Void then
							generate_parameters_list
						end
						buf.put_character (')')
						buf.put_character (')')
					else
						buf.put_character ('(')
						gen_reg.print_target_register
						if parameters /= Void then
							generate_parameters_list
						end
						buf.put_character (')')
						if is_right_parenthesis_needed.item then
							buf.put_character (')')
						end
					end
				else
						-- The line below can be removed when the RTNR macro
						-- doesn't take an argument anymore.
					buf.put_string ("(NULL)")
					l_type_c := real_type (type).c_type
					if not l_type_c.is_void then
						buf.put_two_character (',', ' ')
						l_type_c.generate_default_value (buf)
					end
					buf.put_character (')')
					if is_right_parenthesis_needed.item then
						buf.put_character (')')
					end
				end
			end
		end

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A)
			-- Generate feature call in a `typ' context
		local
			internal_name		: STRING
			table_name			: STRING
			rout_table			: ROUT_TABLE
			type_i: TYPE_A
			type_c				: TYPE_C
			buf					: GENERATION_BUFFER
			array_index			: INTEGER
			local_argument_types: ARRAY [STRING]
			entry: ROUT_ENTRY
			f: FEATURE_I
			l_index: INTEGER
			l_keep, is_nested: BOOLEAN
			l_par: NESTED_BL
			return_type_string: STRING
		do
			l_keep := context.final_mode and then system.keep_assertions
			is_nested := not is_first
			l_par := parent
			array_index := Eiffel_table.is_polymorphic (routine_id, typ, context.context_class_type, True)
			buf := buffer
				-- Tell if we need the extra parenthesis in `generate_end'.
			is_right_parenthesis_needed.put (l_keep)
			type_i := real_type (type)
			type_c := type_i.c_type
			if array_index = -2 then
					-- Call to a deferred feature without implementation
				is_deferred.put (True)
				if l_keep then
					buf.put_character ('(')
				end
				buf.put_string ("(RTNR")
			elseif precursor_type = Void and then array_index >= 0 then
					-- The call is polymorphic, so generate access to the
					-- routine table. The dereferenced function pointer has
					-- to be enclosed in parenthesis.
				table_name := Encoder.routine_table_name (routine_id)
					-- It is pretty important that we use `actual_type.is_formal' and not
					-- just `is_formal' because otherwise if you have `like x' and `x: G'
					-- then we would fail to detect that.
				if
					system.seed_of_routine_id (routine_id).type.actual_type.is_formal and then
					type_i.is_basic and then not has_one_signature
				then
						-- Feature returns a reference that needs to be used as a basic one.
					is_right_parenthesis_needed.put (True)
					buf.put_character ('*')
					type_c.generate_access_cast (buf)
					type_c := reference_c_type
					buf.put_string ("(eif_optimize_return = 1, ")
				elseif l_keep then
					buf.put_character ('(')
				end

				if l_keep then
					if is_nested or else call_kind = call_kind_creation then
						buf.put_string ("nstcall = ")
						buf.put_integer (call_kind)
						buf.put_two_character (',', ' ')
					else
						buf.put_string ("nstcall = 0, ")
					end
				end
				buf.put_character ('(')
				type_c.generate_function_cast (buf, argument_types, False)

					-- Generate following dispatch:
					-- table [Actual_offset - base_offset]
				buf.put_string (table_name)
				buf.put_character ('[')
				if reg.is_current then
					context.generate_current_dtype
				else
					buf.put_string ({C_CONST}.dtype);
					buf.put_character ('(')
					reg.print_register
					buf.put_character (')')
				end
				buf.put_character ('-')
				buf.put_integer (array_index)
				buf.put_string ("])")

					-- Mark routine id used
				Eiffel_table.mark_used (routine_id)
					-- Remember extern declaration
				Extern_declarations.add_routine_table (table_name)
			else
					-- The call is not polymorphic in the given context,
					-- so the name can be hardwired, unless we access a
					-- deferred feature in which case we have to be careful
					-- and get the routine name of the first entry in the
					-- routine table.
				rout_table ?= Eiffel_table.poly_table (routine_id)
				rout_table.goto_implemented (typ, context.context_class_type)

				if rout_table.is_implemented then
					internal_name := rout_table.feature_name

					entry := rout_table.item
					l_index := entry.body_index

					f := system.class_of_id (entry.class_id).feature_of_feature_id (entry.feature_id)
					if f.is_process_or_thread_relative_once and then context.is_once_call_optimized then
							-- Routine contracts (require, ensure, invariant) should not be checked
							-- and value of already called once routine can be retrieved from memory
						is_direct_once.put (True)
						context.generate_once_optimized_call_start (type_c, l_index, is_process_relative, is_object_relative, buf)
					end

					local_argument_types := argument_types
					if rout_table.item.access_type_id /= Context.original_class_type.type_id then
							-- Remember extern routine declaration
						if context.workbench_mode then
							return_type_string := "EIF_TYPED_VALUE"
						else
							return_type_string := type_c.c_string
						end
						Extern_declarations.add_routine_with_signature (return_type_string,
								internal_name, local_argument_types)
						if f.is_process_or_thread_relative_once and then context.is_once_call_optimized then
							Extern_declarations.add_once (type_c, l_index, is_process_relative, is_object_relative)
						end
					end
				else
						-- Call to a deferred feature without implementation
					is_deferred.put (True)
				end
				if l_keep then
					buf.put_character ('(')
					if is_nested or else call_kind = call_kind_creation then
						buf.put_string ("nstcall = ")
						buf.put_integer (call_kind)
						buf.put_two_character (',', ' ')
					else
						buf.put_string ("nstcall = 0, ")
					end
				end
				if is_deferred.item then
					buf.put_string ("(RTNR")
				else
					buf.put_string (internal_name)
				end
			end
		end

	generate_parameters_list
			-- Generate the parameters list for C function call
		local
			expr: EXPR_B
			buf: GENERATION_BUFFER
			l_area: SPECIAL [EXPR_B]
			i, nb: INTEGER
			p: like parameters
		do
			if not is_deferred.item then
				p := parameters
				if p /= Void then
					buf := buffer
					l_area := p.area
					nb := p.count
					p := Void
					from
					until
						i = nb
					loop
						buf.put_string ({C_CONST}.comma_space)
						expr := l_area.item (i);	-- Cannot fail
						expr.print_register
						i := i + 1
					end
				end
			end
		end

	enlarge_parameters
		local
			i, nb: INTEGER
			l_area: SPECIAL [EXPR_B]
			p: like parameters
		do
			p := parameters
			if p /= Void then
				from
					l_area := p.area
					nb := p.count
					p := Void
				until
					i = nb
				loop
					l_area.put (l_area.item (i).enlarged, i)
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation

	is_deferred: CELL [BOOLEAN]
			-- Is current feature call a deferred feature without implementation?
		once
			create Result.put (False)
		ensure
			is_deferred_not_void: Result /= Void
		end

	is_direct_once: CELL [BOOLEAN]
			-- Is current call done on a once which value can be accessed directly?
		once
			create Result.put (False)
		ensure
			is_direct_once_not_void: Result /= Void
		end

	is_right_parenthesis_needed: CELL [BOOLEAN]
			-- Does current call require to close a parenthesis?
			-- Case when one use `nstcall' or `eif_optimize_return'.
		once
			create Result.put (False)
		ensure
			is_right_parenthesis_needed_not_void: Result /= Void
		end

feature {NONE} -- Inlining of calls to features from SPECIAL

	is_special_actual_expanded_with_references (actual_generic: TYPE_A): BOOLEAN
			-- Is actual generic parameter `actual_generic' of current type SPECIAL [G] is
			-- expanded with references?
		require
			is_special_context_class_type: context.context_cl_type.base_class.is_special
		do
			if actual_generic.is_true_expanded then
				Result := actual_generic.associated_class_type (context.context_cl_type).skeleton.has_references
			end
		end

	generate_special_base_address (result_register: detachable REGISTER; target_register: REGISTRABLE)
			-- Generate code for "{SPECIAL}.base_address" with target stored in `target_register'.
			-- Generate an instruction that stores result in `result_register' if it is attached.
			-- Generate an expression otherwise.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.base_address) */")
			buf.put_new_line
			if attached result_register then
				result_register.print_register
				buf.put_three_character (' ', '=', ' ')
			end
			target_register.print_target_register
			if attached result_register then
				buf.put_character (';')
			end
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_clear_all (target_register: REGISTRABLE; actual_generic: TYPE_A)
			-- Generate code for "{SPECIAL}.clear_all" with target stored in `target_register' and actual generic `actual_generic'.
			-- The actual generic should not be user-defined expanded because it may require initialization.
		require
			actual_generic_is_basic: not actual_generic.is_true_expanded
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
				-- New line has been added earlier.
			buf.put_string ("/* INLINED CODE (SPECIAL.clear_all) */")
			buf.put_new_line
			buf.put_string ("memset (")
			target_register.print_target_register
			buf.put_string (", 0, RT_SPECIAL_VISIBLE_SIZE(")
			target_register.print_target_register
			buf.put_three_character (')', ')', ';')
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_copy_data (target_register: REGISTRABLE; actual_generic: TYPE_A)
			-- Generate code for "{SPECIAL}.copy_data" with target stored in `target_register' and actual generic `actual_generic'.
		require
			actual_generic_not_expanded_with_references: not is_special_actual_expanded_with_references (actual_generic)
		local
			buf: GENERATION_BUFFER
			type_c: TYPE_C
			skeleton: SKELETON
		do
			buf := buffer
				-- New line has been added earlier.
			buf.put_string ("/* INLINED CODE (SPECIAL.copy_data) */")
			buf.put_new_line
			if actual_generic.is_true_expanded then
				skeleton := actual_generic.associated_class_type (context.context_class_type.type).skeleton
				buf.put_string ("memmove((char *)")
				target_register.print_target_register
				buf.put_string (" + (rt_uint_ptr)")
				parameters [3].print_register
				buf.put_string (" * (rt_uint_ptr)")
				skeleton.generate_size (buf, True)
				buf.put_string (", (char *) ")
				parameters [1].print_register
				buf.put_string (" + (rt_uint_ptr)")
				parameters [2].print_register
				buf.put_string (" * (rt_uint_ptr)")
				skeleton.generate_size (buf, True)
				buf.put_string (", (rt_uint_ptr)")
				parameters [4].print_register
				buf.put_string (" * (rt_uint_ptr)")
				skeleton.generate_size (buf, True)
			else
				type_c := actual_generic.c_type
				if type_c.level = C_ref then
						-- Because we need to do the aging test in case `source' and `target' are
						-- not the same SPECIAL, we call the run-time helper function `sp_copy_data'.
					buf.put_string ("sp_copy_data(")
					target_register.print_target_register
					buf.put_character (',')
					parameters [1].print_register
					buf.put_character (',')
					parameters [2].print_register
					buf.put_character (',')
					parameters [3].print_register
					buf.put_character (',')
					parameters [4].print_register
				else
					buf.put_string ("memmove(")
					type_c.generate_access_cast (buf)
					target_register.print_target_register
					buf.put_string (" + (")
					parameters [3].print_register
					buf.put_string ("),")
					type_c.generate_access_cast (buf)
					parameters [1].print_register
					buf.put_string (" + ")
					parameters [2].print_register
					buf.put_string (", (rt_uint_ptr)")
					type_c.generate_size (buf)
					buf.put_string (" * (rt_uint_ptr)")
					parameters [4].print_register
				end
			end
			buf.put_two_character (')', ';')
				-- Add `eif_helpers.h' for C compilation where `eif_max_int32' function is declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
			buf.put_new_line
			buf.put_string("RT_SPECIAL_COUNT(");
			target_register.print_register
			buf.put_string (") = eif_max_int32(RT_SPECIAL_COUNT(")
			target_register.print_register
			buf.put_three_character (')', ',', ' ')
			parameters [3].print_register
			buf.put_three_character (' ', '+', ' ')
			parameters [4].print_register
			buf.put_two_character (')', ';')
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_count (result_register: detachable REGISTER; target_register: REGISTRABLE)
			-- Generate code for "{SPECIAL}.count" with target stored in `target_register'.
			-- Generate an instruction that stores result in `result_register' if it is attached.
			-- Generate an expression otherwise.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.count) */")
			buf.put_new_line
			if attached result_register then
				result_register.print_register
				buf.put_three_character (' ', '=', ' ')
			end
			buf.put_string ("RT_SPECIAL_COUNT(")
			target_register.print_target_register
			buf.put_character (')')
			if attached result_register then
				buf.put_character (';')
			end
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_item_basic (result_register: detachable REGISTER; target_register: REGISTRABLE; actual_generic: TYPE_A)
			-- Generate code for "{SPECIAL}.item" with target stored in `target_register' and actual generic `actual_generic'.
			-- Generate an instruction that stores result in `result_register' if it is attached.
			-- Generate an expression otherwise.
		require
			actual_generic_is_basic: not actual_generic.is_true_expanded
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.item) */")
			buf.put_new_line
			if attached result_register then
				result_register.print_register
				buf.put_three_character (' ', '=', ' ')
			end
			buf.put_two_character ('*', '(')
			actual_generic.c_type.generate_access_cast (buf)
			target_register.print_target_register
			buf.put_string (" + (")
			parameters [1].print_register
			buf.put_two_character (')', ')')
			if attached result_register then
				buf.put_character (';')
			end
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_item_with_references (result_register: detachable REGISTER; target_register: REGISTRABLE; actual_generic_class_type: CLASS_TYPE)
			-- Generate code for "{SPECIAL}.item" with target stored in `target_register' and result type `actual_generic_class_type'.
			-- Generate an instruction that stores result in `result_register' if it is attached.
			-- Generate an expression otherwise.
		require
			actual_generic_class_type_has_references: actual_generic_class_type.skeleton.has_references
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.item) */")
			buf.put_new_line
			if attached result_register then
				result_register.print_register
				buf.put_three_character (' ', '=', ' ')
			end
			buf.put_string ("RTCL(")
			target_register.print_target_register
			buf.put_string (" + OVERHEAD + (rt_uint_ptr)")
			parameters [1].print_register
			buf.put_string (" * (rt_uint_ptr)(")
			actual_generic_class_type.skeleton.generate_size (buf, True)
			buf.put_string (" + OVERHEAD))")
			if attached result_register then
				buf.put_character (';')
			end
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_item_address (result_register: detachable REGISTER; target_register: REGISTRABLE; actual_generic: TYPE_A)
			-- Generate code for "{SPECIAL}.item_address" with target stored in `target_register' and actual generic `actual_generic'.
			-- Generate an instruction that stores result in `result_register' if it is attached.
			-- Generate an expression otherwise.
		local
			buf: GENERATION_BUFFER
			skeleton: SKELETON
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.item_address) */")
			buf.put_new_line
			if attached result_register then
				result_register.print_register
				buf.put_three_character (' ', '=', ' ')
			end
			target_register.print_target_register
			if actual_generic.is_true_expanded then
				skeleton := actual_generic.associated_class_type (context.context_class_type.type).skeleton
				if skeleton.has_references then
					buf.put_string (" + OVERHEAD + (rt_uint_ptr)")
					parameters [1].print_register
					buf.put_string (" * (rt_uint_ptr)(")
					skeleton.generate_size (buf, True)
					buf.put_string (" + OVERHEAD)")
				else
					buf.put_string (" + (rt_uint_ptr)")
					parameters [1].print_register
					buf.put_string (" * (rt_uint_ptr)")
					skeleton.generate_size (buf, True)
				end
			else
				buf.put_string (" + (rt_uint_ptr)")
				parameters [1].print_register
				buf.put_three_character (' ', '*', ' ')
				actual_generic.c_type.generate_size (buffer)
			end
			if attached result_register then
				buf.put_character (';')
			end
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_move (target_register: REGISTRABLE; actual_generic: TYPE_A; is_overlapping: BOOLEAN)
			-- Generate code for "{SPECIAL}.move_data" or "{SPECIAL}.overlapping_move" depending on `is_overlapping'
			-- with target stored in `target_register' and argument of type `argument_type'.
		require
			actual_generic_not_expanded_with_references: not is_special_actual_expanded_with_references (actual_generic)
		local
			buf: GENERATION_BUFFER
			type_c: TYPE_C
			skeleton: SKELETON
		do
			buf := buffer
				-- New line has been added earlier.
			if is_overlapping then
				buf.put_string ("/* INLINED CODE (SPECIAL.overlapping_move) */")
				buf.put_new_line
				buf.put_string ("memmove")
			else
				buf.put_string ("/* INLINED CODE (SPECIAL.move_data) */")
				buf.put_new_line
				buf.put_string ("memcpy")
			end
			if actual_generic.is_true_expanded then
				skeleton := actual_generic.associated_class_type (context.context_class_type.type).skeleton
				buf.put_string ("((char *)")
				target_register.print_target_register
				buf.put_string (" + (rt_uint_ptr)")
				parameters [2].print_register
				buf.put_string (" * (rt_uint_ptr)")
				skeleton.generate_size (buf, True)
				buf.put_string (", (char *) ")
				target_register.print_target_register
				buf.put_string (" + (rt_uint_ptr)")
				parameters [1].print_register
				buf.put_string (" * (rt_uint_ptr)")
				skeleton.generate_size (buf, True)
				buf.put_string (", (rt_uint_ptr)")
				parameters [3].print_register
				buf.put_string (" * (rt_uint_ptr)")
				skeleton.generate_size (buf, True)
			else
				type_c := actual_generic.c_type
				buf.put_character ('(')
				type_c.generate_access_cast (buf)
				target_register.print_target_register
				buf.put_string (" + (")
				parameters [2].print_register
				buf.put_two_character (')', ',')
				type_c.generate_access_cast (buf)
				target_register.print_target_register
				buf.put_three_character (' ', '+', ' ')
				parameters [1].print_register
				buf.put_string (", (rt_uint_ptr)")
				type_c.generate_size (buf)
				buf.put_string (" * (rt_uint_ptr)")
				parameters [3].print_register
			end
			buf.put_two_character (')', ';')
				-- Add `eif_helpers.h' for C compilation where `eif_max_int32' function is declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
			buf.put_new_line
			buf.put_string ("RT_SPECIAL_COUNT(")
			target_register.print_register
			buf.put_string (") = eif_max_int32(RT_SPECIAL_COUNT(")
			target_register.print_register
			buf.put_three_character (')', ',', ' ')
			parameters [2].print_register
			buf.put_three_character (' ', '+', ' ')
			parameters [3].print_register
			buf.put_two_character (')', ';')
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_put (target_register: REGISTRABLE; argument_type: TYPE_A)
			-- Generate code for "{SPECIAL}.put" with target stored in `target_register' and argument of type `argument_type'.
		local
			buf: GENERATION_BUFFER
			skeleton: SKELETON
			type_c: TYPE_C
		do
			buf := buffer
				-- New line has been added earlier.
			buf.put_string ("/* INLINED CODE (SPECIAL.put) */")
			buf.put_new_line
			if argument_type.is_true_expanded then
				skeleton := argument_type.associated_class_type (context.context_class_type.type).skeleton
				if skeleton.has_references then
					buf.put_string ("ecopy(")
					parameters [1].print_register
					buf.put_two_character (',', ' ')
					target_register.print_target_register
					buf.put_string (" + OVERHEAD + (rt_uint_ptr)")
					parameters [2].print_register
					buf.put_string (" * (rt_uint_ptr)(")
					skeleton.generate_size (buf, True)
					buf.put_string (" + OVERHEAD));")
				else
					buf.put_string ("memcpy(")
					target_register.print_target_register
					buf.put_string (" + (rt_uint_ptr)")
					parameters [2].print_register
					buf.put_string (" * (rt_uint_ptr)")
					skeleton.generate_size (buf, True)
					buf.put_character (',')
					parameters [1].print_register
					buf.put_two_character (',', ' ')
					skeleton.generate_size (buf, True)
					buf.put_two_character (')', ';')
				end
			else
				type_c := argument_type.c_type
				buf.put_two_character ('*', '(')
				type_c.generate_access_cast (buf)
				target_register.print_target_register
				buf.put_string (" + (")
				parameters [2].print_register
				buf.put_string (")) = ")
				parameters [1].print_register
				buf.put_character (';')
				if type_c.level = C_ref then
					buf.put_new_line
					buf.put_string ("RTAR(")
					target_register.print_register
					buf.put_character (',')
					parameters [1].print_register
					buf.put_two_character (')', ';')
				end
			end
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
