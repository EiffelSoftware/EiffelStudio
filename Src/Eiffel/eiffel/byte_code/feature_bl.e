note
	description: "Enlarged access to an Eiffel feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class FEATURE_BL

inherit
	FEATURE_B
		rename
			make as make_node
		undefine
			analyze,
			basic_register,
			call_kind,
			free_register,
			generate_access,
			generate_parameters,
			has_one_signature,
			is_polymorphic,
			is_temporary,
			register,
			set_call_kind,
			set_parent,
			set_register
		redefine
			analyze_on,
			generate_access_on_type,
			generate_end,
			generate_on,
			generate_parameters_list,
			is_feature_call,
			parent
		end

	ROUTINE_BL
		undefine
			is_object_relative,
			is_once,
			is_process_relative
		redefine
			generate_on,
			parent
		end

	SHARED_DECLARATIONS

	SHARED_INCLUDE
		export
			{NONE} all
		end

feature {NONE} --Initialisation

	fill_from (f: ROUTINE_B)
			-- Fill in node with feature `f`.
		do
			if attached f.precursor_type as p then
				precursor_type := p
				call_kind := call_kind_unqualified
			else
				call_kind := call_kind_qualified
			end
			feature_name_id := f.feature_name_id
			feature_id := f.feature_id
			written_in := f.written_in
			type := f.type
			set_parameters (f.parameters)
			routine_id := f.routine_id
			is_once := f.is_once
			is_process_relative := f.is_process_relative
			is_object_relative := f.is_object_relative
			is_instance_free := f.is_instance_free
			multi_constraint_static := f.multi_constraint_static
			enlarge_parameters
		end

feature -- Access

	parent: NESTED_BL
			-- <Precursor>

feature

	is_feature_call: BOOLEAN = True
			-- Access is a feature call

