-- Context variables for code generation and utilities.

class BYTE_CONTEXT

inherit
	SHARED_C_LEVEL
		export
			{NONE} all
		end
	ASSERT_TYPE
	SHARED_ARRAY_BYTE
	SHARED_SERVER
	SHARED_GENERATION
	COMPILER_EXPORTER

create
	make, make_from_context

feature -- Initialization

	make is
			-- Initialization
		do
			create register_server.make (True)
			create local_vars.make (1, 50)
			create local_index_table.make (10)
			create associated_register_table.make (10)
			create local_list.make
			create old_expressions.make
			create inherited_assertion.make
			create global_onces.make (5)
			create once_manifest_string_count_table.make (100)
			create once_manifest_string_table.make (100)
		end

feature -- Access

	once_index: INTEGER
			-- Index of current once routine
			
	global_onces: ARRAYED_LIST [INTEGER]
			-- List of body indexes which represent all global onces for current
			-- generated type

	is_once_twofold: BOOLEAN
			-- Is once routine generated in two functions to avoid
			-- overhead caused by exception interception?

	workbench_mode: BOOLEAN
			-- Mode of generation: if set to True, generation of C code
			-- for the workbench otherwise generation of C code in final
			-- mode

	final_mode: BOOLEAN is
			-- Is generation of C code for finalized mode?
		do
			Result := not workbench_mode
		end

	has_cpp_externals_calls: BOOLEAN
			-- Does the current generated class have a C++ call?

	current_feature: FEATURE_I
			-- Current feature being processed.

	original_body_index: INTEGER
			-- Original body index of the current feature or class invariant

	current_type: CL_TYPE_I
			-- Current class type in which byte code is processed

	class_type: CLASS_TYPE
			-- The class type which we are generating
			--| will be changed for assertion chaining

	original_class_type: CLASS_TYPE
			-- class type we are generating

	buffer: GENERATION_BUFFER
			-- Buffer used for code generation

	header_buffer: GENERATION_BUFFER
			-- Buffer used for extern declaration generation

	inherited_assertion: INHERITED_ASSERTION
			-- Used to record inherited assertions

	byte_code: BYTE_CODE
			-- Current root of processed byte code

	old_expressions: LINKED_LIST [UN_OLD_B]
			-- Used to record old expressions in Pass 3.

	non_gc_tmp_vars: INTEGER
			-- Total number of registers for references variables needed.

	non_gc_reg_vars: INTEGER
			-- Currently used registers for reference variables which do not
			-- need to be under GC control (e.g. Hector references).

	local_vars: ARRAY [BOOLEAN]
			-- Local variables used have their flag set to True.

	local_index_table: HASH_TABLE [INTEGER, STRING]
			-- Index in local variable array (C code) for a given register

	associated_register_table: HASH_TABLE [REGISTRABLE, STRING]
			-- Indexed by the same keys as `local_index_table', this associative
			-- array maps a name into a registrable instance.

	propagated: BOOLEAN
			-- Was the propagated value caught ?

	current_used: BOOLEAN
			-- Is Current used (apart from dtype computation) ?

	current_used_count: INTEGER
			-- How many times current is used?

	result_used: BOOLEAN
			-- Is Result used (apart from very last assignment) ?

	label: INTEGER
			-- For label generation

	dt_current: INTEGER
			-- Number of time we need to compute Current's type

	inlined_dt_current: INTEGER
			-- Number of time we need to compute Current's type

	dftype_current: INTEGER
			-- Number of time we need to compute Current's full dynamic type

	inlined_dftype_current: INTEGER
			-- Number of time we need to compute Current's full dynamic type

	local_index_counter: INTEGER
			-- Index for local reference variables

	assertion_type: INTEGER
			-- Type of assertion being generated

	origin_has_precondition: BOOLEAN
			-- Is Current feature have origin feature with precondition?
			-- (This is used for cases where the origin of the
			-- routine does not have a precondition and thus
			-- the precondition will always be True)

	is_first_precondition_block_generated: BOOLEAN
			-- Is generation of first precondition block generated?

	is_new_precondition_block: BOOLEAN
			-- Is this the start of a new precondition block?
			
	is_argument_protected: BOOLEAN
			-- Does current call need to protect some of its arguments?

feature -- Setting

	set_first_precondition_block_generated (v: BOOLEAN) is
			-- Set `il_external_creation' with `v'.
		do
			is_first_precondition_block_generated := v
		ensure
			is_first_precondition_block_generated_set: is_first_precondition_block_generated = v
		end

	set_new_precondition_block (v: BOOLEAN) is
			-- Set `il_external_creation' with `v'.
		do
			is_new_precondition_block := v
		ensure
			is_new_precondition_block_set: is_new_precondition_block = v
		end

	set_is_argument_protected (v: BOOLEAN) is
			-- Set `is_argument_protected' with `v'.
		do
			is_argument_protected := v
		ensure
			is_argument_protected_set: is_argument_protected = v
		end

	set_once_index (idx : INTEGER) is
			-- Set `once_index' to `idx'
		require
			valid_index : idx >= 0
		do
			once_index := idx
		ensure
			index_set : once_index = idx
		end

	set_workbench_mode is
			-- Set `workbench_mode' to True.
		do
			workbench_mode := True
		ensure
			workbench_mode_set: workbench_mode
		end

	set_final_mode is
			-- Set `final_mode' to True.
		do
			workbench_mode := False
		ensure
			final_mode_set: final_mode
		end

	set_has_cpp_externals_calls (v: BOOLEAN) is
			-- Set `has_cpp_externals_calls' with `v'.
		do
			has_cpp_externals_calls := v
		ensure
			has_cpp_externals_calls_set: has_cpp_externals_calls = v
		end

	set_buffer (b: like buffer) is
			-- Assign `b' to `buffer'.
		require
			b_not_void: b /= Void
		do
			buffer := b
		ensure
			buffer_set: buffer = b
		end

	set_header_buffer (b: like header_buffer) is
			-- Assign `b' to `header_buffer'.
		require
			b_not_void: b /= Void
		do
			header_buffer := b
		ensure
			header_buffer_set: header_buffer = b
		end

	set_assertion_type (a: INTEGER) is
			-- Assign `a' to `assertion_type'
		do
			assertion_type := a
		end

