note
	description: "Context variables for code generation and utilities."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class BYTE_CONTEXT

inherit

	SHARED_C_LEVEL
		export
			{NONE} all
			{REGISTER}
				c_nb_types
		end

	SHARED_TYPE_I
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

	make
			-- Initialization
		do
			create register_server.make (c_nb_types * 2)
			create local_vars.make (1, 50)
			create local_index_table.make (10)
			create associated_register_table.make (10)
			create local_list.make (10)
			create inherited_assertion.make
			create global_onces.make (5)
			create onces.make (5)
			create once_manifest_string_count_table.make (100)
			create once_manifest_string_table.make (100)
			create class_type_stack.make (10)
			create generated_inlines.make (5)
			create generic_wrappers.make (0)
			create precondition_object_test_local_offset.make (0)
			create postcondition_object_test_local_offset.make (0)
		end

feature -- Access

	workbench_mode: BOOLEAN
			-- Mode of generation: if set to True, generation of C code
			-- for the workbench otherwise generation of C code in final
			-- mode

	final_mode: BOOLEAN
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

	current_type: CL_TYPE_A
			-- Current class type in which byte code is processed

	class_type: CLASS_TYPE
			-- Class type from where the code being generated is coming from.
			--| will be changed for assertion chaining, inlining, etc.

	context_class_type: CLASS_TYPE
			-- Class type for which the code is being generated;
			-- it is changed for inlining

	context_cl_type: CL_TYPE_A
			-- Class type for which the code is being generated;
			-- it is changed for inlining

	original_class_type: CLASS_TYPE
			-- Class type we are generating

	is_class_type_changed: BOOLEAN
			-- Is `class_type' changed to the type, unrelated to `original_class_type'?
			-- (See also: `change_class_type_contrext'.)
		do
			Result := not class_type_stack.is_empty
		ensure
			definition: Result = not class_type_stack.is_empty
		end

	buffer: GENERATION_BUFFER
			-- Buffer used for code generation

	ext_inline_buffer: GENERATION_BUFFER
			-- Buffer used for the generation of inlined externals

	header_buffer: GENERATION_BUFFER
			-- Buffer used for extern declaration generation

	generated_inlines: SEARCH_TABLE [STRING]

	inherited_assertion: INHERITED_ASSERTION
			-- Used to record inherited assertions

	byte_code: BYTE_CODE
			-- Current root of processed byte code

	local_vars: ARRAY [BOOLEAN]
			-- Local variables used have their flag set to True.

	local_index_table: ARRAYED_LIST [STRING]
			-- Index in local variable array (C code) for a given register

	associated_register_table: HASH_TABLE [REGISTRABLE, STRING]
			-- Indexed by the same keys as `local_index_table', this associative
			-- array maps a name into a registrable instance.

	propagated: BOOLEAN
			-- Was the propagated value caught ?

	current_used: BOOLEAN
			-- Is Current used (apart from dtype computation) ?

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

	saved_supplier_precondition: INTEGER
			-- Number of the saved_supplier_precondition local.

	saved_rescue_level: INTEGER
			-- Number of the `saved_rescue_local'.

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

	has_feature_name_stored: BOOLEAN
			-- Is string representing feature name stored in local?

	is_inside_hidden_code: BOOLEAN
			-- Is inside hidden code?
			--| used for sugar code such as new loop construct "across"

	hidden_code_level: INTEGER
			-- Level of hidden code (i.e: depth)


feature -- Setting

	set_first_precondition_block_generated (v: BOOLEAN)
			-- Set `il_external_creation' with `v'.
		do
			is_first_precondition_block_generated := v
		ensure
			is_first_precondition_block_generated_set: is_first_precondition_block_generated = v
		end

	set_new_precondition_block (v: BOOLEAN)
			-- Set `il_external_creation' with `v'.
		do
			is_new_precondition_block := v
		ensure
			is_new_precondition_block_set: is_new_precondition_block = v
		end

	set_is_argument_protected (v: BOOLEAN)
			-- Set `is_argument_protected' with `v'.
		do
			is_argument_protected := v
		ensure
			is_argument_protected_set: is_argument_protected = v
		end

	set_workbench_mode
			-- Set `workbench_mode' to True.
		do
			workbench_mode := True
		ensure
			workbench_mode_set: workbench_mode
		end

	set_final_mode
			-- Set `final_mode' to True.
		do
			workbench_mode := False
		ensure
			final_mode_set: final_mode
		end

	set_has_cpp_externals_calls (v: BOOLEAN)
			-- Set `has_cpp_externals_calls' with `v'.
		do
			has_cpp_externals_calls := v
		ensure
			has_cpp_externals_calls_set: has_cpp_externals_calls = v
		end

	set_buffer (b: like buffer)
			-- Assign `b' to `buffer'.
		require
			b_not_void: b /= Void
		do
			buffer := b
		ensure
			buffer_set: buffer = b
		end

	set_header_buffer (b: like header_buffer)
			-- Assign `b' to `header_buffer'.
		require
			b_not_void: b /= Void
		do
			header_buffer := b
		ensure
			header_buffer_set: header_buffer = b
		end

	set_assertion_type (a: INTEGER)
			-- Assign `a' to `assertion_type'
		do
			assertion_type := a
		end

	set_saved_supplier_precondition (s: INTEGER)
			-- Assign `s' to `saved_supplier_precondition'
		do
			saved_supplier_precondition := s
		end

	set_saved_rescue_level (s: INTEGER)
			-- Assign `s' to `saved_rescue_level'
		do
			saved_rescue_level := s
		end

	set_has_feature_name_stored (v: like has_feature_name_stored)
			-- Assign `v' to `has_feature_name_stored'.
		do
			has_feature_name_stored := v
		ensure
			has_feature_name_stored_set: has_feature_name_stored = v
		end

	set_hidden_code_level (a_level: like hidden_code_level)
		do
			hidden_code_level := a_level
			is_inside_hidden_code := a_level > 0
		end

	enter_hidden_code
			-- Enter level of hidden code
		require
			hidden_code_level_zero_if_not_hidden: not is_inside_hidden_code implies hidden_code_level = 0
		do
			set_hidden_code_level (hidden_code_level + 1)
		ensure
			hidden_code_level_positive: hidden_code_level > 0
		end

	exit_hidden_code
			-- Exit level of hidden code
		require
			is_inside_hidden_code: is_inside_hidden_code
			hidden_code_level_positive: hidden_code_level > 0
		do
			set_hidden_code_level (hidden_code_level - 1)
		ensure
			hidden_code_level_zero_if_not_hidden: not is_inside_hidden_code implies hidden_code_level = 0
		end

feature -- Code generation

	generate_gen_type_conversion (gtype: GEN_TYPE_A; a_level: NATURAL)
			-- Generate code for converting type id arrays
			-- into single id's.
		require
			valid_type : gtype /= Void
		local
			use_init, l_can_save_result: BOOLEAN
			idx_cnt : COUNTER
			l_buffer: like buffer
			l_gen_type: GEN_TYPE_A
			l_cache_name: STRING
		do
			l_buffer := buffer
			if gtype.is_explicit then
				l_gen_type := gtype.deep_actual_type
				use_init := False
				l_can_save_result := not l_gen_type.has_formal_generic
			else
				l_gen_type := gtype
				use_init := True
				l_can_save_result := False
			end

				-- Optimize: Use static array only when `typarr' is
				-- not modified by generated code in multithreaded mode only.
				-- It is safe in monothreaded code as we are guaranteed that
				-- only one thread of execution will use the modified `typarr'.
			l_buffer.put_new_line
			if not System.has_multithreaded or else not use_init then
				l_buffer.put_string ("static ")
			end
			l_buffer.put_string ("EIF_TYPE_INDEX typarr")
			l_buffer.put_natural_32 (a_level)
			l_buffer.put_string ("[] = {")

			l_buffer.put_integer (context_class_type.type.generated_id (final_mode, Void))
			l_buffer.put_character (',')

			if use_init then
				create idx_cnt
				idx_cnt.set_value (1)
				l_gen_type.generate_cid_array (l_buffer, final_mode, True, idx_cnt, context_class_type.type)
			else
				l_gen_type.generate_cid (l_buffer, final_mode, True, context_class_type.type)
			end
			l_buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
			l_buffer.put_string ("};")
			l_buffer.put_new_line
			l_buffer.put_string ("EIF_TYPE_INDEX typres")
			l_buffer.put_natural_32 (a_level)
			l_buffer.put_character (';')
			if l_can_save_result then
				l_buffer.put_new_line
				l_cache_name := "typcache";
				l_cache_name.append_natural_32 (a_level)
				l_buffer.put_string ("static EIF_TYPE_INDEX ")
				l_buffer.put_string (l_cache_name)
				l_buffer.put_string (" = INVALID_DTYPE;")
			end

			if use_init then
				-- Reset counter
				idx_cnt.set_value (1)
				l_gen_type.generate_cid_init (l_buffer, final_mode, True, idx_cnt, context_class_type.type, a_level)
			end

			l_buffer.put_new_line
			l_buffer.put_new_line
			l_buffer.put_string ("typres")
			l_buffer.put_natural_32 (a_level)
			if l_can_save_result then
				l_buffer.put_four_character (' ', '=', ' ', '(')
				l_buffer.put_string (l_cache_name)
				l_buffer.put_four_character (' ', '!', '=', ' ')
				l_buffer.put_string ("INVALID_DTYPE ? ")
				l_buffer.put_string (l_cache_name)
				l_buffer.put_four_character (' ', ':', ' ', '(')
				l_buffer.put_string (l_cache_name)
			end
			l_buffer.put_string (" = eif_compound_id(")
			generate_current_dftype
			l_buffer.put_string (", ")
			l_buffer.put_integer (l_gen_type.generated_id (final_mode, context_class_type.type))
			l_buffer.put_string (", typarr")
			l_buffer.put_natural_32 (a_level)
			if l_can_save_result then
				l_buffer.put_two_character (')', ')')
			end
			l_buffer.put_two_character (')', ';')
		end

feature {NONE} -- Once features: implementation

	onces: HASH_TABLE [PAIR [TYPE_C, like thread_relative_once_index], INTEGER]
			-- List result types and once indexes indexed by body indexes which represent all non-global onces
			-- for current generated type or for the whole system in finalized mode

	global_onces: like onces
			-- List result types and once indexes indexed by body indexes which represent all global onces for current
			-- generated type or for the whole system in finalized mode

	add_once (storage: like onces; type: TYPE_C; code_index: INTEGER)
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

	add_thread_relative_once (type: TYPE_C; code_index: INTEGER)
			-- Register thread-relative once routine identified by its `code_index' with result type `type'.
		require
			type_not_void: type /= Void
		do
			add_once (onces, type, code_index)
		ensure
			added: has_thread_relative_once (code_index)
		end

	add_process_relative_once (type: TYPE_C; code_index: INTEGER)
			-- Register process-relative once routine identified by its `code_index' with result type `type'.
		require
			type_not_void: type /= Void
		do
			add_once (global_onces, type, code_index)
		end

	has_thread_relative_once (code_index: INTEGER): BOOLEAN
			-- Is once feature with `code_index' registered?
		do
			Result := onces.has (code_index)
		end

	thread_relative_once_index (code_index: INTEGER): INTEGER
			-- Index of a once routine with `code_index' counted from 0
		require
			final_mode: final_mode
			has: has_thread_relative_once (code_index)
		do
			Result := onces.item (code_index).second
		end

	generate_once_optimized_call_start (type_c: TYPE_C; code_index: INTEGER; is_process_relative: BOOLEAN; buf: like buffer)
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

	generate_once_data_definition (buf: like buffer)
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
					buf.put_new_line
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
					once_indexes.forth
				end
			end
		end

	generate_module_once_data_initialization (a_type_id: INTEGER)
			-- Generate initialization of once data fields for type identified by `a_type_id'
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
					buf.put_new_line
					buf.put_string ("RTOTS (")
					buf.put_integer (once_indexes.key_for_iteration)
					buf.put_character (',')
					buf.put_string (encoder.feature_name (a_type_id, once_indexes.key_for_iteration))
					buf.put_character (')')
					once_indexes.forth
				end
					-- Initialize indexes for process-relative once routines
				once_indexes := global_onces
				from
					once_indexes.start
				until
					once_indexes.after
				loop
					buf.put_new_line
					buf.put_string ("RTOQS (")
					buf.put_integer (once_indexes.key_for_iteration)
					buf.put_character (',')
					buf.put_string (encoder.feature_name (a_type_id, once_indexes.key_for_iteration))
					buf.put_character (')')
					once_indexes.forth
				end
			end
		end

	generate_system_once_data_initialization (buf: like buffer)
			-- Generate initialization of system-wide once data fields
		require
			buffer_not_void: buf /= Void
		local
			once_indexes: like onces
			initialization_macro: STRING
		do
			if final_mode and then system.has_multithreaded then
					-- Set number of thread-relative once routines
				buf.put_new_line
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
					buf.put_new_line
					buf.put_string (initialization_macro)
					buf.put_integer (once_indexes.key_for_iteration)
					buf.put_character (')')
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

	is_static_system_data_safe: BOOLEAN
			-- Is it safe to use system data stored in system-wide static memory?
		do
			Result := final_mode and then not system.has_multithreaded
		end

	once_manifest_string_count: INTEGER
			-- Number of once manifest strings in current routine body
		require
			is_static_system_data_safe: is_static_system_data_safe
		do
			Result := once_manifest_string_count_table.item (original_body_index)
		ensure
			non_negative_result: Result >= 0
		end

	once_manifest_string_value (number: INTEGER): STRING
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

	generate_once_manifest_string_declaration (buf: like buffer)
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
				buf.put_new_line
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
				string_counts.forth
			end
		end

	generate_once_manifest_string_import (number: INTEGER)
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
				buf.put_new_line
				buf.put_string ("RTEOMS(")
				buf.put_integer (original_body_index - 1)
				buf.put_character (',')
				buf.put_integer (number)
				buf.put_character (')')
				buf.put_character (';')
			end
		ensure
			once_manifest_string_count_set:
				is_static_system_data_safe implies once_manifest_string_count = number
		end

	generate_once_manifest_string_allocation (number: INTEGER)
			-- Generate C code to allocate memory for once manifest strings in current routine body.
		require
			non_negative_number: number >= 0
			consistent_number: True or else to_implement_assertion ("[
					is_static_system_data_safe implies once_manifest_string_count = number
					-- This is currently violated in test#final041 because once manifest
					-- strings are not supported for (inherited) assertions in finalized mode.
				]")
		local
			buf: like buffer
		do
			if number > 0 and then not is_static_system_data_safe then
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTAOMS(")
				buf.put_integer (original_body_index - 1)
				buf.put_character (',')
				buf.put_integer (number)
				buf.put_character (')')
				buf.put_character (';')
			end
		end

	make_once_string_allocation_byte_code (ba: BYTE_ARRAY; number: INTEGER)
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

	generate_once_manifest_string_initialization
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
						buf.put_new_line
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
					end
					i := i - 1
				end
				class_once_manifest_strings.forth
			end
		end

	register_once_manifest_string (value: STRING; number: INTEGER)
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

	set_once_manifest_string_count (number: INTEGER)
			-- Set number of once manifest strings in current routine body to `number'.
		require
			positive_number: number > 0
			same_if_set: once_manifest_string_count > 0 implies once_manifest_string_count = number
		do
			once_manifest_string_count_table.force (number, original_body_index)
		ensure
			once_manifest_string_count_set: once_manifest_string_count = number
		end

feature -- Registers

	Current_register: REGISTRABLE
			-- An instance of Current register for local var index computation
		do
			if inlined_current_register /= Void then
				Result := inlined_current_b
			else
				Result := Current_b
			end
		end

	inlined_current_b: INLINED_CURRENT_B
		once
			create Result
		end

	Current_b: CURRENT_BL
		once
			create Result
		end

	Result_register: RESULT_B
			-- An instace of Result register for local var index computation
		once
				-- This hack is needed because of the special treatment of
				-- the Result register in once functions. The Result is always
				-- recorded in the GC by RTOC, so there is no need to get an
				-- l[] variable from the GC hooks. Here we are going to call
				-- the print_register function on Result_register,
				-- and this has been carefully patched in RESULT_BL to handle
				-- the once cases.
			create {RESULT_BL} Result.make (create {NONE_A})
		end

	get_argument_register (t: TYPE_C): REGISTER
			-- Get a new temporary register of type `t' to hold an argument
			-- to passed to during a feature call
		require
			t_attached: t /= Void
			valid_t: not t.is_void
			is_workbench_mode: workbench_mode
		do
			create Result.make_with_level (t.level + (c_nb_types - 1))
		ensure
			Result_attached: Result /= Void
		end

	print_argument_register (r: REGISTER; buf: like buffer)
			-- Print a name of a register `r' to `buf'
		require
			r_attached: r /= Void
			buf_attached: buf /= Void
		do
			put_register_name (r.level, r.regnum, buf)
			buf.put_character ('x')
		end


feature {BYTE_CONTEXT, REGISTER} -- Registers

	register_server: REGISTER_SERVER
			-- Register number server

feature {REGISTER} -- Registers

	register_name (t: INTEGER; n: INTEGER): STRING
			-- Name of a temporary register number `n' of type `t'.
		require
			valid_t: 0 < t and t <= (c_nb_types - 1) * 2
			positive_n: n > 0
		do
			create Result.make (5)
			Result.append (register_names [t])
			Result.append_integer (n)
		end

	put_register_name (t: INTEGER; n: INTEGER; buf: like buffer)
			-- Put name of a temporary register number `n' of type `t' into `buf'.
		require
			valid_t: 0 < t and t <= (c_nb_types - 1) * 2
			positive_n: n > 0
			buf_attached: buf /= Void
		do
			buf.put_string (register_names [t])
			buf.put_integer (n)
		end

	register_type (t: INTEGER): TYPE_C
			-- Type of register identified by `t'.
		require
			valid_t: 0 < t and t <= (c_nb_types - 1) * 2
		local
			i: INTEGER
		do
			i := t
			if i >= c_nb_types then
				i := i - (c_nb_types - 1)
			end
			inspect i
			when c_uint8 then
				Result := uint8_c_type
			when c_uint16 then
				Result := uint16_c_type
			when c_uint32 then
				Result := uint32_c_type
			when c_uint64 then
				Result := uint64_c_type
			when c_int8 then
				Result := int8_c_type
			when c_int16 then
				Result := int16_c_type
			when c_int32 then
				Result := int32_c_type
			when c_int64 then
				Result := int64_c_type
			when c_ref then
				Result := reference_c_type
			when c_real32 then
				Result := real32_c_type
			when c_real64 then
				Result := real64_c_type
			when c_boolean then
				Result := boolean_c_type
			when c_char then
				Result := char_c_type
			when c_wide_char then
				Result := wide_char_c_type
			when c_pointer then
				Result := pointer_c_type
			end
		end

feature {NONE} -- Registers: implementation

	register_names: SPECIAL [STRING]
			-- Names of registers indexed by their level
		once
				-- `c_void' is not used.
			create Result.make_filled (Void, c_nb_types * 2)
				-- Simple registers.
			Result.put ("ti1_", c_int8)
			Result.put ("ti2_", c_int16)
			Result.put ("ti4_", c_int32)
			Result.put ("ti8_", c_int64)
			Result.put ("tu1_", c_uint8)
			Result.put ("tu2_", c_uint16)
			Result.put ("tu4_", c_uint32)
			Result.put ("tu8_", c_uint64)
			Result.put ("tr4_", c_real32)
			Result.put ("tr8_", c_real64)
			Result.put ("tb", c_boolean)
			Result.put ("tc", c_char)
			Result.put ("tw", c_wide_char)
			Result.put ("tp", c_pointer)
			Result.put ("tr", c_ref)
				-- Registers for passing typed arguments.
			Result.put ("ui1_", c_nb_types - 1 + c_int8)
			Result.put ("ui2_", c_nb_types - 1 + c_int16)
			Result.put ("ui4_", c_nb_types - 1 + c_int32)
			Result.put ("ui8_", c_nb_types - 1 + c_int64)
			Result.put ("uu1_", c_nb_types - 1 + c_uint8)
			Result.put ("uu2_", c_nb_types - 1 + c_uint16)
			Result.put ("uu4_", c_nb_types - 1 + c_uint32)
			Result.put ("uu8_", c_nb_types - 1 + c_uint64)
			Result.put ("ur4_", c_nb_types - 1 + c_real32)
			Result.put ("ur8_", c_nb_types - 1 + c_real64)
			Result.put ("ub", c_nb_types - 1 + c_boolean)
			Result.put ("uc", c_nb_types - 1 + c_char)
			Result.put ("uw", c_nb_types - 1 + c_wide_char)
			Result.put ("up", c_nb_types - 1 + c_pointer)
			Result.put ("ur", c_nb_types - 1 + c_ref)
		end

	register_sk_value (t: INTEGER): STRING
			-- SK value associated with a register type `t'
		require
			valid_t: 0 < t and t <= (c_nb_types - 1) * 2
		do
			Result := register_sk_values [t]
		end

	register_sk_values: ARRAY [STRING]
			-- SK values of registers indexed by their level
		once
			create Result.make (1, (c_nb_types - 1) * 2)
			Result.put ("SK_INT8", c_int8)
			Result.put ("SK_INT16", c_int16)
			Result.put ("SK_INT32", c_int32)
			Result.put ("SK_INT64", c_int64)
			Result.put ("SK_UINT8", c_uint8)
			Result.put ("SK_UINT16", c_uint16)
			Result.put ("SK_UINT32", c_uint32)
			Result.put ("SK_UINT64", c_uint64)
			Result.put ("SK_REAL32", c_real32)
			Result.put ("SK_REAL64", c_real64)
			Result.put ("SK_BOOL", c_boolean)
			Result.put ("SK_CHAR8", c_char)
			Result.put ("SK_CHAR32", c_wide_char)
			Result.put ("SK_POINTER", c_pointer)
			Result.put ("SK_REF", c_ref)
				-- Registers for passing typed arguments.
			Result.put ("SK_INT8", c_nb_types - 1 + c_int8)
			Result.put ("SK_INT16", c_nb_types - 1 + c_int16)
			Result.put ("SK_INT32", c_nb_types - 1 + c_int32)
			Result.put ("SK_INT64", c_nb_types - 1 + c_int64)
			Result.put ("SK_UINT8", c_nb_types - 1 + c_uint8)
			Result.put ("SK_UINT16", c_nb_types - 1 + c_uint16)
			Result.put ("SK_UINT32", c_nb_types - 1 + c_uint32)
			Result.put ("SK_UINT64", c_nb_types - 1 + c_uint64)
			Result.put ("SK_REAL32", c_nb_types - 1 + c_real32)
			Result.put ("SK_REAL64", c_nb_types - 1 + c_real64)
			Result.put ("SK_BOOL", c_nb_types - 1 + c_boolean)
			Result.put ("SK_CHAR8", c_nb_types - 1 + c_char)
			Result.put ("SK_CHAR32", c_nb_types - 1 + c_wide_char)
			Result.put ("SK_POINTER", c_nb_types - 1 + c_pointer)
			Result.put ("SK_REF", c_nb_types - 1 + c_ref)
		end

feature -- Access

	has_chained_prec: BOOLEAN
			-- Feature has chained preconditions?
		do
			Result := (byte_code.precondition /= Void
					or else inherited_assertion.has_precondition)
				and then
					(	workbench_mode
						or else
						system.keep_assertions)
		end

	has_rescue: BOOLEAN
			-- Feature has a rescue clause ?
		do
			Result := byte_code.rescue_clause /= Void
		end

	set_origin_has_precondition (b: BOOLEAN)
		do
			origin_has_precondition := b
		end

	has_postcondition: BOOLEAN
			-- Do we have to generate any postcondition ?
		do
			Result := workbench_mode or else System.keep_assertions
		end

	has_precondition: BOOLEAN
			-- Do we have to generate any precondition ?
		do
			Result := workbench_mode or else System.keep_assertions
		end

	has_invariant: BOOLEAN
			-- Do we have to generate invariant checks ?
		do
			Result := workbench_mode or else System.keep_assertions
		end

	assertion_level: ASSERTION_I
			-- Assertion level description
		do
			Result := associated_class.assertion_level
		end

	associated_class: CLASS_C
			-- Class associated with current type
		do
			Result := current_type.associated_class
		end

	constrained_type_in (type: TYPE_A; a_context_type: CL_TYPE_A): TYPE_A
			-- Constrained type `type' in the context of `context_class_type'
		require
			type_not_void: type /= Void
			context_type_not_void: a_context_type /= Void
			context_type_generics: type.is_formal implies a_context_type.generics /= Void
		local
			formal: FORMAL_A
			formal_position: INTEGER
		do
			debug ("to_implement")
				to_implement ("Move this feature to TYPE_A with a redefinition in FORMAL_A.")
			end
			from
				Result := type
			until
				not Result.is_formal or Result.is_multi_constrained
			loop
				formal ?= Result
				check formal_not_void: formal /= Void end
				formal_position := formal.position
				Result := a_context_type.generics.item (formal_position)
				if Result.is_formal then
					if formal.is_multi_constrained (a_context_type.associated_class) then
						create {MULTI_FORMAL_A} Result.make (True, formal.is_expanded, formal.position)
					else
						Result := a_context_type.associated_class.constrained_type (formal_position)
					end
				end
			end
		ensure
			result_not_void: Result /= Void
			result_not_formal: not Result.is_formal or Result.is_multi_constrained
		end

	real_type_in (type: TYPE_A; a_context_type: CL_TYPE_A): TYPE_A
			-- Type `type' as seen in `a_context_type'
		require
			type_not_void: type /= Void
			context_type_not_void: a_context_type /= Void
		do
			if type.is_like_current then
				Result := a_context_type
			elseif type.is_like then
				Result := real_type_in (type.actual_type, a_context_type)
			elseif type.is_formal then
				Result := constrained_type_in (type, a_context_type)
			else
				Result := type
			end
		ensure
			result_not_void: Result /= Void
			result_not_formal: not Result.is_formal or Result.is_multi_constrained
		end

	real_type (type: TYPE_A): TYPE_A
			-- Type `type' written in `class_type' as seen in `context_class_type'
		require
			type_not_void: type /= Void
			class_type_not_void: class_type /= Void
			context_class_type_not_void: current_type /= Void
		do
				-- If code is inherited, we first find out the type.
			if class_type /= context_class_type then
				if system.il_generation then
						-- Currently our .NET code generation does things in a strange way and sometime
						-- we already have resolved a type for the descendant class but the resolved type
						-- does not make sense for the ancestor version (case where descendant is generic
						-- but not the ancestor (See eweasel test#exec055, test#melt069 on .NET).
					if type.is_valid_for_class (class_type.associated_class) then
						Result := type.evaluated_type_in_descendant (class_type.associated_class,
							context_class_type.associated_class, current_feature)
					else
						check
							generating_expanded: context_class_type.is_expanded
						end
						Result := type
					end
				else
					Result := type.evaluated_type_in_descendant (class_type.associated_class,
						context_class_type.associated_class, current_feature)
				end
			else
				Result := type
			end
				-- And then we instantiate it in the context of `context_cl_type'.
			Result := real_type_in (Result, context_cl_type)
		ensure
			result_not_void: Result /= Void
			result_not_formal: not Result.is_formal or Result.is_multi_constrained
		end

	real_type_fixed (type: TYPE_A): TYPE_A
			-- Type `type' written in `current_type' as seen in `context_class_type'
			-- Fixed means that the possible return of a MULTI_FORMAL_A is checked and valid.
		require
			type_not_void: type /= Void
			class_type_not_void: class_type /= Void
			context_class_type_not_void: current_type /= Void
		do
			Result := real_type_in (type, current_type)
		ensure
			result_not_void: Result /= Void
			result_not_formal: not Result.is_formal or Result.is_multi_constrained
		end

	descendant_type (type: TYPE_A): TYPE_A
			-- Given a type valid for `class_type' returns its meaningulness counterpart in `context_class_type'
		require
			type_not_void: type /= Void
			class_type_not_void: class_type /= Void
			context_class_type_not_void: context_class_type /= Void
		do
				-- If code is inherited, we first find out the type.
			if class_type /= context_class_type then
				Result := type.evaluated_type_in_descendant (class_type.associated_class,
					context_class_type.associated_class, current_feature)
			else
				Result := type
			end
		end

	set_byte_code (bc: BYTE_CODE)
			-- Assign `bc' to byte_code.
		require
			good_argument: bc /= Void
		do
			byte_code := bc
		end

	init (t: CLASS_TYPE)
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
			context_cl_type := t.type
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
					-- "twin" is not found in ANY
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

	is_ancestor (other: CLASS_TYPE): BOOLEAN
			-- Is `other' an ancestor of `context_class_type'?
		do
			Result := context_class_type.type.is_conformant_to (context_class_type.associated_class, other.type)
		end

	is_written_context: BOOLEAN
			-- Does current context match the context where the code is written?
		do
			Result := original_class_type = class_type
		end

	set_class_type (t: CLASS_TYPE)
			-- Assign `t' to `class_type'.
		require
			t_not_void: t /= Void
			context_class_type_not_void: context_class_type /= Void
			is_ancestor: is_ancestor (t) or True --| FIXME IEK Add inherits_from usage when implemented.
		do
			class_type := t
			current_type := t.type
				-- Decide whether once routines can be optimized so that their results
				-- can be retrieved directly from memory without making actual calls.
			if
				workbench_mode or else assertion_level.is_precondition or else
				assertion_level.is_invariant or else assertion_level.is_postcondition
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

	change_class_type_context (
				new_context_class_type: CLASS_TYPE; new_context_cl_type: CL_TYPE_A;
				new_written_class_type: CLASS_TYPE; new_written_cl_type: CL_TYPE_A)

			-- Change the current `class_type' to `new_written_class_type',
			-- not related to `original_class_type', but to `new_context_class_type'.
			-- (Multiple calls to this feature are allowed and should
			-- be paired with the calls to `restore_class_type_context').
		require
			new_context_class_type_not_void: new_context_class_type /= Void
			new_written_class_type_not_void: new_written_class_type /= Void
			context_class_type_not_void: context_class_type /= Void
			class_type_not_void: class_type /= Void
			is_ancestor: -- new_context_cl_type.type_a.is_conformant_to (new_written_class_type.type.type_a)
		do
			class_type_stack.put ([context_class_type, context_cl_type, class_type, current_type])
			context_class_type := new_context_class_type
			context_cl_type := new_context_cl_type
			set_class_type (new_written_class_type)
			current_type := new_written_cl_type
		ensure
			class_type_set: class_type = new_written_class_type
			context_class_type_set: context_class_type = new_context_class_type
			is_class_type_changed: is_class_type_changed
		end

	restore_class_type_context
			-- Restore the state of context to the one before the
			-- earlier call to `change_class_type_context'.
		require
			is_class_type_changed: is_class_type_changed
		local
			previous_context: like context_stack_type
		do
				-- Remove stack item before calling `set_class_type'
			previous_context := class_type_stack.item
			class_type_stack.remove
			context_class_type := previous_context.context_type
			context_cl_type := previous_context.cl_type
			set_class_type (previous_context.written_type)
			current_type := previous_context.written_cl_type
		ensure
			context_class_type_set: context_class_type = old class_type_stack.item.context_type
			context_cl_type_set: context_cl_type = old class_type_stack.item.cl_type
			class_type_set: class_type = old class_type_stack.item.written_type
			current_type_set: current_type = old class_type_stack.item.written_cl_type
		end

	set_current_feature (f: FEATURE_I)
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

	set_original_body_index (new_original_body_index: like original_body_index)
			-- Set `original_body_index' to `new_original_body_index'.
		do
			original_body_index := new_original_body_index
		ensure
			original_body_index_set: original_body_index = new_original_body_index
		end

	init_propagation
			-- Reset `propagated' to False.
		do
			propagated := False
		end

	set_propagated
			-- Signals register has been caught.
		do
			propagated := True
		end

	propagate_no_register: BOOLEAN
			-- Is the propagation of `No_register' allowed ?
		do
			Result := not (	workbench_mode
							or else
							assertion_level.is_precondition)
		end

	add_dt_current
			-- One more time we need to compute Current's type.
		do
			if in_inlined_code then
				inlined_dt_current := inlined_dt_current + 1
			else
				dt_current := dt_current + 1
			end
		end

	add_dftype_current
			-- On more time we need to compute Current's full dynamic type.
		do
			if in_inlined_code then
				inlined_dftype_current := inlined_dftype_current + 1
			else
				dftype_current := dftype_current + 1
			end
		end

	set_inlined_dt_current (i: INTEGER)
			-- Set the value of `inlined_dt_current' to `i'
		require
			i_non_negative: i >= 0
		do
			inlined_dt_current := i
		ensure
			inlined_dt_current_set: inlined_dt_current = i
		end

	set_inlined_dftype_current (i: INTEGER)
			-- Set value of `inlined_dftype_current' to `i'.
		require
			i_non_negative: i >= 0
		do
			inlined_dftype_current := i
		ensure
			inlined_dftype_current_set: inlined_dftype_current = i
		end

	reset_inlined_dt_current
			-- Reset `inlined_dt_current' to 0
		do
			inlined_dt_current := 0
		ensure
			inlined_dt_current_set: inlined_dt_current = 0
		end

	reset_inlined_dftype_current
			-- Reset `inlined_dftype_current' to 0
		do
			inlined_dftype_current := 0
		ensure
			inlined_dftype_current_set: inlined_dftype_current = 0
		end

	mark_current_used
			-- Signals that a reference is made to Current (apart
			-- from computing a DT) and thus needs to be pushed on
			-- the local stack in case it'd be moved by the GC.
			-- As a side effect, compute an index for Current in the
			-- local variable array
		do
				-- Not marking if inside inlined code:
				-- Current is NOT in Current_b
			if not current_used and then not in_inlined_code then
				set_local_index ("Current", Current_b)
				current_used := True
			end
		end

	mark_result_used
			-- Signals that an assignment in Result is made
			-- As a side effect, compute an index for Result in the local
			-- variable array, if the type is a pointer one and we are not
			-- inside a once function.
		do
			if not in_inlined_code then
				if
					not result_used and
					real_type (byte_code.result_type).c_type.is_pointer and
					not byte_code.is_once
				then
					set_local_index ("Result", Result_register)
				end
				result_used := True
			end
		end

	mark_local_used (an_index: INTEGER)
			-- Signals that local variable `an_index' is used
		do
			local_vars.force (True, an_index)
		end

	inc_label
			-- Increment `label'
		do
			label := label + 1
		end

	generate_body_label
			-- Generate label "body"
			--|Note: the semi-colon is added, otherwise C compilers
			--|complain when there are no instructions after the label.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line_only
			buf.put_string ("body:;")
		end

	print_body_label
			-- Print label "body"
		do
			buffer.put_string ("body")
		end

	generate_current_label_definition
			-- Generate current label `label'.
		do
			generate_label_definition (label)
		end

	generate_label_definition (l: INTEGER)
			-- Generate label number `l'
		require
			label_exists: l >= 0
		local
			buf: GENERATION_BUFFER
		do
			if label > 0 then
				buf := buffer
				buf.put_new_line_only
				print_label (l)
				buf.put_character (':')
			end
		end

	print_current_label
			-- Print label number `label'.
		do
			print_label (label)
		end

	print_label (l: INTEGER)
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

	set_local_index (s: STRING; r: REGISTRABLE)
			-- Record the instance `r' into the `associated_register_table'
			-- as register named `s'.
		require
			s_not_void: s /= Void
		local
			key: STRING
		do
			if not associated_register_table.has (s) then
				create key.make_from_string (s)
				local_index_table.extend (key)
				local_index_counter := local_index_counter + 1
				associated_register_table.put (r, key)
			end
		end

	needs_macro_undefinition: BOOLEAN
			-- Does C code generation needs to undefine some macros defined in body?

	need_gc_hook: BOOLEAN
			-- Do we need to generate GC hooks?
			-- Computed by compute_need_gc_hooks for each instance of BYTE_CODE.

	force_gc_hooks
			-- Force usage of GC hooks
		do
			need_gc_hook := True
		end

	compute_need_gc_hooks (has_assertions_checking_enabled: BOOLEAN)
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
						elseif not l_assign.source.allocates_memory_for_type (real_type (l_assign.target.type)) then
							reverse_b ?= l_assign
								-- FIXME: Manu 05/31/2002: we should try to optimize
								-- so that not all reverse assignment prevent the optimization
								-- to be made.
							call ?= l_assign.source
							if call /= Void and then call.is_single and then reverse_b = Void then
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
								tmp := expr_b.has_call or expr_b.allocates_memory or else expr_b.allocates_memory_for_type (real_type (l_assign.target.type))
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

	make_from_context (other: like Current)
			-- Save context for later restoration. This makes the
			-- use of unanalyze possible and meaningful.
		do
			copy (other)
			register_server := other.register_server.duplicate
			local_index_table := other.local_index_table.twin
			associated_register_table := other.associated_register_table.twin
		end

	restore (saved_context: like Current)
			-- Restore the saved context after an analyze followed by an
			-- unanalyze, so that we may analyze again with different
			-- propagations (kind of feedback).
		do
			register_server := saved_context.register_server
			current_used := saved_context.current_used
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
			precondition_object_test_local_offset := saved_context.precondition_object_test_local_offset
			postcondition_object_test_local_offset := saved_context.postcondition_object_test_local_offset
		end

	generate_dtype_declaration (is_once: BOOLEAN)
			-- Declare the 'dtype' variable which holds the pre-computed
			-- dynamic type of current. To avoid unnecssary computations,
			-- this is not done in case of a once, before we know we have
			-- to really enter the body of the routine.
		local
			buf: like buffer
		do
			buf := buffer
			if dftype_current > 1 then
					-- There has to be more than one usage of the dynamic type
					-- of current in order to have this variable generated.
				buf.put_new_line
				if is_once then
					buf.put_string ("RTCFDD;")
				else
					buf.put_string ("RTCFDT;")
				end
			end
			if dt_current > 1 then
					-- There has to be more than one usage of the full dynamic type
					-- of current in order to have this variable generated.
				buf.put_new_line
				if is_once then
					buf.put_string ("RTCDD;")
				else
					buf.put_string ("RTCDT;")
				end
			end
		end

	generate_current_dtype
			-- Generate the dynamic type of `Current'
		do
			if inlined_dt_current > 1 then
				buffer.put_string ({C_CONST}.inlined_dtype_name)
			elseif dt_current > 1 then
				buffer.put_string ({C_CONST}.dtype_name)
			else
				buffer.put_string ({C_CONST}.dtype)
				buffer.put_character ('(')
				Current_register.print_register
				buffer.put_character (')')
			end
		end

	generate_current_dftype
			-- Generate the dynamic type of `Current'
		do
			if inlined_dftype_current > 1 then
				buffer.put_string ({C_CONST}.inlined_dftype_name)
			elseif dftype_current > 1 then
				buffer.put_string ({C_CONST}.dftype_name)
			else
				buffer.put_string ({C_CONST}.dftype)
				buffer.put_character ('(')
				Current_register.print_register
				buffer.put_character (')')
			end
		end

	generate_temporary_ref_variables
			-- Generate temporary variables under the control of the
			-- garbage collector.
		local
			i, j, nb_vars: INTEGER
		do
			needs_macro_undefinition := False
			from
				i := (c_nb_types - 1) * 2
			until
				i <= 0
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
				i := i - 1
			end
		end

	generate_temporary_ref_macro_undefintion
			-- Generate #undef statements for macros being generated to access wrapped arguments.
		local
			i, j, nb_vars: INTEGER
			buf: like buffer
		do
			if needs_macro_undefinition then
				needs_macro_undefinition := False
				from
					buf := buffer
					i := (c_nb_types - 1) * 2
				until
					i < c_nb_types
				loop
					from
						j := 1
						nb_vars := register_server.needed_registers_by_clevel (i)
					until
						j > nb_vars
					loop
						buf.put_new_line_only
						buf.put_string (once "#undef ")
						put_register_name (i, j, buf)
						j := j + 1
					end
					i := i - 1
				end
			end
		end

	generate_tmp_var (ctype, num: INTEGER)
			-- Generate declaration for temporary variable `num'
			-- whose C type is `ctype'.
		local
			buf: GENERATION_BUFFER
			value_type: TYPE_C
			variable_type: STRING
			is_generic: BOOLEAN
		do
			buf := buffer

				-- First get type and name of temporary local.
			value_type := register_type (ctype)
			if ctype >= c_nb_types 	then
					-- This is a register to hold generic argument value
				check
					is_workbench_mode: workbench_mode
				end
				is_generic := True
				needs_macro_undefinition := True
				variable_type := once "EIF_TYPED_VALUE"
			else
				variable_type := value_type.c_string
			end
			buf.put_new_line
			buf.put_string (variable_type)
			buf.put_character (' ')
			if has_rescue and then not is_generic then
				buf.put_string (once " EIF_VOLATILE ")
			end
			put_register_name (ctype, num, buf)
			if is_generic then
					-- Record register type and zero pointer value for GC.
				buf.put_string (once "x = {0, ")
				buf.put_string (register_sk_value (ctype))
				buf.put_string ("};")
				buf.put_new_line_only
				buf.put_string ("#define ")
				put_register_name (ctype, num, buf)
				buf.put_character (' ')
				put_register_name (ctype, num, buf)
				buf.put_string ("x.")
				value_type.generate_typed_field (buf)
			else
				if ctype = c_ref then
						-- Because it is a reference we absolutely need to initialize it
						-- to its default value, otherwise it would mess up the GC local tracking.
					buf.put_string (once " = NULL")
				end
				buf.put_character (';')
			end
		end

	generate_gc_hooks (compound_or_post: BOOLEAN)
			-- In case there are some local reference variables,
			-- generate the hooks for the GC by filling the local variable
			-- array.
			--| `compound_or_post' indicate the generation of hooks
			--| for the compound or post- pre- or invariant routine. -- FREDD
		local
			nb_refs: INTEGER	-- Total number of references to be pushed
			l_table: like local_index_table
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
				buf.put_new_line
				if compound_or_post or else byte_code.rescue_clause = Void then
					buf.put_string (once "RTLI(")
				else
					buf.put_string (once "RTXI(")
				end
				buf.put_integer (nb_refs)
				buf.put_two_character (')', ';')
				from
					l_table := local_index_table
					associated := associated_register_table
					l_table.start
				until
					l_table.after
				loop
					rname := l_table.item_for_iteration
					reg := associated.item (rname)

					check
						reference_type: not reg.is_current implies reg.c_type.is_pointer
					end

					buf.put_local_registration (position, rname)
					if (reg.c_type.is_bit) and (reg.is_argument) then
							-- Clone argument if it is bit
						buf.put_new_line
						buf.put_string (rname)
						buf.put_string (once " = RTCB(")
						buf.put_string (rname)
						buf.put_character (')')
						buf.put_character (';')
					end
					position := position + 1
					l_table.forth
				end
			end
		end

	generate_feature_name (buf: GENERATION_BUFFER)
			-- Generate feature name in `buf'.
		require
			buf_not_void: buf /= Void
		do
			if has_feature_name_stored then
				buf.put_string (feature_name_local)
			else
				buf.put_string_literal (current_feature.feature_name)
			end
		end

	generate_catcall_check (a_register: REGISTRABLE; a_type: TYPE_A; a_pos: INTEGER; a_like_current_optimization_ok: BOOLEAN)
			-- Generate catcall check at runtime for the argument at position `a_pos' against the static
			-- type `a_type'.
		require
			a_register_not_void: a_register /= Void
			a_type_not_void: a_type /= Void
			a_pos_positive: a_pos > 0
		local
			buf: like buffer
			l_info: CREATE_INFO
			l_optimized: BOOLEAN
			l_if_required: BOOLEAN
		do
			if a_type.c_type.is_pointer and not a_type.is_none then
				buf := buffer
					-- If the type is not attached, we have an optimization to not compute the dynamic
					-- type of the expected type. However when the expected type is a formal, or an anchor
					-- then we cannot do this optimization as the type of the formal or the anchor depends on
					-- the actual object's type.
				if not a_type.is_attached and then not a_type.is_formal and then not attached {LIKE_TYPE_A} a_type as l_anchor then
					l_if_required := True
					buf.put_new_line
					buf.put_four_character ('i', 'f', ' ', '(')
					a_register.print_register
					buf.put_three_character (')', ' ', '{')
					buf.indent
				end

					-- Special handling of routines taking `like Current' in non-generic classes as long
					-- as `a_like_current_optimization_ok' is enabled.
					-- Usually, those routines are safe, if the actual type of the argument is a descendant
					-- of the class in which `current_feature' is written in.
					-- It is only done when the context type is not generic, as otherwise it is
					-- harder do implement.
				l_optimized := a_type.is_like_current and original_class_type.type.generics = Void and a_like_current_optimization_ok

				if not l_optimized then
					l_info := a_type.create_info
					l_info.generate_start (buf)
					l_info.generate_gen_type_conversion (0)
				end
				buf.put_new_line
				buf.put_string ("RTCC(")
				a_register.print_register
				buf.put_two_character (',', ' ')
				byte_code.feature_origin (buf)
				buf.put_two_character (',', ' ')
				generate_feature_name (buf)
				buf.put_two_character (',', ' ')
				buf.put_integer (a_pos)
				buf.put_two_character (',', ' ')
				if l_optimized then
					if attached {ATTACHABLE_TYPE_A} a_type as l_type_1 then
						if l_type_1.is_attached then
							buf.put_string ("eif_attached_type(")
							byte_code.feature_origin (buf)
							buf.put_character (')')
						elseif l_type_1.has_detachable_mark then
							buf.put_string ("eif_non_attached_type(")
							byte_code.feature_origin (buf)
							buf.put_character (')')
						else
							byte_code.feature_origin (buf)
						end
					else
						byte_code.feature_origin (buf)
					end
					buf.put_two_character (')', ';')
				else
					if attached {ATTACHABLE_TYPE_A} a_type as l_type_2 then
						if l_type_2.is_attached then
							buf.put_string ("eif_attached_type(")
							l_info.generate_type_id (buf, final_mode, 0)
							buf.put_character (')')
						elseif l_type_2.has_detachable_mark then
							buf.put_string ("eif_non_attached_type(")
							l_info.generate_type_id (buf, final_mode, 0)
							buf.put_character (')')
						else
							l_info.generate_type_id (buf, final_mode, 0)
						end
					else
						l_info.generate_type_id (buf, final_mode, 0)
					end
					buf.put_two_character (')', ';')
					l_info.generate_end (buf)
				end

				if l_if_required then
					buf.exdent
					buf.put_new_line
					buf.put_character ('}')
				end
			end
		end

	make_catcall_check (ba: BYTE_ARRAY; a_type: TYPE_A; a_pos: INTEGER; a_like_current_optimization_ok: BOOLEAN)
			-- Generate catcall check at runtime for the argument at position `a_pos' against the static
			-- type `a_type'.
		require
			ba_not_void: ba /= Void
			a_type_not_void: a_type /= Void
			a_pos_positive: a_pos > 0
		local
			l_name: STRING
		do
			if a_type.c_type.is_pointer and not a_type.is_none then
				ba.append ({BYTE_CONST}.bc_catcall)

					-- Special handling of routines taking `like Current' in non-generic classes as long
					-- as `a_like_current_optimization_ok' is enabled.
					-- Usually, those routines are safe, if the actual type of the argument is a descendant
					-- of the class in which `current_feature' is written in.
					-- It is only done when the context type is not generic, as otherwise it is
					-- harder do implement.
				if a_type.is_like_current and original_class_type.type.generics = Void and a_like_current_optimization_ok then
					class_type.type.create_info.make_byte_code (ba)
				else
					a_type.create_info.make_byte_code (ba)
				end

					-- We sometime need to convert a type to either it associated attached/non-attached
					-- version. First boolean is to figure out if there is an action to be taken, the
					-- second which action.
				if attached {ATTACHABLE_TYPE_A} a_type as l_type_1 then
					if l_type_1.is_attached then
						ba.append_boolean (True)
						ba.append_boolean (True)
					elseif l_type_1.has_detachable_mark then
						ba.append_boolean (True)
						ba.append_boolean (False)
					else
						ba.append_boolean (False)
					end
				else
					ba.append_boolean (False)
				end

				ba.append_type_id (class_type.static_type_id)
				l_name := current_feature.feature_name
				ba.append_integer (l_name.count)
				ba.append_raw_string (l_name)
				ba.append_integer (a_pos)
			end
		end

	expanded_number (arg_pos: INTEGER): INTEGER
			-- Compute the argument's ordinal position within the expanded
			-- subset of arguments.
		local
			arg_array: ARRAY [TYPE_A]
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

	remove_gc_hooks
			-- Pop off pushed addresses on local stack
		local
			vars: INTEGER
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if byte_code.rescue_clause /= Void then
				buf.put_new_line
				buf.put_string ("RTEOK;")
			end
			vars := ref_var_used
			if vars > 0 then
				buf.put_new_line
				if byte_code.rescue_clause /= Void then
					buf.put_string ("RTXE;")
				else
					buf.put_string ("RTLE;")
				end
			end
		end

	ref_var_used: INTEGER
			-- Number of reference variable needed for GC hooks
		do
			if not need_gc_hook then
				Result := 0
			else
				Result := local_index_table.count
			end
		end

	local_list: ARRAYED_LIST [TYPE_A]
			-- Local type list for byte code: it includes Eiffel local
			-- variables types, variant local integer and hector
			-- temporary varaibles

	add_local (t: TYPE_A)
			-- Add local type to `local_list'.
		require
			good_argument: t /= Void
		do
			local_list.extend (t)
		end

	add_locals (l: ARRAY [TYPE_A])
			-- Add all locals from `l'.
		local
			i: INTEGER
		do
			if l /= Void then
				from
					i := l.lower
				until
					i > l.upper
				loop
					add_local (l [i])
					i := i + 1
				end
			end
		end

feature -- C code generation: locals

	generate_local_declaration (local_count: INTEGER; is_exception_safe: BOOLEAN)
			-- Generate declaration of local variables with the first
			-- `local_count' being "normal" locals and preserving their
			-- values on exceptions if `is_exception_safe' is True.
		local
			i: INTEGER
			count: INTEGER
			type_i: TYPE_A
			buf: GENERATION_BUFFER
			used_local: BOOLEAN
			wkb_mode: BOOLEAN
			used_upper: INTEGER
			l_loc_name: STRING
			l_type: CL_TYPE_A
			l_class_type: CLASS_TYPE
			local_types: LIST [TYPE_A]
			modifier: STRING
		do
			buf := buffer
			wkb_mode := workbench_mode
			if is_exception_safe then
				modifier := "EIF_VOLATILE "
			end

			local_types := local_list
			from
				count := local_types.count
				used_upper := local_vars.upper
				i := 1
			until
				i > count
			loop
				type_i := real_type (local_types.i_th (i))
						-- Check whether the variable is used or not.
				if i >= local_count then
						-- Object test locals are always used.
					used_local := True
				elseif i > used_upper then
					used_local := False
				else
					used_local := local_vars.item(i)
				end

						-- Generate only if variable used
				if wkb_mode or (used_local or type_i.is_true_expanded) then
						-- Local reference variable are declared via
						-- the local variable array "l[]".
					if type_i.is_true_expanded then
						create l_loc_name.make (6)
						l_loc_name.append ("sloc")
						l_loc_name.append_integer (i)
						l_type ?= type_i
						check
								-- Only a CL_TYPE_A could be an expanded
							l_type_not_void: l_type /= Void
						end
						l_class_type := l_type.associated_class_type (context_class_type.type)
						l_class_type.generate_expanded_structure_declaration (buf, l_loc_name)
					end
					buf.put_new_line
					type_i.c_type.generate (buf)
					buf.put_character (' ')
					if modifier /= Void then
						buf.put_string (modifier)
					end
					buf.put_string ("loc")
					buf.put_integer (i)
					buf.put_string (" = ")
					if type_i.is_true_expanded then
						type_i.c_type.generate_cast (buf)
						buf.put_string (l_loc_name)
						buf.put_string (".data")
						buf.put_character (';')
					else
						type_i.c_type.generate_cast (buf)
						buf.put_two_character ('0', ';')
					end
				end
				i := i + 1
			end
		end

	generate_push_debug_locals (result_type: TYPE_A; arguments: ARRAY [TYPE_A])
			-- Generate the macros to save the arguments, locals, etc.
			-- of the feature in the C debug pile.
		local
			buf: GENERATION_BUFFER
			type_i: TYPE_A
			local_types: LIST [TYPE_A]
			i: INTEGER
			n: INTEGER
		do
			if workbench_mode then
				buf := buffer
					-- First save the Result register.
				if result_type /= Void and then not result_type.is_void then
					type_i := real_type (result_type)
					buf.put_new_line
					buf.put_string ("RTLU (")
					type_i.c_type.generate_sk_value (buf)
					buf.put_string (", &Result);")
				else
					buf.put_new_line
					buf.put_string ("RTLU (SK_VOID, NULL);")
				end
					-- Then push the arguments of the feature (if any).
				if arguments /= Void then
					from
						n := arguments.count
						i := 1
					until
						i > n
					loop
						type_i := real_type (arguments [i])
							-- Local reference variable are declared via
							-- the local variable array "l[]"
						buf.put_new_line
						buf.put_string ("RTLU(")
						type_i.c_type.generate_sk_value (buf)
						if type_i.is_true_expanded then
							buf.put_string (",&earg")
						else
							buf.put_string (",&arg")
						end
						buf.put_integer (i)
						buf.put_string (");")
						i := i + 1
					end
				end
					-- Then push Current.
				buf.put_new_line
				buf.put_string ("RTLU (SK_REF, &Current);")
					-- Finally push the local variables.
				local_types := local_list
				from
					n := local_types.count
					i := 1
				until
					i > n
				loop
					type_i := real_type (local_types.i_th (i))
						-- Local reference variable are declared via
						-- the local variable array "l[]"
					buf.put_new_line
					buf.put_string ("RTLU(")
					type_i.c_type.generate_sk_value (buf)
					buf.put_string (", &loc")
					buf.put_integer (i)
					buf.put_string (");")
					i := i + 1
				end

					-- Now we record the level of the local variable stack
					-- to restore it in case of a rescue.
				if has_rescue then
					buf := buffer
					buf.put_new_line
					buf.put_string ("RTLXL;")
				end
			end
		end

	generate_pop_debug_locals (arguments: ARRAY [TYPE_A])
			-- Generate the cleaning of the locals stack used by the debugger
			-- when stopped in a C function.
		local
			buf: GENERATION_BUFFER
			i: INTEGER
		do
			if workbench_mode then
				-- we have saved at least Result and Current
				i := local_list.count + 2
				if arguments /= Void then
					i := i + arguments.count
				end
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTLO(")
				buf.put_integer (i)
				buf.put_string (");")
			end
		end

feature -- Object test code generation

	add_object_test_locals (types: ARRAY [TYPE_A]; body_id: INTEGER; is_precondition: BOOLEAN)
			-- Add object test locals from a precondition (if `is_precondition') or from a
			-- postcondition (otherwise) of types `types' from feature of body id `body_id'.
		require
			different_body_id: body_id /= current_feature.body_index
		local
			object_test_local_offset: HASH_TABLE [INTEGER, INTEGER]
		do
			if is_precondition then
				object_test_local_offset := precondition_object_test_local_offset
			else
				object_test_local_offset := postcondition_object_test_local_offset
			end
			if types /= Void and then not object_test_local_offset.has (body_id) then
				object_test_local_offset.force (local_list.count - types.lower + 1, body_id)
				types.do_all (
					agent (t: TYPE_A)
						do
							local_list.extend (descendant_type (t))
						end
				)
			end
		end

	object_test_local_position (l: OBJECT_TEST_LOCAL_B): INTEGER
			-- Position of a given object test local `l' in the list of locals.
		require
			l_attached: l /= Void
		local
			offset: INTEGER_32
		do
			if assertion_type = in_invariant then
					-- Object test is declared in class invariant.
					-- There is no dedicated byte code, so there is no offset for object test locals.
					-- offset := 0
			elseif l.body_id = byte_code.body_index then
					-- Object test is declared in the current feature.
					-- Object test locals come right after the regular locals.
				offset := byte_code.local_count
			elseif assertion_type = in_precondition then
					-- Object test is in the inherited precondition.
				check
					code_id_registered: precondition_object_test_local_offset.has (l.body_id)
				end
				offset := precondition_object_test_local_offset [l.body_id]
			else
				check assertion_type = in_postcondition end
					-- Object test is in the inherited postcondition.
				check
					code_id_registered: postcondition_object_test_local_offset.has (l.body_id)
				end
				offset := postcondition_object_test_local_offset [l.body_id]
			end
			Result := offset + l.position
		end

feature {BYTE_CONTEXT} -- Object test code generation

	precondition_object_test_local_offset: HASH_TABLE [INTEGER, INTEGER]
			-- Offset of inherited precondition object test locals indexed by code_id

	postcondition_object_test_local_offset: HASH_TABLE [INTEGER, INTEGER]
			-- Offset of inherited postcondition object test locals indexed by code_id

feature -- External features

	is_result_checked: BOOLEAN
			-- Is result checked to ensure it is valid?
		do
			inspect external_result_attachment_status
			when is_attached_reference, is_attached_sometimes then
				Result := True
			else
			end
		end

	analyze_external_result
			-- Analyze result of an external feature.
		do
			inspect external_result_attachment_status
			when is_attached_reference then
				mark_result_used
			when is_attached_sometimes then
				mark_result_used
				result_info.analyze
			else
			end
		end

	generate_external_result_check
			-- Generate check for result of an external feature.
		local
			b: GENERATION_BUFFER
			i: CREATE_INFO
		do
			inspect external_result_attachment_status
			when is_attached_reference then
				b := buffer
				b.put_new_line
				b.put_string ("if (!Result) {RTEC(EN_FAIL);}")
			when is_attached_sometimes then
				b := buffer
				b.put_new_line
				b.put_string ("if (!Result) {")
				b.indent
				i := result_info
				i.generate_start (b)
				i.generate_gen_type_conversion (0)
				b.put_new_line
				b.put_string ("if (RTAT(")
				i.generate_type_id (b, final_mode, 0)
				b.put_string (")) {RTEC(EN_FAIL);}")
				i.generate_end (b)
				b.generate_block_close
			else
			end
		end

feature {NONE} -- External_features

	result_info: CREATE_INFO
		local
			f: FEATURE_I
			t: TYPE_A
		do
			f := current_feature
			t := f.type.instantiated_in (current_type)
			if t.is_formal then
				Result := t.create_info
			else
				create {CREATE_FEAT} Result.make (f.feature_id, f.rout_id_set.first)
			end
		end

	external_result_attachment_status: NATURAL_32
			-- Attachment status of a function that is external or `is_attached_never' otherwise
		do
			if current_feature.is_external and then byte_code /= Void and then byte_code.is_external then
				Result := attachment_status (current_feature.type.instantiated_in (current_type))
			else
				Result := is_attached_never
			end
		end

	is_attached_expanded: NATURAL_32 = 1
	is_attached_reference: NATURAL_32 = 2
	is_attached_sometimes: NATURAL_32 = 3
	is_attached_never: NATURAL_32 = 4

	attachment_status (t: TYPE_A): NATURAL_32
			-- Type `t' attachment status
		do
			if t.is_expanded then
					-- Type is expanded.
				Result := is_attached_expanded
			elseif t.is_attached then
					-- Type is explicitly attached.
				Result := is_attached_reference
			elseif
				t.is_formal or else
				t.is_like and then not t.is_like_current and then not t.is_like_argument
			then
				Result := is_attached_sometimes
			else
				Result := is_attached_never
			end
		end

feature -- Clearing

	array_opt_clear
			-- Clear during the array optimization
		do
			class_type := Void
			byte_code := Void
			class_type_stack.wipe_out
		end

	clear_feature_data
			-- Clear feature-specific data.
		do
			local_vars.clear_all
			local_index_table.wipe_out
			associated_register_table.wipe_out
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
			need_gc_hook := False
			label := 0
			local_list.wipe_out
			breakpoint_slots_number := 0;
				-- This should not be necessary but may limit the
				-- effect of bugs in register allocation (if any).
			register_server.clear_all
			precondition_object_test_local_offset.wipe_out
			postcondition_object_test_local_offset.wipe_out
			set_hidden_code_level (0)
		end

	clear_class_type_data
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
			generated_inlines.wipe_out
		ensure
			global_onces_is_empty: workbench_mode implies global_onces.is_empty
			onces_is_empty: workbench_mode implies onces.is_empty
			once_manifest_string_table_is_empty: once_manifest_string_table.is_empty
			generated_inlines_empty: generated_inlines.is_empty
		end

	clear_system_data
			-- Clear system-wide data.
		do
			global_onces.wipe_out
			onces.wipe_out
			once_manifest_string_count_table.wipe_out
			class_type_stack.wipe_out
			generic_wrappers.wipe_out
			expanded_descendants := Void
		ensure
			global_onces_is_empty: global_onces.is_empty
			onces_is_empty: onces.is_empty
			once_manifest_string_count_table_is_empty: once_manifest_string_count_table.is_empty
			generic_wrappers_is_empty: generic_wrappers.is_empty
			has_no_expanded_descendants_information: not has_expanded_descendants_information
		end

feature -- Debugger

	instruction_line: LINE [AST_EIFFEL]
			-- List of breakable instructions on which a breakpoint may be set.

	breakpoint_slots_number: INTEGER
			-- current number of breakpoint slots known

	breakpoint_nested_slots_number: INTEGER
			-- current number of breakpoint nested slots known

	set_instruction_line (l: like instruction_line)
			-- Assign `l' to `instruction_line' and position FIFO stack at the
			-- beginning as a side effect, ready for usage by byte code classes.
		do
			instruction_line := l
			l.start
		end

	get_next_breakpoint_slot: INTEGER
			-- increase the current number of breakpoint slots and then
			-- return the current number of breakpoint slots. It is used
			-- to get a "line number" when recording a breakable point
		do
			breakpoint_slots_number := breakpoint_slots_number + 1
			breakpoint_nested_slots_number := 0
			Result := breakpoint_slots_number
		end

	get_next_breakpoint_nested_slot: INTEGER
			-- increase the current number of breakpoint nested slots and then
			-- return the current number of breakpoint nested slots. It is used
			-- to get a "line nested number" when recording a breakable nested point
		do
			breakpoint_nested_slots_number := breakpoint_nested_slots_number + 1
			Result := breakpoint_nested_slots_number
		end

	get_breakpoint_slot: INTEGER
			-- Return the current number of breakpoint slots. It is used
			-- to get a "line number" when recording a breakable point
		do
			Result := breakpoint_slots_number
		end

	get_breakpoint_nested_slot: INTEGER
			-- Return the current number of breakpoint nested slots. It is used
			-- to get a "line nested number" when recording a breakable nested point
		do
			Result := breakpoint_nested_slots_number
		end

	set_breakpoint_slot (a_number: INTEGER)
			-- Set the current number of breakpoint slots to `a_number'
		do
			breakpoint_slots_number := a_number
			breakpoint_nested_slots_number := 0
		end

	byte_prepend (ba, array: BYTE_ARRAY)
			-- Prepend `array' to byte array `ba' and update positions in the
			-- breakable point list (provided we are in debug mode).
		do
			ba.prepend (array)
		end

feature -- Inlining

	in_inlined_code: BOOLEAN
			-- Are we dealing with inlined code?
		do
			Result := inlined_current_register /= Void
		end

	inlined_current_register: REGISTRABLE
			-- pseudo Current register for inlined code

	set_inlined_current_register (r: REGISTRABLE)
		do
			inlined_current_register := r
		end

feature -- Descendants information

	has_expanded_descendants_information: BOOLEAN
			-- Is information about expanded descendants available?
		require
			is_final_mode: final_mode
		do
			Result := expanded_descendants /= Void
		ensure
			definition: Result = (expanded_descendants /= Void)
		end

	has_expanded_descendants (type_id: INTEGER): BOOLEAN
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

	compute_expanded_descendants
			-- Compute
		require
			is_final_mode: final_mode
			has_no_expanded_descendants_information: not has_expanded_descendants_information
		local
			i: INTEGER
			class_types: ARRAY [CLASS_TYPE]
			c: CLASS_TYPE
			t: CL_TYPE_A
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
					t := c.type.reference_type
					if t.has_associated_class_type (Void) then
						expanded_descendants.put (True, t.associated_class_type (Void).type_id)
					end
				end
				i := i - 1
			end
		ensure
			has_expanded_descendants_information: has_expanded_descendants_information
			expanded_descendants_is_filled: expanded_descendants.count >= system.class_types.count
		end

feature -- Generic code generation

	record_wrapper (body_index: INTEGER; routine_id: INTEGER)
			-- Ensure the wrapper of the routine `body_index' is generated
			--  for the polymorphic table `routine_id'
		require
			final_mode: final_mode
		local
			r: ROUT_ID_SET
		do
			generic_wrappers.search (body_index)
			if generic_wrappers.found then
				r := generic_wrappers.found_item
			else
				create r.make
				generic_wrappers.put (r, body_index)
			end
			r.put (routine_id)
		end

	generic_wrapper_ids (body_index: INTEGER): ROUT_ID_SET
			-- Routine IDs of generic wrappers for a feature with `body_index' (if any)
		do
			Result := generic_wrappers.item (body_index)
		end

feature -- Constants

	feature_name_local: STRING = "l_feature_name"
			-- Name of locals storing the name of the routine.

feature {NONE} -- Generic code generation

	generic_wrappers: HASH_TABLE [ROUT_ID_SET, INTEGER]
			-- Set of routine IDs identified by the body index
			-- for which a wrapper has to be generated

feature {NONE} -- Implementation

	class_type_stack: ARRAYED_STACK [like context_stack_type]
			-- Class types saved due to the context change by `change_class_type_context'

	context_stack_type: TUPLE [context_type: CLASS_TYPE; cl_type: CL_TYPE_A; written_type: CLASS_TYPE; written_cl_type: CL_TYPE_A]
		do
		end

	expanded_descendants: PACKED_BOOLEANS
			-- Marks for class types whether they have an expanded descendant or not

invariant
	global_onces_not_void: global_onces /= Void
	onces_not_void: onces /= Void
	once_manifest_string_count_table_not_void: once_manifest_string_count_table /= Void
	once_manifest_string_table_not_void: once_manifest_string_table /= Void
	class_type_valid_with_current_type: class_type /= Void implies class_type.type = current_type
	class_type_stack_not_void: class_type_stack /= Void
	precondition_object_test_local_offset_attached: precondition_object_test_local_offset /= Void
	postconditionobject_test_local_offset_attached: postcondition_object_test_local_offset /= Void

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