feature -- C code generation

	analyze_on (r: REGISTRABLE)
			-- Analyze feature call on `r`.
		local
			reg: REGISTRABLE
		do
			analyze_non_object_call_target
			analyze_basic_type
			reg := target_register (r)
			if attached parameters as arguments then
					-- If no arguments allocate memory, they can be generated inline.
				if not across arguments as a some a.item.allocates_memory end then
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
		end

	generate_on (reg: REGISTRABLE)
			-- Generate access call of feature in current on `current_register'
		do
				-- Reset variables.
			is_direct_once.put (False)
				-- Generate code.
			Precursor {ROUTINE_BL} (reg)
		end

	check_dt_current (reg: REGISTRABLE)
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			type_i: TYPE_A
			is_polymorphic_access: BOOLEAN
		do
			type_i := context_type
			is_polymorphic_access :=
				not type_i.is_basic and then
				precursor_type = Void and then
				Eiffel_table.is_polymorphic_for_body (routine_id, type_i, context.original_class_type) >= 0
			if reg.is_current and is_polymorphic_access then
				context.add_dt_current
			end
			if
				not reg.is_predefined and
				is_polymorphic_access and then
				attached {ACCESS_B} reg as access and then
				access.register = No_register
			then
					-- BEWARE!! The function call is polymorphic hence we'll
					-- need to evaluate `reg' twice: once to get its dynamic
					-- type and once as a parameter for Current. Hence we
					-- must make sure it is not held in a No_register--RAM.
				access.set_register (Void)
				access.get_register
			end
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_A)
			-- Generate final portion of C code.
		local
			buf: GENERATION_BUFFER
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
						generate_arguments (gen_reg, True)
						buf.put_character (')')
					else
						generate_arguments (gen_reg, not is_polymorphic)
						if is_right_parenthesis_needed.item then
							buf.put_character (')')
						end
					end
				elseif is_right_parenthesis_needed.item then
					buf.put_character (')')
				end
			end
		end

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A)
			-- Generate feature call in a `typ' context
		local
			internal_name: READABLE_STRING_8
			table_name: STRING
			type_i: TYPE_A
			type_c: TYPE_C
			buf: GENERATION_BUFFER
			array_index: INTEGER
			context_entry: ROUT_ENTRY
			f: FEATURE_I
			l_index: INTEGER
			is_trampoline: BOOLEAN
			context_type_id: INTEGER
		do
			check
				final_mode: context.final_mode
			end
			buf := buffer
			type_i := real_type (type)
			type_c := (if is_once_creation then typ else type_i end).c_type
			array_index :=
				if attached precursor_type then
					-1
				else
					Eiffel_table.is_polymorphic_for_body (routine_id, typ, context.original_class_type)
				end
			if array_index = -2 then
					-- There is no feature to call.
				generate_no_call
			elseif array_index >= 0  and then not is_target_type_fixed then
					-- The call is polymorphic, so generate access to the
					-- routine table. The dereferenced function pointer has
					-- to be enclosed in parenthesis.
				generate_nested_flag (True)
				table_name := Encoder.routine_table_name (routine_id)
					-- It is pretty important that we use `actual_type.is_formal' and not
					-- just `is_formal' because otherwise if you have `like x' and `x: G'
					-- then we would fail to detect that.
				if
					system.seed_of_routine_id (routine_id).type.actual_type.is_formal and then
					type_i.is_basic and then not has_one_signature
				then
						-- Feature returns a reference that needs to be used as a basic one.
					if not is_right_parenthesis_needed.item then
						is_right_parenthesis_needed.put (True)
						buf.put_character ('(')
					end
					buf.put_string ("eif_optimize_return = 1, *")
					type_c.generate_access_cast (buf)
					type_c := reference_c_type
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
					buf.put_string ({C_CONST}.dtype)
					buf.put_character ('(')
					reg.print_register
					buf.put_character (')')
				end
				buf.put_character ('-')
				buf.put_integer (array_index)
				buf.put_two_character (']', ')')

					-- Mark routine id used.
				Eiffel_table.mark_used (routine_id)
					-- Remember routine table declaration.
				Extern_declarations.add_routine_table (table_name)
			elseif attached {ROUT_TABLE} Eiffel_table.poly_table (routine_id) as rout_table then
					-- The call is not polymorphic in the given context,
					-- so the name can be hardwired, unless we access a
					-- deferred feature in which case we have to be careful
					-- and get the routine name of the first entry in the
					-- routine table.
				context_type_id := typ.type_id (context.context_cl_type.generic_derivation)
				if attached effective_entry (typ, context_type_id, rout_table) as entry then
					context_entry := rout_table.context_item
					if entry.pattern_id /= context_entry.pattern_id then
							-- A trampoline is required to adapt argument and/or result type.
						is_trampoline := True
						internal_name := rout_table.trampoline_name (entry, context_entry)
						system.request_trampoline (entry, context_entry, routine_id)
					else
						internal_name := entry.routine_name
					end

					f := system.class_of_id (entry.class_id).feature_of_feature_id (entry.feature_id)
					if f.is_process_or_thread_relative_once and then context.is_once_call_optimized then
							-- Routine contracts (require, ensure, invariant) should not be checked
							-- and value of already called once routine can be retrieved from memory
						is_direct_once.put (True)
						l_index := entry.body_index
						context.generate_once_optimized_call_start (type_c, l_index, is_process_relative, is_object_relative, buf)
					end

					if entry.access_type_id /= Context.original_class_type.type_id or else is_trampoline then
							-- Remember extern routine declaration if not written in the same class or if a trampoline is used.
						Extern_declarations.add_routine_with_signature
							(type_c.c_string, internal_name, argument_types)
						if l_index > 0 then
							Extern_declarations.add_once (type_c, l_index, is_process_relative, is_object_relative)
						end
					end
					generate_nested_flag (True)
					buf.put_string (internal_name)
				else
						-- There is no feature to call.
					generate_no_call
				end
			else
					-- There is no feature to call.
				generate_no_call
			end
		end

feature {NONE} -- Status report

	is_once_creation: BOOLEAN
			-- Is it a call to a once creation procedure?
		do
			Result := is_once and then context_type.base_class.is_once
		end