feature {NONE} -- Access: once manifest strings

	once_manifest_string_count_table: HASH_TABLE [INTEGER, INTEGER]
			-- Number of once manifest strings to be allocated for the given routine body index;
			-- actual for the whole system

	once_manifest_string_table: HASH_TABLE [ARRAY [STRING], INTEGER]
			-- Once manifest strings to be created for the given routine body index;
			-- actual for the current class
			
feature -- Access: once manifest strings

	is_static_system_data_safe: BOOLEAN is
			-- Is it safe to use system data stored in system-wide static memory?
		do
			Result := final_mode and then not system.has_multithreaded
		end

	once_manifest_string_count: INTEGER is
			-- Number of once manifest strings in current routine body
		require
			is_static_system_data_safe: is_static_system_data_safe
		do
			Result := once_manifest_string_count_table.item (original_body_index)
		ensure
			non_negative_result: Result >= 0
		end

	once_manifest_string_value (number: INTEGER): STRING is
			-- Value of once manifest string `number' in current routine body
		require
			is_static_system_data_safe: is_static_system_data_safe
			valid_number: number > 0 and then number <= once_manifest_string_count
		local
			routine_once_manifest_strings: ARRAY [STRING]
		do
			routine_once_manifest_strings := once_manifest_string_table.item (original_body_index)
			if routine_once_manifest_strings /= Void then
				Result := routine_once_manifest_strings.item (number)
			end
		end

	generate_once_manifest_string_declaration (buf: like buffer) is
			-- Generate declarations for once manifest strings.
		local
			string_counts: like once_manifest_string_count_table
			i: INTEGER
		do
			string_counts := once_manifest_string_count_table
			from
				string_counts.start
			until
				string_counts.off
			loop
					-- Declare one field for one routine body.
				buf.put_string ("RTDOMS(")
				buf.put_integer (string_counts.key_for_iteration - 1)
				buf.put_character (',')
				i := string_counts.item_for_iteration
				buf.put_integer (i)
				buf.put_character (')')
					-- Set associated string values to NULL.
					-- Objects will be created and assigned during module initialization.
				buf.put_character ('=')
				buf.put_character ('{')
				from
				until
					i <= 0
				loop
					buf.put_string ("NULL")
					i := i - 1
					if i > 0 then
						buffer.put_character (',')
					end
				end
				buf.put_character ('}')
				buf.put_character (';')
				buf.put_new_line
				string_counts.forth
			end
		end

	generate_once_manifest_string_import (number: INTEGER) is
			-- Generate extern declaration for `number' once manifest strings from current routine body.
		require
			non_negative_number: number >= 0
			consistent_number:
				is_static_system_data_safe and then once_manifest_string_count > 0 implies
				once_manifest_string_count = number
		local
			buf: like buffer
		do
			if number > 0 and then is_static_system_data_safe then
					-- Remember number of strings in current routine.
				set_once_manifest_string_count (number)
					-- Generate reference to once manifest string field
				buf := buffer
				buf.put_string ("RTEOMS(")
				buf.put_integer (original_body_index - 1)
				buf.put_character (',')
				buf.put_integer (number)
				buf.put_character (')')
				buf.put_character (';')
				buf.put_new_line
				buf.put_new_line
			end
		ensure
			once_manifest_string_count_set:
				is_static_system_data_safe implies once_manifest_string_count = number
		end

	generate_once_manifest_string_allocation (number: INTEGER) is
			-- Generate C code to allocate memory for once manifest strings in current routine body.
		require
			non_negative_number: number >= 0
			consistent_number: is_static_system_data_safe implies once_manifest_string_count = number
		local
			buf: like buffer
		do
			if number > 0 and then not is_static_system_data_safe then
				buf := buffer
				buf.put_string ("RTAOMS(")
				buf.put_integer (original_body_index - 1)
				buf.put_character (',')
				buf.put_integer (number)
				buf.put_character (')')
				buf.put_character (';')
				buf.put_new_line
			end
		end

	make_once_string_allocation_byte_code (ba: BYTE_ARRAY; number: INTEGER) is
			-- Generate byte code to allocate memory for once manifest strings in current routine body.
		require
			byte_array_not_void: ba /= Void
			non_negative_number: number >= 0
		do
			if number > 0 then
				ba.append ({BYTE_CONST}.Bc_allocate_once_strings)
				ba.append_integer (original_body_index - 1)
				ba.append_integer (number)
			end
		end

	generate_once_manifest_string_initialization is
			-- Generate code to initialize once manifest strings.
		local
			buf: like buffer
			class_once_manifest_strings: like once_manifest_string_table
			routine_once_manifest_strings: ARRAY [STRING]
			body_index: like original_body_index
			i: INTEGER
			value: STRING
		do
			buf := buffer
			buf.indent
			class_once_manifest_strings := once_manifest_string_table
			from
				class_once_manifest_strings.start
			until
				class_once_manifest_strings.off
			loop
				body_index := class_once_manifest_strings.key_for_iteration
				routine_once_manifest_strings := class_once_manifest_strings.item_for_iteration
				from
					i := routine_once_manifest_strings.count
				until
					i <= 0
				loop
					value := routine_once_manifest_strings.item (i)
						-- `value' is void when string appears in assertion that is not generated
					if value /= Void then
							-- RTPOMS is the macro used to create and store once manifest string
							-- provided that it is not created and stored before
						buf.put_string ("RTPOMS(")
						buf.put_integer (body_index - 1)
						buf.put_character (',')
						buf.put_integer (i - 1)
						buf.put_character (',')
						buf.put_character ('%"')
						buf.escape_string (value)
						buf.put_character ('%"')
						buf.put_character (',')
						buf.put_integer (value.count)
						buf.put_character(',')
						buf.put_integer (value.hash_code)
						buf.put_character (')')
						buf.put_character (';')
						buf.put_new_line
					end
					i := i - 1
				end
				class_once_manifest_strings.forth
			end
			buf.exdent
		end

	register_once_manifest_string (value: STRING; number: INTEGER) is
			-- Register that current routine body has once manifest string
			-- with the given `number' of the given `value'.
		require
			is_static_system_data_safe: is_static_system_data_safe
			non_void_value: value /= Void
			valid_number: number > 0 and number <= once_manifest_string_count
			same_if_registered: 
				once_manifest_string_value (number) /= Void implies
				once_manifest_string_value (number) = value
		local
			index: like original_body_index
			routine_once_manifest_strings: ARRAY [STRING]
		do
			index := original_body_index
			routine_once_manifest_strings := once_manifest_string_table.item (index)
			if routine_once_manifest_strings = Void then
				create routine_once_manifest_strings.make (1, once_manifest_string_count)
				once_manifest_string_table.force (routine_once_manifest_strings, index)
			end
			routine_once_manifest_strings.put (value, number)
		ensure
			registered: once_manifest_string_value (number) = value
		end

