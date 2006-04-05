indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	REFACTORING_HELPER

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
			create inherited_assertion.make
			create global_onces.make (5)
			create onces.make (5)
			create once_manifest_string_count_table.make (100)
			create once_manifest_string_table.make (100)
			create {LINKED_STACK [PAIR [CLASS_TYPE, CLASS_TYPE]]} class_type_stack.make
		end

feature -- Access

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
			-- Context class type with the code which we are generating
			--| will be changed for assertion chaining, inlining, etc.

	context_class_type: CLASS_TYPE
			-- Class type for which the code is being generated;
			-- it is changed for inlining

	original_class_type: CLASS_TYPE
			-- Class type we are generating

	is_class_type_changed: BOOLEAN is
			-- Is `class_type' changed to the type, unrelated to `original_class_type'?
			-- (See also: `change_class_type_contrext'.)
		do
			Result := not class_type_stack.is_empty
		ensure
			definition: Result = not class_type_stack.is_empty
		end

	buffer: GENERATION_BUFFER
			-- Buffer used for code generation

	header_buffer: GENERATION_BUFFER
			-- Buffer used for extern declaration generation

	inherited_assertion: INHERITED_ASSERTION
			-- Used to record inherited assertions

	byte_code: BYTE_CODE
			-- Current root of processed byte code

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

	copy_body_index: INTEGER
			-- Body index of `copy' from ANY

	twin_body_index: INTEGER
			-- Body index of `twin' from ANY

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

feature {NONE} -- Once features: implementation

	onces: HASH_TABLE [PAIR [TYPE_C, like thread_relative_once_index], INTEGER]
			-- List result types and once indexes indexed by body indexes which represent all non-global onces
			-- for current generated type or for the whole system in finalized mode

	global_onces: like onces
			-- List result types and once indexes indexed by body indexes which represent all global onces for current
			-- generated type or for the whole system in finalized mode

	add_once (storage: like onces; type: TYPE_C; code_index: INTEGER) is
			-- Register once routine identified by its `code_index' with result type `type' in `storage'.
		require
			storage_not_void: storage /= Void
			type_not_void: type /= Void
		do
			if not storage.has (code_index) then
					-- Register new once
				storage.put (create {PAIR [TYPE_C, INTEGER]}.make (type, storage.count), code_index)
			end
		end

feature -- C code generation: once features

	is_once_call_optimized: BOOLEAN
			-- Can call to a once routine be optimized by direct loading of its result from memory?

	add_thread_relative_once (type: TYPE_C; code_index: INTEGER) is
			-- Register thread-relative once routine identified by its `code_index' with result type `type'.
		require
			type_not_void: type /= Void
		do
			add_once (onces, type, code_index)
		ensure
			added: has_thread_relative_once (code_index)
		end

	add_process_relative_once (type: TYPE_C; code_index: INTEGER) is
			-- Register process-relative once routine identified by its `code_index' with result type `type'.
		require
			type_not_void: type /= Void
		do
			add_once (global_onces, type, code_index)
		end

	has_thread_relative_once (code_index: INTEGER): BOOLEAN is
			-- Is once feature with `code_index' registered?
		do
			Result := onces.has (code_index)
		end

	thread_relative_once_index (code_index: INTEGER): INTEGER is
			-- Index of a once routine with `code_index' counted from 0
		require
			final_mode: final_mode
			has: has_thread_relative_once (code_index)
		do
			Result := onces.item (code_index).second
		end

	generate_once_optimized_call_start (type_c: TYPE_C; code_index: INTEGER; is_process_relative: BOOLEAN; buf: like buffer) is
			-- Generate beginning of optimized direct call to once routine of type `type_c' with given `code_index'
		require
			is_once_call_optimized: is_once_call_optimized
			type_not_void: type_c /= Void
			buffer_not_void: buf /= Void
		do
			if not System.has_multithreaded then
				if type_c.is_void then
						-- It is a once procedure
					buf.put_string ("RTOSCP(")
				else
						-- It is a once function
					buf.put_string ("RTOSCF(")
				end
				buf.put_integer (code_index)
			elseif is_process_relative then
				if type_c.is_void then
						-- It is a once procedure
					buf.put_string ("RTOPCP(")
				else
						-- It is a once function
					buf.put_string ("RTOPCF(")
				end
				buf.put_integer (code_index)
			else
				if type_c.is_void then
						-- It is a once procedure
					buf.put_string ("RTOUCP(")
				elseif type_c.is_pointer then
						-- It is a once function returning reference
					buf.put_string ("RTOUCR(")
				else
						-- It is a once function returning basic type
					buf.put_string ("RTOUCB(")
					buf.put_string (type_c.c_string)
					buf.put_character (',')
				end
					-- Once routine might be not registered yet
					-- Let's do it now
				add_thread_relative_once (type_c, code_index)
				buf.put_integer (thread_relative_once_index (code_index))
			end
			buf.put_character (',')
		end

	generate_once_data_definition (buf: like buffer) is
			-- Generate definition of once data fields
		require
			buffer_not_void: buf /= Void
		local
			once_indexes: like onces
			definition_macro_prefix: STRING
			result_type: TYPE_C
		do
			if final_mode then
				if system.has_multithreaded then
					once_indexes := global_onces
					definition_macro_prefix := "RTOPD"
				else
					once_indexes := onces
					definition_macro_prefix := "RTOSD"
				end
				from
					once_indexes.start
				until
					once_indexes.after
				loop
					buf.put_string (definition_macro_prefix)
					result_type := once_indexes.item_for_iteration.first
					if result_type.is_void then
						buf.put_string ("P (")
					else
						buf.put_string ("F (")
						buf.put_string (result_type.c_string)
						buf.put_character (',')
					end
					buf.put_integer (once_indexes.key_for_iteration)
					buf.put_character (')')
					buf.put_new_line
					once_indexes.forth
				end
			end
		end

	generate_module_once_data_initialization (static_type_id: INTEGER) is
			-- Generate initialization of once data fields for type identified by `static_type_id'
		require
			buffer_not_void: buffer /= Void
		local
			buf: like buffer
			once_indexes: like onces
		do
			if workbench_mode then
				buf := buffer
					-- Initialize indexes for single-threaded or thread-relative once routines
				once_indexes := onces
				from
					once_indexes.start
				until
					once_indexes.after
				loop
					buf.put_string ("RTOTS (")
					buf.put_integer (once_indexes.key_for_iteration)
					buf.put_character (',')
					buf.put_string (encoder.feature_name (static_type_id, once_indexes.key_for_iteration))
					buf.put_character (')')
					buf.put_new_line
					once_indexes.forth
				end
					-- Initialize indexes for process-relative once routines
				once_indexes := global_onces
				from
					once_indexes.start
				until
					once_indexes.after
				loop
					buf.put_string ("RTOQS (")
					buf.put_integer (once_indexes.key_for_iteration)
					buf.put_character (',')
					buf.put_string (encoder.feature_name (static_type_id, once_indexes.key_for_iteration))
					buf.put_character (')')
					buf.put_new_line
					once_indexes.forth
				end
			end
		end

	generate_system_once_data_initialization (buf: like buffer) is
			-- Generate initialization of system-wide once data fields
		require
			buffer_not_void: buf /= Void
		local
			once_indexes: like onces
			initialization_macro: STRING
		do
			if final_mode and then system.has_multithreaded then
					-- Set number of thread-relative once routines
				buf.put_string ("EIF_once_count = ")
				buf.put_integer (onces.count)
				buf.put_character (';')
				buf.put_new_line
					-- Initialize process-relative once routine fields
					-- FIXME: Manu: 02/11/2003: Mutex are created but they are never freed,
					-- thus a memory leak if upon program termination the system does not
					-- get back the resources allocated for the mutex.
				once_indexes := global_onces
				initialization_macro := "RTOPI("
				from
					once_indexes.start
				until
					once_indexes.after
				loop
					buf.put_string (initialization_macro)
					buf.put_integer (once_indexes.key_for_iteration)
					buf.put_character (')')
					buf.put_new_line
					once_indexes.forth
				end
			end
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
		require
			buffer_not_void: buf /= Void
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
						buf.put_string_literal (value)
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

	constrained_type_in (type: TYPE_I; context_type: CLASS_TYPE): TYPE_I is
			-- Constrained type `type' in the context of `context_class_type'
		require
			type_not_void: type /= Void
			context_type_not_void: context_type /= Void
		local
			context_type_i: CL_TYPE_I
			formal: FORMAL_I
			formal_position: INTEGER
			reference_i: REFERENCE_I
		do
			debug ("to_implement")
				to_implement ("Move this feature to TYPE_I with a redefinition in FORMAL_I.")
			end
			Result := type
			if Result.is_formal then
				context_type_i := context_type.type
				formal ?= Result
				check
					context_type_i.meta_generic /= Void
				end
				formal_position := formal.position
				Result := context_type_i.meta_generic.item (formal_position)
				reference_i ?= Result
				if reference_i /= Void then
					Result := context_type_i.base_class.constraint (formal_position).type_i
				end
			end
		ensure
			result_not_void: Result /= Void
			result_not_formal: not Result.is_formal
		end

	real_type_in (type: TYPE_I; context_type: CLASS_TYPE): TYPE_I is
			-- Type `type' as seen in `context_type'
		require
			type_not_void: type /= Void
			context_type_not_void: context_type /= Void
		do
			debug ("to_implement")
				to_implement ("Move this feature to TYPE_I and descendants.")
			end
			Result := constrained_type_in (type, context_type).instantiation_in (context_type)
		ensure
			result_not_void: Result /= Void
			result_not_formal: not Result.is_formal
		end

	real_type (type: TYPE_I): TYPE_I is
			-- Type `type' written in `class_type' as seen in `context_class_type'
		require
			type_not_void: type /= Void
			class_type_not_void: class_type /= Void
			context_class_type_not_void: context_class_type /= Void
		local
			cl_type_i: CL_TYPE_I
		do
				-- Avoid instantiating types if possible
			cl_type_i ?= type
			if cl_type_i /= Void and then cl_type_i.is_standalone then
					-- Standalone class type
				Result := cl_type_i
			elseif cl_type_i = Void and then type.is_anchored then
					-- "like Current"
				Result := context_class_type.type
			elseif context_class_type = class_type then
				Result := real_type_in (type, class_type)
			else
				debug ("to_implement")
					to_implement ("Implement context-aware TYPE_I.instantiation_in so that there is no need to create TYPE_A.")
				end
				Result := constrained_type_in (type, class_type).type_a.instantiation_in
						(context_class_type.type.type_a, class_type.type.class_id).type_i
			end
		ensure
			result_not_void: Result /= Void
			result_not_formal: not Result.is_formal
		end

	creation_type (type: TYPE_I): TYPE_I is
			-- Convenience
		require
			good_argument: type /= Void
			valid_class_type: class_type /= Void
		do
			Result := type.complete_instantiation_in (class_type)
		end

	set_byte_code (bc: BYTE_CODE) is
			-- Assign `bc' to byte_code.
		require
			good_argument: bc /= Void
		do
			byte_code := bc
		end

	init (t: CLASS_TYPE) is
			-- Initialize byte context with `t'.
		require
			t_not_void: t /= Void
		local
			f: FEATURE_I
			feature_table: FEATURE_TABLE
		do
			class_type_stack.wipe_out
			original_class_type := t
			context_class_type := t
			set_class_type (t)
			feature_table := System.any_class.compiled_class.feature_table
			f := feature_table.item_id ({PREDEFINED_NAMES}.copy_name_id)
			if f = Void then
					-- "copy" is not found in ANY
				copy_body_index := -1
			else
				copy_body_index := f.body_index
			end
			f := feature_table.item_id ({PREDEFINED_NAMES}.twin_name_id)
			if f = Void then
					-- "copy" is not found in ANY
				twin_body_index := -1
			else
				twin_body_index := f.body_index
			end
		ensure
			original_class_type_set: original_class_type = t
			context_class_type_set: context_class_type = t
			class_type_set: class_type = t
			not_is_class_type_changed: not is_class_type_changed
		end

	is_ancestor (other: CLASS_TYPE): BOOLEAN is
			-- Is `other' an ancestor of `context_class_type'?
		do
			Result := context_class_type.type.type_a.is_conformant_to (other.type.type_a)
		end

	is_written_context: BOOLEAN is
			-- Does current context match the context where the code is written?
		do
			Result := context_class_type = class_type
		end

	set_class_type (t: CLASS_TYPE) is
			-- Assign `t' to `class_type'.
		require
			t_not_void: t /= Void
			context_class_type_not_void: context_class_type /= Void
			is_ancestor: is_ancestor (t)
		do
			class_type := t
			current_type := t.type
				-- Decide whether once routines can be optimized so that their results
				-- can be retrieved directly from memory without making actual calls.
			if
				workbench_mode or else assertion_level.check_precond or else
				assertion_level.check_invariant or else assertion_level.check_postcond
			then
				fixme ("[
					Even with precondition and postcondition checks turned on there is a possibility that
					routine has no preconditions and postconditions. Then if class invariants are not checked
					the optimization is still applicable.
				]")
				is_once_call_optimized := False
			else
				is_once_call_optimized := True
			end
		ensure
			class_type_set: class_type = t
		end

	change_class_type_context (new_context_class_type: CLASS_TYPE; new_written_class_type: CLASS_TYPE) is
			-- Change the current `class_type' to `new_written_class_type',
			-- not related to `original_class_type', but to `new_context_class_type'.
			-- (Multiple calls to this feature are allowed and should
			-- be paired with the calls to `restore_class_type_context').
		require
			new_context_class_type_not_void: new_context_class_type /= Void
			new_written_class_type_not_void: new_written_class_type /= Void
			context_class_type_not_void: context_class_type /= Void
			class_type_not_void: class_type /= Void
			is_ancestor: -- new_context_class_type.type.type_a.is_conformant_to (new_written_class_type.type.type_a)
		do
			class_type_stack.put (create {PAIR [CLASS_TYPE, CLASS_TYPE]}.make (context_class_type, class_type))
			context_class_type := new_context_class_type
			set_class_type (new_written_class_type)
		ensure
			class_type_set: class_type = new_written_class_type
			context_class_type_set: context_class_type = new_context_class_type
			is_class_type_changed: is_class_type_changed
		end

	restore_class_type_context is
			-- Restore the state of context to the one before the
			-- earlier call to `change_class_type_context'.
		require
			is_class_type_changed: is_class_type_changed
		local
			previous_context: PAIR [CLASS_TYPE, CLASS_TYPE]
		do
				-- Remove stack item before calling `set_class_type'
			previous_context := class_type_stack.item
			class_type_stack.remove
			context_class_type := previous_context.first
			set_class_type (previous_context.second)
		ensure
			context_class_type_set: context_class_type = old class_type_stack.item.first
			class_type_set: class_type = old class_type_stack.item.second
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

	generate_tmp_var (ctype, num: INTEGER) is
			-- Generate declaration for temporary variable `num'
			-- whose C type is `ctype'.
		local
			buf: GENERATION_BUFFER
			l_type, l_name: STRING
		do
			buf :=buffer

				-- First get type and name of temporary local.
			inspect
				ctype
			when c_uint8 then
				l_type := once "EIF_NATURAL_8"
				l_name := once "tu8_"
			when c_uint16 then
				l_type := once "EIF_NATURAL_16"
				l_name := once "tu16_"
			when c_uint32 then
				l_type := once "EIF_NATURAL_32"
				l_name := once "tu32_"
			when c_uint64 then
				l_type := once "EIF_NATURAL_64"
				l_name := once "tu64_"
			when C_int8 then
				l_type := once "EIF_INTEGER_8"
				l_name := once "ti8_"
			when C_int16 then
				l_type := once "EIF_INTEGER_16"
				l_name := once "ti16_"
			when C_int32 then
				l_type := once "EIF_INTEGER_32"
				l_name := once "ti32_"
			when C_int64 then
				l_type := once "EIF_INTEGER_64"
				l_name := once "ti64_"
			when C_ref then
				l_type := once "EIF_REFERENCE"
				l_name := once "tp"
			when C_real32 then
				l_type := once "EIF_REAL_32"
				l_name := once "tr32_"
			when C_char then
				l_type := once "EIF_CHARACTER"
				l_name := once "tc"
			when C_wide_char then
				l_type := once "EIF_WIDE_CHAR"
				l_name := once "twc"
			when C_real64 then
				l_type := once "EIF_REAL_64"
				l_name := once "tr64_"
			when C_pointer then
				l_type := once "EIF_POINTER"
				l_name := once "ta"
			end
			buf.put_string (l_type)
			buf.put_character (' ')
			if has_rescue then
				buf.put_string (once " EIF_VOLATILE ")
			end
			buf.put_string (l_name)
			buf.put_integer (num)
			if ctype = c_ref then
					-- Because it is a reference we absolutely need to initialize it
					-- to its default value, otherwise it would mess up the GC local tracking.
				buf.put_string (once " = NULL")
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

	array_opt_clear is
			-- Clear during the array optimization
		do
			class_type := Void
			byte_code := Void
			class_type_stack.wipe_out
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
			local_list.wipe_out
			breakpoint_slots_number := 0;
				-- This should not be necessary but may limit the
				-- effect of bugs in register allocation (if any).
			register_server.clear_all
		end

	clear_class_type_data is
			-- Clear class-type-specific data.
		do
			if workbench_mode then
					-- Wipe out content of `global_onces'.
				global_onces.wipe_out
					-- Wipe out content of `onces'.
				onces.wipe_out
			end
				-- Wipe out once manifest strings records.
			once_manifest_string_table.wipe_out
			class_type_stack.wipe_out
		ensure
			global_onces_is_empty: workbench_mode implies global_onces.is_empty
			onces_is_empty: workbench_mode implies onces.is_empty
			once_manifest_string_table_is_empty: once_manifest_string_table.is_empty
		end

	clear_system_data is
			-- Clear system-wide data.
		do
			global_onces.wipe_out
			onces.wipe_out
			once_manifest_string_count_table.wipe_out
			class_type_stack.wipe_out
			expanded_descendants := Void
		ensure
			global_onces_is_empty: global_onces.is_empty
			onces_is_empty: onces.is_empty
			once_manifest_string_count_table_is_empty: once_manifest_string_count_table.is_empty
			has_no_expanded_descendants_information: not has_expanded_descendants_information
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

feature -- Descendants information

	has_expanded_descendants_information: BOOLEAN is
			-- Is information about expanded descendants available?
		require
			is_final_mode: final_mode
		do
			Result := expanded_descendants /= Void
		ensure
			definition: Result = (expanded_descendants /= Void)
		end

	has_expanded_descendants (type_id: INTEGER): BOOLEAN is
			-- Are there expanded descendants for class type of `type_id'?
		require
			is_final_mode: final_mode
			has_expanded_descendants_information: has_expanded_descendants_information
			valid_type_id: type_id > 0 and then type_id <= system.class_types.count
		do
			Result := expanded_descendants.item (type_id)
		ensure
			definition: Result = expanded_descendants.item (type_id)
		end

	compute_expanded_descendants is
			-- Compute
		require
			is_final_mode: final_mode
			has_no_expanded_descendants_information: not has_expanded_descendants_information
		local
			i: INTEGER
			class_types: ARRAY [CLASS_TYPE]
			c: CLASS_TYPE
		do
			from
				class_types := system.class_types
				i := class_types.count
				create expanded_descendants.make (i)
			until
				i <= 0
			loop
				c := class_types.item (i)
				if c /= Void and then c.is_expanded then
					expanded_descendants.include (c.conformance_table)
				end
				i := i - 1
			end
		ensure
			has_expanded_descendants_information: has_expanded_descendants_information
			expanded_descendants_is_filled: expanded_descendants.count >= system.class_types.count
		end

feature {NONE} -- Implementation

	class_type_stack: STACK [PAIR [CLASS_TYPE, CLASS_TYPE]]
			-- Class types saved due to the context change by `change_class_type_context'

	expanded_descendants: PACKED_BOOLEANS
			-- Marks for class types whether they have an expanded descendant or not

invariant
	global_onces_not_void: global_onces /= Void
	onces_not_void: onces /= Void
	once_manifest_string_count_table_not_void: once_manifest_string_count_table /= Void
	once_manifest_string_table_not_void: once_manifest_string_table /= Void
	class_type_valid_with_current_type: class_type /= Void implies class_type.type = current_type
	class_type_stack_not_void: class_type_stack /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