feature {NONE} -- C code generation: actual arguments

	generate_arguments (r: REGISTRABLE; v: BOOLEAN)
			-- Generate a list of arguments, including target `r`, enclosed in parentheses.
			-- Add a check for voidness of `r` iff `v`.
		local
			buf: like buffer
		do
			buf := buffer
			buf.put_character ('(')
			if v then
				r.print_checked_target_register
			else
				r.print_register
			end
			if attached parameters then
				generate_parameters_list
			end
			buf.put_character (')')
		end

	generate_parameters_list
			-- Generate the parameters list for C function call.
		local
			buf: GENERATION_BUFFER
			l_area: SPECIAL [EXPR_B]
			i, nb: INTEGER
		do
			if
				not is_deferred.item and then
				attached parameters as p
			then
				buf := buffer
				l_area := p.area
				nb := p.count
				from
				until
					i = nb
				loop
					buf.put_string ({C_CONST}.comma_space)
					l_area [i].print_register
					i := i + 1
				end
			end
		end

	enlarge_parameters
		local
			i, nb: INTEGER
			l_area: SPECIAL [EXPR_B]
		do
			if attached parameters as p then
				from
					l_area := p.area
					nb := p.count
				until
					i = nb
				loop
					l_area [i] := l_area [i].enlarged
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation

	is_direct_once: CELL [BOOLEAN]
			-- Is current call done on a once which value can be accessed directly?
		once
			create Result.put (False)
		ensure
			is_direct_once_not_void: Result /= Void
		end