feature {NONE} -- Setting: once manifest strings

	set_once_manifest_string_count (number: INTEGER) is
			-- Set number of once manifest strings in current routine body to `number'.
		require
			positive_number: number > 0
			same_if_set: once_manifest_string_count > 0 implies once_manifest_string_count = number
		do
			once_manifest_string_count_table.force (number, original_body_index)
		ensure
			once_manifest_string_count_set: once_manifest_string_count = number
		end

feature -- Access

	Current_register: REGISTRABLE is
			-- An instance of Current register for local var index computation
		do
			Result := inlined_current_register
			if Result = Void then
				Result := Current_b
			end
		end

	Current_b: CURRENT_BL is
		once
			create Result
		end

	Result_register: RESULT_B is
			-- An instace of Result register for local var index computation
		local
			dummy: NONE_I
		once
				-- This hack is needed because of the special treatment of
				-- the Result register in once functions. The Result is always
				-- recorded in the GC by RTOC, so there is no need to get an
				-- l[] variable from the GC hooks. Here we are going to call
				-- the print_register function on Result_register,
				-- and this has been carefully patched in RESULT_BL to handle
				-- the once cases.
			create dummy
			create {RESULT_BL} Result.make (dummy)
		end

	register_server: REGISTER_SERVER
			-- Register number server

	has_chained_prec: BOOLEAN is
			-- Feature has chained preconditions?
		do
			Result := (byte_code.precondition /= Void
					or else inherited_assertion.has_precondition)
				and then
					(	workbench_mode
						or else
						assertion_level.check_precond)
		end

	has_rescue: BOOLEAN is
			-- Feature has a rescue clause ?
		do
			Result := byte_code.rescue_clause /= Void
		end

	set_origin_has_precondition (b: BOOLEAN) is
		do
			origin_has_precondition := b
		end

	has_postcondition: BOOLEAN is
			-- Do we have to generate any postcondition ?
		do
			Result :=	workbench_mode
						or else
						(	assertion_level.check_postcond
							and
							(	byte_code.postcondition /= Void
								or else
								inherited_assertion.has_postcondition
							)
						)
		end

	has_precondition: BOOLEAN is
			-- Do we have to generate any precondition ?
		do
			Result := 	workbench_mode
						or else
						(
							assertion_level.check_precond
							and
							byte_code.precondition /= Void
						)
		end

	has_invariant: BOOLEAN is
			-- Do we have to generate invariant checks ?
		do
			Result := workbench_mode or assertion_level.check_invariant
		end

	assertion_level: ASSERTION_I is
			-- Assertion level description
		do
			Result := associated_class.assertion_level
		end

	associated_class: CLASS_C is
			-- Class associated with current type
		do
			Result := current_type.base_class
		end

	instantiation_of (type: TYPE_I): TYPE_I is
			-- Instantiation of `type' in `class_type'.
		require
			class_type_exists: class_type /= Void
		do
			if type.has_formal then
				Result := type.instantiation_in (class_type)
			else
				Result := type
			end
		end

	constrained_type (type: TYPE_I): TYPE_I is
			-- Constrained type
		require
			curent_type_exists: current_type /= Void
		local
			formal: FORMAL_I
			formal_position: INTEGER
			reference_i: REFERENCE_I
		do
			Result := type
			if Result.is_formal then
				formal ?= Result
				check
					current_type.meta_generic /= Void
				end
				formal_position := formal.position
				Result := current_type.meta_generic.item (formal_position)
				reference_i ?= Result
				if reference_i /= Void then
					Result := current_type.base_class.constraint
													(formal_position).type_i
				end
			end
		ensure
			not_formal: not Result.is_formal
		end

	real_type (type: TYPE_I): TYPE_I is
			-- Convenience
		require
			good_argument: type /= Void
			valid_class_type: class_type /= Void
		do
			Result := constrained_type (type)
			Result := instantiation_of (Result)
		ensure
			not Result.is_formal
		end

	creation_type (type: TYPE_I): TYPE_I is
			-- Convenience
		require
			good_argument: type /= Void
			valid_class_type: class_type /= Void
		do
			if type.has_true_formal then
				Result := type.complete_instantiation_in (class_type)
			else
				Result := type
			end
		end

	set_byte_code (bc: BYTE_CODE) is
			-- Assign `bc' to byte_code.
		require
			good_argument: bc /= Void
		do
			byte_code := bc
		end

	init (t: CLASS_TYPE) is
			-- Initialization of byte context.
			-- Check to see if class type has inherited
			-- assertions. If it does not then set
			-- has_inherited_assertion to False. Otherwize,
			-- set has_inherited_assertion to True.
		do
			set_class_type (t)
			original_class_type := t
			--if System.Redef_feat_server.has (associated_class.id) then
				--has_inherited_assertion := True
			--else
				--has_inherited_assertion := False
			--end
		end

	set_class_type (t: CLASS_TYPE) is
			-- Assign `t' to class_type.
		require
			good_argument: t /= Void
		do
			class_type := t
			current_type := t.type
				-- Decide whether once routines should be generated as two functions
				-- to avoid performance penalty caused by inefficient code generated
				-- for functions with exception handling
			if
				workbench_mode or else system.has_multithreaded or else
				assertion_level.check_precond or else
				assertion_level.check_invariant or else assertion_level.check_postcond
			then
				is_once_twofold := False
			else
				is_once_twofold := True
			end
		end

	set_current_feature (f: FEATURE_I) is
			-- Assign `f' to `current_feature'.
		require
			valid_f: f /= Void
		do
			current_feature := f
			original_body_index := f.body_index
		ensure
			current_feature_set: current_feature = f
			original_body_index_set: original_body_index = f.body_index
		end
		
	set_original_body_index (new_original_body_index: like original_body_index) is
			-- Set `original_body_index' to `new_original_body_index'.
		do
			original_body_index := new_original_body_index
		ensure
			original_body_index_set: original_body_index = new_original_body_index
		end

	add_non_gc_vars is
			-- Add a temporary reference variable not to be placed under GC.
		do
			non_gc_reg_vars := non_gc_reg_vars + 1
			if non_gc_tmp_vars < non_gc_reg_vars then
				non_gc_tmp_vars := non_gc_reg_vars
			end
		end

	free_non_gc_vars is
			-- Free a temporary reference not under GC control.
		require
			good_context: non_gc_reg_vars >= 1
		do
			non_gc_reg_vars := non_gc_reg_vars - 1
		end

	init_propagation is
			-- Reset `propagated' to False.
		do
			propagated := False
		end

	set_propagated is
			-- Signals register has been caught.
		do
			propagated := True
		end

	propagate_no_register: BOOLEAN is
			-- Is the propagation of `No_register' allowed ?
		do
			Result := not (	workbench_mode
							or else
							assertion_level.check_precond)
		end

	add_dt_current is
			-- One more time we need to compute Current's type.
		do
			if in_inlined_code then
				inlined_dt_current := inlined_dt_current + 1
			else
				dt_current := dt_current + 1
			end
		end
		
	add_dftype_current is
			-- On more time we need to compute Current's full dynamic type.
		do
			if in_inlined_code then
				inlined_dftype_current := inlined_dftype_current + 1
			else
				dftype_current := dftype_current + 1
			end
		end

	set_inlined_dt_current (i: INTEGER) is
			-- Set the value of `inlined_dt_current' to `i'
		require
			i_non_negative: i >= 0
		do
			inlined_dt_current := i
		ensure
			inlined_dt_current_set: inlined_dt_current = i
		end

	set_inlined_dftype_current (i: INTEGER) is
			-- Set value of `inlined_dftype_current' to `i'.
		require
			i_non_negative: i >= 0
		do
			inlined_dftype_current := i
		ensure
			inlined_dftype_current_set: inlined_dftype_current = i
		end

	reset_inlined_dt_current is
			-- Reset `inlined_dt_current' to 0
		do
			inlined_dt_current := 0
		ensure
			inlined_dt_current_set: inlined_dt_current = 0
		end

	reset_inlined_dftype_current is
			-- Reset `inlined_dftype_current' to 0
		do
			inlined_dftype_current := 0
		ensure
			inlined_dftype_current_set: inlined_dftype_current = 0
		end

	mark_current_used is
			-- Signals that a reference is made to Current (apart
			-- from computing a DT) and thus needs to be pushed on
			-- the local stack in case it'd be moved by the GC.
			-- As a side effect, compute an index for Current in the
			-- local variable array
		do
				-- Not marking if inside inlined code:
				-- Current is NOT in Current_b
			current_used_count := current_used_count + 1
			if not (current_used or else in_inlined_code) then
				set_local_index ("Current", Current_b)
				current_used := True
			end
		end

	mark_result_used is
			-- Signals that an assignment in Result is made
			-- As a side effect, compute an index for Result in the local
			-- variable array, if the type is a pointer one and we are not
			-- inside a once function.
		do
			if not in_inlined_code then
				if not result_used and
					real_type (byte_code.result_type).c_type.is_pointer and
					not byte_code.is_once
				then
					set_local_index ("Result", Result_register)
				end
				result_used := True
			end
		end

	mark_local_used (an_index: INTEGER) is
			-- Signals that local variable `an_index' is used
		do
			local_vars.force (True, an_index)
		end

	inc_label is
			-- Increment `label'
		do
			label := label + 1
		end

	generate_body_label is
			-- Generate label "body"
			--|Note: the semi-colon is added, otherwise C compilers
			--|complain when there are no instructions after the label.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.exdent
			buf.put_string ("body:;")
			buf.put_new_line
			buf.indent
		end

	print_body_label is
			-- Print label "body"
		do
			buffer.put_string ("body")
		end

	generate_current_label_definition is
			-- Generate current label `label'.
		do
			generate_label_definition (label)
		end

	generate_label_definition (l: INTEGER) is
			-- Generate label number `l'
		require
			label_exists: l >= 0
		local
			buf: GENERATION_BUFFER
		do
			if label > 0 then
				buf := buffer
				buf.exdent
				buf.put_new_line
				print_label (l)
				buf.put_character (':')
				buf.put_new_line
				buf.indent
			end
		end

	print_current_label is
			-- Print label number `label'.
		do
			print_label (label)
		end

	print_label (l: INTEGER) is
			-- Print label number `l'
		require
			label_exists: l > 0
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_string ("label_")
			buf.put_integer (l)
		end

	set_local_index (s: STRING; r: REGISTRABLE) is
			-- Record the instance `r' into the `associated_register_table'
			-- as register named `s'.
		require
			s_not_void: s /= Void
		local
			key: STRING
		do
			if not local_index_table.has (s) then
				key := s.twin
				local_index_table.put (local_index_counter, key)
				local_index_counter := local_index_counter + 1
				associated_register_table.put (r, key)
			end
		end

	need_gc_hook: BOOLEAN
			-- Do we need to generate GC hooks?
			-- Computed by compute_need_gc_hooks for each instance of BYTE_CODE.

	force_gc_hooks is
			-- Force usage of GC hooks
		do
			need_gc_hook := True
		end

	compute_need_gc_hooks (has_assertions_checking_enabled: BOOLEAN) is
			-- Set `need_gc_hook' for current instance of BYTE_CODE
			-- If `has_assertions_checking_enabled', `need_gc_hook' is set to True.
		local
			l_assign: ASSIGN_BL
			reverse_b: REVERSE_BL
			call: CALL_B
			expr_b: EXPR_B
			creation_expr: CREATION_EXPR_B
			instruction_call: INSTR_CALL_B
			attribute_b: ATTRIBUTE_B
			compound: BYTE_LIST [BYTE_NODE]
			byte_node: BYTE_NODE
			tmp: BOOLEAN
		do
				-- We won't need any RTLI if the only statement is an expanded
				-- assignment in Result or a single call.

				-- If there is a rescue clause, then we'll
				-- need an execution vector, hence GC hooks
				-- are really needed.
				-- If some calls are inlined, we need to save Current, Result,
				-- the arguments and locals in registers
				-- If there are some pre/post conditions to check, we choose
				-- to be safe by encapsulating even when not needed if the checks
				-- are generated.
			tmp := has_rescue or byte_code.has_inlined_code or has_assertions_checking_enabled

			if not tmp and then assertion_type /= In_invariant then
				tmp := True	
					-- Not in an invariant generation
				compound := byte_code.compound
				if compound /= Void and then compound.count = 1 then
					byte_node := compound.first
					l_assign ?= byte_node
					if l_assign /= Void then
						if l_assign.expand_return then
								-- Assignment in Result is expanded in a return instruction
							tmp := False
						else
							reverse_b ?= l_assign
								-- FIXME: Manu 05/31/2002: we should try to optimize
								-- so that not all reverse assignment prevent the optimization
								-- to be made.
							call ?= l_assign.source
							if call /= Void and then call.is_single and reverse_b = Void then
									-- Simple assignment of a single call
								creation_expr ?= call
								if creation_expr /= Void or has_invariant then
										-- We do not optimize if we are handling a creation expression or
										-- if invariant checking is enabled.
									tmp := True
								else
									if call.is_constant then
										tmp := False
									elseif l_assign.target.is_predefined then
											-- Assignment on a predefined target is always safe.
										tmp := False
									else
											-- We can optimize target := call when
											-- no metamorphosis occurs on source.
										tmp := not real_type (l_assign.target.type).is_basic and
											real_type (call.type).is_basic
										
										if not tmp then
											attribute_b ?= call
											if attribute_b /= Void then
													-- An attribute access is always safe
												tmp := False
											else
													-- If it is an instruction target := call
													-- where the source is a predefined item
													-- (local, current, result or argument),
													-- we can still optimize. Xavier
												tmp := not call.is_predefined
											end
										end
									end
								end
							else
								expr_b ?= l_assign.source
								tmp := expr_b.has_call or expr_b.allocates_memory
							end
						end
					else
						instruction_call ?= byte_node
						if instruction_call /= Void then
							if instruction_call.call.is_single then
									-- A single instruction call
								tmp := has_invariant
							end
						end
					end
				end
			end
			need_gc_hook := tmp
		end

	make_from_context (other: like Current) is
			-- Save context for later restoration. This makes the
			-- use of unanalyze possible and meaningful.
		do
			copy (other)
			register_server := other.register_server.duplicate
			local_index_table := other.local_index_table.twin
			associated_register_table := other.associated_register_table.twin
		end

	restore (saved_context: like Current) is
			-- Restore the saved context after an analyze followed by an
			-- unanalyze, so that we may analyze again with different
			-- propagations (kind of feedback).
		do
			register_server := saved_context.register_server
			current_used := saved_context.current_used
			current_used_count := saved_context.current_used_count
			need_gc_hook := saved_context.need_gc_hook
			current_feature := saved_context.current_feature
			result_used := saved_context.result_used
			dt_current := saved_context.dt_current
			inlined_dt_current := saved_context.inlined_dt_current
			dftype_current := saved_context.dftype_current
			inlined_dftype_current := saved_context.inlined_dftype_current
			non_gc_reg_vars := saved_context.non_gc_reg_vars
			non_gc_tmp_vars := saved_context.non_gc_tmp_vars
			local_index_table := saved_context.local_index_table
			local_index_counter := saved_context.local_index_counter
			associated_register_table := saved_context.associated_register_table
		end

	generate_current_dtype is
			-- Generate the dynamic type of `Current'
		do
			if inlined_dt_current > 1 then
				buffer.put_string (gc_inlined_dtype)
			elseif dt_current > 1 then
				buffer.put_string (gc_dtype)
			else
				buffer.put_string (gc_upper_dtype_lparan)
				Current_register.print_register
				buffer.put_character (')')
			end
		end

	generate_current_dftype is
			-- Generate the dynamic type of `Current'
		do
			if inlined_dftype_current > 1 then
				buffer.put_string (gc_inlined_dftype)
			elseif dftype_current > 1 then
				buffer.put_string (gc_dftype)
			else
				buffer.put_string (gc_upper_dftype_lparan)
				Current_register.print_register
				buffer.put_character (')')
			end
		end

	generate_temporary_ref_variables is
			-- Generate temporary variables under the control of the
			-- garbage collector.
		local
			i, j, nb_vars: INTEGER
		do
			from
				i := 1
			until
				i > C_nb_types
			loop
				from
					j := 1
					nb_vars := register_server.needed_registers_by_clevel (i)
				until
					j > nb_vars
				loop
					generate_tmp_var (i, j)
					j := j + 1
				end
				i := i + 1
			end
		end

	generate_temporary_nonref_variables is
			-- Generate temporary variables not under the control of the
			-- garbage collector.
		local
			i, j: INTEGER
			buf: GENERATION_BUFFER
			has_rescue_clause: BOOLEAN
		do
			j := non_gc_tmp_vars
			if j >= 1 then
				from
					i := 1
					buf := buffer
					has_rescue_clause := has_rescue
				until
					i > j
				loop
					if has_rescue_clause then
						buf.put_string ("EIF_OBJECT EIF_VOLATILE xp")
					else
						buf.put_string ("EIF_OBJECT xp")
					end
					buf.put_integer (i)
					buf.put_character (';')
					buf.put_new_line
					i := i + 1
				end
			end
		end

	generate_tmp_var (ctype, num: INTEGER) is
			-- Generate declaration for temporary variable `num'
			-- whose C type is `ctype'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if
				has_rescue and then 
				(ctype /= C_ref and then ctype /= C_pointer)
			then
					-- Protect access to local variables due
					-- to rescue clause.
				buf.put_string ("EIF_VOLATILE ")
			end

			inspect
				ctype
			when c_uint8 then
				buf.put_string ("EIF_NATURAL_8 tu8_")
				buf.put_integer (num)
			when c_uint16 then
				buf.put_string ("EIF_NATURAL_16 tu16_")
				buf.put_integer (num)
			when c_uint32 then
				buf.put_string ("EIF_NATURAL_32 tu32_")
				buf.put_integer (num)
			when c_uint64 then
				buf.put_string ("EIF_NATURAL_64 tu64_")
				buf.put_integer (num)
			when C_int8 then
				buf.put_string ("EIF_INTEGER_8 ti8_")
				buf.put_integer (num)
			when C_int16 then
				buf.put_string ("EIF_INTEGER_16 ti16_")
				buf.put_integer (num)
			when C_int32 then
				buf.put_string ("EIF_INTEGER_32 ti32_")
				buf.put_integer (num)
			when C_int64 then
				buf.put_string ("EIF_INTEGER_64 ti64_")
				buf.put_integer (num)
			when C_ref then
				buf.put_string ("EIF_REFERENCE tp")
				buf.put_integer (num)
				buf.put_string (" = NULL")
			when C_real32 then
				buf.put_string ("EIF_REAL_32 tr32_")
				buf.put_integer (num)
			when C_char then
				buf.put_string ("EIF_CHARACTER tc")
				buf.put_integer (num)
			when C_wide_char then
				buf.put_string ("EIF_WIDE_CHAR twc")
				buf.put_integer (num)
			when C_real64 then
				buf.put_string ("EIF_REAL_64 tr64_")
				buf.put_integer (num)
			when C_pointer then
				if has_rescue then
					buf.put_string ("EIF_POINTER EIF_VOLATILE ta")
				else
					buf.put_string ("EIF_POINTER ta")
				end
				buf.put_integer (num)
			end
			buf.put_character (';')
			buf.put_new_line
		end

	generate_gc_hooks (compound_or_post: BOOLEAN) is
			-- In case there are some local reference variables,
			-- generate the hooks for the GC by filling the local variable
			-- array. Unfortunately, I cannot use bzero() on the array, in
			-- case it would be a function call--RAM.
			--| `compound_or_post' indicate the generation of hooks
			--| for the compound or post- pre- or invariant routine. -- FREDD
		local
			nb_refs: INTEGER	-- Total number of references to be pushed
			hash_table: HASH_TABLE [INTEGER, STRING]
			associated: HASH_TABLE [REGISTRABLE, STRING]
			rname: STRING
			position: INTEGER
			reg: REGISTRABLE
			buf: GENERATION_BUFFER
		do
			buf := buffer
				-- if more than, say, 20 local variables are to be initialized,
				-- then it might be worthy to call bzero() instead of manually
				-- setting the entries (beneficial both in code size and execution
				-- time
				-- Current is needed only if used
			nb_refs := ref_var_used

				-- The hooks are only needed if there is at least one reference
			if nb_refs > 0 then
				if compound_or_post or else byte_code.rescue_clause = Void then
					buf.put_string ("RTLI(")
				else
					buf.put_string ("RTXI(")
				end
				buf.put_integer (nb_refs)
				buf.put_string (gc_rparan_semi_c)
				buf.put_new_line
				from
					hash_table := local_index_table
					associated := associated_register_table
					hash_table.start
				until
					hash_table.after
				loop
					rname := hash_table.key_for_iteration
					position := hash_table.item_for_iteration
					reg := associated.item (rname)

					check
						reference_type: not reg.is_current implies reg.c_type.is_pointer
					end

					if
						((reg.is_predefined or reg.is_temporary)
						and not (reg.is_current or reg.is_argument)
						and not (reg.is_result and compound_or_post))
					then
						buf.put_local_registration (position, rname)
					else
						if (reg.c_type.is_bit) and (reg.is_argument) then
								-- Clone argument if it is bit
							buf.put_local_registration (position, rname)
							buf.put_new_line
							buf.put_string (rname)
							buf.put_string (" = RTCB(")
							buf.put_string (rname)
							buf.put_character (')')
							buf.put_character (';')
						else
							buf.put_local_registration (position, rname)
						end
					end
					buf.put_new_line
					hash_table.forth
				end
				buf.put_new_line
			end
		end

	expanded_number (arg_pos: INTEGER): INTEGER is
			-- Compute the argument's ordinal position within the expanded
			-- subset of arguments.
		local
			arg_array: ARRAY [TYPE_I]
			i, count: INTEGER
			nb_exp: INTEGER
		do
			arg_array := byte_code.arguments
			from
				i := arg_array.lower
				count := arg_array.count
			until
				Result /= 0 or i > count or i > arg_pos
			loop
				if real_type (arg_array.item (i)).is_true_expanded then
					nb_exp := nb_exp + 1
				end
				if i = arg_pos then
					Result := nb_exp
				end
				i := i + 1
			end
		end

	remove_gc_hooks is
			-- Pop off pushed addresses on local stack
		local
			vars: INTEGER
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if byte_code.rescue_clause /= Void then
				buf.put_string ("RTEOK;")
				buf.put_new_line
			end
			vars := ref_var_used
			if vars > 0 then
				if byte_code.rescue_clause /= Void then
					buf.put_string ("RTXE;")
					buf.put_new_line
				else
					buf.put_string ("RTLE;")
					buf.put_new_line
				end
			end
		end

	ref_var_used: INTEGER is
			-- Number of reference variable needed for GC hooks
		do
			if not need_gc_hook then
				Result := 0
			else
				Result := local_index_table.count
			end
		end

	local_list: LINKED_LIST [TYPE_I]
			-- Local type list for byte code: it includes Eiffel local
			-- variables types, variant local integer and hector
			-- temporary varaibles

	add_local (t: TYPE_I) is
			-- Add local type to `local_list'.
		require
			good_argument: t /= Void
		do
			local_list.finish
			local_list.put_right (t)
		end