feature {NONE} -- Inlining of calls to features from SPECIAL

	context_cl_type: CL_TYPE_A
			-- A context class type.
		do
			Result := context.context_cl_type
		end

	is_special_actual_expanded_with_references (actual_generic: TYPE_A): BOOLEAN
			-- Is actual generic parameter `actual_generic' of current type SPECIAL [G] is
			-- expanded with references?
		require
			is_special_context_class_type: attached context_type.base_class as c and then c.is_special
		do
			if
				actual_generic.is_true_expanded and then
				attached actual_generic.associated_class_type (context_type) as c
			then
				Result := c.skeleton.has_references
			end
		end

	generate_special_base_address (r: detachable REGISTER; t: REGISTRABLE)
			-- Generate code for "{SPECIAL}.base_address" with target stored in `t`.
			-- Generate an instruction that stores result in `r` if it is attached.
			-- Generate an expression otherwise.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.base_address) */")
			buf.put_new_line
			if attached r then
				r.print_register
				buf.put_three_character (' ', '=', ' ')
			end
			t.print_target_register
			if attached r then
				buf.put_character (';')
			end
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_clear_all (t: REGISTRABLE; actual_generic: TYPE_A)
			-- Generate code for "{SPECIAL}.clear_all" with target stored in `t` and actual generic `actual_generic'.
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
			t.print_target_register
			buf.put_string (", 0, RT_SPECIAL_VISIBLE_SIZE(")
			t.print_target_register
			buf.put_three_character (')', ')', ';')
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_copy_data (t: REGISTRABLE; actual_generic: TYPE_A)
			-- Generate code for "{SPECIAL}.copy_data" with target stored in `t` and actual generic `actual_generic'.
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
				t.print_target_register
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
					t.print_target_register
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
					t.print_target_register
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
			t.print_register
			buf.put_string (") = eif_max_int32(RT_SPECIAL_COUNT(")
			t.print_register
			buf.put_three_character (')', ',', ' ')
			parameters [3].print_register
			buf.put_three_character (' ', '+', ' ')
			parameters [4].print_register
			buf.put_two_character (')', ';')
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_count (r: detachable REGISTER; t: REGISTRABLE)
			-- Generate code for "{SPECIAL}.count" with target stored in `t`.
			-- Generate an instruction that stores result in `r` if it is attached.
			-- Generate an expression otherwise.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.count) */")
			buf.put_new_line
			if attached r then
				r.print_register
				buf.put_three_character (' ', '=', ' ')
			end
			buf.put_string ("RT_SPECIAL_COUNT(")
			t.print_target_register
			buf.put_character (')')
			if attached r then
				buf.put_character (';')
			end
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_item_basic (r: detachable REGISTER; t: REGISTRABLE; actual_generic: TYPE_A)
			-- Generate code for "{SPECIAL}.item" with target stored in `t` and actual generic `actual_generic'.
			-- Generate an instruction that stores result in `r` if it is attached.
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
			if attached r then
				r.print_register
				buf.put_three_character (' ', '=', ' ')
			end
			buf.put_two_character ('*', '(')
			actual_generic.c_type.generate_access_cast (buf)
			t.print_target_register
			buf.put_string (" + (")
			parameters [1].print_register
			buf.put_two_character (')', ')')
			if attached r then
				buf.put_character (';')
			end
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_item_with_references (r: detachable REGISTER; t: REGISTRABLE; actual_generic_class_type: CLASS_TYPE)
			-- Generate code for "{SPECIAL}.item" with target stored in `t` and result type `actual_generic_class_type'.
			-- Generate an instruction that stores result in `r` if it is attached.
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
			if attached r then
				r.print_register
				buf.put_three_character (' ', '=', ' ')
			end
			buf.put_string ("RTCL(")
			t.print_target_register
			buf.put_string (" + OVERHEAD + (rt_uint_ptr)")
			parameters [1].print_register
			buf.put_string (" * (rt_uint_ptr)(")
			actual_generic_class_type.skeleton.generate_size (buf, True)
			buf.put_string (" + OVERHEAD))")
			if attached r then
				buf.put_character (';')
			end
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_item_address (r: detachable REGISTER; t: REGISTRABLE; actual_generic: TYPE_A)
			-- Generate code for "{SPECIAL}.item_address" with target stored in `t` and actual generic `actual_generic'.
			-- Generate an instruction that stores result in `r` if it is attached.
			-- Generate an expression otherwise.
		local
			buf: GENERATION_BUFFER
			skeleton: SKELETON
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.item_address) */")
			buf.put_new_line
			if attached r then
				r.print_register
				buf.put_three_character (' ', '=', ' ')
			end
			t.print_target_register
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
			if attached r then
				buf.put_character (';')
			end
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_move (t: REGISTRABLE; actual_generic: TYPE_A; is_overlapping: BOOLEAN)
			-- Generate code for "{SPECIAL}.move_data" or "{SPECIAL}.overlapping_move" depending on `is_overlapping'
			-- with target stored in `t` and argument of type `argument_type'.
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
				t.print_target_register
				buf.put_string (" + (rt_uint_ptr)")
				parameters [2].print_register
				buf.put_string (" * (rt_uint_ptr)")
				skeleton.generate_size (buf, True)
				buf.put_string (", (char *) ")
				t.print_target_register
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
				t.print_target_register
				buf.put_string (" + (")
				parameters [2].print_register
				buf.put_two_character (')', ',')
				type_c.generate_access_cast (buf)
				t.print_target_register
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
			t.print_register
			buf.put_string (") = eif_max_int32(RT_SPECIAL_COUNT(")
			t.print_register
			buf.put_three_character (')', ',', ' ')
			parameters [2].print_register
			buf.put_three_character (' ', '+', ' ')
			parameters [3].print_register
			buf.put_two_character (')', ';')
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_special_put (t: REGISTRABLE; argument_type: TYPE_A)
			-- Generate code for "{SPECIAL}.put" with target stored in `t` and argument of type `argument_type'.
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
					t.print_target_register
					buf.put_string (" + OVERHEAD + (rt_uint_ptr)")
					parameters [2].print_register
					buf.put_string (" * (rt_uint_ptr)(")
					skeleton.generate_size (buf, True)
					buf.put_string (" + OVERHEAD));")
				else
					buf.put_string ("memcpy(")
					t.print_target_register
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
				t.print_target_register
				buf.put_string (" + (")
				parameters [2].print_register
				buf.put_string (")) = ")
				parameters [1].print_register
				buf.put_character (';')
				if type_c.level = C_ref then
					buf.put_new_line
					buf.put_string ({C_CONST}.rtar_open)
					t.print_register
					buf.put_character (',')
					parameters [1].print_register
					buf.put_two_character (')', ';')
				end
			end
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