feature -- Clearing

	clear_old_expressions is
			-- Clear old expressions.
		do
				--! Did this so it won't effect any old_expression
				--! referencing this object.
			create old_expressions.make
		end

	array_opt_clear is
			-- Clear during the array optimization
		do
			class_type := Void
			byte_code := Void
		end

	clear_feature_data is
			-- Clear feature-specific data.
		do
			local_vars.clear_all
			local_index_table.clear_all
			associated_register_table.clear_all
			local_index_counter := 0
			dt_current := 0
			inlined_dt_current := 0
			dftype_current := 0
			inlined_dftype_current := 0
			is_first_precondition_block_generated := False
			is_new_precondition_block := False
			result_used := False
			current_feature := Void
			original_body_index := 0
			current_used := False
			current_used_count := 0
			need_gc_hook := False
			label := 0
			non_gc_reg_vars := 0
			non_gc_tmp_vars := 0
			local_list.wipe_out
			breakpoint_slots_number := 0;
				-- This should not be necessary but may limit the
				-- effect of bugs in register allocation (if any).
			register_server.clear_all
		end

	clear_class_type_data is
			-- Clear class-type-specific data.
		do
				-- Wipe out content of `global_onces'.
			global_onces.wipe_out
				-- Wipe out once manifest strings records.
			once_manifest_string_table.wipe_out
		ensure
			global_onces_is_empty: global_onces.is_empty
			once_manifest_string_table_is_empty: once_manifest_string_table.is_empty
		end

	clear_system_data is
			-- Clear system-wide data.
		do
			once_manifest_string_count_table.wipe_out
		ensure
			once_manifest_string_count_table_is_empty: once_manifest_string_count_table.is_empty
		end

feature -- Debugger

	instruction_line: LINE [AST_EIFFEL]
			-- List of breakable instructions on which a breakpoint may be set.

	breakpoint_slots_number: INTEGER
			-- current number of breakpoint slots known

	set_instruction_line (l: like instruction_line) is
			-- Assign `l' to `instruction_line' and position FIFO stack at the
			-- beginning as a side effect, ready for usage by byte code classes.
		do
			instruction_line := l
			l.start
		end

	get_next_breakpoint_slot: INTEGER is
			-- increase the current number of breakpoint slots and then
			-- return the current number of breakpoint slots. It is used
			-- to get a "line number" when recording a breakable point
		do
			breakpoint_slots_number := breakpoint_slots_number + 1
			Result := breakpoint_slots_number
		end
	
	get_breakpoint_slot: INTEGER is
			-- Return the current number of breakpoint slots. It is used
			-- to get a "line number" when recording a breakable point
		do
			Result := breakpoint_slots_number
		end

	set_breakpoint_slot (a_number: INTEGER) is
			-- Set the current number of breakpoint slots to `a_number'
		do
			breakpoint_slots_number := a_number
		end

	byte_prepend (ba, array: BYTE_ARRAY) is
			-- Prepend `array' to byte array `ba' and update positions in the
			-- breakable point list (provided we are in debug mode).
		do
			ba.prepend (array)
		end

feature -- Inlining

	in_inlined_code: BOOLEAN is
			-- Are we dealing with inlined code?
		do
			Result := inlined_current_register /= Void
		end

	inlined_current_register: REGISTRABLE
			-- pseudo Current register for inlined code

	set_inlined_current_register (r: REGISTRABLE) is
		do
			inlined_current_register := r
		end

invariant
	global_onces_not_void: global_onces /= Void
	once_manifest_string_count_table_not_void: once_manifest_string_count_table /= Void
	once_manifest_string_table_not_void: once_manifest_string_table /= Void
	class_type_valid_with_current_type: class_type /= Void implies class_type.type = current_type

end
