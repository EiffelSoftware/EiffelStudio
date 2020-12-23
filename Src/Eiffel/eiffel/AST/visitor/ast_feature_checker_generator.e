note
	description: "Type checking and code generation of BYTE_NODE tree."

class
	AST_FEATURE_CHECKER_GENERATOR

inherit
	AST_VISITOR

	AST_FEATURE_CHECKER_EXPORT

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	SHARED_TYPES
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_INSTANTIATOR
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_INSPECT
		export
			{NONE} all
		end

	SYNTAX_STRINGS
		export
			{NONE} all
		end

	SHARED_SERVER
		export
			{NONE} all
		end

	SHARED_TMP_SERVER
		export
			{NONE} all
		end

	CONF_CONSTANTS
		export
			{NONE} all
		end

	SHARED_DEGREES
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		export
			{NONE} all
		end

	SHARED_ENCODING_CONVERTER
		export
			{NONE} all
		end

	SHARED_LOCALE
		export
			{NONE} all
		end

	FORMATTED_MESSAGE
		export
			{NONE} all
		end

	OBSOLETE_CALL_HANDLER

feature -- Initialization

	init (a_context: AST_CONTEXT)
		require
			current_class_is_attached: attached a_context.current_class as c
			current_class_has_feature_table: c.has_feature_table
		do
			if type_a_checker = Void then
				create type_a_checker
			end
			if inherited_type_a_checker = Void then
				create inherited_type_a_checker
			end
			if type_a_generator = Void then
				create type_a_generator
			end
			if byte_anchor = Void then
				create byte_anchor
			end
			context := a_context
			feature_table := a_context.current_class.feature_table
		end

feature -- Type checking

	type_check_only (a_feature: FEATURE_I; a_is_safe_to_check_inherited, a_code_inherited, a_replicated_in_current_class: BOOLEAN)
			-- Type check `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
			valid_inherited_check: a_code_inherited implies a_is_safe_to_check_inherited
		do
			fixme (once "Make sure to use `a_code_inherited' to properly initialize our type checker.")
			set_is_replicated (a_replicated_in_current_class)
			type_a_checker.init_for_checking (a_feature, context.current_class, context.supplier_ids, error_handler)
			a_feature.record_suppliers (context.supplier_ids)
			current_feature := a_feature
			reset
				-- Ensure feature body is in memory if we are processing the class where it comes from
				-- so that updates to AST (like routine IDs, class IDs, status of an entity, etc.) are saved.
			if a_feature.written_in = context.current_class.class_id then
				tmp_ast_server.load (context.current_class)
			end
				-- Initialize structures to record attribute scopes.
			context.init_attribute_scopes
			is_byte_node_enabled := False
			is_ast_modified := False
			break_point_slot_count := 0
			if a_is_safe_to_check_inherited then
				process_inherited_assertions (a_feature, True)
			end
			if a_code_inherited then
				inherited_type_a_checker.init_for_checking (a_feature, context.written_class, Void, Void)
				if not a_feature.is_deferred and not a_feature.is_il_external then
					set_is_inherited (not a_replicated_in_current_class)
					a_feature.body.process (Current)
					set_is_inherited (False)
				end
			else
				a_feature.body.process (Current)
			end
			is_byte_node_enabled := False
			if a_is_safe_to_check_inherited then
				process_inherited_assertions (a_feature, False)
			end
			check_creation
		end

	type_check_and_code (a_feature: FEATURE_I; a_is_safe_to_check_inherited, a_replicated_in_current_class: BOOLEAN)
			-- Type check `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		do
			set_is_replicated (a_replicated_in_current_class)
			type_a_checker.init_for_checking (a_feature, context.current_class, context.supplier_ids, error_handler)
			a_feature.record_suppliers (context.supplier_ids)
			current_feature := a_feature
			reset
				-- Ensure feature body is in memory if we are processing the class where it comes from
				-- so that updates to AST (like routine IDs, class IDs, status of an entity, etc.) are saved.
			if a_feature.written_in = context.current_class.class_id then
				tmp_ast_server.load (context.current_class)
			end
				-- Initialize structures to record attribute scopes.
			context.init_attribute_scopes
			if a_is_safe_to_check_inherited then
				is_byte_node_enabled := False
				break_point_slot_count := 0
				process_inherited_assertions (a_feature, True)
				is_byte_node_enabled := True
				if a_replicated_in_current_class then
						-- We need to correct set the inherited TYPE_A checker to be the current
						-- class so that like features are correctly handled.
					inherited_type_a_checker.init_for_checking (a_feature, context.written_class, Void, Void)
				end
				a_feature.body.process (Current)
				is_byte_node_enabled := False
				process_inherited_assertions (a_feature, False)
			else
				is_byte_node_enabled := True
				if a_replicated_in_current_class then
						-- We need to correct set the inherited TYPE_A checker to be the current
						-- class so that like features are correctly handled.
					inherited_type_a_checker.init_for_checking (a_feature, context.written_class, Void, Void)
				end
				a_feature.body.process (Current)
			end

			if
				attached a_feature.real_body as b and then
				attached {ROUTINE_AS} b.content as rout_as and then
				break_point_slot_count > 0
			then
					--| FIXME(jfiat:2007/01/26):
					--| It occurs `break_point_slot_count' = 0 at this point
					--| but just before we set rout_as.number_of_breakpoint_slots
					--| had been set to non zero value
					--| Check why we have this kind of issue.
				rout_as.set_number_of_breakpoint_slots (break_point_slot_count)
			end
			check_creation
		end

	invariant_type_check (a_feature: FEATURE_I; a_clause: INVARIANT_AS; a_generate_code: BOOLEAN)
			-- Type check `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
			a_clause_not_void: a_clause /= Void
		local
			l_invariant: INVARIANT_B
		do
			set_is_replicated (False)
			type_a_checker.init_for_checking (a_feature, context.current_class, context.supplier_ids, error_handler)
			is_byte_node_enabled := a_generate_code
			is_ast_modified := False
			current_feature := a_feature
			reset
				-- Initialize structures to record attribute scopes.
			context.init_attribute_scopes
				-- There are no locals, but we need to initialize the structures that are used for scope tests.
			context.init_local_scopes
			a_clause.process (Current)
			if
				a_generate_code and then
				attached {BYTE_LIST [ASSERT_B]} last_byte_node as l
			then
				create l_invariant
				l_invariant.set_class_id (context.current_class.class_id)
				l_invariant.set_byte_list (l)
				l_invariant.set_once_manifest_string_count (a_clause.once_manifest_string_count)
				context.init_invariant_byte_code (l_invariant)
				last_byte_node := l_invariant
			end
		end

	custom_attributes_type_check_and_code (a_feature: FEATURE_I; a_cas: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS])
			-- Type check `a_cas' for `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
			a_cas_not_void: a_cas /= Void
		do
			set_is_replicated (False)
			type_a_checker.init_for_checking (a_feature, context.current_class, context.supplier_ids, error_handler)
			is_byte_node_enabled := True
			current_feature := a_feature
			reset
				-- Initialize structures to record attribute scopes.
			context.init_attribute_scopes
			a_cas.process (Current)
		end

feature -- Status report

	is_ast_modified: BOOLEAN
			-- Is AST modified as a part of processing?
			-- The value is reset at the beginning of `type_check_only' and `invariant_type_check'.
			-- If it is set at the end, AST is modified and the code may need to be regenerated.

feature {AST_FEATURE_CHECKER_GENERATOR} -- Internal type checking

	check_body (a_feature: FEATURE_I; a_body: BODY_AS; a_is_byte_node_enabled, a_is_inherited, a_is_replicated_in_current_class, a_is_for_inline_agent: BOOLEAN)
			-- Type check `a_feature' which represents an inline agent `a_body'.
		require
			a_feature_not_void: a_feature /= Void
		local
			l_written_class: CLASS_C
			l_error_level: NATURAL_32
		do
			break_point_slot_count := 0
			l_error_level := error_level

			type_a_checker.init_for_checking (a_feature, context.current_class, context.supplier_ids, error_handler)
			inherited_type_a_checker.init_for_checking (a_feature, context.written_class, Void, Void)
			a_feature.record_suppliers (context.supplier_ids)
			current_feature := a_feature
			reset
			is_byte_node_enabled := a_is_byte_node_enabled
			set_is_inherited (a_is_inherited)
			l_written_class := context.written_class
				-- Initialize AST context before calling `check_types'
				-- This is an optimization for checking types during degree 4 to avoid repetitive type creation.
			context.initialize (feature_table.associated_class, feature_table.associated_class.actual_type)
			a_feature.check_types (feature_table)
			if error_level = l_error_level then
				a_feature.check_type_validity (context.current_class)
				if error_level = l_error_level then
					context.set_written_class (l_written_class)
					if
						not is_inherited and then
						a_is_for_inline_agent and then
						a_feature.has_arguments
					then
						a_feature.check_argument_names (feature_table)
					end
					if error_level = l_error_level then
						a_body.process (Current)
					end
				end
			end
		end

feature {NONE} -- Internal type checking

	check_creation
			-- Check VEVI for attributes and record information necessary to check validity rules for targeted expressions.
		local
			c: CLASS_C
		do
			c := context.current_class
				-- Optimization: skip deferred classes.
			if not c.is_deferred and then is_void_safe_initialization then
					-- Check if the current feature is a creation procedure.
				if
					attached c.creators as cs and then cs.has (current_feature.feature_name_id) or else
					attached c.creation_feature as cf and then cf.feature_id = current_feature.feature_id
				then
					(create {AST_CREATION_PROCEDURE_CHECKER}.make (current_feature, context)).do_nothing
				end
			end
		end

feature -- Access

	byte_code: BYTE_CODE
			-- Last computed BYTE_CODE instance if any.
		do
			Result ?= last_byte_node
		end

	inline_agent_byte_codes: LINKED_LIST [BYTE_CODE]
			-- List of computed inline agent byte nodes if any.

	invariant_byte_code: INVARIANT_B
			-- Last computed invariant byte node if any.
		do
			Result ?= last_byte_node
		end

	last_byte_node: BYTE_NODE
			-- Last computed BYTE_NODE after a call to one of the `process_xx' routine

feature {NONE} -- Access

	last_calls_target_type: TYPE_A
			-- Static type of last feature call.
			-- In case of multiple constrained formal generics there are several static types possible.
			-- MTNASK: current_target_type could be used instead, for now i don't want to interfere with that...

feature {NONE} -- Implementation: Access

	type_a_generator: AST_TYPE_A_GENERATOR
			-- To convert TYPE_AS into TYPE_A

	inherited_type_a_checker, type_a_checker: TYPE_A_CHECKER
			-- To check a type

	byte_anchor: AST_BYTE_NODE_ANCHOR
			-- To get node type for UNARY_AS and BINARY_AS nodes

feature {NONE} -- Implementation: Context

	current_feature: FEATURE_I
			-- Feature which is checked

feature {AST_FEATURE_CHECKER_GENERATOR}

	is_void_safe_call: BOOLEAN
			-- Is code being check for void-safe calls on `a_class'?
		do
			Result := context.is_void_safe_call
		end

	is_void_safe_conformance: BOOLEAN
			-- Is code being check for void-safe conformance on `a_class'?
		do
			Result := context.is_void_safe_conformance
		end

	is_void_safe_initialization: BOOLEAN
			-- Is code being check for void-safe initialization on `a_class'?
		do
			Result := context.is_void_safe_initialization
		end

	is_void_safe_construct: BOOLEAN
			-- Is code being check for void-safe constructs (e.g. no CAP for "check ...end") on `a_class'?
		do
			Result := context.is_void_safe_construct
		end

	is_replicated: BOOLEAN
			-- Is code being processed to be replicated in the current class?

	set_is_replicated (a_replicated: BOOLEAN)
		do
			is_replicated := a_replicated
		end

feature {NONE} -- Implementation: State

	is_byte_node_enabled: BOOLEAN
			-- Are we also doing BYTE_NODE generation as well as type checking?

	has_loop: BOOLEAN
			-- Does Current have a loop instruction?

	has_hector: BOOLEAN
			-- Does Current have an address expression?

	once_manifest_string_index: INTEGER
			-- Index of once manifest strings from the beginning
			-- of the current routine or of the current class invariant

	is_in_rescue: BOOLEAN
			-- Flag to ensure that `retry' instruction appears only in a rescue clause.

	is_in_creation_expression: BOOLEAN
			-- Are we type checking a creation expression?
			-- Usefull, for not checking VAPE error in precondition
			-- using creation expression, since type checking
			-- on CREATION_EXPR_AS will report a not sufficiently
			-- exported creation routine.

	is_target_of_creation_instruction: BOOLEAN
			-- Are we type checking the call to the creation routine?

	check_for_vaol: BOOLEAN
			-- Is current checking for VAOL error?

	depend_unit_level: NATURAL_16
			-- Current level used to create new instances of DEPEND_UNIT.

	context: AST_CONTEXT
			-- Context in which current checking is done

	feature_table: FEATURE_TABLE
			-- Current feature table

	is_checking_postcondition: BOOLEAN
			-- Are we currently checking a postcondition.
			-- Needed to ensure that old expression only appears in
			-- postconditions
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_ensure_flag) =
				{DEPEND_UNIT}.is_in_ensure_flag
		end

	is_checking_invariant: BOOLEAN
			-- Level of analysis for access, When analyzing an access id,
			-- (instance of ACCESS_ID_AS), locals, arguments
			-- are not taken into account if set to True.
			-- Useful for analyzing class invariant.
			-- [Set on when analyzing invariants].
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_invariant_flag) =
				{DEPEND_UNIT}.is_in_invariant_flag
		end

	is_checking_precondition: BOOLEAN
			-- Level for analysis of precondition
		do
			Result := depend_unit_level & ({DEPEND_UNIT}.is_in_require_flag | {DEPEND_UNIT}.is_in_wait_condition_flag) /= 0
		end

	is_checking_check: BOOLEAN
			-- Level for analyzis of check clauses
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_check_flag) =
				{DEPEND_UNIT}.is_in_check_flag
		end

	is_in_assignment: BOOLEAN
			-- Level for analysis of target of an assignment
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_assignment_flag) =
				{DEPEND_UNIT}.is_in_assignment_flag
		end

	last_expressions_type: ARRAYED_LIST [TYPE_A]
			-- Last computed types of a list of expressions

	last_tuple_type: TUPLE_TYPE_A
			-- Type of last computed manifest tuple

	current_target_type: TYPE_A
			-- Type of target of expression being processed
			-- Only useful for type checking of manifest array or evaluating the type of `?' when
			-- used in agent.

	old_expressions: LINKED_LIST [UN_OLD_B]
			-- List of old expressions found during feature type checking

	is_type_compatible: TUPLE [is_compatible: BOOLEAN; conversion_info: detachable CONVERSION_INFO]
			-- Result of computation of `process_type_compatibility'. If `last_type' is
			-- compatible then `is_compatible' is set, if there is a conversion, then
			-- `conversion_info' is set?

	last_assigner_command: detachable FEATURE_I
			-- Last assigner command associated with a feature.

	last_assignment_target: detachable FEATURE_I
			-- Target of assignment or assigner command.

	assigner_source: detachable EXPR_AS
			-- Source of a current assigner command (if any).

	is_qualified_call: BOOLEAN
			-- Is a qualified call being processed?

	is_checking_cas: BOOLEAN
			-- Is a custom attribute being processed?

	error_level: NATURAL_32
			-- Convenience feature for compactness.
		do
			Result := error_handler.error_level
		ensure
			definition: Result = error_handler.error_level
		end

	has_untyped_local: BOOLEAN
			-- Is there a local declared without type?

feature {NONE} -- Measurement

	maximum_inference_count: NATURAL_32 = 100
			-- Maximum number of iterations to perform type inference.

feature {NONE} -- Implementation: Access

	last_access_writable: BOOLEAN
			-- Is last ACCESS_AS node creatable?

	is_object_test_local_initializing: BOOLEAN
			-- Is an object test local being initialized, so that it can be used as a target of an assignment?

	last_actual_feature_name: STRING
			-- Whenever a feature name is required, use this to select the actually correct one.
			--| If last_original_feature_name is 0 then last_feature_name will be selected
		require
			at_least_one_name_available: last_original_feature_name_id /= 0 or last_feature_name_id /= 0
		do
			if last_original_feature_name_id = 0 then
				Result := last_feature_name
			else
				Result := last_original_feature_name
			end
		ensure
			Result_not_void: Result /= Void
		end

	last_actual_feature_name_id: INTEGER
			-- Whenever a feature name is required, use this to select the actually correct one.
			--| If last_original_feature_name is 0 then last_feature_name will be selected
		require
			at_least_one_name_available: last_original_feature_name_id /= 0 or last_feature_name_id /= 0
		do
			Result := last_original_feature_name_id
			if Result = 0 then
				Result := last_feature_name_id
			end
		ensure
			Result_not_zero: Result /= 0
		end

	last_original_feature_name: STRING
			-- Original name of last ACCESS_AS (`last_feature_name' might be different and depending
			-- on what usage is intended this or the other might be the one to use)
		require
			last_original_feature_name_id_not_negative: last_original_feature_name_id >= 0
		do
			Result := names_heap.item (last_original_feature_name_id)
		ensure
			Result_correct: last_original_feature_name_id /= 0 implies Result /= Void
		end

	last_original_feature_name_id: INTEGER
			-- Names_heap Id of original name of last ACCESS_AS (`last_feature_name' might be different and depending
			-- on what usage is intended this or the other might be the one to use)

	last_feature_name: STRING
			-- Actual name of last ACCESS_AS (might be different from original name
			-- in case an overloading resolution or a renaming of a formal constraint took place)
		require
			last_feature_name_id_not_zero: last_feature_name_id /= 0
		do
			Result := names_heap.item (last_feature_name_id)
		ensure
			Result_correct: Result /= Void
		end

	last_feature_name_id: INTEGER
			-- Names_heap Id of `last_feature_name'

	is_last_access_tuple_access: BOOLEAN
			-- Is last ACCESS_AS node an access to a TUPLE element?

feature {NONE} -- Settings

	reset
			-- Reset all attributes to their default value
		local
			l_conv_info: detachable CONVERSION_INFO
		do
			old_expressions := Void
			reset_types
			has_loop := False
			has_hector := False
			once_manifest_string_index := 0
			is_in_rescue := False
			is_in_creation_expression := False
			is_target_of_creation_instruction := False
			check_for_vaol := False
			depend_unit_level := 0
			last_access_writable := False
			last_original_feature_name_id := 0
			last_feature_name_id := 0
			last_calls_target_type := Void
			is_type_compatible := [False, l_conv_info]
			last_assigner_command := Void
			last_assignment_target := Void
			set_is_inherited (False)
			inline_agent_byte_codes := Void
			internal_agent_call_routine_ids := Void
		end

	reset_types
			-- Reset attributes storing types to Void
		do
			last_tuple_type := Void
			last_type := Void
			last_calls_target_type := Void
			last_expressions_type := Void
			current_target_type := Void
		end

	reset_byte_node
			-- Reset byte node generation
		do
			if is_byte_node_enabled then
				last_byte_node := Void
			end
		end

	reset_for_unqualified_call_checking
		do
			last_type := context.current_class_type
			is_controlled := False
			is_qualified_call := False
		end

	set_is_checking_postcondition (b: BOOLEAN)
			-- Assign `b' to `is_checking_postcondition'.
		do
			if b then
				depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_ensure_flag
			else
				depend_unit_level := depend_unit_level &
					{DEPEND_UNIT}.is_in_ensure_flag.bit_not
			end
		ensure
			is_checking_postcondition_set: is_checking_postcondition = b
		end

	set_is_checking_invariant (b: BOOLEAN)
			-- Assign `b' to `is_checking_invariant'.
		do
			if b then
				depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_invariant_flag
			else
				depend_unit_level := depend_unit_level &
					{DEPEND_UNIT}.is_in_invariant_flag.bit_not
			end
		ensure
			is_checking_invariant_set: is_checking_invariant = b
		end

	set_is_checking_precondition (b: BOOLEAN)
			-- Assign `b' to `is_checking_precondition'.
			-- Also set `b' to check_for_vape.
		do
			if b then
				if system.is_scoop and then current_feature.has_separate_arguments then
						-- It's possible that there are no wait conditions,
						-- but then the combined precondition should be tested for that
						-- and this is not done at the moment.
					debug ("to_implement")
						to_implement ("[
							Test if a combined precondition has a wait condition and
							use this result to do more precise evaluation.
						]")
					end
					depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_wait_condition_flag
				else
					depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_require_flag
				end
			else
				depend_unit_level := depend_unit_level &
					({DEPEND_UNIT}.is_in_require_flag | {DEPEND_UNIT}.is_in_wait_condition_flag).bit_not
			end
		ensure
			is_checking_precondition_set: is_checking_precondition = b
		end

	set_is_checking_check (b: BOOLEAN)
			-- Assign `b' to `is_checking_check'.
		do
			if b then
				depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_check_flag
			else
				depend_unit_level := depend_unit_level &
					{DEPEND_UNIT}.is_in_check_flag.bit_not
			end
		ensure
			is_checking_check_set: is_checking_check = b
		end

	set_is_in_assignment (b: BOOLEAN)
			-- Assign `b' to `is_in_assignment'.
		do
			if b then
				depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_assignment_flag
			else
				depend_unit_level := depend_unit_level &
					{DEPEND_UNIT}.is_in_assignment_flag.bit_not
			end
		ensure
			is_in_assignment_set: is_in_assignment = b
		end

	set_current_feature (a_feature: FEATURE_I)
			-- Assign `a_feature' to `current_feature'.
		do
			current_feature := a_feature
		ensure
			is_current_feature_set: current_feature = a_feature
		end

feature {NONE} -- Roundtrip

	process_keyword_as (l_as: KEYWORD_AS)
			-- Process `l_as'.
		do
		end

	process_symbol_as (l_as: SYMBOL_AS)
			-- Process `l_as'.
		do
		end

	process_break_as (l_as: BREAK_AS)
			-- Process `l_as'.
		do
		end

	process_leaf_stub_as (l_as: LEAF_STUB_AS)
			-- Process `l_as'.
		do
		end

	process_symbol_stub_as (l_as: SYMBOL_STUB_AS)
			-- Process `l_as'.
		do
		end

	process_keyword_stub_as (l_as: KEYWORD_STUB_AS)
			-- Process `l_as'.
		do
		end

	process_none_id_as (l_as: NONE_ID_AS)
			-- Process `l_as'.
		do
			process_id_as (l_as)
		end

	process_typed_char_as (l_as: TYPED_CHAR_AS)
			-- Process `l_as'.
		do
			check_type (l_as.type)
			if attached last_type as t then
				if not t.is_character then
						-- The type is unexpected.
					error_handler.insert_error (create {VWMQ}.make (t, <<character_type, wide_char_type>>, context, l_as))
					reset_types
				elseif
						-- Do nothing for CHARACTER_32, since all characters are valid.
					not t.is_character_32 and then
					not l_as.value.is_character_8
				then
						-- Report error when the type is CHARACTER_8, but the value is not.
					error_handler.insert_error (create {VWMQ}.make (t, <<wide_char_type>>, context, l_as))
					reset_types
				end
				if is_byte_node_enabled then
					create {CHAR_CONST_B} last_byte_node.make (l_as.value, t)
				end
			end
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS)
			-- Process `l_as'.
		do
			process_routine_creation_as (l_as)
		end

	process_inline_agent_creation_as (l_as: INLINE_AGENT_CREATION_AS)
			-- Process `l_as'.
		local
			l_feature_name: ID_AS
			l_context: like context
			l_feature_as: FEATURE_AS
			l_feature_generator: AST_FEATURE_I_GENERATOR
			l_feature, l_cur_feature, l_enclosing_feature: FEATURE_I
			l_feature_names: EIFFEL_LIST [FEATURE_NAME]
			l_current_class, l_written_class: EIFFEL_CLASS_C
			l_body_code: BYTE_CODE
			l_loc: LOCATION_AS
			l_new_feature_dep: FEATURE_DEPENDANCE
			l_feature_checker: AST_FEATURE_CHECKER_GENERATOR
			l_used_argument_names: SEARCH_TABLE [INTEGER]
			l_used_local_names: SEARCH_TABLE [INTEGER]
			l_arg_names: SPECIAL [INTEGER]
			l_locals: EIFFEL_LIST [LIST_DEC_AS]
			i: INTEGER
			l_routine: ROUTINE_AS
			l_id_list: IDENTIFIER_LIST
			l_error_level: NATURAL_32
			l_vpir: VPIR3
		do
			if current_feature.is_class then
				report_vucr (create {VUCR_BODY}.make_inline_agent (current_feature, context.current_class, context.written_class, l_as.first_token (match_list_of_class (context.written_class.class_id))))
			end

			l_error_level := error_level
			l_current_class ?= context.current_class

			if is_inherited then
					-- We have to retrieve the FEATURE_I object from the class where the inline agent is
					-- written, since those are not inherited.
				l_feature :=
					system.class_of_id (l_as.class_id).eiffel_class_c.inline_agent_of_rout_id (l_as.inl_rout_id)
				l_feature := l_feature.instantiation_in (context.current_class_type.conformance_type.as_implicitly_detachable.as_variant_free)
			elseif
				not attached {ROUTINE_AS} l_as.body.content as r or else
				r.is_deferred or else
				r.is_attribute
			then
				create l_vpir
				l_vpir.set_class (context.current_class)
				l_vpir.set_feature (context.current_feature)
				l_vpir.set_location (l_as.body.start_location)
				error_handler.insert_error (l_vpir)
				reset_types
			elseif
				r.is_external or else
				r.is_once
			then
				error_handler.insert_error (create {NOT_SUPPORTED}.make
					(agent format_elements
						(?,
						locale.translation_in_context ("Inline agent with the body other than a {1} form is not supported.", "compiler.error"),
						<<agent {TEXT_FORMATTER}.process_keyword_text ({TEXT_FORMATTER}.ti_do_keyword, Void)>>),
					context,
					l_as.body.start_location))
				reset_types
			elseif is_byte_node_enabled or else has_untyped_local then
					-- TODO: Move creation of a new `{FEATURE_I}' object to an earlier stage to avoid the dependency on code generation.
					-- This is the first place, where inline agents are looked at as features.
					-- They are ignored by degree 2. So a new FEATURE_I has to be created
				create l_feature_names.make (1)
				l_feature_names.extend (create {FEAT_NAME_ID_AS}.initialize (create {ID_AS}.initialize ("inline_agent")))
				create l_feature_as.initialize (l_feature_names, l_as.body, Void, 0, 0)

				l_cur_feature := context.current_feature
				create l_feature_generator

				if is_replicated then
						-- Agent needs to be created with respect to its original class.
					l_written_class ?= l_cur_feature.written_class
				else
					l_written_class := l_current_class
				end
				l_feature := l_feature_generator.new_feature (l_feature_as, 0, l_written_class)

				l_feature := init_inline_agent_feature (l_feature, Void, l_current_class, l_written_class)

				create l_feature_name.initialize_from_id (l_feature.feature_name_id)
				l_loc := l_as.start_location
				l_feature_name.set_position (l_loc.line, l_loc.column, l_loc.position, 0,
					l_loc.character_column, l_loc.character_position, 0)
				l_as.set_feature_name (l_feature_name)

				context.put_inline_agent (l_feature, l_as)
			else
				l_cur_feature := context.current_feature
				if l_cur_feature.is_invariant then
					l_enclosing_feature := l_cur_feature
				else
					l_enclosing_feature := l_cur_feature.enclosing_feature
				end
				l_feature := context.inline_agent (l_as)
				if l_feature = Void then
					l_feature := l_current_class.inline_agent_with_nr (l_enclosing_feature.body_index, context.inline_agent_counter.next)
					context.put_inline_agent (l_feature, l_as)
				end
			end

			if error_level = l_error_level then
					-- The context is modified, for the processing of the body of the inline agent.
				l_context := context.save

				if not is_inherited then
					create l_used_argument_names.make (1)
					if l_cur_feature.argument_count > 0  then
						from
							l_arg_names := context.current_feature.arguments.argument_names
							i := l_arg_names.lower
						until
							i > l_arg_names.upper
						loop
							l_used_argument_names.force (l_arg_names.item (i))
							i := i + 1
						end
					end

					if l_context.used_argument_names /= Void then
						l_used_argument_names.merge (l_context.used_argument_names)
					end
					context.set_used_argument_names (l_used_argument_names)

					create l_used_local_names.make (1)
					if not l_cur_feature.is_invariant then
						if l_cur_feature.is_inline_agent then
							l_routine ?= context.current_inline_agent_body.content
						else
							l_routine ?= l_cur_feature.real_body.content
						end
						if l_routine /= Void then
							l_locals := l_routine.locals
							if l_locals /= Void and not l_locals.is_empty then
								from
									l_locals.start
								until
									l_locals.after
								loop
									l_id_list := l_locals.item.id_list
									from
										l_id_list.start
									until
										l_id_list.after
									loop
										l_used_local_names.force (l_id_list.item.item)
										l_id_list.forth
									end
									l_locals.forth
								end
							end
						end
					end

					if l_context.used_local_names /= Void then
						l_used_local_names.merge (l_context.used_local_names)
					end
					context.set_used_local_names (l_used_local_names)
				end

				context.set_current_feature (l_feature)
				context.init_attribute_scopes
				create l_feature_checker
				l_feature_checker.init (context)
				l_feature_checker.set_type_recorder (type_recorder)
				context.set_current_inline_agent_body (l_as.body)
				l_feature_checker.check_body (l_feature, l_as.body, is_byte_node_enabled, is_inherited, is_replicated, True)

				l_new_feature_dep := context.supplier_ids
				context.restore (l_context)
				l_context := Void

				if error_level = l_error_level then
					if not is_inherited then
						if is_byte_node_enabled then
							l_body_code ?= l_feature_checker.last_byte_node
							l_body_code.set_start_line_number (l_as.body.start_location.line)
								-- When an inline agent X of an enclosing feature f is a client of
								-- feature g, we make the enclosing feature f a client of g.
							if inline_agent_byte_codes = Void then
								create inline_agent_byte_codes.make
							end
							inline_agent_byte_codes.extend (l_body_code)
							if l_feature_checker.inline_agent_byte_codes /= Void then
								inline_agent_byte_codes.append (l_feature_checker.inline_agent_byte_codes)
							end
							init_inline_agent_dep (l_feature, l_new_feature_dep)
						end
						l_as.set_inl_class_id (l_feature.access_in)
						l_as.set_inl_rout_id (l_feature.rout_id_set.first)
					end
						-- Now as the features is generated the inline agent creation is
						-- threaten like a normal routine creation
					process_routine_creation_as_ext (l_as, l_feature)
				else
					if
						not is_inherited and then
						is_byte_node_enabled and then
						l_current_class.has_inline_agents
					then
						l_current_class.inline_agent_table.remove (l_feature.feature_name_id)
					end
					reset_types
				end
			end
		end

	process_creation_as (l_as: CREATION_AS)
			-- Process `l_as'.
		local
			l_access: ACCESS_B
			l_target_type, l_explicit_type, l_creation_type: TYPE_A
			l_vgcc3: VGCC3
			l_vgcc31: VGCC31
			l_vgcc7: VGCC7
			l_needs_byte_node: BOOLEAN
			l_error_level: NATURAL_32
			l_warning_level: like {ERROR_HANDLER}.warning_level
			l_reinitialized_variable: like last_reinitialized_variable
		do
			l_error_level := error_level
			break_point_slot_count := break_point_slot_count + 1

			l_needs_byte_node := is_byte_node_enabled
			reset_for_unqualified_call_checking

				-- Set flag so that depend_unit knows it is used as a creation routine
				-- not just a normal feature call. It is reset as soon as it is processed.
			is_target_of_creation_instruction := True
			last_access_writable := False
			last_reinitialized_variable := 0
			l_as.target.process (Current)
			if l_needs_byte_node then
				l_access ?= last_byte_node
			end
				-- Record initialized variable to commit it after the call is processed.
			l_reinitialized_variable := last_reinitialized_variable
				-- Although it might be already reset when `target' is indeed
				-- a feature of the current class, it is not reset when it is a local,
				-- that's why we reset it.
			is_target_of_creation_instruction := False

			l_target_type := last_type
			if l_target_type /= Void then
				if not last_access_writable then
					create l_vgcc7
					context.init_error (l_vgcc7)
					l_vgcc7.set_target_name (l_as.target.access_name)
					l_vgcc7.set_type (l_target_type)
					l_vgcc7.set_location (l_as.target.start_location)
					error_handler.insert_error (l_vgcc7)
				else
					if l_as.type /= Void then
						l_as.type.process (Current)
						l_explicit_type := last_type
							-- If `l_explicit_type' is Void then we stop the process here.
						if l_explicit_type /= Void then
								-- Creation type is always attached
							l_explicit_type := l_explicit_type.as_attached_in (context.current_class)
						end
					end

					if error_level = l_error_level then
							-- Check validity of creation type.
						if
							l_target_type.is_none or else (l_explicit_type /= Void and then
							(l_explicit_type.is_none or else
								(l_target_type.is_expanded and then l_explicit_type.is_expanded and then
								not l_explicit_type.same_as (l_target_type))))
						then
								-- Cannot create instance of NONE.
								-- Cannot create an expanded type which is different from
								-- the declared type of `l_as.target'.
							create l_vgcc3
							context.init_error (l_vgcc3)
							l_vgcc3.set_type (l_explicit_type)
							l_vgcc3.set_target_name (l_as.target.access_name)
							l_vgcc3.set_location (l_as.target.start_location)
							error_handler.insert_error (l_vgcc3)
						else
							l_warning_level := error_handler.warning_level
							if
								l_explicit_type /= Void and then
								not l_target_type.backward_conform_to (context.current_class, l_explicit_type)
							then
									-- Specified creation type must conform to
									-- the entity type
								create l_vgcc31
								context.init_error (l_vgcc31)
								l_vgcc31.set_target_name (l_as.target.access_name)
								l_vgcc31.set_type (l_explicit_type)
								l_vgcc31.set_location (l_as.type.start_location)
								error_handler.insert_error (l_vgcc31)
							elseif l_warning_level /= error_handler.warning_level then
								error_handler.warning_list.last.set_location (l_as.type.start_location)
							end

							if attached l_explicit_type then
								instantiator.dispatch (l_explicit_type, context.current_class)
								l_creation_type := l_explicit_type
							else
									-- Creation type is always attached.
								l_creation_type := l_target_type.as_attached_in (context.current_class)
							end

								-- Check call validity for creation.
							process_abstract_creation (l_creation_type, l_as.call, l_as.target.access_name, l_as, l_as.target.start_location)
							if attached last_type as t then
									-- Update creation type.
								l_creation_type := t
							end
							if not is_inherited then
								record_creation_dependence
									(if
										not attached l_explicit_type and then
										attached {ACCESS_FEAT_AS} l_as.target as a and then
										a.is_feature and then
										attached context.current_class.feature_of_name_id (a.feature_name.name_id) as f and then
										attached type_a_checker.check_and_solved (create {LIKE_FEATURE}.make (f, context.current_class.class_id), Void) as t
									then
											-- Use `attached like feature_name` type for creation on a feature without explicit type.
										t.as_attached_in (context.current_class)
									else
											-- Use type of the target otherwise.
										l_creation_type
									end)
							end

							if l_needs_byte_node then
								generate_creation (l_as.is_active, l_access, {ROUTINE_B} / last_byte_node, l_creation_type, l_explicit_type,
									l_as.target.start_location)
									-- Set line information for instruction.
								if attached {ASSIGN_B} last_byte_node as l_assign then
									l_assign.set_line_pragma (l_as.line_pragma)
								end
							end
						end
					end
				end
				if l_reinitialized_variable /= 0 then
						-- Local variable is now attached.
					if l_reinitialized_variable = result_name_id then
						context.add_result_instruction_scope
						context.set_result
					elseif l_reinitialized_variable > 0 then
						context.add_local_instruction_scope (l_reinitialized_variable)
						context.set_local (l_reinitialized_variable)
					else
						context.add_attribute_instruction_scope (- l_reinitialized_variable)
					end
				end
			end
			reset_types
		end

	process_creation_expression (target_type: TYPE_A; is_active: BOOLEAN; call: ACCESS_FEAT_AS; target_node: TYPE_AS)
			-- Process a creation expression with the target type `t` with region activity specified by `is_active`
			-- and call `call` at location identified by `target_node`.
		local
			t: TYPE_A
			e: CREATION_EXPR_B
		do
				-- Type of a creation expression is always attached.
			t := target_type.as_attached_in (context.current_class)
				-- Type of a creation expression is frozen if this is a class type.
			if attached {DEANCHORED_TYPE_A} t as d then
				t := d.duplicate
				t.set_frozen_mark
			end
			instantiator.dispatch (t, context.current_class)
			is_in_creation_expression := True
			process_abstract_creation (t, call, Void, target_node, target_node.start_location)
			if attached last_type as c then
				if not is_inherited then
					record_creation_dependence (c)
				end
				if
					is_byte_node_enabled and then
					attached {ROUTINE_B} last_byte_node as a
				then
					create e
					e.set_is_active (is_active)
					e.set_call (a)
					e.set_info (c.create_info)
					e.set_type (c)
					e.set_line_number (target_node.start_location.line)
					last_byte_node := e
				end
			end
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS)
			-- Process `l_as'.
		local
			l_vgcc3: VGCC3
			l_error_level: NATURAL_32
		do
			reset_for_unqualified_call_checking
			l_error_level := error_level
			l_as.type.process (Current)
			if attached last_type as t then
				if t.is_none then
						-- Cannot create instance of NONE.
					create l_vgcc3
					context.init_error (l_vgcc3)
					l_vgcc3.set_type (t)
					l_vgcc3.set_location (l_as.type.start_location)
					error_handler.insert_error (l_vgcc3)
				else
					process_creation_expression (t, l_as.is_active, l_as.call, l_as.type)
				end
			end
			if error_level /= l_error_level then
				reset_types
			end
		end

feature {NONE} -- Implementation

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS)
		local
			l_creation: CREATION_EXPR_B
			l_ca_b: CUSTOM_ATTRIBUTE_B
		do
			check dotnet_generation: system.il_generation end
			is_checking_cas := True
			l_as.creation_expr.process (Current)
			if attached {CL_TYPE_A} last_type as l_creation_type then
				if l_creation_type.has_like or else l_creation_type.has_formal_generic then
					fixme ("Generate an error here as it should be a valid type")
				end
				if is_byte_node_enabled then
					l_creation ?= last_byte_node
					create l_ca_b.make (l_creation)
					if l_as.tuple /= Void then
						check_tuple_validity_for_ca (l_creation_type, l_as.tuple, l_ca_b)
					end
					last_byte_node := l_ca_b
				elseif l_as.tuple /= Void then
					check_tuple_validity_for_ca (l_creation_type, l_as.tuple, Void)
				end
			end
			reset_types
			is_checking_cas := False
		ensure then
			is_checking_cas_reset: not is_checking_cas
		rescue
				-- If an exception occurs while type checking the custom attribute
				-- we need to satisfy our post-condition before passing the exception
				-- to our caller.
			is_checking_cas := False
		end

	process_id_as (l_as: ID_AS)
		do
			-- Nothing to be done
		end

	process_integer_as (l_as: INTEGER_CONSTANT)
		do
			set_type (l_as.manifest_type, l_as)
			if not {SYSTEM_I}.is_basic_class_alive and then not is_inherited then
				record_creation_dependence (l_as.manifest_type)
			end
			if is_byte_node_enabled then
				last_byte_node := l_as
			end
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS)
		local
			l_vsta1: VSTA1
			l_feature: FEATURE_I
			l_error_level: NATURAL_32
		do
			l_as.class_type.process (Current)
			if attached last_type as l_type then
					-- Check validity of type declaration for static access
				if l_type.is_none then
					create l_vsta1.make (l_type.dump, l_as.feature_name.name)
					l_vsta1.set_class (context.current_class)
					l_vsta1.set_location (l_as.class_type.start_location)
					error_handler.insert_error (l_vsta1)
					reset_types
				elseif
					attached l_type.base_class as c and then
					c.is_once and then
					c.creators.has (l_as.feature_name.name_id)
				then
						-- This is a shorthand for creating an object of a once class.
					process_creation_expression (l_type, False, l_as, l_as.class_type)
				else
					set_type (l_type, l_as.class_type)
					instantiator.dispatch (l_type, context.current_class)
					if is_inherited then
						l_feature := l_type.base_class.feature_of_rout_id (l_as.routine_ids.first)
					else
						record_non_object_call_dependence (l_type)
					end
					l_error_level := error_level
					process_call (l_type, Void, l_as.feature_name, l_feature, l_as.parameters, True, False, True, False, True)
					if error_level = l_error_level and then not is_inherited then
						set_routine_ids (last_routine_id_set, l_as)
						l_as.set_class_id (last_calls_target_type.base_class.class_id)
					end
					if attached last_vuar_error as e and then attached last_type as t then
							-- Feature without arguments is found, try parenthesis alias on it.
						look_for_parenthesis_alias (l_as.internal_parameters, e, t)
					end
						-- Set type of the call as a whole.
					set_type (last_type, l_as)
				end
			end
		end

	process_call (
			a_type, a_precursor_type: TYPE_A; a_name: ID_AS; a_feature: FEATURE_I;
			a_params: EIFFEL_LIST [EXPR_AS]; is_static, is_agent, is_qualified, is_precursor: BOOLEAN;
			is_vuar_delayed: BOOLEAN)

			-- Process call to `a_name' in context of `a_type' with `a_params' if ANY.
			-- If `is_static' it is a static call.
			--
			-- `a_type': Target on which feature is called
			-- `a_precursor_type': Target type of precursor call, i.e Precursor {A_PRECURSOR_TARGET_TYPE} (a_params)
			-- `a_name': Name of called feature
			-- `a_feature': Feature object if alredy known
			-- `a_params': List of parameters to the call
			-- `is_static': Indicates a static call (C external or constant)
			-- `is_qualified': True => Call of the form 'a.b' / False => Call of the form 'b'
			-- `is_precursor': True => Call of the form Precursor {A_PRECURSOR_TYPE} (a_params)
			-- `is_vuar_delayed': Is VUAR error report when a feature take no arguments, but there are actual arguments, delayed (the error is available in `last_vuar_error')?
		require
			a_type_not_void: a_type /= Void
			a_precursor_type_not_void: is_precursor implies a_precursor_type /= Void
			a_name_not_void: a_feature = Void implies a_name /= Void
		local
			l_arg_nodes: BYTE_LIST [EXPR_B]
			l_arg_types: like last_expressions_type
			l_formal_arg_type: TYPE_A
			l_like_argument: LIKE_ARGUMENT
			l_feature: FEATURE_I
			l_found_feature: FEATURE_I
			l_seed: FEATURE_I
			i, l_actual_count, l_formal_count: INTEGER
				-- Id of the class type on the stack
			l_arg_type: TYPE_A
			l_last_type: TYPE_A
			l_last_constrained: TYPE_A
			l_last_type_set: TYPE_SET_A
				-- Type onto the stack
			l_last_id: INTEGER
				-- Id of the class correponding to `l_last_type'
			l_last_class: CLASS_C
			l_context_current_class: CLASS_C
			l_access: ACCESS_B
			l_vuar1: VUAR1
			l_vuex: VUEX
			l_vkcn3: VKCN3
			l_vape: VAPE
			l_is_in_creation_expression, l_is_target_of_creation_instruction: BOOLEAN
			l_feature_name: ID_AS
			l_parameters: EIFFEL_LIST [EXPR_AS]
			l_wrapped_actuals: EIFFEL_LIST [EXPR_AS]
			l_argument: EXPR_AS
			l_needs_byte_node: BOOLEAN
			l_conv_info: CONVERSION_INFO
			l_expr: EXPR_B
			l_result_type, l_pure_result_type: TYPE_A
			l_generated_result_type: TYPE_A
			l_veen: VEEN
			l_vica2: VICA2
			l_cl_type_i: CL_TYPE_A
			l_parameter: PARAMETER_B
			l_parameter_list: BYTE_LIST [PARAMETER_B]
			old_assigner_source: like assigner_source
			l_is_last_access_tuple_access: BOOLEAN
			l_formal: FORMAL_A
			l_last_feature_table: FEATURE_TABLE
			l_is_multiple_constraint_case: BOOLEAN
			l_result_tuple: TUPLE[feature_item: FEATURE_I; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]
			l_last_original_feature_name_id: INTEGER
			l_tuple_access_b: TUPLE_ACCESS_B
			vbac2: VBAC2
			l_vtmc1: VTMC1
			l_error_level: NATURAL_32
			l_is_in_assignment: BOOLEAN
			l_warning_level: like {ERROR_HANDLER}.warning_level
			l_tcat: CAT_CALL_WARNING
			l_is_controlled: BOOLEAN
			is_target_known: BOOLEAN
			tuple_argument_number: INTEGER
			w: like {ERROR_HANDLER}.warning_level
			has_vucr: BOOLEAN
			l_is_qualified_call: BOOLEAN
			old_expressions_type: like last_expressions_type
		do
				-- Reset any previously reported VUAR error.
			last_vuar_error := Void
				-- Record if the call is controlled.
			l_is_controlled := is_controlled
				-- Record if the call is qualified (the attribute `is_qualified_call` may change when processing arguments).
				-- TODO: check whether `is_qualified` would be a safe replacement for `is_qualified_call`.
			l_is_qualified_call := is_qualified_call
				-- Reset
			l_error_level := error_level
			if a_feature = Void then
				last_calls_target_type := Void
			end
			l_needs_byte_node := is_byte_node_enabled

				-- Retrieve if we are type checking a routine that is the creation
				-- routine of a creation expression. As soon as we know this, we
				-- reset `l_is_in_creation_expression' to False, so that if any parameter
				-- of the creation routine is also a creation expression we perform
				-- a correct type checking of the VAPE errors.
			l_is_in_creation_expression := is_in_creation_expression
			l_is_target_of_creation_instruction := is_target_of_creation_instruction
			l_is_in_assignment := is_in_assignment
			is_in_creation_expression := False
			is_last_access_tuple_access := False

				-- Reset assigner call flag
			old_assigner_source := assigner_source
			assigner_source := Void

				-- `a_name' can be void for inline agents
			if a_name /= Void then
				l_feature_name := a_name
					-- We need to store the original name as it may change due to
					-- renamings applied of multi constraint formal generics.				
				l_last_original_feature_name_id := a_name.name_id
				last_original_feature_name_id := l_last_original_feature_name_id
				check
					last_original_feature_name_correct: last_original_feature_name = a_name.name
				end
			else
				last_original_feature_name_id := 0
			end

			l_context_current_class := context.current_class

			l_last_type := a_type.actual_type
			is_target_known := True
			if l_last_type.is_formal then
				l_formal ?= l_last_type
				if not l_formal.is_single_constraint_without_renaming (l_context_current_class) then
					l_last_type_set := l_last_type.to_type_set.constraining_types  (l_context_current_class)
						-- from now on we know that we have multiple constraints
						-- we cannot compute `l_last_class', `l_last_id', ... as we do not know which
						-- which type to take out of the type set. we know it after we computed the feature.
					l_is_multiple_constraint_case := True
				else
						-- Resolve formal type
					l_last_constrained := l_formal.constrained_type (l_context_current_class)
						-- Protect if constrained type is NONE.
					if  l_last_constrained.has_associated_class then
						l_last_class := l_last_constrained.base_class
						l_last_id := l_last_class.class_id
						l_last_feature_table := l_last_class.feature_table
					else
						check l_last_constrained_is_none: l_last_constrained.is_none end
					end
				end
			elseif l_last_type.is_known then
					-- We have no formal, therefore we don't need to recompute `l_last_constrained'
				l_last_constrained := l_last_type
				if l_last_type.is_void then
						-- No call when target is a procedure
					create l_vkcn3
					context.init_error (l_vkcn3)
					l_vkcn3.set_location (l_feature_name)
					l_vkcn3.set_called_feature (a_name.name)
					error_handler.insert_error (l_vkcn3)
				else
						-- Protect if constrained type is NONE.
					if l_last_constrained.has_associated_class then
						l_last_class := l_last_type.base_class
						l_last_id := l_last_class.class_id
						l_last_feature_table := l_last_class.feature_table
					else
						check l_last_constrained_is_none: l_last_constrained.is_none end
					end
				end
			else
					-- Type is being computed.
				is_target_known := False
				l_last_constrained := unknown_type
			end

			if l_vkcn3 = Void and then not is_static and then not a_type.is_attached and then is_void_safe_call then
				error_handler.insert_error (create {VUTA2}.make (context, a_type, l_feature_name))
			end

				-- Check for `NONE'
			if
				(l_last_constrained /= Void and then l_last_constrained.is_none) or
				(l_last_type_set /= Void and then l_last_type_set.has_none)
			then
				create l_vuex.make_for_none (l_feature_name.name)
				context.init_error (l_vuex)
				l_vuex.set_location (l_feature_name)
				error_handler.insert_error (l_vuex)
			elseif error_level = l_error_level then
					-- When there is no error we can continue
				l_parameters := a_params
				if l_parameters /= Void then
					l_actual_count := l_parameters.count
				end

				if a_feature /= Void then
					l_feature := a_feature
					if l_is_multiple_constraint_case then
						l_last_constrained := last_calls_target_type
					elseif l_formal /= Void then
						l_last_constrained := l_formal.constrained_type (l_context_current_class)
					else
						l_last_constrained := a_type
					end

					check has_associated_class: l_last_constrained.has_associated_class end
					l_last_class := l_last_constrained.base_class
					l_last_id := l_last_class.class_id
				else
					if l_is_multiple_constraint_case then
						check
							type_set_available: l_last_type_set  /= Void
							no_last_constraint: l_last_constrained = Void
							no_last_class: l_last_class = Void
							no_last_id: l_last_id = 0
						end
							-- NOTE: The look-up for overloaded functions for .NET is not done because it's not used so often.
						l_result_tuple := l_last_type_set.feature_i_state_by_name_id (l_feature_name.name_id)
							-- If there we did not found a feature it could still be a tuple item.
						if l_result_tuple.features_found_count > 1  then
							error_handler.insert_error (
								new_vtmc_error (l_feature_name, l_formal.position, l_context_current_class, False))
						else
							l_feature := l_result_tuple.feature_item
							l_last_constrained := l_result_tuple.class_type_of_feature
								-- If no feature was found it is void.
							if l_last_constrained /= Void  then
								l_last_class := l_last_constrained.base_class
								l_last_id := l_last_class.class_id
							end
						end
					elseif is_target_known then
						check
							no_type_set_available: l_last_type_set = Void
							last_constrained_available: l_last_constrained /= Void
							last_class_available: l_last_class /= Void
							last_class_id_available: l_last_id > 0
						end
							-- Look for a feature in the class associated to the
							-- last actual type onto the context type stack. If it
							-- is a generic take the associated constraint.
						if l_last_feature_table.has_overloaded (l_feature_name.name_id) then
								-- Evaluate parameters. This is needed for overloading resolution.
								-- Note: if one parameter is a manifest array, then its type is resolved
								-- without context.
							if l_parameters /= Void then
								l_actual_count := l_parameters.count
								current_target_type := Void
								old_expressions_type := last_expressions_type
								process_expressions_list (l_parameters)
								l_arg_types := last_expressions_type
								last_expressions_type := old_expressions_type
								if l_needs_byte_node then
									l_arg_nodes ?= last_byte_node
								end
							end
							if error_level = l_error_level then
								l_feature := overloaded_feature (l_last_type, l_last_class, l_arg_types,
									l_feature_name, is_static)
								if l_feature /= Void then
										-- Update `l_feature_name' with appropriate resolved name.
										-- Otherwise some routine using `l_feature_name' will fail although
										-- it succeeds here (e.g. CREATION_EXPR_AS and CREATION_AS)
									create l_feature_name.initialize_from_id (l_feature.feature_name_id)
								end
							end
						else
							l_feature := feature_with_name_using (l_feature_name, l_last_feature_table)
						end
					end
				end

				check
						-- If we found a feature all the necessary information should be computed.
					state_correct:l_feature /= Void implies (
						l_last_constrained /= Void and then
						l_last_class /= Void and then
						l_last_id > 0)
				end

				if error_level = l_error_level then
					if l_feature = Void then
							-- If no feature was found, so the target of the call may be a named tuple
							-- then it may be a call on one of its label.
							--| This we only check in the case of single cosntraint formals.
							--| It does not make any sense to check it for multi constraints as
							--| one is not allowed to inherit from `TUPLE'.
						if
							attached {NAMED_TUPLE_TYPE_A} l_last_type as l_named_tuple and then
							attached l_named_tuple.label_position_by_id (l_feature_name.name_id) as l_label_pos and then
							l_label_pos > 0
						then
							l_formal_arg_type := l_named_tuple.generics.i_th (l_label_pos)
							set_type (l_formal_arg_type, a_name)
							l_is_last_access_tuple_access := True
							last_feature_name_id := l_feature_name.name_id
								-- No renaming possible (from RENAMED_TYPE_A), they are the same
							last_original_feature_name_id := last_feature_name_id
							check
								last_feature_name_correct: last_feature_name = l_feature_name.name
							end
								-- Restore previous value of `is_controlled'.
							is_controlled := l_is_controlled
							if attached old_assigner_source then
									-- Assignment to a tuple field.
								old_assigner_source.process (Current)
								l_arg_type := last_type
								if attached l_arg_type then
									if attached argument_compatibility_error (l_named_tuple, l_named_tuple, l_arg_type, l_label_pos, l_named_tuple.generics, Void, l_feature_name, l_feature_name) as e then
										error_handler.insert_error (e)
									else
										l_warning_level := error_handler.warning_level
										if not l_formal_arg_type.backward_conform_to (l_context_current_class, l_arg_type) then
											if
												not is_inherited and then
												l_arg_type.convert_to (l_context_current_class, l_formal_arg_type.deep_actual_type)
											then
												l_conv_info := context.last_conversion_info
												if l_conv_info.has_depend_unit then
													context.supplier_ids.extend (l_conv_info.depend_unit)
												end
												l_argument := converted_expression (old_assigner_source, l_conv_info)
													-- Make sure the source of the assigner instruction is updated.
												assigner_source := l_argument
													-- Generate conversion byte node only if we are not checking
													-- a custom attribute. Indeed in that case, we do not want those
													-- conversion routines, we will use the attachment type to figure
													-- out how the custom attribute will be generated.
												if l_needs_byte_node and not is_checking_cas and then attached {EXPR_B} last_byte_node as e then
													last_byte_node := l_conv_info.byte_node (e)
												end
													-- Update `l_arg_type' with the converted type.
												l_arg_type := l_formal_arg_type
											end
										elseif l_warning_level /= error_handler.warning_level then
											error_handler.warning_list.last.set_location (l_feature_name)
										end
										if l_needs_byte_node then
												-- Preserve source byte node
											check
												is_expression: attached {EXPR_B} last_byte_node as source_byte_node
											then
													-- When assigning to a tuple, we simply transform the tuple
													-- access by giving a source.
												create {TUPLE_ACCESS_B} l_tuple_access_b.make (l_named_tuple, l_label_pos)
												l_tuple_access_b.set_line_number (l_feature_name.line)
												create l_parameter
												l_parameter.set_expression (source_byte_node)
												l_parameter.set_attachment_type (l_tuple_access_b.tuple_element_type)
												l_parameter.set_is_for_tuple_access (True)
												l_tuple_access_b.set_source (l_parameter)
												last_byte_node := l_tuple_access_b
											end
										end
									end
								end
							else
									-- Adapt separateness and controlled status of the result to target type.
								adapt_type_to_target (last_type, a_type, Void, l_is_controlled, a_name, l_error_level, l_feature_name)
								if l_needs_byte_node then
									create {TUPLE_ACCESS_B} l_tuple_access_b.make (l_named_tuple, l_label_pos)
									last_byte_node := l_tuple_access_b
									last_byte_node.set_line_number (l_feature_name.line)
								end
							end
						elseif not is_target_known then
								-- No feature is found and this is not a tuple access.
								-- Unknown target case: do not report an error.
								-- Lookup for a feature in a set of possible types.
							if attached {LOCAL_TYPE_A} a_type.actual_type as t and then
								attached t.feature_call (a_name.name_id, context.current_class) as f
							then
									-- For the use of `f.site.class_id' see test#anchor086.
								l_result_type := f.descriptor.type.recomputed_in
									(f.target.as_implicitly_detachable.as_variant_free,
									l_context_current_class.class_id,
									f.site.as_implicitly_detachable.as_variant_free,
									f.site.class_id)
								if attached l_arg_types then
									l_result_type := l_result_type.actual_argument_type (l_arg_types)
								end
								set_type (l_result_type, a_name)
								last_calls_target_type := f.site
								last_access_writable := f.descriptor.is_attribute
								last_feature_name_id := f.descriptor.feature_name_id
								last_routine_id_set := f.descriptor.rout_id_set
							else
									-- Propagate information that the result type is unknown.
								set_type (unknown_type, a_name)
							end
						elseif l_is_multiple_constraint_case then
								-- No feature is found and this is not a tuple access.
								-- Multiple constraints case: report VTMC1 error instead of a VEEN.
							create l_vtmc1
							context.init_error (l_vtmc1)
							l_vtmc1.set_feature_call_name (l_feature_name.name)
							l_vtmc1.set_location (l_feature_name)
							l_vtmc1.set_type_set (l_last_type_set)
							l_vtmc1.set_location (l_feature_name)
							error_handler.insert_error (l_vtmc1)
								-- We have an error, so we need to reset the types.
							reset_types
						else
								-- No feature is found and this is not a tuple access.
								-- Single constraint case: report that a feature name is not found.
							create l_veen
							context.init_error (l_veen)
							l_veen.set_identifier (l_feature_name.name)
							l_veen.set_target_type (l_last_type)
							if system.il_generation then
								l_veen.set_parameter_count (l_actual_count)
							end
							l_veen.set_location (l_feature_name)
							error_handler.insert_error (l_veen)
								-- We have an error, so we need to reset the types.
							reset_types
						end
					else
							-- A feature is found.
						l_found_feature := l_feature
						if is_static then
							if not l_feature.is_class then
									-- Not a valid feature for static access.
								check_instance_free (l_feature, l_last_class,
									agent error_handler.insert_error (create {VUNO_FEATURE}.make
										(l_feature, current_feature, context.current_class, context.written_class, l_feature_name)),
									l_feature_name)
							end
							if not l_feature.is_target_free then
								if not attached {CL_TYPE_A} l_last_type then
										-- Instance-free calls are not supported on formal generic and anchored types.
									error_handler.insert_error (create {VUNO_NOT_CLASS_TYPE}.make (l_last_type, current_feature, context.current_class, context.written_class, a_name))
								elseif l_last_class.is_deferred then
										-- Instance-free calls are not allowed on deferred classes.
									error_handler.insert_error (create {VUNO_DEFERRED}.make (l_last_class, current_feature, context.current_class, context.written_class, a_name))
								end
							end
							if error_level /= l_error_level then
								reset_types
							end
						elseif not l_is_qualified_call and then current_feature.is_class and then not l_feature.is_class then
								-- The error for agents is reported elsewhere.
							if not is_agent then
								w := error_handler.warning_level
								check_instance_free (l_feature, context.current_class,
									if is_precursor then
										agent report_vucr (create {VUCR_BODY}.make_precursor
											(l_feature, current_feature, context.current_class, context.written_class, a_name))
									else
										agent report_vucr (create {VUCR_BODY}.make_feature
											(l_feature, current_feature, context.current_class, context.written_class, a_name))
									end,
									l_feature_name)
								if error_level = l_error_level then
									has_vucr := w /= error_handler.warning_level
								else
									reset_types
								end
							end
						end
						if attached old_assigner_source then
								-- Check if the assigner query is obsolete.
							check_obsolescence (l_feature, l_last_class, a_name)
								-- Transform a query into an assigner command call if necessary.
							process_assigner_command (l_last_type, l_last_constrained, l_feature)
							if not attached last_assigner_command as target_assigner then
									-- No assigner command is found.
								create vbac2
								context.init_error (vbac2)
								if attached a_name then
									vbac2.set_location (a_name.start_location)
								end
								error_handler.insert_error (vbac2)
							else
									-- Replace an assigner instruction with a call to an assigner command.
								l_feature := target_assigner
							end
							if error_level = l_error_level then
									-- Put source expression of the assigner instruction as a first actual argument.
								if attached l_parameters then
									create l_parameters.make_from_iterable (l_parameters)
								else
									create l_parameters.make (1)
								end
								l_parameters.put_front (old_assigner_source)
								l_actual_count := l_actual_count + 1
								if attached l_arg_types then
										-- Query arguments have been processed, process the assigner command argument now.
									reset_for_unqualified_call_checking
									old_assigner_source.process (Current)
									if attached last_type as t then
										l_arg_types.put_front (t)
									end
									if attached l_arg_nodes and then attached {EXPR_B} last_byte_node as e then
										l_arg_nodes.put_front (e)
									end
								end
							end
						end
						if error_level = l_error_level then
							if is_static and then not l_feature.is_class then
									-- The instance-free call is OK, but the called feature is not instance-free.
								error_handler.insert_warning (create {VUNO_NOT_INSTANCE_FREE}.make (l_feature, current_feature, context.current_class, context.written_class, l_feature_name), context.current_class.lace_class.options.is_warning_as_error)
							elseif
								not has_vucr and then
								not l_is_qualified_call and then
								current_feature.is_class and then
								not l_feature.is_class and then
								not is_agent
							then
									-- The unqualified call is OK, but the called feature is not instance-free.
								error_handler.insert_warning
									(if is_precursor then
										create {VUCR_BODY_WARNING}.make_precursor (l_feature, current_feature, context.current_class, context.written_class, a_name)
									else
										create {VUCR_BODY_WARNING}.make_feature (l_feature, current_feature, context.current_class, context.written_class, a_name)
									end,
									l_context_current_class.lace_class.options.is_warning_as_error)
							end
							if not system.il_generation then
								if l_feature.is_inline_agent then
									l_seed := l_feature
								else
									l_seed := system.seed_of_routine_id (l_feature.rout_id_set.first)
								end
							end
								-- Attachments type check
							l_formal_count := l_feature.argument_count
							if is_agent and l_actual_count = 0 and l_formal_count > 0 then
									-- Delayed call with all arguments open.
									-- Create l_parameters.
								from
									create l_parameters.make (l_formal_count)
									i := 0
								until
									i = l_formal_count
								loop
									l_parameters.extend (create {OPERAND_AS}.initialize (Void, Void))
									i := i + 1
								end
								l_actual_count := l_formal_count
								l_parameters.start
							end
							if
								l_actual_count /= l_formal_count and then
								not is_agent and then
								not l_is_in_assignment and then
								l_formal_count > 0
							then
								tuple_argument_number := tuple_argument_index (l_feature.arguments, l_last_type.as_implicitly_detachable.as_variant_free, l_last_constrained.as_implicitly_detachable.as_variant_free, l_last_id)
								if tuple_argument_number > 0 then
										-- The list of actual arguments may be adapted to the list of formal arguments.
									if l_actual_count > l_formal_count then
											-- Additional actual arguments may be converted to a TUPLE.
										create l_wrapped_actuals.make (l_actual_count - l_formal_count + 1)
										from
											l_parameters.go_i_th (tuple_argument_number)
										until
											l_wrapped_actuals.count = l_actual_count - l_formal_count + 1
										loop
											l_wrapped_actuals.extend (l_parameters.item)
											l_parameters.forth
										end
											-- Avoid changing original list of arguments.
										create l_parameters.make_from_iterable (l_parameters)
											-- Replace extra arguments with a tuple.
										l_parameters.put_i_th (create {TUPLE_AS}.initialize (l_wrapped_actuals, Void, Void), tuple_argument_number)
											-- Remove extra arguments.
										from
											l_parameters.go_i_th (tuple_argument_number)
										until
											l_actual_count = l_formal_count
										loop
											l_parameters.remove_right
												-- Adjust number of actual arguments.
											l_actual_count := l_actual_count - 1
										variant
											actual_count_formal_count_difference: l_actual_count - l_formal_count
										end
									elseif l_actual_count + 1 = l_formal_count then
											-- Avoid changing original list of arguments.
										if attached l_parameters then
											l_parameters := l_parameters.twin
										else
											create l_parameters.make (1)
										end
											-- Add an empty tuple.
										create l_wrapped_actuals.make (0)
										l_parameters.go_i_th (tuple_argument_number)
										l_parameters.put_left (create {TUPLE_AS}.initialize (l_wrapped_actuals, Void, Void))
											-- Adjust number of actual arguments.
										l_actual_count := l_formal_count
									end
								end
							end
							if l_actual_count /= l_formal_count then
								if not l_is_in_assignment and not l_is_target_of_creation_instruction then
									create l_vuar1
									context.init_error (l_vuar1)
									l_vuar1.set_called_feature (l_feature, l_last_id)
									l_vuar1.set_argument_count (l_actual_count)
									l_vuar1.set_formal_count (l_feature.argument_count)
									l_vuar1.set_location (l_feature_name)
									if l_formal_count = 0 and then is_vuar_delayed then
											-- Record error for future use.
										last_vuar_error := l_vuar1
									else
										error_handler.insert_error (l_vuar1)
									end
								end
							elseif l_parameters /= Void then
								if l_needs_byte_node then
									create l_parameter_list.make (l_actual_count)
								end
								if l_arg_types /= Void then
										-- Parameters have been evaluated, nothing to be done.
										-- Case for overloaded routine call or agent with all open arguments.
								else
										-- Parameters haven't yet evaluated
									from
										i := 1
										create l_arg_types.make (l_actual_count)
										if l_needs_byte_node then
											create l_arg_nodes.make (l_actual_count)
										end
									until
										i > l_actual_count
									loop
											-- Get formal argument type.
										l_formal_arg_type := l_feature.arguments.i_th (i)

										reset_for_unqualified_call_checking
										current_target_type :=
											l_formal_arg_type.instantiation_in (l_last_type.as_implicitly_detachable.as_variant_free, l_last_id).actual_type
										l_parameters.i_th (i).process (Current)
										if attached last_type and then attached l_arg_types then
											l_arg_types.extend (last_type)
											if l_needs_byte_node then
												l_expr ?= last_byte_node
												l_arg_nodes.extend (l_expr)
											end
										else
												-- An error occurred, we reset `l_arg_types'.
											l_arg_types := Void
										end
										i := i + 1
									end
								end

								if error_level = l_error_level then
										-- Conformance checking of arguments.
									from
										i := 1
									until
										i > l_actual_count
									loop
											-- Report type compatibility issues if any.
										if attached argument_compatibility_error (a_type, l_last_constrained, l_arg_types [i], i, l_arg_types, l_feature, Void, l_parameters [i].start_location) as e then
												-- Actual and formal types of the argument at position `i' are not compatible.
											if
												tuple_argument_number = 0 and then
												tuple_argument_index (l_feature.arguments, l_last_type.as_implicitly_detachable.as_variant_free, l_last_constrained.as_implicitly_detachable.as_variant_free, l_last_id) = i
											then
													-- No actual arguments are wrapped to match a formal tuple argument
													-- and there is a formal tuple argument at position `i'.
													-- Try to wrap the actual argument into a tuple.
												l_arg_type := l_arg_types [i]
												reset_for_unqualified_call_checking
												create l_wrapped_actuals.make (1)
												l_wrapped_actuals.extend (l_parameters [i])
												current_target_type := l_formal_arg_type.instantiation_in (l_last_type.as_implicitly_detachable.as_variant_free, l_last_id).actual_type
												;(create {TUPLE_AS}.initialize (l_wrapped_actuals, Void, Void)).process (Current)
												l_arg_types.put_i_th (last_type, i)
													-- Check if now actual and formal types of the tuple argument are compatible.
												if attached argument_compatibility_error (a_type, l_last_constrained, l_arg_types [i], i, l_arg_types, l_feature, Void, l_parameters [i].start_location) then
														-- Revert changes back.
													l_arg_types.put_i_th (l_arg_type, i)
														-- Report an original error.
													error_handler.insert_error (e)
												elseif l_needs_byte_node and then attached {EXPR_B} last_byte_node as b then
														-- Keep changes, update byte nodes.
													l_arg_nodes.put_i_th (b, i)
												end
											else
													-- There is no tuple argument that may be involved in argument wrapping.
													-- Report an original error.
												error_handler.insert_error (e)
											end
										end

											-- Get actual argument type.
										l_arg_type := l_arg_types [i]

											-- Get formal argument type.
										l_formal_arg_type := l_feature.arguments [i]

											-- Actual formal type of feature argument.
										l_formal_arg_type := l_formal_arg_type.recomputed_in (l_last_type.as_implicitly_detachable.as_variant_free, l_context_current_class.class_id, l_last_constrained.as_implicitly_detachable.as_variant_free, l_last_id).actual_type

											-- check if `l_formal_arg_type' involves some generics whose actuals
											-- are marked `variant'. Only do this when `is_inherited' is false, since
											-- all descendants are checked in `check_cat_call'.
										if
											not is_inherited and then is_qualified and then
											not l_last_type.is_like_current and then
											context.current_class.is_catcall_detection_enabled and then
											l_formal_arg_type.is_variant
										then
											if l_tcat = Void then
												create l_tcat.make (l_feature_name)
												context.init_error (l_tcat)
												l_tcat.set_called_feature (l_feature)
												system.update_statistics (l_tcat)
												error_handler.insert_error (l_tcat)
											end
											l_tcat.add_covariant_generic_violation
										end

										l_warning_level := error_handler.warning_level
										if not l_formal_arg_type.backward_conform_to (l_context_current_class, l_arg_type) then
											if
												not is_inherited and then
												l_arg_type.convert_to (l_context_current_class, l_formal_arg_type.deep_actual_type)
											then
												l_conv_info := context.last_conversion_info
												if l_conv_info.has_depend_unit then
													context.supplier_ids.extend (l_conv_info.depend_unit)
												end
												l_argument := converted_expression (l_parameters [i], l_conv_info)
												l_parameters [i] := l_argument
												if attached old_assigner_source and then i = 1 then
														-- Make sure the source of the assigner instruction is updated.
													assigner_source := l_argument
												end
													-- Generate conversion byte node only if we are not checking
													-- a custom attribute. Indeed in that case, we do not want those
													-- conversion routines, we will use the attachment type to figure
													-- out how the custom attribute will be generated.
												if l_needs_byte_node and not is_checking_cas then
													l_expr ?= l_arg_nodes.i_th (i)
													l_arg_nodes.put_i_th (l_conv_info.byte_node (l_expr), i)
												end
													-- Update `l_arg_types' with the converted type.
													-- This fixes eweasel test#freez022.
												l_arg_types.put_i_th (l_formal_arg_type, i)
											end
										elseif l_warning_level /= error_handler.warning_level then
											error_handler.warning_list.last.set_location (l_parameters.i_th (i).start_location)
										end
										if l_needs_byte_node then
											create l_parameter
											l_expr ?= l_arg_nodes.i_th (i)
											l_parameter.set_expression (l_expr)
												-- Partial solution to the case of using Precursor in an expanded
												-- class where some of the arguments are not expanded in the parent
												-- class but are now in the current class (a typical example is
												-- `prefix "not": like Current' defined in BOOLEAN_REF which is kept
												-- as is in BOOLEAN). We need to remember that the original type
												-- were not expanded otherwise we do not perform a proper code
												-- generation.
												-- This fix is incomplete since it does not take care of types
												-- that are redefined as expanded.
											if a_precursor_type /= Void and l_last_class.is_expanded then
												l_parameter.set_attachment_type (l_formal_arg_type.instantiation_in (a_precursor_type.as_implicitly_detachable.as_variant_free, a_precursor_type.base_class.class_id))
											else
												l_parameter.set_attachment_type (l_formal_arg_type)
												if not system.il_generation then
														-- It is pretty important that we use `actual_type.is_formal' and not
														-- just `is_formal' because otherwise if you have `like x' and `x: G'
														-- then we would fail to detect that.
													l_parameter.set_is_formal (l_seed.arguments.i_th (i).actual_type.is_formal)
												end
											end
											l_parameter_list.extend (l_parameter)

											if is_checking_cas then
												fixme ("[
													Validity checking should not be done when byte code generation
													is required. But unfortunately we need the compiled version to get
													information about the parameters.
													]")
												if not l_expr.is_constant_expression then
													create l_vica2.make (l_context_current_class, current_feature)
													l_vica2.set_location (l_parameters.i_th (i).start_location)
													error_handler.insert_error (l_vica2)
												end
											end
										end
										i := i + 1
									end
								end
									-- Reset VUAR error (if any).
								last_vuar_error := Void


								if context.current_class.lace_class.is_catcall_conformance and then agent_call_routine_ids.has (l_feature.rout_id_set.first) then
										-- This is an agent call with catcall avoidance enabled. We will verify that none of TUPLE
										-- actual generic argument are variant.
									check_agent_call_validity (l_feature, l_last_type, l_parameters, l_arg_types)
								end
							end

								-- Reset original name because it was polluted by the argument checking
							last_original_feature_name_id := l_last_original_feature_name_id
							check
								last_original_feature_name_correct: a_name /= Void implies (last_original_feature_name = a_name.name)
							end

								-- Get the type of Current feature.
							l_result_type := l_feature.type
							l_result_type := l_result_type.recomputed_in
								(l_last_type.as_implicitly_detachable.as_variant_free,
								l_context_current_class.class_id,
								l_last_constrained.as_implicitly_detachable.as_variant_free,
								l_last_id)
								-- Adapted type in case it is a formal generic parameter or a like.
							if l_arg_types /= Void then
								l_pure_result_type := l_result_type
								l_result_type := l_result_type.actual_argument_type (l_arg_types)
								if l_pure_result_type.is_like_argument and then is_byte_node_enabled then
										-- Ensure the expandedness status of the result type matches
										-- the expandedness status of the argument it is anchored to (if any).
									l_like_argument ?= l_pure_result_type
									check
										l_like_argument_attached: l_like_argument /= Void
									end
									i := l_like_argument.position
									if
										l_feature.arguments.i_th (i).actual_type.is_reference and then
										l_result_type.is_expanded and then
										attached {CL_TYPE_A} l_result_type as l_cl_type_a
									then
										l_generated_result_type := l_cl_type_a.reference_type
									end
								end
							end
								-- Export validity
							if
								not context.is_ignoring_export and is_qualified and
								not l_feature.is_exported_for (l_context_current_class)
							then
								create l_vuex
								context.init_error (l_vuex)
								l_vuex.set_static_class (l_last_class)
								l_vuex.set_exported_feature (l_feature)
								l_vuex.set_location (l_feature_name)
								error_handler.insert_error (l_vuex)
							end
							check_obsolescence (l_feature, l_last_class, a_name)
							if
								not System.do_not_check_vape and then is_checking_precondition and then
								not l_is_in_creation_expression and then
								not current_feature.export_status.is_subset (l_feature.export_status)
							then
									-- In precondition and checking for vape
								create l_vape
								context.init_error (l_vape)
								l_vape.set_exported_feature (l_feature)
								l_vape.set_location (l_feature_name)
								error_handler.insert_error (l_vape)
							end

								-- Supplier dependances update only for non-inherited code.
							if not is_inherited then
								context.supplier_ids.extend_depend_unit_with_level
									(l_last_id,
									l_feature,
									depend_unit_level |
									if l_is_target_of_creation_instruction then {DEPEND_UNIT}.is_in_creation_flag else {NATURAL_16} 0 end |
									if
										is_precursor or else
										is_static and then attached {CL_TYPE_A} l_last_type or else
										is_agent and then l_feature.is_inline_agent
									then
										{DEPEND_UNIT}.is_uniform_flag
									else
										{NATURAL_16} 0
									end)
							end
							if
								not l_is_target_of_creation_instruction and then
								not is_qualified and then
								l_feature.is_replicated_directly and then
								not l_feature.from_non_conforming_parent and then
									-- We are unqualified-calling an inherited conforming feature that is replicated in the current class.
									-- Therefore the calling feature must also be replicated in the current class.
								not current_feature.is_replicated_directly and then
								current_feature.written_class /= System.current_class
							then
									-- Invalid call to replicated feature, raise VMCS.
								Error_handler.insert_warning (create {REPLICATED_FEATURE_CALL_WARNING}.make (System.current_class, current_feature, l_feature), context.current_class.lace_class.options.is_warning_as_error)
							end

								-- Check if cat-call detection only for qualified calls and if enabled for current context class and
								-- if no error occurred during the normal checking and only for non-inherited feature, since the
								-- type checking has already been done in the class where it was written.
							if
								error_level = l_error_level and then l_tcat = Void and then not is_inherited and then
								is_qualified and then context.current_class.is_catcall_detection_enabled and then
									-- Feature without arguments don't need to be checked.
									-- Inline agents have no descendants, so they don't need to be checked anyway
									-- Static calls don't need to be checked since they can't have a descendant either
								l_feature.argument_count > 0 and then not l_feature.is_inline_agent and not is_static
							then
									-- Cat call detection is enabled: Test if this feature call is valid
									-- in all subtypes of the current class.
								check_cat_call (l_last_type, l_feature, l_arg_types, l_feature_name, l_parameters)
							end

							set_type
								(if l_is_qualified_call then
										-- We need to use deep_actual_type because we cannot carry
										-- the anchors from the result type which do not make sense in
										-- the current context.
										-- TODO: Remove this branch when anchored types are properly adapted to the current context.
									l_result_type.deep_actual_type
								else
	  								l_result_type
								end,
								a_name)
							last_calls_target_type := l_last_constrained
							if l_feature.is_attribute then
								last_access_writable := True
								if not is_qualified and then current_feature.is_class and then not l_feature.is_class then
									report_vucr (create {VUCR_BODY}.make_attribute (l_feature, current_feature, context.current_class, context.written_class, a_name))
								end
							else
								last_access_writable := False
							end
								-- Use feature name and routine IDs before any transformation.
								-- (E.g., before replacing an assigner query with an assigner command.)
							last_feature_name_id := l_found_feature.feature_name_id
							check
								last_feature_name_correct: last_feature_name = l_found_feature.feature_name
							end
							last_routine_id_set := l_found_feature.rout_id_set
							if not is_qualified and then last_access_writable and then l_feature.is_stable then
								if l_is_in_assignment or else l_is_target_of_creation_instruction then
										-- The attribute might change its attachment status.
										-- It is recorded for future checks because
										-- it might be still unsafe to use the attribute in the expression
										-- before actual reattachment takes place.
									last_reinitialized_variable := - l_feature.feature_name_id
									last_assignment_target := l_feature
								elseif context.is_attribute_attached (l_feature.feature_name_id) then
										-- Attribute may be of a detachable type, but it's safe to use it as an attached one.
									l_result_type := l_result_type.as_attached_in (context.current_class)
									set_type (l_result_type, a_name)
								end
							end

								-- Restore previous value of `is_controlled'.
							is_controlled := l_is_controlled
							if is_qualified and then attached last_type then
									-- Adapt separateness and controlled status of the result to target type.
								adapt_type_to_target (last_type, a_type, l_feature, l_is_controlled, a_name, l_error_level, l_feature_name)
							end

							if l_needs_byte_node then
								if l_generated_result_type = Void then
									l_generated_result_type := last_type
								end
								if is_static then
									l_access := l_feature.access_for_feature (l_generated_result_type, a_type, is_qualified, a_type.is_separate, True)
									if l_is_multiple_constraint_case then
										check not l_last_constrained.is_formal end
										l_access.set_multi_constraint_static (l_last_constrained)
									end
								elseif is_precursor then
									l_cl_type_i ?= a_precursor_type
									l_access := l_feature.access_for_feature (l_generated_result_type, l_cl_type_i, False, False, False)
										-- Strange situation where Precursor is an external, then we do as if
										-- it was a static call.
								else
									if l_is_multiple_constraint_case then
										check not l_last_constrained.is_formal end
										l_access := l_feature.access_for_multi_constraint (l_generated_result_type, l_last_constrained, is_qualified, a_type.is_separate)
									else
										l_access := l_feature.access (l_generated_result_type, is_qualified, a_type.is_separate)
									end
									if l_is_in_assignment or else l_is_target_of_creation_instruction then
										l_access.set_is_attachment
									end
								end
								l_access.set_parameters (l_parameter_list)
								last_byte_node := l_access
							end
						end
					end
						-- Finally update current to reflect if current call is a tuple
						-- access or not.
					is_last_access_tuple_access := l_is_last_access_tuple_access
					if l_is_last_access_tuple_access then
							-- Properly update current to show we have just accessed a tuple.
						last_access_writable := True
						last_routine_id_set := Void
					end
				end
			end
			if attached l_feature and then not l_feature.has_return_value and then l_feature.is_failing then
					-- This is a procedure that fails, so the code after it is unreachable.
					-- The cases of unreachable queries are not handled yet.
				debug ("to_implement")
					to_implement ("Detect unreachable code after failing queries.")
				end
				context.set_all
			end
		ensure
			last_calls_target_type_proper_set: (error_level = old error_level and not is_last_access_tuple_access and last_type.is_known) implies last_calls_target_type /= Void
		end

	tuple_argument_index (arguments: FEAT_ARG; target_type: TYPE_A; base_type: TYPE_A; base_class_id: INTEGER): INTEGER
			-- Index of an argument of a tuple type or 0 if there is none or several such arguments.
		local
			i: INTEGER
			context_current_class_id: INTEGER
		do
			context_current_class_id := context.current_class.class_id
			from
				i := arguments.count
			until
				i <= 0
			loop
				if arguments.i_th (i).recomputed_in (target_type, context_current_class_id, base_type, base_class_id).actual_type.is_tuple then
					if Result = 0 then
							-- One tuple argument is found.
						Result := i
					else
							-- There is more than one tuple argument.
						Result := 0
							-- Exit loop.
						i := 1
					end
				end
				i := i - 1
			variant
				countdown: i
			end
		end

feature {NONE} -- Type checks

	argument_compatibility_error (target_type: TYPE_A; target_base_type: TYPE_A; expression_type: TYPE_A; argument_number: INTEGER; actual_types: ARRAYED_LIST [TYPE_A]; callee: detachable FEATURE_I; name: detachable ID_AS; location: LOCATION_AS): detachable ERROR
			-- Error describing validity violation in case actual an argument type `a' is not compatible with a formal argument type `f'.
		require
			feature_or_tuple_attached: attached callee or attached name
		local
			actual_target_type: TYPE_A
			current_class: CLASS_C
			formal_type: TYPE_A
			like_argument_type: TYPE_A
			target_base_class: CLASS_C
			target_base_class_id: INTEGER
			warning_level: like {ERROR_HANDLER}.warning_level
		do
			actual_target_type := target_type.actual_type
			target_base_class := target_base_type.base_class
			target_base_class_id := target_base_class.class_id
			current_class := context.current_class
			if attached callee then
					-- Regular feature calll.
				formal_type := callee.arguments [argument_number]
					-- Adapt formal type of a feature argument.
				formal_type := formal_type.recomputed_in (actual_target_type.as_implicitly_detachable.as_variant_free, current_class.class_id, target_base_type.as_implicitly_detachable.as_variant_free, target_base_class_id).actual_type
			else
					-- Tuple access.
				formal_type := actual_types [argument_number]
			end

			if formal_type.is_like_argument then
				like_argument_type := formal_type.instantiation_in
					(actual_target_type.as_implicitly_detachable.as_variant_free, target_base_class_id).actual_argument_type
					(actual_types).actual_type
					-- Check that `expression_type' is compatible to its `like argument'.
					-- Once this is done, then type checking is done on the real
					-- type of the routine, not the anchor.
				warning_level := error_handler.warning_level
				if
					not expression_type.conform_to (current_class, like_argument_type) and then
					(is_inherited or else not expression_type.convert_to (current_class, like_argument_type.deep_actual_type))
				then
					create {VUAR2} Result.make (context, callee, name, target_base_class, argument_number, like_argument_type, expression_type, location)
				end
				if warning_level /= error_handler.warning_level then
					error_handler.warning_list.last.set_location (location)
				end
			elseif system.is_scoop and then target_type.is_separate and then expression_type.is_reference and then not formal_type.is_separate then
				create {VUAR3} Result.make (context, callee, name, target_base_class, argument_number, formal_type, expression_type, location)
			elseif system.is_scoop and then expression_type.is_expanded and then not expression_type.is_processor_attachable_to (target_type) then
				create {VUAR4} Result.make (context, callee, name, target_base_class, argument_number, formal_type, expression_type, location)
			end

			warning_level := error_handler.warning_level
			if not formal_type.backward_conform_to (current_class, expression_type) then
				if
					not is_inherited and then
					expression_type.convert_to (current_class, formal_type.deep_actual_type)
				then
				elseif
					expression_type.is_expanded and then formal_type.is_external and then
					expression_type.is_conformant_to (current_class, formal_type)
				then
				else
					create {VUAR2} Result.make (context, callee, name, target_base_class, argument_number, formal_type, expression_type, location)
				end
			elseif not is_frozen_type_compatible (expression_type, formal_type, False) then
				create {VUAR2} Result.make (context, callee, name, target_base_class, argument_number, formal_type, expression_type, location)
			elseif warning_level /= error_handler.warning_level then
				error_handler.warning_list.last.set_location (location)
			end
		end

feature {NONE} -- Visitor

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
		do
			-- Nothing to be done
		end

	process_unique_as (l_as: UNIQUE_AS)
		do
			-- Nothing to be done
		end

	process_tuple_as (l_as: TUPLE_AS)
		local
			l_tuple_type: TUPLE_TYPE_A
			l_list: BYTE_LIST [EXPR_B]
			l_error_level: NATURAL_32
			old_expressions_type: like last_expressions_type
		do
			old_expressions_type := last_expressions_type
			reset_for_unqualified_call_checking

				-- Type check expression list
			l_error_level := error_level
			process_expressions_list_for_tuple (l_as.expressions)
			if error_level = l_error_level then
					-- Update type stack
				create l_tuple_type.make (system.tuple_id, last_expressions_type)
				l_tuple_type.set_frozen_mark
					-- Type of tuple is always attached
				l_tuple_type := l_tuple_type.as_attached_in (context.current_class)
				if across last_expressions_type as e all e.item.is_known end then
					instantiator.dispatch (l_tuple_type, context.current_class)
				end
				last_tuple_type := l_tuple_type
				set_type (l_tuple_type, l_as)
				if not {SYSTEM_I}.is_tuple_class_alive and then not is_inherited then
					record_creation_dependence (l_tuple_type)
				end
				if is_byte_node_enabled then
					l_list ?= last_byte_node
					create {TUPLE_CONST_B} last_byte_node.make (l_list, l_tuple_type, l_tuple_type.create_info)
				end
			else
				reset_types
			end
			last_expressions_type := old_expressions_type
		ensure then
			last_tuple_type_set_if_no_error:
				error_level /= old error_level or else
				not last_type.is_known or else
				last_tuple_type /= Void
		end

	process_real_as (l_as: REAL_AS)
		do
			if l_as.constant_type = Void then
				set_type (manifest_real_64_type, l_as)
			else
				fixme ("We should check that `constant_type' matches the real `value' and%
					%possibly remove `constant_type' from REAL_AS.")
				check_type (l_as.constant_type)
				if attached {REAL_A} last_type as l_real then
					if l_real.size = 32 then
						set_type (manifest_real_32_type, l_as)
					else
						set_type (manifest_real_64_type, l_as)
					end
				end
			end
			if attached last_type as t then
				if not {SYSTEM_I}.is_basic_class_alive and then not is_inherited then
					record_creation_dependence (t)
				end
				if is_byte_node_enabled then
					create {REAL_CONST_B} last_byte_node.make (l_as.value, t)
				end
			end
		end

	process_bool_as (l_as: BOOL_AS)
		do
			set_type (Boolean_type, l_as)
			if not {SYSTEM_I}.is_basic_class_alive and then not is_inherited then
				record_creation_dependence (boolean_type)
			end
			if is_byte_node_enabled then
				create {BOOL_CONST_B} last_byte_node.make (l_as.value)
			end
		end

	process_array_as (l_as: COMPILER_ARRAY_AS)
		local
			i, nb: INTEGER
			l_array_type: GEN_TYPE_A
			l_generics: ARRAYED_LIST [TYPE_A]
			l_type_a, l_element_type: TYPE_A
			l_list: BYTE_LIST [EXPR_B]
			l_last_types: like last_expressions_type
			l_has_error: BOOLEAN
			l_current_class: CLASS_C
			l_context: like context
			explicit_type: TYPE_A
			implicit_type: GEN_TYPE_A
			default_element_type: TYPE_A
			default_array_type: GEN_TYPE_A
			old_expressions_type: like last_expressions_type
		do
			l_context := context
			l_current_class := l_context.current_class
			reset_for_unqualified_call_checking
				-- Check explicit array type (if specified).
			if attached l_as.type as type_declaration then
				check_type (type_declaration)
				if not attached last_type as t then
					l_has_error := True
				elseif not attached t.conformance_type.base_class as b then
						-- Error: there is no fixed class type.
					error_handler.insert_error (create {VWMA_NO_CLASS_TYPE}.make (context, t, type_declaration.first_token (match_list_of_class (context.written_class.class_id))))
					l_has_error := True
				elseif
					attached {GEN_TYPE_A} t.conformance_type as g implies
					g.class_id /= system.array_id and then
					(is_checking_cas implies g.class_id /= system.native_array_id)
				then
						-- Error: the specified type is not an ARRAY class type.
					error_handler.insert_error (create {VWMA_NOT_ARRAY}.make (context, t, type_declaration.first_token (match_list_of_class (context.written_class.class_id))))
					l_has_error := True
				elseif t.is_separate then
						-- Error: the specified ARRAY type is separate.
					error_handler.insert_error (create {VWMA_SEPARATE_ARRAY}.make (context, t, type_declaration.first_token (match_list_of_class (context.written_class.class_id))))
					l_has_error := True
				else
					explicit_type := t
					current_target_type := t
					implicit_type := g
					l_type_a := implicit_type.generics.first.actual_type
				end
			elseif
					-- Look at the target type to see if it can be used to compute target type.
				attached current_target_type as t and then
				attached {GEN_TYPE_A} t.conformance_type as g and then
					-- Check that it is either an ARRAY, or a NATIVE_ARRAY when used
					-- in a custom attribute.
				(g.base_class.class_id = system.array_id or else
				is_checking_cas and then g.base_class.class_id = system.native_array_id)
			then
				implicit_type := g
				l_type_a := implicit_type.generics.first.actual_type
			end
			if not l_has_error then
					-- Type check expression list.
					-- Use element type (if any) as a target type.
				current_target_type := l_type_a
				old_expressions_type := last_expressions_type
				process_expressions_list (l_as.expressions)
				l_last_types := last_expressions_type
				last_expressions_type := old_expressions_type
			end

			if attached l_last_types then
				if is_byte_node_enabled then
					l_list := {BYTE_LIST [EXPR_B]} / last_byte_node
				end

				if not attached explicit_type then
						-- There is no explicit manifest array type.
						-- Compute the type from the common type for all elements.
					default_element_type := maximal_type (l_last_types)
					create l_generics.make (1)
					l_generics.extend (default_element_type)
						-- Type of a manifest array is always attached.
					default_array_type := (create {GEN_TYPE_A}.make (system.array_id, l_generics)).as_normally_attached (l_current_class)
						-- Type of a manifest array is always frozen.
					default_array_type.set_frozen_mark
				end

				if attached l_type_a then
						-- There is either an explicit array type or a target type of the array reattachment.
					check
						attached_implicit_type_from_code: attached implicit_type
					end
					if
						attached default_element_type implies
						not default_element_type.conform_to (context.current_class, l_type_a)
					then
							-- Either an explicit array type is specified or the computed array type is not useable for all elements.
							-- Check conformance and conversion rules for the explicit array type or for the target type.
						if attached default_element_type then
								-- The implicit type is required to compute array type, it should be replaced with an explicit one.
							if context.current_class.lace_class.is_manifest_array_type_mismatch_warning then
									-- Report a warning.
								error_handler.insert_warning (create {VWMA_EXPLICIT_TYPE_REQUIRED_FOR_CONFORMANCE}.make (context, default_element_type, l_type_a, l_as, False), context.current_class.lace_class.options.is_warning_as_error)
							elseif context.current_class.lace_class.is_manifest_array_type_mismatch_error then
									-- Report an error.
								error_handler.insert_error (create {VWMA_EXPLICIT_TYPE_REQUIRED_FOR_CONFORMANCE}.make (context, default_element_type, l_type_a, l_as, True))
							end
						end
							-- Check that expressions' type matches element's type of the array.
						from
							nb := l_as.expressions.count
							i := 1
						until
							i > nb
						loop
							l_element_type := l_last_types [i]
							if not l_type_a.backward_conform_to (l_current_class, l_element_type) then
								if not is_inherited and then l_element_type.convert_to (l_current_class, l_type_a.deep_actual_type) then
									if l_context.last_conversion_info.has_depend_unit then
										context.supplier_ids.extend (l_context.last_conversion_info.depend_unit)
									end
									l_as.expressions [i] := converted_expression (l_as.expressions [i], l_context.last_conversion_info)
									if attached l_list and not is_checking_cas then
										l_list [i] := l_context.last_conversion_info.byte_node (l_list [i])
									end
								else
									if attached default_element_type then
											-- There is no explicit array type and the computed array type is not compatible with the target array type.
											-- Use the default (computed) array type.
											-- Note: the byte code for some elements might be changed due to conversion, but it is safe to leave it "as is" because an error will be reported for the incompatible types.
										l_type_a := default_element_type
										implicit_type := default_array_type
									else
											-- Report an error only for the explicit type.
											-- For the implicit type the error has been reported above or will be reported where the array is used.
										error_handler.insert_error (create {VWMA_INCOMPATIBLE_EXPRESSION}.make (context, l_element_type, l_type_a, i, l_as.expressions [i].first_token (match_list_of_class (context.written_class.class_id))))
										l_has_error := True
									end
										-- Exit the loop
									i := nb + 1
								end
							end
							i := i + 1
						end
					else
							-- There is no explicit array type and the computed array type conforms to the target array type.
						if
							not is_inherited and then
							not context.current_class.lace_class.is_manifest_array_type_standard and then
							attached default_element_type and then
							not l_type_a.conform_to (context.current_class, default_element_type)
						then
								-- The source type is different from the target one.
							if context.current_class.lace_class.is_manifest_array_type_mismatch_error then
									-- Report an error.
								error_handler.insert_error (create {VWMA_EXPLICIT_TYPE_REQUIRED_FOR_MATCH}.make (context, default_element_type, l_type_a, l_as, True))
							else
									-- Report a warning.
								error_handler.insert_warning (create {VWMA_EXPLICIT_TYPE_REQUIRED_FOR_MATCH}.make (context, default_element_type, l_type_a, l_as, False), context.current_class.lace_class.options.is_warning_as_error)
							end
						end
							-- Use the default (computed) array type.
						l_type_a := default_element_type
						implicit_type := default_array_type
					end
					if not l_has_error then
							-- Adjust array type if needed.
						if is_checking_cas and then implicit_type.class_id /= system.native_array_id then
								-- Create a .NET array.
							create l_generics.make (1)
							l_generics.extend (l_type_a)
							create {NATIVE_ARRAY_TYPE_A} l_array_type.make (system.native_array_id, l_generics)
						else
								-- Reuse the target type for the ARRAY type.
							l_array_type := implicit_type
						end
						if is_qualified_call then
								-- When the manifest array appears in a qualified call, the anchors if any should
								-- be resolved in the context of the target of the qualified call and not Current
								-- (See eweasel test#term106 for an example). However the code generation does not
								-- support that, so we remove the anchors.
							l_array_type := l_array_type.deep_actual_type
						end
							-- Type of a manifest array is always attached.
						l_array_type := l_array_type.as_normally_attached (l_current_class)
					end
				else
						-- There is no explicit or implicit array type,  use the default one.
					l_type_a := default_element_type
					l_array_type := default_array_type
				end
				if l_has_error then
					reset_types
				else
					if l_type_a.is_known then
						instantiator.dispatch (l_array_type, l_current_class)
					end
						-- Update type stack.
					set_type (l_array_type, l_as)
					if not {SYSTEM_I}.is_array_class_alive and then not is_inherited then
						record_creation_dependence (l_array_type)
					end
					l_as.set_array_type (last_type)
					if attached l_list then
						create {ARRAY_CONST_B} last_byte_node.make (l_list, l_array_type)
					end
				end
			else
				reset_types
			end
		end

	process_char_as (l_as: CHAR_AS)
		local
			t: TYPE_A
		do
			t := if l_as.value.is_character_8 then character_type else wide_char_type end
			set_type (t, l_as)
			if not {SYSTEM_I}.is_basic_class_alive and then not is_inherited then
				record_creation_dependence (t)
			end
			if is_byte_node_enabled then
				create {CHAR_CONST_B} last_byte_node.make (l_as.value, t)
			end
		end

	adapted_manifest_string_class_c (a_class_id: INTEGER; a_class_i: detachable CLASS_I): detachable CLASS_C
		do
			if
				attached a_class_i and then
				attached a_class_i.compiled_class as c and then
				c.class_id = a_class_id
			then
				Result := c
			end
		ensure
			Result /= Void implies Result.class_id = a_class_id and Result.original_class = a_class_i
		end

	process_string_as (l_as: STRING_AS)
		local
			l_simplified_string_type: TYPE_A
			l_is_string_32: BOOLEAN
			l_value: detachable STRING
			class_id: INTEGER
			s8, s32: detachable CLASS_C
			l_is_immutable: BOOLEAN
		do
			if attached l_as.type as t then
					-- Check explicit manifest string type.
				check_type (t)
				if attached last_type as l_last_type then
					l_simplified_string_type := l_last_type.duplicate
						-- Manifest strings are always frozen.
					l_simplified_string_type.set_frozen_mark
				end
			else
					-- Default to STRING_8, if possible, and to STRING_32 otherwise.
				l_simplified_string_type :=
					if l_as.is_code_point_valid_string_8 then
						manifest_string_8_type
					else
						manifest_string_32_type
					end
			end
			if attached l_simplified_string_type then
					-- Constants are always of an attached type.
				l_simplified_string_type := l_simplified_string_type.as_normally_attached (context.current_class)
				set_type (l_simplified_string_type, l_as)
				if not {SYSTEM_I}.is_string_class_alive and then not is_inherited then
					record_creation_dependence (l_simplified_string_type)
				end
				class_id := l_simplified_string_type.base_class.class_id
				s32 := adapted_manifest_string_class_c (class_id, system.string_32_class)
				if s32 = Void then
					s32 := adapted_manifest_string_class_c (class_id, system.immutable_string_32_class)
					l_is_immutable := s32 /= Void
				end
				if s32 = Void then
					s8 := adapted_manifest_string_class_c (class_id, system.string_8_class)
					if s8 = Void then
						s8 := adapted_manifest_string_class_c (class_id, system.immutable_string_8_class)
						l_is_immutable := s8 /= Void
					end
				end
				if attached s8 then
					check s8.class_id = class_id end
					if l_as.is_code_point_valid_string_8 then
							-- Constant is of type "STRING_8".
						if is_byte_node_enabled then
								-- At code generation we convert UTF-8 into UTF-32.
								-- ISO-8859-1, the default encoding we take as implicit encoding,
								-- is compatible with UTF-32.
							l_value := l_as.value
						end
					else
							-- Invalid Unicode code point for STRING_8.
						error_handler.insert_error (create {VWMQ}.make (l_simplified_string_type, <<
							if attached system.string_32_class as i and then attached i.compiled_class as c then
								c.actual_type
							else
								Void
							end,
							if attached system.immutable_string_32_class as i and then attached i.compiled_class as c then
								c.actual_type
							else
								Void
							end
						>>, context, l_as))
						reset_types
					end
				elseif attached s32 then
					check s32.class_id = class_id end
						-- Constant is of type "STRING_32".
					if is_byte_node_enabled then
							-- For STRING_32 manifest string, UTF-8 value is kept for later transformation.
						l_value := l_as.value
						l_is_string_32 := True
					end
				else
						-- The type is unexpected.
					error_handler.insert_error (create {VWMQ}.make (l_simplified_string_type, <<
							if l_as.is_code_point_valid_string_8 and then attached system.string_8_class as i and then attached i.compiled_class as c then
								c.actual_type
							else
								Void
							end,
							if l_as.is_code_point_valid_string_8 and then attached system.immutable_string_8_class as i and then attached i.compiled_class as c then
								c.actual_type
							else
								Void
							end,
							if attached system.string_32_class as i and then attached i.compiled_class as c then
								c.actual_type
							else
								Void
							end,
							if attached system.immutable_string_32_class as i and then attached i.compiled_class as c then
								c.actual_type
							else
								Void
							end
						>>, context, l_as))
					reset_types
				end
				if attached l_value then
					if l_as.is_once_string then
						once_manifest_string_index := once_manifest_string_index + 1
						create {ONCE_STRING_B} last_byte_node.make (l_value, l_is_string_32, l_is_immutable, once_manifest_string_index)
					else
						create {STRING_B} last_byte_node.make (l_value, l_is_string_32, l_is_immutable)
					end
				end
			end
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS)
		do
			process_string_as (l_as)
		end

	process_body_as (l_as: BODY_AS)
		do
			safe_process (l_as.content)
		end

	process_built_in_as (l_as: BUILT_IN_AS)
			-- Process `l_as'.
		local
			l_feature_as: FEATURE_AS
			l_feature_checker: AST_FEATURE_CHECKER_GENERATOR
			old_local_scopes: like context.local_scopes
		do
			if is_byte_node_enabled then
					-- If associated feature is not an external anymore, it means that it was interpreted
					-- by our compiler as a real `built_in'.
				if attached {EXTERNAL_I} current_feature as l_external then
					create {EXT_BYTE_CODE} last_byte_node.make (l_external.external_name_id)
				else
					l_feature_as := l_as.body
					if l_feature_as /= Void and then l_feature_as.body.content /= Void then
							-- Save old local scopes.
						old_local_scopes := context.local_scopes
							-- Only interprets the `built_in' implementation if this is not an attribute.
						create l_feature_checker
						l_feature_checker.init (context)
						l_feature_checker.set_type_recorder (type_recorder)
						l_feature_checker.check_body (current_feature, l_feature_as.body, True, False, False, False)
						last_byte_node := l_feature_checker.last_byte_node
						l_as.set_body (l_feature_as)
							-- Restore local scopes.
						context.set_local_scopes (old_local_scopes)
 					else
 							-- No implementation is provided, let's assume empty body.
						create {STD_BYTE_CODE} last_byte_node
					end
				end
			end
		end

	process_result_as (l_as: RESULT_AS)
		local
			l_feat_type: TYPE_A
			l_vrle3: VRLE3
			l_has_error: BOOLEAN
			l_veen2a: VEEN2A
		do
			reset_byte_node
				-- Error if in procedure or invariant
			l_has_error := is_checking_invariant
			if not l_has_error then
				l_feat_type := current_feature.type
				l_has_error := l_feat_type.actual_type.conform_to (context.current_class, Void_type)
			end

			if l_has_error then
				create l_vrle3
				context.init_error (l_vrle3)
				l_vrle3.set_location (l_as.start_location)
				error_handler.insert_error (l_vrle3)
				reset_types
			else
				if is_checking_precondition then
						-- Result entity in precondition
					create l_veen2a
					context.init_error (l_veen2a)
					l_veen2a.set_location (l_as.start_location)
					error_handler.insert_error (l_veen2a)
					reset_types
				else
						-- Update the type stack
					last_access_writable := True
					if is_byte_node_enabled then
						create {RESULT_B} last_byte_node
					end
					if is_in_assignment or else is_target_of_creation_instruction then
							-- "Result" might change its attachment status.
							-- It is recorded for future checks because
							-- it might be still safe to use it in the expression
							-- before actual reattachment takes place.
						last_reinitialized_variable := result_name_id
							-- Treat result type as detachable, then check that it is attached at the end of a feature.
						l_feat_type := l_feat_type.as_detachable_type
					elseif context.is_result_attached then
							-- "Result" is safe to be used as an attached type.
						l_feat_type := l_feat_type.as_attached_in (context.current_class)
					elseif
						l_feat_type.is_initialization_required and then
						not context.local_initialization.is_result_set and then
						is_void_safe_initialization
					then
							-- Result is not properly initialized.
							-- Treat it as if it is of a detachable type.
							-- The void-safety level should be "initialization" or higher
							-- because otherwise errors may be reported for cases
							-- when local is of an attached type but is uninitialized
							-- and initialization errors are not reported at this level.
							-- (See test#attach120).
						l_feat_type := l_feat_type.as_detachable_type
					end
					set_type (l_feat_type, l_as)
				end
			end
		end

	process_current_as (l_as: CURRENT_AS)
		local
			l_type: LIKE_CURRENT
		do
			if current_feature.is_class then
				report_vucr (create {VUCR_BODY}.make_current (current_feature, context.current_class, context.written_class, l_as))
			end
				-- The type of Current in class X is X .. X.
			l_type := context.current_class_type.duplicate
			l_type.set_frozen_mark
			set_type (l_type, l_as)
			if is_byte_node_enabled then
				create {CURRENT_B} last_byte_node
			end
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS)
		local
			l_type_a, l_last_type, l_feature_type, l_last_feature_type: TYPE_A
			l_formal: FORMAL_A
			l_feature: FEATURE_I
			l_result: LIST [TUPLE [feature_i: FEATURE_I; cl_type: RENAMED_TYPE_A]]
			l_result_item: TUPLE [feature_i: FEATURE_I; cl_type: RENAMED_TYPE_A]
			l_type_a_is_multi_constrained: BOOLEAN
			l_type_set: TYPE_SET_A
			l_vtmc4: VTMC4
			l_error_level: NATURAL_32
			l_is_not_call: BOOLEAN
			l_is_byte_node_enabled: BOOLEAN
		do
			l_is_byte_node_enabled := is_byte_node_enabled
			l_type_a := last_type.actual_type
			if l_type_a.is_formal then
				l_formal ?= l_type_a
				if l_formal.is_multi_constrained (context.current_class) then
					l_type_a_is_multi_constrained := True
				else
					l_type_a := l_formal.constrained_type (context.current_class)
				end
			end

			l_error_level := error_level
			l_last_type := last_type

			if  not l_type_a_is_multi_constrained then
				if not l_type_a.is_none and not l_type_a.is_void and then is_inherited then
					if not l_as.is_tuple_access then
							-- Reuse the feature when it is really one, otherwise when it is a tuple
							-- access the call to `process_call' will do the right thing for
							-- inherited code.
						l_feature := l_type_a.base_class.feature_of_rout_id (l_as.routine_ids.first)
					else
						if attached {TUPLE_TYPE_A} l_last_type.actual_type as l_tuple_type then
							l_is_not_call := True
							is_last_access_tuple_access := True
							assigner_source := Void
							set_type (l_tuple_type.generics.i_th (l_as.label_position), l_as)
						else
							check
								False
							end
						end
					end
				end
			else
					-- Multi constraint case
				if is_inherited then
					l_is_not_call := True
						-- This code here is very similar to some parts of `process_abstract_creation'.
						-- It has the very same issues as described there.
					fixme ("Related to fix me in `process_abstract_creation'")

						-- Note: We do not need to protect against TUPLE access here since
						-- named tuples are not allowed in multiple-constraint.

						-- We need to iterate through the type set to find the routine of ID													
					l_formal ?= l_type_a
					check
							-- It should work as we are in the multi constraint case
						l_formal_not_void: l_formal /= Void
					end
					l_type_set := context.current_class.constraints (l_formal.position)
					l_type_set := l_type_set.constraining_types (context.current_class)
					l_result := l_type_set.feature_i_list_by_rout_id (l_as.routine_ids.first)
					check at_least_one_feature_found: l_result.count > 0 end
							-- As we inherited this feature there's the possiblity that now,
					from
						l_result.start
					until
						l_result.after or l_vtmc4 /= Void
					loop
						l_result_item := l_result.item
						l_feature := l_result_item.feature_i
							-- Restore last_type
						last_calls_target_type :=  l_result_item.cl_type.type
							-- Type check the call
						process_call (l_last_type, Void, l_as.feature_name, l_feature, l_as.parameters,
							False, False, True, False, True)
						l_result.forth
							-- We inherited this feature.
						l_feature_type := last_type
						if 	l_last_feature_type = Void then
							l_last_feature_type := l_feature_type
							is_byte_node_enabled := False
						elseif not l_last_feature_type.same_as (l_feature_type) then
								-- The two features have redefined their return type differently.
								-- We don't allow this: Add an error, but continue checking as this only an additional
								-- check and does not break anything else.
								-- Note: If `like Current' is the type of the feature this is ok, as the type is adapted to the formal.
							create l_vtmc4
							l_vtmc4.set_class (context.current_class)
							l_vtmc4.set_written_class (system.class_of_id (l_as.class_id))
							l_vtmc4.set_feature (context.current_feature)
							l_vtmc4.set_location (l_as.start_location)
							l_vtmc4.set_feature_info (l_result)
							error_handler.insert_error (l_vtmc4)
						end
						if attached last_vuar_error as e and then attached last_type as t then
							look_for_parenthesis_alias (l_as.internal_parameters, e, t)
							l_feature_type := last_type
						end
					end
						-- We inherited this feature. Adapt it's type.
					l_last_type := l_feature_type
						-- Restore code generation status.
					is_byte_node_enabled := l_is_byte_node_enabled
				end
			end
			if not l_is_not_call then
					-- Type check the call.
				process_call (l_last_type, Void, l_as.feature_name, l_feature, l_as.parameters,
					False, False, True, False, True)
			end

			if error_level = l_error_level then
				if not is_inherited then
						-- set some type attributes of the node
					if last_calls_target_type /= Void then
						l_as.set_class_id (last_calls_target_type.base_class.class_id)
					else
						l_as.set_class_id (-1)
					end
					if not last_type.is_known then
							-- Feature for an unknown type is unknown.
					elseif last_routine_id_set /= Void then
						check
							not_is_tuple_access: not is_last_access_tuple_access
						end
						set_routine_ids (last_routine_id_set, l_as)
					else
						check
							is_tuple_access: is_last_access_tuple_access
						end
						l_as.enable_tuple_access
						if attached {NAMED_TUPLE_TYPE_A} l_last_type.actual_type as l_labeled_tuple then
							l_as.set_label_position (l_labeled_tuple.label_position (l_as.feature_name.name))
						else
							check
								False
							end
						end
					end
				end
				if not l_is_not_call and then attached last_vuar_error as e and then attached last_type as q then
					look_for_parenthesis_alias (l_as.internal_parameters, e, q)
				end
				if attached last_type as t then
					set_type (t, l_as)
				end
			else
				reset_types
			end
		end

	process_access_inv_as (l_as: ACCESS_INV_AS)
		local
			l_class_id: INTEGER
			l_type: TYPE_A
			l_feature: FEATURE_I
			l_error_level: NATURAL_32
		do
			l_type := last_type.actual_type
			check
				not_formal: not l_type.is_formal
			end
			l_class_id := l_type.base_class.class_id
			if attached context.object_test_local (l_as.feature_name.name_id) as i then
				process_object_test_local (i, l_as)
			else
				if is_inherited then
					l_feature := l_type.base_class.feature_of_rout_id (l_as.routine_ids.first)
				end
				l_error_level := error_level
				process_call (last_type, Void, l_as.feature_name, l_feature, l_as.parameters, False, False, False, False, True)
				if error_level = l_error_level and not is_inherited then
						-- set some type attributes of the node
					l_as.set_class_id (l_class_id)
					set_routine_ids (last_routine_id_set, l_as)
				end
				if attached last_vuar_error as e and then attached last_type as t then
						-- Feature without arguments is found, try parenthesis alias on it.
					look_for_parenthesis_alias (l_as.internal_parameters, e, t)
				end
				if attached last_type as t then
						-- Record type of the feature call.
					set_type (t, l_as)
				end
			end
		end

	process_access_id_as (l_as: ACCESS_ID_AS)
		local
			l_arg_pos: INTEGER
			l_last_id: INTEGER
			l_argument: ARGUMENT_B
			l_local_info: LOCAL_INFO
			l_feature: FEATURE_I
			l_has_vuar_error: BOOLEAN
			l_vuar1: VUAR1
			l_veen2b: VEEN2B
			l_needs_byte_node: BOOLEAN
			l_type: TYPE_A
			l_context_current_class: CLASS_C
			l_error_level: NATURAL_32
			is_type_set: BOOLEAN
		do
			l_context_current_class := context.current_class
			l_needs_byte_node := is_byte_node_enabled
				-- No need for `last_type.actual_type' as here `last_type' is equal to
				-- `context.current_class_type' since we start a feature call.
			check not_is_formal: not last_type.is_formal end
			l_last_id := last_type.base_class.class_id
			check  equivalent_ids: l_last_id =  last_type.conformance_type.base_class.class_id end

			l_feature := current_feature
				-- Look for an argument
			if l_feature /= Void then
				if is_inherited then
					if l_as.is_argument then
						l_arg_pos := l_as.argument_position
					end
				else
					l_arg_pos := l_feature.argument_position (l_as.feature_name.name_id)
				end
			end
			if l_arg_pos /= 0 then
					-- Found argument
					-- Arguments are controlled.
				is_controlled := True
				l_type := l_feature.arguments.i_th (l_arg_pos)
				l_type := l_type.instantiation_in (last_type.as_implicitly_detachable.as_variant_free, l_last_id)
				l_has_vuar_error := l_as.parameters /= Void
				if l_needs_byte_node then
					create l_argument
					l_argument.set_position (l_arg_pos)
					last_byte_node := l_argument
				end
				if context.is_argument_attached (l_as.feature_name.name_id) then
					l_type := l_type.as_attached_in (l_context_current_class)
				end
					-- Set some type attributes of the node.
				if not is_inherited then
					set_argument_position (l_arg_pos, l_as)
					l_as.set_class_id (class_id_of (l_type))
				end
			else
					-- Look for a local if not in a pre- or postcondition
				if not is_inherited or else l_as.is_local then
					l_local_info := context.locals.item (l_as.feature_name.name_id)
				end
				if l_local_info /= Void then
						-- Local found
					l_local_info.enable_is_used
					last_access_writable := True
					l_has_vuar_error := l_as.parameters /= Void
					l_type := l_local_info.type
					l_type := l_type.instantiation_in (last_type.as_implicitly_detachable.as_variant_free, l_last_id)
					if l_needs_byte_node then
						create {LOCAL_B} last_byte_node.make (l_local_info.position)
					end

					if is_checking_postcondition or else is_checking_precondition then
							-- Local in post- or precondition
							--|Note: this should not happen since
							--|in the context of assertions we would have
							--|ACCESS_ASSERT_AS and not ACCESS_ID_AS objects.
							--|(Fred)
						create l_veen2b
						context.init_error (l_veen2b)
						l_veen2b.set_identifier (l_as.feature_name.name)
						l_veen2b.set_location (l_as.feature_name)
						error_handler.insert_error (l_veen2b)
					elseif is_in_assignment or else is_target_of_creation_instruction then
							-- The local might change its attachment status.
							-- It is recorded for future checks because
							-- it might be still safe to use the local in the expression
							-- before actual reattachment takes place.
						last_reinitialized_variable := l_as.feature_name.name_id
							-- Treat local type as detachable.
						l_type := l_type.as_detachable_type
					elseif context.is_local_attached (l_as.feature_name.name_id) then
							-- Local is safe to be used as of an attached type.
						l_type := l_type.as_attached_in (context.current_class)
					elseif
						l_type.is_initialization_required and then
						not context.local_initialization.is_local_set (l_local_info.position) and then
						is_void_safe_initialization
					then
							-- Treat it as if it is of a detachable type.
							-- The void-safety level should be "initialization" or higher
							-- because otherwise errors may be reported for cases
							-- when local is of an attached type but is uninitialized
							-- and initialization errors are not reported at this level.
							-- (See test#attach120).
						l_type := l_type.as_detachable_type
					end
					if not is_inherited then
							-- set some type attributes of the node
						set_local (l_as)
						l_as.set_class_id (class_id_of (l_type))
					end
				elseif attached context.object_test_local (l_as.feature_name.name_id) as i then
					process_object_test_local (i, l_as)
					is_type_set := True
				else
						-- Look for a feature
					l_feature := Void
					if is_inherited then
						check system.class_of_id (l_last_id) = last_type.base_class end
						l_feature := system.class_of_id (l_last_id).feature_of_rout_id (l_as.routine_ids.first)
					end

					l_error_level := error_level
					process_call (last_type, Void, l_as.feature_name, l_feature, l_as.parameters, False, False, False, False, True)
					l_type := last_type
					if error_level = l_error_level and not is_inherited then
							-- set some type attributes of the node
						l_as.set_class_id (l_last_id)
						set_routine_ids (last_routine_id_set, l_as)
					end
					if attached {VUAR1} last_vuar_error as e and then attached last_type as t then
							-- Feature without arguments is found, try parenthesis alias on it.
						l_vuar1 := e
						l_type := t
						l_has_vuar_error := True
					end
				end
			end
			if l_has_vuar_error then
					-- Record type of the entity without arguments.
				set_type (l_type, l_as.feature_name)
				if not attached l_vuar1 then
					create l_vuar1
					if l_arg_pos = 0 then
						l_vuar1.set_local_name (l_as.feature_name.name)
					else
						l_vuar1.set_arg_name (l_as.feature_name.name)
					end
					context.init_error (l_vuar1)
					l_vuar1.set_location (l_as.feature_name)
				end
				look_for_parenthesis_alias (l_as.internal_parameters, l_vuar1, l_type)
					-- Record type of the call as a whole.
				l_type := last_type
			end
			if not is_type_set then
				set_type (l_type, l_as)
			end
		end

	process_object_test_local (l_local_info: LOCAL_INFO; l_as: ACCESS_INV_AS)
			-- Process object test local identified by `i` in access node `a`
			-- including an optional call to a parenthesis alias and set `last_type` accordingly.
		local
			l_type: TYPE_A
			l_vuar1: VUAR1
			old_is_inherited: BOOLEAN
		do
			if l_local_info.is_cursor then
					-- Process access to the feature `item` on the cursor variable.
					-- Disable expansion of the variable name in recursive calls.
				l_local_info.disable_is_cursor
					-- Process associated expression instead of the variable using routine ID computed earlier to handle renaming properly.
				old_is_inherited := is_inherited
				is_inherited := False
				l_local_info.expression.process (Current)
				is_inherited := old_is_inherited
					-- Restore status of the variable meaning.
				l_local_info.enable_is_cursor
				if not old_is_inherited then
						-- Record type information for analysis tools.
					set_inline_local (l_as)
					if attached last_type as t then
						l_as.set_class_id (class_id_of (t))
					end
				end
			else
				l_local_info.enable_is_used
				last_access_writable := False
				is_controlled := l_local_info.is_controlled
				l_type := l_local_info.type.instantiation_in (last_type.as_implicitly_detachable.as_variant_free, last_type.base_class.class_id)
				if not is_inherited then
					set_inline_local (l_as)
					l_as.set_class_id (class_id_of (l_type))
				end
				if is_byte_node_enabled then
					create {OBJECT_TEST_LOCAL_B} last_byte_node.make (l_local_info.position, current_feature.body_index, l_type)
				end
				if attached l_as.parameters as p then
					create l_vuar1
					context.init_error (l_vuar1)
					l_vuar1.set_local_name (l_as.feature_name.name)
					l_vuar1.set_location (l_as.feature_name)
					look_for_parenthesis_alias (l_as.internal_parameters, l_vuar1, l_type)
					if attached last_type as t then
							-- Record type of the object test local.
						set_type (l_type, l_as.feature_name)
						l_type := t
					end
				end
				set_type (l_type, l_as)
			end
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS)
		local
			l_arg_pos: INTEGER
			l_local_info: LOCAL_INFO
			l_argument: ARGUMENT_B
			l_arg_type: TYPE_A
			l_feature: FEATURE_I
			l_vuar1: VUAR1
			l_veen2b: VEEN2B
			l_last_id: INTEGER
			l_error_level: NATURAL_32
		do
			-- No need for `last_type.actual_type' as here `last_type' is equal to
			-- `context.current_class_type' since we start a feature call.
			check not_is_formal: not last_type.is_formal end
			l_last_id := last_type.base_class.class_id
			check  equivalent_ids: l_last_id =  last_type.base_class.class_id end

			l_feature := current_feature
				-- Look for an argument
			if is_inherited then
				if l_as.is_argument then
					l_arg_pos := l_as.argument_position
				end
			else
				l_arg_pos := l_feature.argument_position (l_as.feature_name.name_id)
			end

			l_error_level := error_level
			if l_arg_pos /= 0 then
					-- Found argument
					-- Arguments are controlled.
				is_controlled := True
				l_arg_type := l_feature.arguments.i_th (l_arg_pos)

				l_arg_type := l_arg_type.instantiation_in (last_type.as_implicitly_detachable.as_variant_free, l_last_id)
				if context.is_argument_attached (l_as.feature_name.name_id) then
					l_arg_type := l_arg_type.as_attached_in (context.current_class)
				end
				if is_byte_node_enabled then
					create l_argument
					l_argument.set_position (l_arg_pos)
					last_byte_node := l_argument
				end
				if not is_inherited then
					set_argument_position (l_arg_pos, l_as)
					l_as.set_class_id (class_id_of (last_type))
				end
				if attached l_as.parameters as p then
					create l_vuar1
					context.init_error (l_vuar1)
					l_vuar1.set_arg_name (l_as.feature_name.name)
					l_vuar1.set_location (l_as.feature_name)
					look_for_parenthesis_alias (l_as.internal_parameters, l_vuar1, l_arg_type)
					if attached last_type as t then
							-- Set type for the argument.
						set_type (l_arg_type, l_as.feature_name)
						l_arg_type := t
					end
				end
				set_type (l_arg_type, l_as)
			else
					-- Look for a local if in a pre- or postcondition
				if not is_inherited then
					l_local_info := context.locals.item (l_as.feature_name.name_id)
				end
				if l_local_info /= Void then
						-- Local found
					create l_veen2b
					context.init_error (l_veen2b)
					l_veen2b.set_identifier (l_as.feature_name.name)
					l_veen2b.set_location (l_as.feature_name)
					error_handler.insert_error (l_veen2b)
				elseif attached context.object_test_local (l_as.feature_name.name_id) as i then
					process_object_test_local (i, l_as)
				else
						-- Look for a feature
					l_feature := Void
					if is_inherited then
						l_feature := system.class_of_id (l_last_id).feature_of_rout_id (l_as.routine_ids.first)
					end
					process_call (last_type, Void, l_as.feature_name, l_feature, l_as.parameters, False, False, False, False, True)
					if error_level = l_error_level and not is_inherited then
							-- Record routine and class IDs for descendants and tools.
						set_routine_ids (last_routine_id_set, l_as)
						l_as.set_class_id (l_last_id)
					end
					if attached last_vuar_error as e and then attached last_type as t then
							-- Feature without arguments is found, try parenthesis alias on it.
						look_for_parenthesis_alias (l_as.internal_parameters, e, t)
					end
					if attached last_type as t then
							-- Set type for the feature call.
						set_type (t, l_as)
					end
				end
			end
			if error_level /= l_error_level then
				reset_types
			end
		end

	process_precursor_as (l_as: PRECURSOR_AS)
		local
			l_vdpr1: VDPR1
			l_vdpr2: VDPR2
			l_vdpr3: VDPR3
			l_pre_table: like precursor_table
			l_feature_i: FEATURE_I
			l_parent_type: CL_TYPE_A
			l_parent_class: CLASS_C
			l_feat_ast: FEATURE_AS
			l_precursor_id: ID_AS
			l_instatiation_type: LIKE_CURRENT
			l_has_error: BOOLEAN
			l_current_class: CLASS_C
			l_rout_id_set: ROUT_ID_SET
			l_orig_result_type: TYPE_A
			l_precursor_keyword: KEYWORD_AS
			l_error_level: like error_level
		do
			if not is_inherited then
				if current_feature.is_invariant or else current_feature.is_inline_agent then
					create l_vdpr1
					context.init_error (l_vdpr1)
					error_handler.insert_error (l_vdpr1)
					l_has_error := True
				else
					l_feat_ast := context.current_class.feature_with_name (current_feature.feature_name).ast

						-- When a precursor is evaluated in a inherited replicated feature, the context should be its written class.
						-- Otherwise written class coincides with the current class.
					l_current_class := current_feature.written_class

					if not current_feature.is_selected then
							-- We are trying to evaluate a precursor where the routine id is different from its parent precursor routine
							-- Retrieve rout id set from from parent routine, merging if necessary with current routine id set.

							--| FIXME IEK: We need to retrieve the routine id of the selected routine.
						l_rout_id_set := current_feature.rout_id_set
					else
						l_rout_id_set := current_feature.rout_id_set
					end

						-- Check that feature has a unique name (vdpr1)
						-- Check that we're in the body of a routine (l_vdpr1).

					if
						l_feat_ast.feature_names.count > 1 or
						is_checking_precondition or is_checking_postcondition or is_checking_invariant
					then
						create l_vdpr1
						context.init_error (l_vdpr1)
						error_handler.insert_error (l_vdpr1)
						l_has_error := True
					else
							-- Create table of routine ids of all parents which have
							-- an effective precursor of the current feature.
						l_pre_table := precursor_table (l_as, l_current_class, l_rout_id_set)

							-- Check that current feature is a redefinition.
						if l_pre_table.is_empty then
							if l_as.parent_base_class /= Void then
									-- The specified parent does not have
									-- an effective precursor.
								create l_vdpr2
								context.init_error (l_vdpr2)
								error_handler.insert_error (l_vdpr2)
								l_has_error := True
							else
									-- No parent has an effective precursor
									-- (not a redefinition)
								create l_vdpr3
								context.init_error (l_vdpr3)
								error_handler.insert_error (l_vdpr3)
								l_has_error := True
							end
						elseif l_pre_table.count > 1 then
								-- Unqualified precursor construct is ambiguous
							create l_vdpr3.make_with_list (l_pre_table)
							context.init_error (l_vdpr3)
							error_handler.insert_error (l_vdpr3)
							l_has_error := True
						end

						if not l_has_error then
								-- Table has exactly one entry.
							l_pre_table.start
							l_parent_type := l_pre_table.item.parent_type
							l_parent_class := l_parent_type.base_class
							l_feature_i := l_pre_table.item.feat
							l_as.set_class_id (l_parent_class.class_id)
							set_routine_ids (l_feature_i.rout_id_set, l_as)
						end
					end
				end
			else
				l_parent_class := system.class_of_id (l_as.class_id)
				l_parent_type := l_parent_class.actual_type
				l_parent_type ?= l_parent_type.instantiation_in (
					context.current_class.actual_type, l_as.class_id)
				l_feature_i := l_parent_class.feature_of_rout_id (l_as.routine_ids.first)
			end

			if not l_has_error then
					-- Update signature of parent `l_feature_i' in context of its instantiation
					-- in current class.
				l_feature_i := l_feature_i.duplicate
					-- Adapt `l_feature_i' to context of current class (e.g. if `l_parent_type' is
					-- generic then we need to resolve formals used in `l_feature_i' but the one from
					-- the instantiation `l_parent_type'.
				if not l_parent_type.is_attached then
					l_parent_type := l_parent_type.twin
					if context.current_class.lace_class.is_attached_by_default then
						l_parent_type.set_is_attached
					else
						l_parent_type.set_is_implicitly_attached
					end
				end
				create l_instatiation_type.make (l_parent_type)
				l_orig_result_type := l_feature_i.type
				l_feature_i := l_feature_i.instantiated (l_instatiation_type)
					-- Now that we have the fully instantiated type, we need to adapt it to
					-- the current class type (e.g. like Current).
				l_feature_i := l_feature_i.instantiated (context.current_class_type)

				create l_precursor_id.initialize_from_id ({PREDEFINED_NAMES}.precursor_name_id)
				l_precursor_keyword := l_as.precursor_keyword
				l_precursor_id.set_position (l_precursor_keyword.line, l_precursor_keyword.column,
					l_precursor_keyword.position, l_precursor_keyword.location_count,
					l_precursor_keyword.character_column, l_precursor_keyword.character_position, l_precursor_keyword.character_count)
				l_error_level := error_level
				process_call (context.current_class_type, l_parent_type, l_precursor_id, l_feature_i,
					l_as.parameters, False, False, False, True, True)
				if error_level = l_error_level then
						-- Now `last_type' is the type we got from the processing of `Precursor'. We have to adapt
						-- it to the current class, but instead of using the malformed `last_type' we use `l_orig_result_type'.
					set_type (l_orig_result_type.evaluated_type_in_descendant
						(l_parent_type.base_class, context.current_class, context.current_feature), l_as.precursor_keyword)
					if attached last_vuar_error as e and then attached last_type as t then
							-- Feature without arguments is found, try parenthesis alias on it.
						look_for_parenthesis_alias (l_as.internal_parameters, e, t)
					end
						-- Record type of the call as a whole.
					set_type (last_type, l_as)
				end
			else
				reset_types
			end
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS)
		local
			l_target_type: TYPE_A
			target_code: ACCESS_B
			l_nested: NESTED_B
			l_is_qualified_call: BOOLEAN
			l_error_level: NATURAL_32
			old_assigner_source: like assigner_source
			s: like context.scope
			connective_id: like {NAMES_HEAP}.id_of
			is_connective: BOOLEAN
			binary_b: BINARY_B
		do
				-- Type check the target, but we reset the
				-- assigner flag syntax, because it is only pertinent
				-- to the message, not the target.
			old_assigner_source := assigner_source
			assigner_source := Void
			l_as.target.process (Current)

			l_target_type := last_type
			if l_target_type /= Void then
					-- Restore assigner source for nested call.
				assigner_source := old_assigner_source
					-- Make sure separate call is valid.
				if l_target_type.is_separate then
					validate_separate_target (l_as.message.access_name_32, l_as.target)
				end
				if is_byte_node_enabled then
					check last_byte_node_not_void: last_byte_node /= Void end
					if attached {ACCESS_B} last_byte_node as b then
						target_code := b
					else
						create {ACCESS_EXPR_B} target_code.make ({EXPR_B} / last_byte_node)
					end
				end

					-- Type check the message
				l_is_qualified_call := is_qualified_call
				is_qualified_call := True
				l_error_level := error_level
				if l_target_type.is_boolean then
					connective_id := l_as.message.feature_name.name_id
					inspect connective_id
					when
						{PREDEFINED_NAMES}.conjuncted_name_id,
						{PREDEFINED_NAMES}.disjuncted_exclusive_name_id,
						{PREDEFINED_NAMES}.disjuncted_name_id
					then
						is_connective := True
					when {PREDEFINED_NAMES}.conjuncted_semistrict_name_id then
						is_connective := True
						s := context.scope
						;(create {AST_SCOPE_CONJUNCTIVE_EXPRESSION}.make (context)).add_scopes (l_as.target)
					when {PREDEFINED_NAMES}.disjuncted_semistrict_name_id then
						is_connective := True
						s := context.scope
						;(create {AST_SCOPE_DISJUNCTIVE_EXPRESSION}.make (context)).add_scopes (l_as.target)
					when {PREDEFINED_NAMES}.implication_name_id then
						is_connective := True
						s := context.scope
						;(create {AST_SCOPE_IMPLICATIVE_EXPRESSION}.make (context)).add_scopes (l_as.target)
					else
							-- Some other call on BOOLEAN.
					end
				end
				l_as.message.process (Current)
				if s > 0 then
					context.set_scope (s)
				end
				is_qualified_call := l_is_qualified_call
				if
					error_level = l_error_level and then
					is_byte_node_enabled
				then
					if attached {CALL_B} last_byte_node as c then
						if
							is_connective and then
							attached {CALL_ACCESS_B} c as a and then
							attached a.parameters as ps and then
							ps.count = 1 and then
							attached ps [1] as p
						then
							inspect connective_id
							when {PREDEFINED_NAMES}.conjuncted_name_id then
								create {BIN_AND_B} binary_b.make (target_code, p.expression)
							when {PREDEFINED_NAMES}.conjuncted_semistrict_name_id then
									-- TODO: replace specialized code with conditional expression after specializing code generation
									-- to produce the code comparable by efficiency with the binary equivalent.
									-- a ∧ b ≜ if a then b else False end
									-- create {IF_EXPRESSION_B} last_byte_node.make (l_access_expr, p.expression, Void, create {BOOL_CONST_B}.make (False), l_target_type, Void)
								create {B_AND_THEN_B} binary_b.make (target_code, p.expression)
							when {PREDEFINED_NAMES}.disjuncted_exclusive_name_id then
								create {BIN_XOR_B} binary_b.make (target_code, p.expression)
							when {PREDEFINED_NAMES}.disjuncted_name_id then
								create {BIN_OR_B} binary_b.make (target_code, p.expression)
							when {PREDEFINED_NAMES}.disjuncted_semistrict_name_id then
									-- TODO: replace specialized code with conditional expression after specializing code generation
									-- to produce the code comparable by efficiency with the binary equivalent.
									-- a ∨ b ≜ if a then True else b end
									-- create {IF_EXPRESSION_B} last_byte_node.make (l_access_expr, create {BOOL_CONST_B}.make (True), Void, p.expression, l_target_type, Void)
								create {B_OR_ELSE_B} binary_b.make (target_code, p.expression)
							when {PREDEFINED_NAMES}.implication_name_id then
									-- TODO: replace specialized code with conditional expression after specializing code generation
									-- to produce the code comparable by efficiency with the binary equivalent.
									-- a ⇒ b ≜ if a then b else True end
									-- create {IF_EXPRESSION_B} last_byte_node.make (l_access_expr, p.expression, Void, create {BOOL_CONST_B}.make (True), l_target_type, Void)
								create {B_IMPLIES_B} binary_b.make (target_code, p.expression)
							end
							binary_b.init (a)
							last_byte_node := binary_b
						else
							create l_nested
							l_nested.set_target (target_code)
							l_nested.set_message (c)
							c.set_parent (l_nested)
							target_code.set_parent (l_nested)
							last_byte_node := l_nested
						end
					else
						check
							expected_byte_node: False
						end
					end
				end
			end
		end

	process_routine_as (l_as: ROUTINE_AS)
		local
			l_vxrc: VXRC
			l_byte_code: BYTE_CODE
			l_list: BYTE_LIST [BYTE_NODE]
			l_assertion_byte_code: ASSERTION_BYTE_CODE
			l_needs_byte_node: BOOLEAN
			s: INTEGER
			l_error_level: NATURAL_32
			l_has_invalid_locals: BOOLEAN
			l_feat_type: TYPE_A
			f: FEATURE_I
			l_rescue: detachable EIFFEL_LIST [INSTRUCTION_AS]
			l_check_count: like maximum_inference_count
			old_is_byte_node_enabled: BOOLEAN
			had_untyped_local: BOOLEAN
			l_untyped_local: like untyped_local
			retried: BOOLEAN
		do
			if not retried then
				f := current_feature
				l_needs_byte_node := is_byte_node_enabled
					-- Request freeze if there are too many arguments some of which are separate.
					-- ("interp.c" uses "EIF_NATURAL_64" to keep track of uncontrolled arguments,
					-- so if there are more arguments, freeze is requested.)
				if l_needs_byte_node and then f.argument_count > 64 and then f.has_separate_arguments then
					system.request_freeze
				end
				l_error_level := error_level

					-- Remember current scope state
				s := context.scope

					-- Check if some arguments are attached because of an inherited precondition.
					-- Avoid doing it when there are no inherited preconditions.
					-- Strict void safety: no variables change their attachment status because of inherited preconditions.
					-- Soft void safety: variables may change attachment status because of inherited preconditions.
				if
					is_void_safe_conformance and then
					not is_void_safe_construct and then
					not (f.has_precondition and then f.assert_id_set = Void)
				then
					;(create {AST_SCOPE_COMBINED_PRECONDITION}.make (f, context)).do_nothing
				end

					-- Check local variables before checking precondition because local count is used to initialize the structures.
				if l_as.locals /= Void then
					check_locals (l_as)
					l_untyped_local := untyped_local
					l_has_invalid_locals := error_level /= l_error_level
				end
					-- Initialize structures to record local scopes.
					-- This should be done after checking locals that sets their count.
				context.init_local_scopes

					-- Check preconditions
				if l_as.precondition /= Void then
						-- Set Result access analysis level to `is_checking_precondition': locals
						-- and Result cannot be found in preconditions
					set_is_checking_precondition (True)
					l_as.precondition.process (Current)
					if l_needs_byte_node then
						l_assertion_byte_code ?= last_byte_node
					end
						-- Reset the levels to default values
					set_is_checking_precondition (False)
				end

				l_rescue := l_as.rescue_clause
				if
					 attached l_rescue and then
					(l_as.routine_body.is_deferred or else l_as.routine_body.is_external)
				then
						-- A deferred or external feature cannot have a rescue clause.
					create l_vxrc
					context.init_error (l_vxrc)
					l_vxrc.set_deferred (l_as.routine_body.is_deferred)
					l_vxrc.set_location (l_rescue.start_location)
					error_handler.insert_error (l_vxrc)
				end

				from
					if l_has_invalid_locals then
							-- Do not check code with invalid locals.
						-- l_check_count := 0
					elseif attached l_untyped_local then
							-- Compute type of locals and then do real type-checking.
						has_untyped_local := True
							-- The maxium inference count is increased by 1 to take the real code generation pass into account.
						l_check_count := maximum_inference_count + 1
						old_is_byte_node_enabled := l_needs_byte_node
						is_byte_node_enabled := False
						l_needs_byte_node := False
					else
							-- All locals are declated with types, do normal type checks.
						has_untyped_local := False
						l_check_count := 1
					end
				until
					l_check_count = 0
				loop
					l_check_count := l_check_count - 1
					if attached l_rescue and then not l_as.routine_body.is_built_in then
							-- Make it possible to remove variable scopes so that
							-- rescue clause can be processed in a state where only
							-- variable scopes started in the precondition are recorded.
							-- Built-in features are not handled in this way, because
							-- the scope information is cleaned when they are processed.
						context.enter_realm
					end
						-- Avoid relying on the body when checking postcondition.
					if l_as.postcondition /= Void then
						context.enter_realm
					end
						-- Check body
					l_as.routine_body.process (Current)
					if l_needs_byte_node and then error_level = l_error_level then
						l_byte_code ?= last_byte_node
						l_byte_code.set_precondition (l_assertion_byte_code)
					end

					l_feat_type := f.type
					if
						(l_feat_type.is_basic implies not {SYSTEM_I}.is_basic_class_alive) and then
						not is_inherited and then
						l_feat_type.is_expanded_creation_possible
					then
						record_expanded_dependence (l_feat_type)
					end
					if l_feat_type.is_initialization_required then
							-- Verify that result is properly set in internal routine if required.
						if
							not context.local_initialization.is_result_set and then
							not l_as.is_deferred and then
							not l_as.is_external and then
							not (l_as.is_attribute and then l_as.routine_body.is_empty) and then
							is_void_safe_initialization
						then
								-- Result is not properly initialized.
							error_handler.insert_error (create {VEVI}.make_result (context, l_as.end_keyword))
						end
					elseif
						l_as.is_attribute and then
						not l_as.routine_body.is_empty and then
						not is_inherited and then
						context.current_class.is_warning_enabled (w_vwab)
					then
							-- Warn that the attribute has a non-empty body that is never executed.
						error_handler.insert_warning (create {VWAB}.make (l_as.routine_body.start_location, context), context.current_class.is_warning_reported_as_error (w_vwab))
					end
						-- Check postconditions
					if l_as.postcondition /= Void then
							-- Revert to the state just after a precondition.
						context.leave_optional_realm
							-- Set access id level analysis to `is_checking_postcondition': locals
							-- are not taken into account
						set_is_checking_postcondition (True)
						if l_feat_type.is_initialization_required and then not context.local_initialization.is_result_set then
							context.set_result
						end
						if l_feat_type.is_attached then
							context.add_result_instruction_scope
						end
						l_as.postcondition.process (Current)
						if l_needs_byte_node and then error_level = l_error_level then
							l_assertion_byte_code ?= last_byte_node
							l_byte_code.set_postcondition (l_assertion_byte_code)
						end
						if l_feat_type.is_attached then
							context.remove_result_scope
						end
							-- Reset the level
						set_is_checking_postcondition (False)
					end
					if attached l_rescue then
						if not l_as.routine_body.is_built_in then
								-- Ensure the variable scopes do not affect rescue clause.
							context.leave_optional_realm
						end
							-- Set mark of context.
						is_in_rescue := True
							-- Remove any previously started local scopes.
						context.init_local_scopes
						process_compound (l_rescue)
						if l_needs_byte_node and then error_level = l_error_level then
							l_list ?= last_byte_node
							l_byte_code.set_rescue_clause (l_list)
						end
						is_in_rescue := False
					end
					if has_untyped_local then
							-- Compute types of local variables.
							-- Uncomputed types are allowed if this is not the last iteration.
						resolve_locals (l_check_count > 1, l_untyped_local)
							-- Adjust inference count if there are no more untyped locals during this and previous iteration.
						if not has_untyped_local then
								-- Check if all local types were resolved at the previous step.
								-- Perform one more iteration to make sure the fixed point is reached.
								-- Set `has_untyped_local' to `True' to be able to call `resolve_locals'.
							has_untyped_local := True
							if not had_untyped_local then
									-- Assign real types to locals if this is not done yet.
								if l_check_count > 1 then
									resolve_locals (False, l_untyped_local)
								end
									-- Flag that this is going to be a real pass rather than just type computation.
								l_check_count := 1
							end
								-- Record last status of untyped locals.
								-- If there are no untyped locals during 2 iterations then the fixed-point is reached.
							had_untyped_local := False
						else
								-- Record last status of untyped locals.
							had_untyped_local := True
						end
						if l_check_count = 1 then
								-- Restore code generation flags.
							is_byte_node_enabled := old_is_byte_node_enabled
							l_needs_byte_node := old_is_byte_node_enabled
								-- Terminate the loop without generating code at the last iteration
								-- for the feature with untyped locals.
							l_check_count := 0
						end
					end
				variant
					(l_check_count + 1).to_integer_32
				end


					-- Revert to the original scope state
				context.set_scope (s)

					-- Check for unused locals only when there is no errors otherwise it
					-- is confusing to get a warning for something that might be incorrect.
				if
					not l_has_invalid_locals and then
					l_as.locals /= Void and then error_level = l_error_level and then
					context.current_class.is_warning_enabled (w_unused_local) and then
					not is_inherited
				then
					check_unused_locals (context.locals)
				end

				if error_level = l_error_level then
					if l_needs_byte_node then
						context.init_byte_code (l_byte_code)
						if old_expressions /= Void and then old_expressions.count > 0 then
							l_byte_code.set_old_expressions (old_expressions)
						end
						l_byte_code.set_end_location (l_as.end_location)
						l_byte_code.set_once_manifest_string_count (l_as.once_manifest_string_count)
						last_byte_node := l_byte_code
					end
					l_as.set_number_of_breakpoint_slots (break_point_slot_count)
				end
			end
		rescue
			if
				not retried and then
				not error_handler.rescue_status.is_error_exception and then
				attached l_untyped_local
			then
					-- Report errors for untyped locals.
				resolve_locals (False, l_untyped_local)
				retried := True
				retry
			end
		end

	process_constant_as (l_as: CONSTANT_AS)
		do
			-- Nothing to be done
		end

	process_compound (compound: EIFFEL_LIST [INSTRUCTION_AS])
			-- Process instruction list keeping track of local scopes.
		local
			s: INTEGER
		do
			s := context.scope
			compound.process (Current)
			context.set_scope (s)
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL])
		do
			process_eiffel_list_with_matcher (l_as, Void, Void)
		end

	process_eiffel_list_with_matcher (l_as: EIFFEL_LIST [AST_EIFFEL]; m: AST_SCOPE_MATCHER; b: BYTE_LIST [BYTE_NODE])
		local
			l_cursor: INTEGER
			l_list: BYTE_LIST [BYTE_NODE]
			e: like {ERROR_HANDLER}.error_level
		do
			if is_byte_node_enabled then
					-- Initialize result byte node.
				if b = Void then
					create l_list.make (l_as.count)
				else
					l_list := b
				end
			end
			e := error_handler.error_level
			l_cursor := l_as.index
			from
				l_as.start
			until
				l_as.after
			loop
				l_as.item.process (Current)
				if m /= Void then
					m.add_scopes (l_as.item)
				end
				if attached l_list then
					if e = error_handler.error_level then
						l_list.extend (last_byte_node)
					else
						l_list := Void
					end
				end
				l_as.forth
			end
			l_as.go_i_th (l_cursor)
			if is_byte_node_enabled then
				last_byte_node := l_list
			end
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS)
		do
			-- Nothing to be done
		end

	process_operand_as (l_as: OPERAND_AS)
		local
			l_class_type: TYPE_A
		do
			if attached l_as.expression as e then
				reset_for_unqualified_call_checking
				e.process (Current)
			elseif attached l_as.class_type as t then
				t.process (Current)
				l_class_type := last_type
				if l_class_type /= Void then
					instantiator.dispatch (l_class_type, context.current_class)
					if is_byte_node_enabled then
						create {OPERAND_B} last_byte_node
					end
				end
			else
					-- Case of a question mark in either `agent ?.something' or `agent f (?, a)'.
					-- We rely on `current_target_type' to provide us the right type for ?,
					-- i.e. the current type in `agent ?.something', or the type of the formal argument
					-- of `f' in the current context.
				set_type (current_target_type, l_as)
				if is_byte_node_enabled then
					create {OPERAND_B} last_byte_node
				end
			end
		end

	process_tagged_as (l_as: TAGGED_AS)
		local
			l_vwbe3: VWBE3
			l_expr: EXPR_B
			l_error_level: NATURAL_32
		do
			break_point_slot_count := break_point_slot_count + 1

			reset_for_unqualified_call_checking

			l_error_level := error_level
			l_as.expr.process (Current)

			if error_level = l_error_level then
					-- Check if the type of the expression is boolean
				if not last_type.actual_type.is_known then
						-- Record expected type.
					last_type.actual_type.conform_to (context.current_class, boolean_type).do_nothing
				elseif not last_type.actual_type.is_boolean then
					create l_vwbe3
					context.init_error (l_vwbe3)
					l_vwbe3.set_type (last_type)
					l_vwbe3.set_location (l_as.expr.end_location)
					error_handler.insert_error (l_vwbe3)
				elseif is_byte_node_enabled then
					l_expr ?= last_byte_node
					check
						l_expr_not_void: l_expr /= Void
					end
					create {ASSERT_B} last_byte_node.make (assertion_tag (l_as), l_expr, l_as.expr.start_location.line)
				end
			end
		end

	process_variant_as (l_as: VARIANT_AS)
		local
			l_vave: VAVE
		do
			reset_for_unqualified_call_checking
			l_as.expr.process (Current)

			if last_type /= Void then
					-- Check if the type of the expression is integer
					-- We use `actual_type', otherwise eweasel test#valid265 is failing.
				if not last_type.actual_type.is_integer then
					create l_vave
					context.init_error (l_vave)
					l_vave.set_type (last_type)
					l_vave.set_location (l_as.expr.end_location)
					error_handler.insert_error (l_vave)
				end

				if is_byte_node_enabled then
					if attached {EXPR_B} last_byte_node as e then
						create {VARIANT_B} last_byte_node.make (assertion_tag (l_as), e, l_as.expr.start_location.line)
					else
						check expected_byte_node_type: False end
					end
				end
			end
		end

	process_un_strip_as (l_as: UN_STRIP_AS)
		local
			l_id: INTEGER
			l_index: INTEGER
			l_feat_tbl: FEATURE_TABLE
			l_attribute_i: ATTRIBUTE_I
			l_depend_unit: DEPEND_UNIT
			l_vwst1: VWST1
			l_vwst2: VWST2
			l_strip: STRIP_B
			l_needs_byte_node: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled
			from
				if l_needs_byte_node then
					create l_strip.make
				end
				l_feat_tbl := context.current_class.feature_table
				l_as.id_list.start
			until
				l_as.id_list.after
			loop
				l_id := l_as.id_list.item
				l_index := l_as.id_list.index
				l_as.id_list.forth
				l_as.id_list.search (l_id)
				if not l_as.id_list.after then
						-- Id appears more than once in attribute list
					create l_vwst2
					context.init_error (l_vwst2)
					l_vwst2.set_attribute_name (Names_heap.item (l_id))
					l_vwst2.set_location (l_as.start_location)
					error_handler.insert_error (l_vwst2)
				else
					l_attribute_i ?= l_feat_tbl.item_id (l_id)
					if l_attribute_i = Void then
						create l_vwst1
						context.init_error (l_vwst1)
						l_vwst1.set_attribute_name (Names_heap.item (l_id))
						l_vwst1.set_location (l_as.start_location)
						error_handler.insert_error (l_vwst1)
					else
						if not is_inherited then
							create l_depend_unit.make (context.current_class.class_id, l_attribute_i)
							context.supplier_ids.extend (l_depend_unit)
						end
						if l_needs_byte_node then
							l_strip.feature_ids.put (l_attribute_i.feature_id)
						end
					end
				end
				l_as.id_list.go_i_th (l_index)
				l_as.id_list.forth
			end
				-- Type of strip expression is always attached.
			set_type (strip_type.as_attached_in (context.current_class), l_as)
			if not {SYSTEM_I}.is_array_class_alive and then not is_inherited then
				record_creation_dependence (strip_type)
			end
			if l_needs_byte_node then
				last_byte_node := l_strip
			end
		end

	process_converted_expr_as (l_as: CONVERTED_EXPR_AS)
		local
			l_feat: FEATURE_I
			l_feat_name: ID_AS
			l_location: LOCATION_AS
			l_error_level: like error_level
			l_is_qualified_call: BOOLEAN
		do
			l_error_level := error_level
			l_as.expr.process (Current)
				-- It only make sense to process the conversion data only when
				-- rechecking the code in a descendant class.
			if is_inherited and then l_error_level = error_level and then attached {PARENT_CONVERSION_INFO} l_as.data as l_info then
					-- If we have some data about the above with a conversion, we need
					-- to extract it so that we can recheck that the converted code still
					-- make sense in a descendant.
				if l_info.is_null_conversion or l_info.is_from_conversion then
						-- For a from conversion or a null conversion, we just need to adapt the creation
						-- type to the descendant class (case of formal generics that might need to be
						-- instantiated).
					set_type (l_info.creation_type.evaluated_type_in_descendant (context.written_class,
						context.current_class, context.current_feature), l_as)
				else
						-- For a to conversion, we need to take the descendant version of the routine
						-- orginally taken and check that its return type still make sense.
					l_feat := last_type.base_class.feature_of_rout_id (l_info.routine_id)

					if l_feat /= Void then
						create l_feat_name.initialize_from_id (l_feat.feature_name_id)
						l_location := l_as.expr.end_location
						l_feat_name.set_position (l_location.line, l_location.column,
							l_location.position + l_location.location_count, 0,
							l_location.character_column, l_location.character_position + l_location.character_count, 0)
						l_is_qualified_call := is_qualified_call
						is_qualified_call := True
						process_call (last_type, Void, l_feat_name, l_feat, Void, False, False, True, False, False)
						is_qualified_call := l_is_qualified_call
					else
							-- We should not get there, but just in case we generate an internal
							-- error message.
						reset_types
						error_handler.insert_error (create {INTERNAL_ERROR}.make (
							"In {AST_FEATURE_CHECKER_GENERATOR}.process_converted_expr_as could%N%
							%not find routine of a given routine ID in an inherited conversion"))
					end
				end
			end
		end

	process_paran_as (a: PARAN_AS)
		do
			a.expr.process (Current)
			if attached last_type as t then
				set_type (t, a)
			end
		end

	process_expr_call_as (l_as: EXPR_CALL_AS)
		local
			l_vkcn3: VKCN3
			l_list: LEAF_AS_LIST
			is_assigner_call: BOOLEAN
		do
			is_assigner_call := attached assigner_source
			reset_for_unqualified_call_checking
			l_as.call.process (Current)
			if attached last_type as t then
				if t.is_void and then not is_assigner_call then
					create l_vkcn3
					context.init_error (l_vkcn3)
					l_vkcn3.set_location (l_as.call.end_location)
					if attached context.written_class as cl then
						l_list := match_list_of_class (cl.class_id)
						if l_list /= Void and then l_as.call.is_text_available (l_list) then
							l_vkcn3.set_called_feature (l_as.call.text (l_list))
						end
					end
					error_handler.insert_error (l_vkcn3)
					reset_types
				else
					set_type (t, l_as)
				end
			end

			-- Nothing to be done for `last_byte_node' as it was computed in previous call
			-- `l_as.call.process'.
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS)
		do
			l_as.expr.process (Current)
			if attached last_type as l_type then
				create {TYPED_POINTER_A} last_type.make_typed (l_type)
				instantiator.dispatch (last_type, context.current_class)
				if is_byte_node_enabled and attached {EXPR_B} last_byte_node as l_expr then
					create {EXPR_ADDRESS_B} last_byte_node.make (l_expr)
				end
			else
					-- An error occurred.
			end
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS)
		local
			l_vrle3: VRLE3
			l_veen2a: VEEN2A
			l_typed_pointer: TYPED_POINTER_A
		do
			reset_byte_node
			if is_checking_invariant or else not current_feature.has_return_value then
					-- It means that we are in a location where `Result' is not
					-- acceptable (e.g. an invariant, or within the body of a procedure).
				create l_vrle3
				context.init_error (l_vrle3)
				l_vrle3.set_location (l_as.start_location)
				error_handler.insert_error (l_vrle3)
			elseif is_checking_precondition then
					-- Result entity in precondition
				create l_veen2a
				context.init_error (l_veen2a)
				l_veen2a.set_location (l_as.start_location)
				error_handler.insert_error (l_veen2a)
			end
			create l_typed_pointer.make_typed (current_feature.type)
			set_type (l_typed_pointer, l_as)
			instantiator.dispatch (l_typed_pointer, context.current_class)
			if is_byte_node_enabled then
				create {HECTOR_B} last_byte_node.make_with_type (create {RESULT_B}, l_typed_pointer)
				has_hector := True
			end
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS)
		local
			l_typed_pointer: TYPED_POINTER_A
		do
			if current_feature.is_class then
				report_vucr (create {VUCR_BODY}.make_current (current_feature, context.current_class, context.written_class, l_as.current_keyword))
			end
			create l_typed_pointer.make_typed (context.current_class_type)
			set_type (l_typed_pointer, l_as)
			instantiator.dispatch (l_typed_pointer, context.current_class)
			if is_byte_node_enabled then
				create {HECTOR_B} last_byte_node.make_with_type (create {CURRENT_B}, l_typed_pointer)
				has_hector := True
			end
		end

	process_address_as (l_as: ADDRESS_AS)
		local
			l_access: ACCESS_B
			l_argument: ARGUMENT_B
			l_local: LOCAL_B
			l_local_info: LOCAL_INFO
			l_feature: FEATURE_I
			l_vzaa1: VZAA1
			l_veen: VEEN
			l_veen2b: VEEN2B
			l_arg_pos: INTEGER
			l_last_id: INTEGER
			l_type: TYPE_A
			l_typed_pointer: TYPED_POINTER_A
			l_depend_unit: DEPEND_UNIT
			l_needs_byte_node: BOOLEAN
			l_error_level: NATURAL_32
		do
			l_needs_byte_node := is_byte_node_enabled

				-- Initialization of the type stack
			reset_for_unqualified_call_checking

			l_last_id := context.current_class.class_id
			if not is_inherited then
				l_as.set_class_id (l_last_id)
			end

			l_feature := current_feature
				-- Look for an argument
			if l_feature /= Void then
				if is_inherited then
					if l_as.is_argument then
						l_arg_pos := l_as.argument_position
					end
				else
					l_arg_pos := l_feature.argument_position (l_as.feature_name.internal_name.name_id)
				end
			end

			l_error_level := error_level
			if l_arg_pos /= 0 then
					-- Found argument
				l_type := l_feature.arguments.i_th (l_arg_pos)
				l_type := l_type.instantiation_in (last_type.as_implicitly_detachable.as_variant_free, l_last_id)
				create l_typed_pointer.make_typed (l_type)
				set_type (l_typed_pointer, l_as)
				if l_needs_byte_node then
					create l_argument
					l_argument.set_position (l_arg_pos)
					create {HECTOR_B} last_byte_node.make_with_type (l_argument, l_typed_pointer)
					has_hector := True
				end
				if not is_inherited then
					l_as.enable_argument
					l_as.set_argument_position (l_arg_pos)
				end
			else
					-- Look for a local if not in a pre- or postcondition
				if not is_inherited or else l_as.is_local then
					l_local_info := context.locals.item (l_as.feature_name.internal_name.name_id)
				end
				if l_local_info /= Void then
						-- Local found
					l_local_info.enable_is_used
					l_type := l_local_info.type
					if attached {LOCAL_TYPE_A} l_type as t and then attached t.minimum as m then
							-- Use type approximation.
						l_type := m
					end
					if l_type.is_known then
						l_type := l_type.instantiation_in (last_type.as_implicitly_detachable.as_variant_free, l_last_id)
						create l_typed_pointer.make_typed (l_type)
						set_type (l_typed_pointer, l_as)
						if l_needs_byte_node then
							create l_local.make (l_local_info.position)
							create {HECTOR_B} last_byte_node.make_with_type (l_local, l_typed_pointer)
							has_hector := True
						end
					else
						set_type (unknown_type, l_as)
					end

					if is_checking_postcondition or else is_checking_precondition then
							-- Local in post- or precondition
							--|Note: this should not happen since
							--|in the context of assertions we would have
							--|ACCESS_ASSERT_AS and not ACCESS_ID_AS objects.
							--|(Fred)
						create l_veen2b
						context.init_error (l_veen2b)
						l_veen2b.set_identifier (l_as.feature_name.internal_name.name)
						l_veen2b.set_location (l_as.feature_name.start_location)
						error_handler.insert_error (l_veen2b)
					end

					if not is_inherited then
						l_as.enable_local
					end
				else
					l_local_info := context.object_test_local (l_as.feature_name.internal_name.name_id)
					if l_local_info /= Void then
						if l_local_info.is_cursor then
							error_handler.insert_error (create {NOT_SUPPORTED}.make
								(agent format_elements
									(?,
									locale.translation_in_context ("Address of a cursor variable of {1} form of a loop is not supported.", "compiler.error"),
									<<agent {TEXT_FORMATTER}.process_keyword_text ({TEXT_FORMATTER}.ti_is_keyword, Void)>>),
								context,
								l_as.feature_name.internal_name))
						else
							l_local_info.enable_is_used
							last_access_writable := False
							is_controlled := l_local_info.is_controlled
							l_type := l_local_info.type.instantiation_in (last_type.as_implicitly_detachable.as_variant_free, l_last_id)
							create l_typed_pointer.make_typed (l_type)
							set_type (l_typed_pointer, l_as)
							if not is_inherited then
								l_as.enable_object_test_local
							end
							if l_needs_byte_node then
								create {OBJECT_TEST_LOCAL_B} l_local.make (l_local_info.position, l_feature.body_index, l_type)
								create {HECTOR_B} last_byte_node.make_with_type (l_local, l_typed_pointer)
								has_hector := True
							end
						end
					else
						if is_inherited then
							l_feature := context.current_class.feature_of_rout_id (l_as.routine_ids.first)
						else
							l_feature := context.current_class.feature_table.item_id (l_as.feature_name.internal_name.name_id)
						end
						if l_feature = Void then
							create l_veen
							context.init_error (l_veen)
							l_veen.set_identifier (l_as.feature_name.internal_name.name)
							l_veen.set_location (l_as.feature_name.start_location)
							error_handler.insert_error (l_veen)
						else
							if l_feature.is_constant then
								create l_vzaa1
								context.init_error (l_vzaa1)
								l_vzaa1.set_address_name (l_as.feature_name.internal_name.name)
								l_vzaa1.set_location (l_as.feature_name.start_location)
								error_handler.insert_error (l_vzaa1)
							elseif l_feature.is_external then
								error_handler.insert_error (create {NOT_SUPPORTED}.make_from_string
									(locale.translation_in_context ("The $ operator is not supported on externals.", "compiler.error"),
									context,
									l_as.feature_name.start_location))
							elseif l_feature.is_attribute then
								l_type := l_feature.type.actual_type
								create l_typed_pointer.make_typed (l_type)
								set_type (l_typed_pointer, l_as)
								if current_feature.is_class then
									report_vucr (create {VUCR_BODY}.make_attribute (l_feature, current_feature, context.current_class, context.written_class, l_as.feature_name.internal_name))
								end
							else
								set_type (Pointer_type, l_as)
							end

							if error_level = l_error_level then
									-- Dependance
								if not is_inherited then
									create l_depend_unit.make_with_level (l_last_id, l_feature, depend_unit_level)
									context.supplier_ids.extend (l_depend_unit)
								end

								if l_needs_byte_node then
									if l_typed_pointer /= Void then
										check is_attribte: l_feature.is_attribute end
										l_access := l_feature.access (l_type, False, False)
										create {HECTOR_B} last_byte_node.make_with_type (l_access, l_typed_pointer)
										has_hector := True
									else
										create {ADDRESS_B} last_byte_node.make (context.current_class.class_id, l_feature)
									end
								end
								if not is_inherited then
									set_routine_ids (l_feature.rout_id_set, l_as)
									check_obsolescence (l_feature, context.current_class, l_as.feature_name.start_location)
								end
							end
						end
					end
				end
			end
			if error_level = l_error_level then
				instantiator.dispatch (last_type, context.current_class)
			else
				reset_types
			end
		end

	process_type_expr_as (l_as: TYPE_EXPR_AS)
 		local
			l_type: TYPE_A
			l_type_type: GEN_TYPE_A
			l_generics: ARRAYED_LIST [TYPE_A]
		do
			l_as.type.process (Current)
			l_type := last_type
			if l_type /= Void then
				create l_generics.make (1)
				l_generics.extend (l_type)
				create l_type_type.make (system.type_class.compiled_class.class_id, l_generics)
					-- The type is always frozen.
				l_type_type.set_frozen_mark
					-- The type is always attached.
				l_type_type := l_type_type.as_attached_in (context.current_class)
				instantiator.dispatch (l_type_type, context.current_class)
				set_type (l_type_type, l_as)
				if not is_inherited then
					record_creation_dependence (l_type_type)
				end
				if is_byte_node_enabled then
					create {TYPE_EXPR_B} last_byte_node.make (l_type_type)
				end
			end
		end

	process_routine_creation_as_ext (l_as: ROUTINE_CREATION_AS; a_feature: FEATURE_I)
		local
			l_class: CLASS_C
			l_feature: FEATURE_I
			l_table: FEATURE_TABLE
			l_target_type: TYPE_A
			l_return_type: TYPE_A
			l_target_node: EXPR_B
			l_needs_byte_node: BOOLEAN
			l_feature_name: ID_AS
			l_access: ACCESS_B
			l_named_tuple: NAMED_TUPLE_TYPE_A
			l_label_pos: INTEGER
			l_is_named_tuple: BOOLEAN
			l_error_level: NATURAL_32
			l_old_current_target_type: like current_target_type
		do
			l_needs_byte_node := is_byte_node_enabled
			l_error_level := error_level

				-- Type check the target
			reset_for_unqualified_call_checking

			if l_as.target = Void then
					-- Target is the closed operand `Current'.
				l_target_type := context.current_class_type
				if l_needs_byte_node then
					create {CURRENT_B} l_target_node
				end
			else
				l_old_current_target_type := current_target_type
				current_target_type := context.current_class_type
				l_as.target.process (Current)
				current_target_type := l_old_current_target_type
				l_target_type := last_type
				if l_target_type /= Void then
					if l_needs_byte_node then
						check
							is_expression_byte_code: attached {EXPR_B} last_byte_node as e
						then
	  						l_target_node := e
						end
  					end
						-- Insert an error if the target type is separate and open.
					if system.is_scoop and then l_target_type.is_separate and then l_as.target.is_open then
							-- TODO: It might be a better idea to create a new error class.
						Error_handler.insert_error (create {VUTA3}.make (context, last_type, Void, l_as.target.start_location))
					end
  				end
			end

				-- If `l_target_type' is Void, it simply means we had an error earlier, so no need to continue.
			if l_target_type /= Void then
				l_feature_name := l_as.feature_name

				if l_target_type.conformance_type.is_formal or l_target_type.conformance_type.is_basic then
						-- Not supported. May change in the future - M.S.
						-- Reason: We cannot call a feature with basic call target!
					error_handler.insert_error (create {NOT_SUPPORTED}.make_from_string
						(locale.translation_in_context ("Type of target in a agent call may not be a basic type or a formal.", "compiler.error"),
						context,
						if attached l_as.target as t then
							t.start_location
						else
							l_feature_name
						end))
				else
					if l_target_type.has_associated_class then
						l_class := l_target_type.base_class
						l_table := l_class.feature_table

						if is_inherited then
							if a_feature = Void then
								l_feature := l_class.feature_of_rout_id (l_as.routine_ids.first)
							else
								l_feature := a_feature
							end
						else
							if a_feature = Void then
									-- Note that the following can yield `Void' in case it is not a valid feature name or
									-- if it is a named tuple access. That's ok, since it is going to be properly
									-- handled by `process_call'.
								l_feature := l_table.item_id (l_feature_name.name_id)
							else
								l_feature := a_feature
							end
						end
					elseif attached {LOCAL_TYPE_A} l_target_type as t and then attached t.feature_call (l_feature_name.name_id, context.current_class) as f then
						l_feature := f.descriptor
						l_target_type := f.target
						l_class := f.site.base_class
					else
						l_feature := a_feature
					end

						-- Type check the call
					process_call (l_target_type, Void, l_feature_name, l_feature, l_as.operands, False, True, l_as.has_target, False, False)
					if error_level = l_error_level then
						if l_feature = Void then
							l_named_tuple ?= l_target_type
							if l_named_tuple /= Void then
								l_label_pos := l_named_tuple.label_position (l_feature_name.name)
								if l_label_pos > 0 then
									l_is_named_tuple := True
								end
							end
						elseif not l_as.has_target and then current_feature.is_class and then attached l_as.feature_name as feature_name and then not attached {INLINE_AGENT_CREATION_AS} l_as then
							report_vucr (create {VUCR_BODY}.make_unqualified_agent (l_feature, current_feature, context.current_class, context.written_class, feature_name))
						end

						if l_feature = Void and then not l_is_named_tuple then
							if l_target_type.is_known then
								error_handler.insert_error (create {NOT_SUPPORTED}.make
									(agent format_elements
										(?,
										locale.translation_in_context
											("Agent creation on {1} is not supported because it is either an attribute, a constant or an external feature.",
											"compiler.error"),
										<<agent {TEXT_FORMATTER}.process_feature_name_text (l_feature_name.name_32, context.written_class)>>),
									context,
									l_feature_name))
							else
								set_type (unknown_type, l_as)
							end
						else
								-- Subsequent code that computes the type of the agent uses information about the corresponding class.
								-- Therefore, class ID should be set before that.
							if not is_inherited then
								l_as.set_class_id (l_class.class_id)
								if attached l_feature then
										-- This is a real agent rather than a named tuple access.
										-- Remember the corresponding routine IDs and the dependency.
									set_routine_ids (l_feature.rout_id_set, l_as)
									context.supplier_ids.extend_depend_unit_with_level
										(l_class.class_id,
										l_feature,
										depend_unit_level | if l_feature.is_inline_agent then {DEPEND_UNIT}.is_uniform_flag else {NATURAL_16} 0 end)
								end
							end
							l_access ?= last_byte_node
							check
								has_feature: not l_is_named_tuple implies l_feature /= Void
							end
							if l_is_named_tuple or else l_feature.is_attribute or else l_feature.is_constant then
								is_byte_node_enabled := False

									-- Special processing for return type for named TUPLEs since they do not have an associated
									-- feature.
								if l_is_named_tuple then
									l_return_type := last_type
								else
									l_return_type := l_feature.type
								end

								compute_routine (l_feature, True, False, l_class.class_id, l_target_type, l_return_type,
										l_as, l_access, l_target_node)

								if l_needs_byte_node then
									is_byte_node_enabled := True
									if l_is_named_tuple then
										compute_named_tuple_fake_inline_agent (
											l_as, l_named_tuple, l_label_pos, l_target_node, l_target_type, last_type)
									else
										compute_feature_fake_inline_agent (
											l_as, l_feature, l_target_node, l_target_type, last_type)
									end
								end
							else
								compute_routine (l_feature, not l_feature.type.is_void,l_feature.has_arguments,
											l_class.class_id, l_target_type, l_feature.type, l_as, l_access, l_target_node)
							end
							if last_type.is_known then
								instantiator.dispatch (last_type, context.current_class)
							end
							if not is_inherited then
									-- `last_type` was computed by the previous calls only,
									-- and could not be recorded earlier.
								record_creation_dependence (last_type)
							end
						end
					end
				end
			end
			if error_level /= l_error_level then
				reset_types
			end
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS)
		do
			process_routine_creation_as_ext (l_as, Void)
		end

	process_unary_as (l_as: UNARY_AS)
		require
			l_as_not_void: l_as /= Void
		local
			l_prefix_feature: FEATURE_I
			l_feature_type, l_last_feature_type: TYPE_A
			l_prefix_feature_type, l_last_constrained: TYPE_A
			l_last_class: CLASS_C
			l_depend_unit: DEPEND_UNIT
			l_vwoe: VWOE
			l_vuex: VUEX
			l_needs_byte_node: BOOLEAN
			l_expr: EXPR_B
			l_access: ACCESS_B
			l_unary: UNARY_B
			old_assigner_source: like assigner_source
			l_formal: FORMAL_A
			l_is_multi_constrained: BOOLEAN
			l_type_set: TYPE_SET_A
			l_result: LIST [TUPLE [feature_i: FEATURE_I; cl_type: RENAMED_TYPE_A]]
			l_result_item: TUPLE [feature_i: FEATURE_I; cl_type: RENAMED_TYPE_A]
			l_result_tuple: TUPLE[feature_item: FEATURE_I; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER]
			l_context_current_class: CLASS_C
			l_error_level: NATURAL_32
			l_vtmc_error: VTMC
			l_vtmc4: VTMC4
			l_is_controlled: BOOLEAN
			l_target_type: TYPE_A
		do
			l_needs_byte_node := is_byte_node_enabled

				-- Reset assigner call flag
			old_assigner_source := assigner_source
			assigner_source := Void
			l_context_current_class := context.current_class
				-- Check operand
			l_as.expr.process (Current)

			l_target_type := last_type
			if attached l_target_type then
				if l_target_type.is_separate then
					validate_separate_target (Void, l_as.expr)
					l_is_controlled := is_controlled
				end
				if l_needs_byte_node then
					l_expr ?= last_byte_node
				end
				set_type (l_target_type.actual_type, l_as)
				l_formal ?= last_type
				if l_formal /= Void then
					if not l_formal.is_single_constraint_without_renaming (l_context_current_class) then
						l_is_multi_constrained := True
					else
						l_last_constrained := l_formal.constrained_type (context.current_class)
					end
				else
					l_last_constrained := last_type
				end

				l_error_level := error_level
				if not last_type.is_attached and then is_void_safe_call then
					error_handler.insert_error (create {VUTA2}.make (context, last_type, l_as.operator_location))
				end

				if not l_is_multi_constrained then
					check has_constrained: l_last_constrained /= Void end
						-- Check if target is not of type NONE
					if l_last_constrained.is_none then
						create l_vuex.make_for_none (l_as.prefix_feature_name)
						context.init_error (l_vuex)
						l_vuex.set_location (l_as.expr.end_location)
						error_handler.insert_error (l_vuex)
					end
				end

				if error_level = l_error_level then
					if is_inherited then
						if l_is_multi_constrained then
								-- This code here is very similar to `process_access_feat_as'.
								-- Note: We do not need to protect against TUPLE access here since
								-- named tuples are not allowed in multiple-constraint.
								-- We need to iterate through the type set to find the routine of ID													
							l_type_set := context.current_class.constraints (l_formal.position)
							l_type_set := l_type_set.constraining_types (context.current_class)
							l_result := l_type_set.feature_i_list_by_rout_id (l_as.routine_ids.first)
							check at_least_one_feature_found: l_result.count > 0 end
									-- As we inherited this feature there's the possiblity that now,
							from
								l_result.start
							until
								l_result.after or l_vtmc4 /= Void or last_alias_error /= Void
							loop
								l_result_item := l_result.item
								l_prefix_feature := l_result_item.feature_i
								l_last_constrained := l_result_item.cl_type.type
								l_last_class := l_last_constrained.base_class
								check_prefix_feature (l_prefix_feature, l_last_class)
								l_result.forth
									-- We inherited this feature.
								if last_alias_error = Void then
									l_feature_type := l_prefix_feature.type.recomputed_in
										(last_type.as_implicitly_detachable.as_variant_free,
										l_context_current_class.class_id,
										l_last_constrained.as_implicitly_detachable.as_variant_free,
										l_last_class.class_id).actual_type
									if 	l_last_feature_type = Void then
										l_last_feature_type := l_feature_type
									elseif not l_last_feature_type.same_as (l_feature_type) then
											-- The two features have redefined their return type differently.
											-- We don't allow this: Add an error, but continue checking as this only an additional
											-- check and does not break anything else.
											-- Note: If `like Current' is the type of the feature this is ok, as the type is adapted to the formal.
										create l_vtmc4
										l_vtmc4.set_class (context.current_class)
										l_vtmc4.set_written_class (system.class_of_id (l_as.class_id))
										l_vtmc4.set_feature (context.current_feature)
										l_vtmc4.set_location (l_as.start_location)
										l_vtmc4.set_feature_info (l_result)
										error_handler.insert_error (l_vtmc4)
									end
								end
							end
						else
							l_last_class := l_last_constrained.base_class
							l_prefix_feature := l_last_class.feature_of_rout_id (l_as.routine_ids.first)
						end
					else
						if l_is_multi_constrained then
							l_type_set := last_type.actual_type.to_type_set.constraining_types (l_context_current_class)
							l_result_tuple := l_type_set.feature_i_state_by_alias_name (l_as.prefix_feature_name)
							if l_result_tuple.features_found_count > 1 then
								l_vtmc_error := new_vtmc_error (create {ID_AS}.initialize (l_as.prefix_feature_name),
										l_formal.position, l_context_current_class, True)
								l_vtmc_error.set_location (l_as.operator_location)
								error_handler.insert_error (l_vtmc_error)
							elseif l_result_tuple.features_found_count = 1 then
								l_prefix_feature := l_result_tuple.feature_item
								l_last_constrained := l_result_tuple.class_type_of_feature
								l_last_class := l_last_constrained.base_class
								last_calls_target_type := l_last_constrained
							end
						elseif l_last_constrained.has_associated_class then
							l_last_class := l_last_constrained.base_class
							l_prefix_feature := l_last_class.feature_table.alias_item (l_as.prefix_feature_name)
						elseif
							attached {LOCAL_TYPE_A} l_last_constrained as t and then
							attached t.operator_call (names_heap.id_of (l_as.prefix_feature_name), l_context_current_class) as f
						then
							l_prefix_feature := f.descriptor
							l_last_constrained := f.site
							l_last_class := l_last_constrained.base_class
							l_target_type := f.target
							last_calls_target_type := l_last_constrained
						end
					end
				end

				if error_level = l_error_level then
					if not l_last_constrained.is_known then
							-- Unknown feature in unknown class.
							-- Use unknown type as a result type.
						adapt_type_to_target (unknown_type, l_target_type, Void, l_is_controlled, l_as, 0, Void)
					elseif l_prefix_feature = Void then
							-- Error: not prefixed function found
						create l_vwoe
						context.init_error (l_vwoe)
						if l_last_class /= Void then
							l_vwoe.set_other_class (l_last_class)
						else
							l_vwoe.set_other_type_set (l_type_set)
						end
						l_vwoe.set_op_name (l_as.prefix_feature_name)
						l_vwoe.set_location (l_as.operator_location)
						error_handler.insert_error (l_vwoe)
					else
						if not is_inherited then
							l_as.set_class_id (l_last_class.class_id)
							set_routine_ids (l_prefix_feature.rout_id_set, l_as)
							check_obsolescence (l_prefix_feature, l_last_class, l_as.start_location)
						end

							-- Validate the feature used as prefix operator.
						check_prefix_feature (l_prefix_feature, l_last_class)

						if last_alias_error /= Void then
							last_alias_error.set_location (l_as.operator_location)
							error_handler.insert_error (last_alias_error)
						else
								-- Suppliers update
							if not is_inherited then
								create l_depend_unit.make_with_level (l_last_class.class_id, l_prefix_feature, depend_unit_level)
								context.supplier_ids.extend (l_depend_unit)
							end

								-- Assumes here that a prefix feature has no argument
								-- Update the type stack; instantiate the result of the
								-- refixed feature
							l_prefix_feature_type := l_prefix_feature.type
							if l_as.is_minus then
									-- Let's say if it is a special case the negation of a positive
									-- value in which case we maintain the type of the expression.
									-- E.g. -127 is of type INTEGER_8, not of type INTEGER
									--      -128 is of type INTEGER_16, since 128 is an INTEGER_16
									--      -511 is of type INTEGER_16, not of type INTEGER
									--
									-- FIXME: Manu 02/06/2004: we do not attempt here to ensure
									-- that `-128' is of type INTEGER_8. We will have to wait for ETL3
									-- to tell us what we need to do. The current behavior preserve
									-- compatibility with older version of Eiffel (5.4 and earlier).
								if attached {ATOMIC_AS} l_as.expr as l_value and attached {MANIFEST_INTEGER_A} l_last_constrained as l_manifest then
									l_prefix_feature_type := l_last_constrained
								else
										-- Usual case
									l_prefix_feature_type := l_prefix_feature_type.recomputed_in
										(last_type.as_implicitly_detachable.as_variant_free,
										l_context_current_class.class_id,
										l_last_constrained.as_implicitly_detachable.as_variant_free,
										l_last_class.class_id).actual_type
								end
							else
									-- Usual case
								l_prefix_feature_type := l_prefix_feature_type.recomputed_in
									(last_type.as_implicitly_detachable.as_variant_free,
									l_context_current_class.class_id,
									l_last_constrained.as_implicitly_detachable.as_variant_free,
									l_last_class.class_id).actual_type
							end
							if attached old_assigner_source then
								process_assigner_command (last_type, l_last_constrained, l_prefix_feature)
							end

							adapt_type_to_target (l_prefix_feature_type, l_target_type, l_prefix_feature, l_is_controlled, l_as, l_error_level, l_as.operator_location)

							if l_needs_byte_node then
								l_access := l_prefix_feature.access (last_type, True, l_target_type.is_separate)
									-- If we have something like `a.f' where `a' is predefined
									-- and `f' is a constant then we simply generate a byte
									-- node that will be the constant only. Otherwise if `a' is
									-- not predefined and `f' is a constant, we generate the
									-- complete evaluation `a.f'. However during generation,
									-- we will do an optimization by hardwiring value of constant.
								if l_is_multi_constrained then
									l_access.set_multi_constraint_static (last_calls_target_type)
								end
								if not (l_access.is_constant and l_expr.is_predefined) then
									l_unary := byte_anchor.unary_node (l_as)
									l_unary.set_expr (l_expr)
									l_unary.init (l_access)
									last_byte_node := l_unary
								else
									last_byte_node := l_access
								end
							end
						end
					end
				end
			end
			if error_level /= l_error_level then
				reset_types
			end
		end

	process_un_free_as (l_as: UN_FREE_AS)
		do
			process_unary_as (l_as)
		end

	process_un_minus_as (l_as: UN_MINUS_AS)
		do
			process_unary_as (l_as)
		end

	process_un_not_as (l_as: UN_NOT_AS)
		do
			process_unary_as (l_as)
		end

	process_un_old_as (l_as: UN_OLD_AS)
		local
			l_vaol1: VAOL1
			l_vaol2: VAOL2
			l_saved_vaol_check: BOOLEAN
			l_expr: EXPR_B
			l_un_old: UN_OLD_B
			s: INTEGER
		do
			if not is_checking_postcondition then
					-- Old expression found somewhere else that in a
					-- postcondition
				create l_vaol1
				context.init_error (l_vaol1)
				l_vaol1.set_location (l_as.expr.start_location)
				error_handler.insert_error (l_vaol1)
				reset_types
			else
				l_saved_vaol_check := check_for_vaol
				if not l_saved_vaol_check then
						-- Set flag for vaol check.
						-- Check for an old expression within
						-- an old expression.
					check_for_vaol := True
				end
					-- Record current scope information.
				s := context.scope
					-- Mark the beginning of the old expression
					-- (to prevent OT locals declared outside the old expression from being used inside it).
				context.add_old_expression_scope
					-- Expression type check
				l_as.expr.process (Current)
					-- Restore scope information.
				context.set_scope (s)
				if attached last_type as t then
					set_type (t, l_as)
					if not l_saved_vaol_check then
							-- Reset flag for vaol check
						check_for_vaol := False
					end

					if t.conform_to (context.current_class, Void_type) or else check_for_vaol then
							-- Not an expression
						create l_vaol2
						context.init_error (l_vaol2)
						l_vaol2.set_location (l_as.expr.end_location)
						error_handler.insert_error (l_vaol2)
					elseif is_byte_node_enabled then
						l_expr ?= last_byte_node
						create l_un_old
						l_un_old.set_expr (l_expr)
						if old_expressions = Void then
							create old_expressions.make
						end
						old_expressions.put_front (l_un_old)
						last_byte_node := l_un_old
					end
					if not is_inherited then
						l_as.set_class_id (class_id_of (t.actual_type))
					end
				end
			end
		end

	process_un_plus_as (l_as: UN_PLUS_AS)
		do
			process_unary_as (l_as)
		end

	process_binary_as (l_as: BINARY_AS)
		require
			l_as_not_void: l_as /= Void
		local
			l_infix_type: TYPE_A
			l_left_type, l_right_type: TYPE_A
			l_feature_type, l_last_feature_type: TYPE_A
			l_right_constrained, l_left_constrained: TYPE_A
			l_target_type: TYPE_A
			l_left_id: INTEGER
			l_depend_unit: DEPEND_UNIT
			l_vuex: VUEX
			l_error: ERROR
			l_target_conv_info: CONVERSION_INFO
			l_left_expr, l_right_expr: EXPR_B
			l_needs_byte_node: BOOLEAN
			l_binary: BINARY_B
			l_call_access: CALL_ACCESS_B
			old_assigner_source: like assigner_source
			l_is_left_multi_constrained: BOOLEAN
			l_class: CLASS_C
			l_context_current_class: CLASS_C
			s: INTEGER
			l_error_level: NATURAL_32
			l_arg_types: ARRAYED_LIST [TYPE_A]
			l_parameters: EIFFEL_LIST [EXPR_AS]
			l_result: LIST [TUPLE [feature_i: FEATURE_I; cl_type: RENAMED_TYPE_A]]
			l_result_item: TUPLE [feature_i: FEATURE_I; cl_type: RENAMED_TYPE_A]
			l_type_set: TYPE_SET_A
			l_vtmc4: VTMC4
			l_is_controlled: BOOLEAN
			scope_matcher: AST_SCOPE_MATCHER
			old_is_byte_node_enabled: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled
			l_context_current_class := context.current_class

				-- Reset assigner call
			old_assigner_source := assigner_source
			assigner_source := Void

			l_error_level := error_level

				-- First type check the left operand
			l_as.left.process (Current)
			l_target_type := last_type
			if attached l_target_type then
				if l_target_type.is_separate then
					validate_separate_target (Void, l_as.left)
					l_is_controlled := is_controlled
				end
				l_left_type := l_target_type.actual_type
				if l_left_type.is_formal and then attached {FORMAL_A} l_left_type as l_formal then
					if l_formal.is_multi_constrained (l_context_current_class) then
						l_is_left_multi_constrained := True
					else
						l_left_constrained := l_formal.constrained_type (l_context_current_class)
					end
				else
					l_left_constrained := l_left_type
				end

				if l_needs_byte_node then
					l_left_expr ?= last_byte_node
				end

				if not l_is_left_multi_constrained  then
					check l_left_constrained_attached: l_left_constrained /= Void end
						-- Check if target is not of type NONE
					if l_left_constrained.is_none then
						create l_vuex.make_for_none (l_as.infix_function_name)
						context.init_error (l_vuex)
						l_vuex.set_location (l_as.operator_location)
						error_handler.insert_error (l_vuex)
					end
				end

				if error_level = l_error_level then
						-- Then type check the right operand.
						-- Apply CAPs for semi-strict operators if applicable.
					if
						l_target_type.is_boolean and then
						attached
							if is_inherited then
									-- Use recorded information.
								l_target_type.base_class.feature_of_rout_id (l_as.routine_ids.first)
							else
									-- Lookup for an associated feature.
								l_target_type.base_class.feature_of_alias_id (names_heap.id_of (l_as.infix_function_name))
							end
						as f
					then
							-- Rely on predefined feature name.
						inspect f.feature_name_id
						when {PREDEFINED_NAMES}.conjuncted_semistrict_name_id then
							create {AST_SCOPE_CONJUNCTIVE_EXPRESSION} scope_matcher.make (context)
						when {PREDEFINED_NAMES}.disjuncted_semistrict_name_id then
							create {AST_SCOPE_DISJUNCTIVE_EXPRESSION} scope_matcher.make (context)
						when {PREDEFINED_NAMES}.implication_name_id then
							create {AST_SCOPE_IMPLICATIVE_EXPRESSION} scope_matcher.make (context)
						else
								-- Some other operator.
						end
					end
					if scope_matcher /= Void then
						s := context.scope
						scope_matcher.add_scopes (l_as.left)
					end
					l_as.right.process (Current)
					if scope_matcher /= Void then
						context.set_scope (s)
					end
					if last_type /= Void then
						l_right_type := last_type.actual_type
						if l_right_type.is_formal and then attached {FORMAL_A} l_right_type as l_formal then
							if not l_formal.is_multi_constrained (l_context_current_class) then
								l_right_constrained := l_formal.constrained_type (l_context_current_class)
							end
						else
							l_right_constrained	:= l_right_type
						end

						if l_needs_byte_node then
							l_right_expr ?= last_byte_node
						end

							-- Conformance: take care of constrained genericity and
							-- of the balancing rule for the simple numeric types
						if is_inherited then
							if l_is_left_multi_constrained and then attached {FORMAL_A} l_left_type as l_formal then
									-- This code here is very similar to `process_access_feat_as'.
									-- Note: We do not need to protect against TUPLE access here since
									-- named tuples are not allowed in multiple-constraint.
									-- We need to iterate through the type set to find the routine of ID													
								l_type_set := context.current_class.constraints (l_formal.position)
								l_type_set := l_type_set.constraining_types (context.current_class)
								l_result := l_type_set.feature_i_list_by_rout_id (l_as.routine_ids.first)
								check at_least_one_feature_found: l_result.count > 0 end
										-- As we inherited this feature there's the possiblity that now,
								from
									l_result.start
								until
									l_result.after or l_vtmc4 /= Void or l_error /= Void
								loop
									l_result_item := l_result.item
									last_alias_feature := l_result_item.feature_i
									l_left_constrained := l_result_item.cl_type.type
									l_class := l_left_constrained.base_class
									check_infix_feature (last_alias_feature, l_class, l_as.infix_function_name, l_left_type, l_left_constrained, l_right_type)
									l_error := last_alias_error
									l_result.forth
										-- We inherited this feature.
									if l_error = Void then
										l_feature_type := last_alias_feature.type
										l_feature_type := l_feature_type.recomputed_in
											(l_left_type.as_implicitly_detachable.as_variant_free,
											l_context_current_class.class_id,
											l_left_constrained.as_implicitly_detachable.as_variant_free,
											l_class.class_id)
										if l_feature_type.has_like_argument then
											create l_arg_types.make (1)
											l_arg_types.extend (l_right_type)
											l_feature_type := l_feature_type.actual_argument_type (l_arg_types)
										end
										l_feature_type := l_feature_type.actual_type
										if 	l_last_feature_type = Void then
											l_last_feature_type := l_feature_type
										elseif not l_last_feature_type.same_as (l_feature_type) then
												-- The two features have redefined their return type differently.
												-- We don't allow this: Add an error, but continue checking as this only an additional
												-- check and does not break anything else.
												-- Note: If `like Current' is the type of the feature this is ok, as the type is adapted to the formal.
											create l_vtmc4
											l_vtmc4.set_class (context.current_class)
											l_vtmc4.set_written_class (system.class_of_id (l_as.class_id))
											l_vtmc4.set_feature (context.current_feature)
											l_vtmc4.set_location (l_as.start_location)
											l_vtmc4.set_feature_info (l_result)
											error_handler.insert_error (l_vtmc4)
										end
									end
								end
							else
								l_class := l_left_constrained.base_class
								last_alias_feature := l_class.feature_of_rout_id (l_as.routine_ids.first)
								check_infix_feature (last_alias_feature, l_class, l_as.infix_function_name, l_left_type, l_left_constrained, l_right_type)
								l_error := last_alias_error
							end
						else
							if
								attached {LOCAL_TYPE_A} l_left_type as t and then
								attached t.operator_call (names_heap.id_of (l_as.infix_function_name), l_context_current_class) as f
							then
								l_left_constrained := f.site
								l_class := l_left_constrained.base_class
								l_left_type := f.target
								l_target_type := l_left_type
							end
							if l_left_type.is_known then
								if is_infix_valid (l_left_type, l_right_type, l_as.infix_function_name, l_as.operator_location) then
									check last_calls_target_type /= Void end
									if l_left_constrained = Void then
										l_left_constrained := last_calls_target_type
									end
								else
									l_error := last_alias_error
									if not is_inherited and then l_left_type.convert_to (context.current_class, l_right_type.deep_actual_type) then
										l_target_conv_info := context.last_conversion_info
										if is_infix_valid (l_right_type, l_right_type, l_as.infix_function_name, l_as.operator_location) then
											l_right_constrained := last_calls_target_type
											l_left_constrained := l_right_constrained
											l_error := Void
											if attached scope_matcher then
													-- The target boolean type of a semi-strict operator is replaced with something else.
													-- Re-check the right-hand side for regular operator instead.
												context.set_scope (s)
												old_is_byte_node_enabled := is_byte_node_enabled
												is_byte_node_enabled := False
												l_as.right.process (Current)
												is_byte_node_enabled := old_is_byte_node_enabled
											end
										else
											l_target_conv_info := Void
										end
									end
								end
							end
						end

						check no_error_implies_feature: (l_error = Void and l_target_type.is_known) implies last_alias_feature /= Void end

						if error_level /= l_error_level then
								-- There was an error, ingnore further processing.
						elseif attached l_error then
								-- Raise error here.
							if attached {VWOE1} l_error then
								l_error.set_location (l_as.right.start_location)
							else
								l_error.set_location (l_as.operator_location)
							end
							error_handler.insert_error (l_error)
						elseif l_target_type.is_known then
								-- Process conversion if any.
							if l_target_conv_info /= Void then
								check
									no_conversion_if_right_type_is_formal: not l_right_type.is_formal
									therefore_l_right_constrained_not_void: l_right_constrained /= Void
									not_inherited: not is_inherited
								end
								l_class := l_right_constrained.base_class
								check not_is_inherited: not is_inherited end
								if l_target_conv_info.has_depend_unit then
									context.supplier_ids.extend (l_target_conv_info.depend_unit)
								end
								l_as.set_left (converted_expression (l_as.left, l_target_conv_info))
								l_target_type := l_target_conv_info.target_type
								if l_needs_byte_node then
									l_left_expr := l_target_conv_info.byte_node (l_left_expr)
								end
							else
								l_class := l_left_constrained.base_class
								l_target_type := l_left_type
							end

							l_left_id := l_class.class_id

							if not l_target_type.is_attached and then is_void_safe_call then
								error_handler.insert_error (create {VUTA2}.make (context, l_target_type, l_as.operator_location))
							end

							if not is_inherited then
									-- Set type informations
								set_routine_ids (last_alias_feature.rout_id_set, l_as)
								l_as.set_class_id (l_left_id)
								check_obsolescence (last_alias_feature, l_class, l_as.right.start_location)
								if context.current_class.is_catcall_detection_enabled then
									create l_arg_types.make (1)
									l_arg_types.extend (l_right_type)
									create l_parameters.make (1)
									l_parameters.extend (l_as.right)
									check_cat_call (l_target_type, last_alias_feature, l_arg_types, l_as.left.start_location, l_parameters)
								end
							end

							if last_infix_argument_conversion_info /= Void then
								check not_inherited: not is_inherited end
								if last_infix_argument_conversion_info.has_depend_unit then
									context.supplier_ids.extend (last_infix_argument_conversion_info.depend_unit)
								end
								l_as.set_right (converted_expression (l_as.right, last_infix_argument_conversion_info))
								if l_needs_byte_node then
									l_right_expr ?= last_infix_argument_conversion_info.byte_node (l_right_expr)
								end
							end

								-- Suppliers update
							if not is_inherited then
								create l_depend_unit.make_with_level (l_left_id, last_alias_feature, depend_unit_level)
								context.supplier_ids.extend (l_depend_unit)
							end

								-- Update the type stack: instantiate result type of the
								-- infixed feature
							l_infix_type := last_alias_feature.type.recomputed_in
								(l_target_type.as_implicitly_detachable.as_variant_free,
								l_context_current_class.class_id,
								l_left_constrained.as_implicitly_detachable.as_variant_free,
								l_left_id)
							if l_infix_type.has_like_argument then
								create l_arg_types.make (1)
								l_arg_types.extend (l_right_type)
								l_infix_type := l_infix_type.actual_argument_type (l_arg_types)
							end
							l_infix_type := l_infix_type.actual_type

							if attached old_assigner_source then
								process_assigner_command (l_target_type, l_left_constrained, last_alias_feature)
							end

							adapt_type_to_target (l_infix_type, l_target_type, last_alias_feature, l_is_controlled, l_as, l_error_level, l_as.operator_location)

							if l_needs_byte_node then
								l_binary := byte_anchor.binary_node (l_as)
								l_binary.set_left (l_left_expr)
								l_binary.set_right (l_right_expr)

								l_call_access ?= last_alias_feature.access (last_type, True, l_target_type.is_separate)
									-- If we have a multi constrained formal we need to set the selected constrained type on which the call is done.
								if l_is_left_multi_constrained then
									l_call_access.set_multi_constraint_static (l_left_constrained.conformance_type)
								end
								l_binary.init (l_call_access)
									-- Add type to `parameters' in case we will need it later.
								l_binary.set_attachment (last_infix_arg_type)
								last_byte_node := l_binary
							end
						else
							set_type (unknown_type, l_as)
						end
					end
				end
			end
			if error_level /= l_error_level then
				reset_types
			end
			last_alias_error := Void
			last_alias_feature := Void
			last_infix_arg_type := Void
			last_infix_argument_conversion_info := Void
		end

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_free_as (l_as: BIN_FREE_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_implies_as (l_as: BIN_IMPLIES_AS)
		local
			l_implies: B_IMPLIES_B
			l_bool_val: VALUE_I
			l_old_expr: like old_expressions
		do
			l_old_expr := old_expressions
			old_expressions := Void
			process_binary_as (l_as)
			if
				last_type /= Void and then
				is_byte_node_enabled
			then
					-- Special optimization, if the left-hand side is False, then
					-- expression is evaluated to True and we discard any new UN_OLD_AS
					-- expressions as they are not needed.
				l_implies ?= last_byte_node
				check
					l_implies_not_void: l_implies /= Void
				end
				l_bool_val := l_implies.left.evaluate
				if l_bool_val.is_boolean and then not l_bool_val.boolean_value then
						-- Expression can be simplified into a Boolean constant
					create {BOOL_CONST_B} last_byte_node.make (True)
					old_expressions := l_old_expr
				else
						-- Add any new UN_OLD_AS expression we found during type checking.
					if old_expressions = Void then
						old_expressions := l_old_expr
					elseif l_old_expr /= Void and old_expressions /= Void then
						old_expressions.append (l_old_expr)
					end
				end
			end
		end

	process_bin_or_as (l_as: BIN_OR_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_or_else_as (l_as: BIN_OR_ELSE_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_xor_as (l_as: BIN_XOR_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_ge_as (l_as: BIN_GE_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_gt_as (l_as: BIN_GT_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_le_as (l_as: BIN_LE_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_lt_as (l_as: BIN_LT_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_div_as (l_as: BIN_DIV_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_minus_as (l_as: BIN_MINUS_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_mod_as (l_as: BIN_MOD_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_plus_as (l_as: BIN_PLUS_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_power_as (l_as: BIN_POWER_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_slash_as (l_as: BIN_SLASH_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_star_as (l_as: BIN_STAR_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_and_as (l_as: BIN_AND_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_eq_as (l_as: BIN_EQ_AS)
		local
			l_left_type, l_right_type: TYPE_A
			l_left_expr, l_right_expr: EXPR_B
			l_conv_info: CONVERSION_INFO
			l_binary: BINARY_B
			l_vweq: VWEQ
			l_needs_byte_node, l_conforming: BOOLEAN
			l_is_byte_node_simplified: BOOLEAN
			l_ne_as: BIN_NE_AS
		do
			l_needs_byte_node := is_byte_node_enabled

				-- First type check the left member
			l_as.left.process (Current)
			l_left_type := last_type
			if l_left_type /= Void and l_needs_byte_node then
				l_left_expr ?= last_byte_node
			end

				-- Then type check the right member
			l_as.right.process (Current)
			l_right_type := last_type
			if l_right_type /= Void and l_needs_byte_node then
				l_right_expr ?= last_byte_node
			end

			if l_left_type /= Void and then l_right_type /= Void then
					-- Check if `l_left_type' conforms to `l_right_type' or if
					-- `l_right_type' conforms to `l_left_type'.
				if not is_inherited then
					l_as.set_class_id (class_id_of (l_left_type))
				end
					-- Check if right/left hand side types conform to their counterparts
					-- including the case when they conform to the detachable versions.
					-- The detachable variants are separated and protected for efficiency reasons,
					-- as otherwise it would be easier to compare to the detachable versions from the beginning.
				if
					not is_inherited and then
					not (l_left_type.conform_to (context.current_class, l_right_type.actual_type) or else
					l_right_type.conform_to (context.current_class, l_left_type.actual_type) or else
					l_right_type.actual_type.is_attached and then l_left_type.conform_to (context.current_class, l_right_type.actual_type.as_detachable_type) or else
					l_left_type.actual_type.is_attached and then l_right_type.conform_to (context.current_class, l_left_type.actual_type.as_detachable_type))
				then
					if l_right_type.convert_to (context.current_class, l_left_type.deep_actual_type) then
						l_conv_info := context.last_conversion_info
						if l_conv_info.has_depend_unit then
							context.supplier_ids.extend (l_conv_info.depend_unit)
						end
						l_as.set_right (converted_expression (l_as.right, l_conv_info))
						if l_needs_byte_node then
							l_right_expr := l_conv_info.byte_node (l_right_expr)
						end
						l_conforming := True
					elseif l_left_type.convert_to (context.current_class, l_right_type.deep_actual_type) then
						l_conv_info := context.last_conversion_info
						if l_conv_info.has_depend_unit then
							context.supplier_ids.extend (l_conv_info.depend_unit)
						end
						l_as.set_left (converted_expression (l_as.left, l_conv_info))
						if l_needs_byte_node then
								l_left_expr := l_conv_info.byte_node (l_left_expr)
						end
						l_conforming := True
					end
					if not l_conforming then
							-- Report a warning (when enabled) except when comparing against
							-- Void if the other operand is expanded. That is to say it will
							-- not report an error for `a = Void' and `Void = a' if
							-- `a' is not expanded.
						if
							current_feature.written_in = context.current_class.class_id and then
							context.current_class.is_warning_enabled (w_vweq) and then
							((l_left_type.is_none xor l_right_type.is_none) implies
								(l_left_type.is_expanded or l_right_type.is_expanded))
						then
							create l_vweq
							context.init_error (l_vweq)
							l_vweq.set_left_type (l_left_type)
							l_vweq.set_right_type (l_right_type)
							l_vweq.set_location (l_as.operator_location)
							error_handler.insert_warning (l_vweq, context.current_class.is_warning_reported_as_error (w_vweq))
						end
						if l_left_type.is_basic and l_right_type.is_basic then
								-- Non-compatible basic type always implies a False/true comparison.
							l_is_byte_node_simplified := True
						end
					end
				end

				if l_needs_byte_node then
					if l_is_byte_node_simplified then
						l_ne_as ?= l_as
						if l_ne_as /= Void then
							create {BOOL_CONST_B} last_byte_node.make (True)
						else
							create {BOOL_CONST_B} last_byte_node.make (False)
						end
					else
						l_binary := byte_anchor.binary_node (l_as)
						l_binary.set_left (l_left_expr)
						l_binary.set_right (l_right_expr)
						last_byte_node := l_binary
					end
				end
			end
				-- Regardless of a failure in either expressions, we can still assume the return
				-- type to be a BOOLEAN, that way we can detect all the other errors in the englobing
				-- expressions if any.
			set_type (boolean_type, l_as)
		end

	process_bin_ne_as (l_as: BIN_NE_AS)
		do
			process_bin_eq_as (l_as)
		end

	process_bin_tilde_as (l_as: BIN_TILDE_AS)
		do
			process_bin_eq_as (l_as)
		end

	process_bin_not_tilde_as (l_as: BIN_NOT_TILDE_AS)
		do
			process_bin_tilde_as (l_as)
		end

	process_bracket_as (l_as: BRACKET_AS)
		local
			old_assigner_source: like assigner_source
			constrained_target_type: TYPE_A
			target_expr: EXPR_B
			target_access: ACCESS_EXPR_B
			bracket_feature: FEATURE_I
			id_feature_name: ID_AS
			location: LOCATION_AS
			call_b: CALL_B
			nested_b: NESTED_B
			l_is_multi_constraint: BOOLEAN
			l_access_b: ACCESS_B
			l_is_qualified_call: BOOLEAN
			l_error_level: NATURAL_32
		do
				-- Clean assigner call flag for bracket target
			old_assigner_source := assigner_source
			assigner_source := Void

			l_error_level := error_level

				-- Check target
			l_as.target.process (Current)
			if attached last_type as l_target_type then
				if is_byte_node_enabled then
					target_expr ?= last_byte_node
				end
				l_is_multi_constraint := attached {FORMAL_A} last_type.actual_type as p and then not p.is_single_constraint_without_renaming (context.current_class)
				lookup_feature_alias (bracket_str, l_as, l_as.left_bracket_location, l_target_type)

				if attached last_alias_error as e then
					error_handler.insert_error (e)
					last_alias_error := Void
				else
					bracket_feature := last_alias_feature
				end
				if l_target_type.is_separate then
					validate_separate_target (bracket_feature.feature_name_32, l_as.target)
				end

				if l_error_level = error_level then
					if attached bracket_feature then
							-- Process arguments
						create id_feature_name.initialize_from_id (bracket_feature.feature_name_id)
						location := l_as.left_bracket_location
						id_feature_name.set_position (location.line, location.column, location.position, location.location_count,
							location.character_column, location.character_position, location.character_count)
							-- Restore assigner source.
						assigner_source := old_assigner_source
						constrained_target_type := last_calls_target_type
							-- Process call to bracket feature
						l_is_qualified_call := is_qualified_call
						is_qualified_call := True
						process_call (last_type, Void, id_feature_name, last_alias_feature, l_as.operands, False, False, True, False, False)
						if attached last_type as t then
								-- Record type for the call as a whole.
							set_type (t, l_as)
						end
						is_qualified_call := l_is_qualified_call
						if error_level = l_error_level and then is_byte_node_enabled then
							create nested_b
							create target_access.make (target_expr)
							target_access.set_parent (nested_b)
							if l_is_multi_constraint then
								l_access_b ?= last_byte_node
									-- Last generated bytenode is from `process_call'.
								check is_access_b: l_access_b /= Void end
								l_access_b.set_multi_constraint_static (constrained_target_type)
								call_b := l_access_b
							else
								call_b ?= last_byte_node
							end

							check
								call_b_not_void: call_b /= Void
							end
							call_b.set_parent (nested_b)
							nested_b.set_message (call_b)
							nested_b.set_target (target_access)
							last_byte_node := nested_b
						end
					else
							-- Target of the bracket expression is unknown.
						set_type (unknown_type, l_as)
					end
				end
			end
			if error_level /= l_error_level then
				reset_types
			end
		end

	process_object_test_as (l_as: OBJECT_TEST_AS)
		local
			l_needs_byte_node: BOOLEAN
			local_id: ID_AS
			local_name_id: INTEGER
			local_type: TYPE_A
			local_info: LOCAL_INFO
			local_b: OBJECT_TEST_LOCAL_B
			expr: EXPR_B
			l_has_type_error: BOOLEAN
			l_bin_ne: BIN_NE_B
		do
			l_needs_byte_node := is_byte_node_enabled

				-- Type check object-test local name if present.
			local_id := l_as.name
			if attached local_id then
				local_name_id := local_id.name_id
				if
					not is_inherited and then
					(feature_table.has_id (local_name_id) or else
					current_feature.has_argument_name (local_name_id) or else
					context.locals.has (local_name_id) or else
					context.is_name_used (local_name_id))
				then
						-- The local name is the same as one used for an entity in the current scope.
					error_handler.insert_error (create {VUOT1}.make_from_context (context, local_id))
				end
			end

				-- There is no reason to check for object test local name clash
				-- as this will be detected and reported when their scopes intersect.
			if l_as.type /= Void then
				check_type (l_as.type)
				local_type := last_type
				if local_type /= Void then
					local_type := local_type.as_attached_in (context.current_class)
					if not is_inherited then
							-- No need to recheck for obsolete classes when checking inherited code.
						local_type.check_for_obsolete_class (context.current_class, context.current_feature)
					end

					if current_feature.written_in = context.current_class.class_id then
						instantiator.dispatch (local_type, context.current_class)
					end

					if local_type.has_associated_class then
							-- Add the supplier in the feature_dependance list
						context.supplier_ids.add_supplier (local_type.base_class)
					end
				else
					l_has_type_error := True
				end
			end

				-- Type check expression
			l_as.expression.process (Current)

			if attached last_type as expression_type and not l_has_type_error then
				if l_as.is_attached_keyword and local_type = Void then
						-- Set `local_type' to the type of the expression and make it attached.
					local_type := expression_type.as_attached_in (context.current_class)
				end
				check local_type_attached: local_type /= Void end
				if local_id /= Void or l_as.type /= Void then
						-- Avoid generating new object test local record when processing loop body multiple times.
					if local_id /= Void then
						local_info := context.unchecked_object_test_local (local_id)
					end
					if local_info = Void and then (local_id /= Void or else l_needs_byte_node) then
						create local_info.make (local_type, context.next_object_test_local_position)
						local_info.set_is_controlled (is_controlled)
						local_info.enable_is_used
						context.add_object_test_local (local_info, if attached local_id then local_id else create {ID_AS}.initialize ("dummy_" + context.hidden_local_counter.next.out) end)
					end

					if l_needs_byte_node then
						expr ?= last_byte_node
						create local_b.make (local_info.position, current_feature.body_index, local_type)
						create {OBJECT_TEST_B} last_byte_node.make (local_b, expr, expression_type.is_implicitly_attached, local_type.create_info, l_as.type = Void)
					end
				elseif l_needs_byte_node then
					create l_bin_ne
					expr ?= last_byte_node
					l_bin_ne.set_left (expr)
					l_bin_ne.set_right (create {VOID_B})
					last_byte_node := l_bin_ne
				end
			end

			if l_needs_byte_node and then last_type = Void then
					-- Generate a stub.
				create {BOOL_CONST_B} last_byte_node.make (False)
			end
			set_type (boolean_type, l_as)
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS)
		do
			-- Nothing to be done
		end

	process_feature_as (l_as: FEATURE_AS)
		local
			l_byte_code: BYTE_CODE
			l_list: BYTE_LIST [BYTE_NODE]
			l_property_name: STRING
			l_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			l_error_level: NATURAL_32
		do
			reset_byte_node
			l_error_level := error_level
			if current_feature.is_class then
				if current_feature.is_attribute then
						-- Ignore static external attributes.
					if attached current_feature.extension as e implies not e.is_static then
						report_vucr (create {VUCR_ATTRIBUTE}.make (current_feature, context.current_class, l_as.feature_name))
					end
				elseif current_feature.is_object_relative_once then
					report_vucr (create {VUCR_ONCE}.make (current_feature, context.current_class, l_as.feature_name))
				end
			end
			reset_for_unqualified_call_checking
			l_as.body.process (Current)
			if error_level = l_error_level then
				if is_byte_node_enabled then
					if attached {BYTE_CODE} last_byte_node as b then
						l_byte_code := b
					elseif not attached {IL_EXTENSION_I} current_feature.extension then
						create {ATTRIBUTE_BYTE_CODE} l_byte_code
						context.init_byte_code (l_byte_code)
						l_byte_code.set_end_location (l_as.end_location)
					end
					if attached l_byte_code then
						l_byte_code.set_start_line_number (l_as.start_location.line)
						l_byte_code.set_has_loop (has_loop)
						l_byte_code.set_has_hector (has_hector)
					end
				end
					-- For the moment, there is no point in checking custom attributes in non-dotnet mode.
					-- This fixes eweasel test#incr207.
				if system.il_generation then
					l_custom_attributes := l_as.custom_attributes
					if l_custom_attributes /= Void then
						l_custom_attributes.process (Current)
						if attached l_byte_code then
							l_list ?= last_byte_node
							l_byte_code.set_custom_attributes (l_list)
						end
					end
					l_custom_attributes := l_as.class_custom_attributes
					if l_custom_attributes /= Void then
						l_custom_attributes.process (Current)
						if attached l_byte_code then
							l_list ?= last_byte_node
							l_byte_code.set_class_custom_attributes (l_list)
						end
					end
					l_custom_attributes := l_as.interface_custom_attributes
					if l_custom_attributes /= Void then
						l_custom_attributes.process (Current)
						if attached l_byte_code then
							l_list ?= last_byte_node
							l_byte_code.set_interface_custom_attributes (l_list)
						end
					end
				end
				l_property_name := l_as.property_name
				if l_property_name /= Void then
					if attached l_byte_code then
						l_byte_code.set_property_name (l_property_name)
					end
					l_custom_attributes := l_as.property_custom_attributes
						-- See above comments for why it is only done in .NET mode.
					if l_custom_attributes /= Void and system.il_generation then
						l_custom_attributes.process (Current)
						if attached l_byte_code then
							l_list ?= last_byte_node
							l_byte_code.set_property_custom_attributes (l_list)
						end
					end
				end
				if is_byte_node_enabled then
					last_byte_node := l_byte_code
				end
			end
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS)
		do
			-- Nothing to be done
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS)
		do
			-- Nothing to be done.
		end

	process_feature_list_as (l_as: FEATURE_LIST_AS)
		do
			-- Nothing to be done
		end

	process_all_as (l_as: ALL_AS)
		do
			-- Nothing to be done
		end

	process_assign_as (l_as: ASSIGN_AS)
		local
			l_target_node: ACCESS_B
			l_source_expr: EXPR_B
			l_assign: ASSIGN_B
			l_ve03: VE03
			l_source_type, l_target_type: TYPE_A
			target_attribute: FEATURE_I
			l_vjar: VJAR
			l_warning_level: like {ERROR_HANDLER}.warning_level
			l_reinitialized_variable: like last_reinitialized_variable
			l_error_level: NATURAL_32
		do
			break_point_slot_count := break_point_slot_count + 1
			l_error_level := error_handler.error_level

				-- Init type stack
			reset_for_unqualified_call_checking

				-- Type check the target.
			last_reinitialized_variable := 0
			set_is_in_assignment (True)
			last_access_writable := False
			last_assignment_target := Void
			l_as.target.process (Current)
			set_is_in_assignment (False)
			target_attribute := last_assignment_target
			last_assignment_target := Void
				-- Record initialized variable to commit it after the expression is processed.
			l_reinitialized_variable := last_reinitialized_variable
			l_target_type := last_type
			if l_target_type /= Void then
				current_target_type := l_target_type

					-- Check if the target is not read-only mode.
				if not last_access_writable then
						-- Read-only entity
					create l_ve03
					context.init_error (l_ve03)
					l_ve03.set_target (l_as.target)
					l_ve03.set_location (l_as.target.end_location)
					error_handler.insert_error (l_ve03)
				end

				if is_byte_node_enabled then
					l_target_node ?= last_byte_node
				end
			end

				-- Type check the source
			l_as.source.process (Current)
			l_source_type := last_type

			if l_source_type /= Void and then l_target_type /= Void then
					-- Type checking
				l_warning_level := error_handler.warning_level
				process_type_compatibility (l_target_type)
				if not is_inherited then
					if l_target_type.is_like then
						system.conformance_checks.like_target := system.conformance_checks.like_target + 1
					end
					if l_target_type.same_as (l_source_type) then
						system.conformance_checks.same := system.conformance_checks.same + 1
					end
					system.conformance_checks.nb := system.conformance_checks.nb + 1
				end
				if not is_type_compatible.is_compatible then
					create l_vjar
					context.init_error (l_vjar)
					l_vjar.set_source_type (l_source_type)
					l_vjar.set_target_type (l_target_type)
					l_vjar.set_target_name (l_as.target.access_name)
					l_vjar.set_location (l_as.start_location)
					error_handler.insert_error (l_vjar)
				elseif
					attached target_attribute and then
					target_attribute.is_stable and then
					not l_source_type.is_implicitly_attached and then
					is_void_safe_conformance
				then
					error_handler.insert_error (create {VBAR2}.make (l_source_type, target_attribute, l_as.start_location, context))
				else
					if l_warning_level /= error_handler.warning_level then
						error_handler.warning_list.last.set_location (l_as.start_location)
					end
					if
						not is_inherited and then
						is_type_compatible.conversion_info /= Void
					then
						l_as.set_source (converted_expression (l_as.source, is_type_compatible.conversion_info))
					end
				end

				if l_error_level = error_handler.error_level and is_byte_node_enabled then
						-- Only create BYTE code if there is no error.
					l_source_expr ?= last_byte_node
					create l_assign.make (l_target_node, l_source_expr)
					l_assign.set_line_number (l_as.target.start_location.line)
					l_assign.set_line_pragma (l_as.line_pragma)
					last_byte_node := l_assign
				end
			end
			if attached l_target_type and then l_reinitialized_variable /= 0 then
				if not attached l_source_type or else l_source_type.is_attached or else l_source_type.is_implicitly_attached then
						-- Local variable is initialized to a non-void value.
						-- (A non-void value is also assumed if there was an error
						-- when evaluating source to avoid spurious error.)
					if l_reinitialized_variable = result_name_id then
						context.add_result_instruction_scope
						context.set_result
					elseif l_reinitialized_variable > 0 then
						context.add_local_instruction_scope (l_reinitialized_variable)
						context.set_local (l_reinitialized_variable)
					else
						context.add_attribute_instruction_scope (- l_reinitialized_variable)
					end
				elseif l_source_type.is_initialization_required then
						-- Local variable might become Void, but it is set.
					if l_reinitialized_variable = result_name_id then
						context.remove_result_scope
						context.set_result
					elseif l_reinitialized_variable > 0 then
						context.remove_local_scope (l_reinitialized_variable)
						context.set_local (l_reinitialized_variable)
					end
				else
						-- Local variable might become Void, and it is unset.
					if l_reinitialized_variable = result_name_id then
						context.remove_result_scope
						context.unset_result
					elseif l_reinitialized_variable > 0 then
						context.remove_local_scope (l_reinitialized_variable)
						context.unset_local (l_reinitialized_variable)
					end
				end
			end
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS)
			-- <Precursor>
		local
			l_call_b: INSTR_CALL_B
		do
			break_point_slot_count := break_point_slot_count + 1

			last_assigner_command := Void
			last_assignment_target := Void
				-- Set assigner call flag for target expression
			assigner_source := l_as.source
			l_as.target.process (Current)
			is_last_access_tuple_access := False
			if attached assigner_source as s and then s /= l_as.source then
					-- The source might have been updated to change conversion into account.
					-- Save these changes for future use.
				l_as.set_source (s)
			end
				-- We need to wrap the NESTED_B instance that was created if type check was
				-- successful otherwise we would not generate the proper debugger hook.
			if is_byte_node_enabled and then attached {NESTED_B} last_byte_node as l_call then
				create l_call_b.make (l_call, l_as.source.start_location.line)
				l_call_b.set_line_pragma (l_as.line_pragma)
				last_byte_node := l_call_b
			end
			assigner_source := Void
		end

	process_reverse_as (l_as: REVERSE_AS)
		local
			l_target_node: ACCESS_B
			l_source_expr: EXPR_B
			l_reverse: REVERSE_B
			l_ve03: VE03
			l_source_type, l_target_type: TYPE_A
			target_attribute: FEATURE_I
			l_vjrv1: VJRV1
			l_vjrv2: VJRV2
			l_vjrv3: VJRV3
			l_attribute: ATTRIBUTE_B
			l_create_info: CREATE_INFO
			l_reinitialized_variable: like last_reinitialized_variable
		do
			break_point_slot_count := break_point_slot_count + 1

				-- Init type stack
			reset_for_unqualified_call_checking

				-- Type check the target
			last_reinitialized_variable := 0
			last_access_writable := False
			set_is_in_assignment (True)
			last_assignment_target := Void
			l_as.target.process (Current)
			target_attribute := last_assignment_target
			last_assignment_target := Void
			set_is_in_assignment (False)
			l_target_type := last_type
			l_reinitialized_variable := last_reinitialized_variable
			if l_target_type /= Void then
				current_target_type := l_target_type

					-- Check if the target is not read-only mode.
				if not last_access_writable then
						-- Read-only entity
					create l_ve03
					context.init_error (l_ve03)
					l_ve03.set_target (l_as.target)
					l_ve03.set_location (l_as.target.end_location)
					error_handler.insert_error (l_ve03)
				elseif l_target_type.is_expanded then
					if not is_inherited and context.current_class.is_warning_enabled (w_vjrv) then
						create l_vjrv1
						context.init_error (l_vjrv1)
						l_vjrv1.set_target_name (l_as.target.access_name)
						l_vjrv1.set_target_type (l_target_type)
						l_vjrv1.set_location (l_as.target.end_location)
						error_handler.insert_warning (l_vjrv1, context.current_class.is_warning_reported_as_error (w_vjrv))
					end
				elseif
					is_void_safe_conformance and then
					(l_target_type.is_attached or else l_target_type.is_initialization_required)
				then
						-- Allowing assignment attempts on attached entities does not make sense
						-- since we cannot guarantee that the entity will not be Void after.
					create l_vjrv3
					context.init_error (l_vjrv3)
					l_vjrv3.set_target_name (l_as.target.access_name)
					l_vjrv3.set_target_type (l_target_type)
					l_vjrv3.set_location (l_as.target.end_location)
					error_handler.insert_error (l_vjrv3)
				elseif
					attached target_attribute and then
					target_attribute.is_stable and then
					is_void_safe_conformance
				then
					error_handler.insert_error (create {VBAR2}.make (l_target_type.as_detachable_type, target_attribute, l_as.start_location, context))
				elseif l_target_type.actual_type.is_formal then
					check attached {FORMAL_A} l_target_type.actual_type as l_formal then
						if
							not l_formal.is_reference and
							(not is_inherited and context.current_class.is_warning_enabled (w_vjrv))
						then
							create l_vjrv2
							context.init_error (l_vjrv2)
							l_vjrv2.set_target_name (l_as.target.access_name)
							l_vjrv2.set_target_type (l_target_type)
							l_vjrv2.set_location (l_as.target.end_location)
							error_handler.insert_warning (l_vjrv2, context.current_class.is_warning_reported_as_error (w_vjrv))
						end
					end
				end

				if is_byte_node_enabled then
					l_target_node ?= last_byte_node
				end

					-- Type check the source
				l_as.source.process (Current)
				l_source_type := last_type
				if l_source_type /= Void then
					if is_byte_node_enabled then
						l_source_expr ?= last_byte_node
						create l_reverse.make (l_target_node, l_source_expr)
						l_reverse.set_line_number (l_as.target.start_location.line)
						l_reverse.set_line_pragma (l_as.line_pragma)
						if l_target_node.is_attribute then
							l_attribute ?= l_target_node
							create {CREATE_FEAT} l_create_info.make (l_attribute.attribute_id,
								l_attribute.routine_id)
							if system.il_generation then
									-- we need to record into current class
								context.current_class.extend_type_set (l_attribute.routine_id)
							end
						else
							l_create_info := l_target_type.create_info
						end
						l_reverse.set_info (l_create_info)
						last_byte_node := l_reverse
					end
					if l_reinitialized_variable /= 0 then
							-- Local variable might become Void.
						if l_reinitialized_variable = result_name_id then
							context.remove_result_scope
							context.unset_result
						elseif l_reinitialized_variable > 0 then
							context.remove_local_scope (l_reinitialized_variable)
							context.unset_local (l_reinitialized_variable)
						end
					end
				elseif l_reinitialized_variable /= 0 then
						-- The was an error evaluating source expression.
						-- Mark target as attached to avoid spurious errors.
					if l_reinitialized_variable = result_name_id then
						context.add_result_instruction_scope
						context.set_result
					elseif l_reinitialized_variable > 0 then
						context.add_local_instruction_scope (l_reinitialized_variable)
						context.set_local (l_reinitialized_variable)
					else
						context.add_attribute_instruction_scope (- l_reinitialized_variable)
					end
				end
			end
		end

	process_check_as (l_as: CHECK_AS)
		local
			l_check: CHECK_B
			l_list: BYTE_LIST [BYTE_NODE]
			s: INTEGER
		do
			if l_as.check_list /= Void then
					-- Attachment properties are not propagated outside the check instruction.
				set_is_checking_check (True)
				s := context.scope
				if is_void_safe_construct then
						-- Strict void safety: no variables change their attachment status because of this assertion.
					context.enter_realm
					process_eiffel_list_with_matcher (l_as.check_list, create {AST_SCOPE_ASSERTION}.make (context), Void)
					context.leave_optional_realm
					context.set_scope (s)
				else
						-- Soft void safety: variables may change attachment status because of this assertion.
					process_eiffel_list_with_matcher (l_as.check_list, create {AST_SCOPE_ASSERTION}.make (context), Void)
					context.remove_object_test_scopes (s)
				end
				set_is_checking_check (False)

				if is_byte_node_enabled then
					l_list ?= last_byte_node
					create l_check
					l_check.set_check_list (l_list)
					l_check.set_line_number (l_as.check_list.start_location.line)
					l_check.set_end_location (l_as.end_keyword)
					l_check.set_line_pragma (l_as.line_pragma)
					last_byte_node := l_check
				end
			elseif is_byte_node_enabled then
				create l_check
				l_check.set_end_location (l_as.end_keyword)
				l_check.set_line_pragma (l_as.line_pragma)
				last_byte_node := l_check
			end
		end

	process_creation_call (f: detachable FEATURE_I; t: detachable TYPE_A; c: detachable CLASS_C; a: ACCESS_FEAT_AS; n: AST_EIFFEL; r: TYPE_A)
			-- Process a call to creation feature `f` on base type `t` from class `c` of creation type `r`
			-- updating `last_type` associated with node `n` and `last_calls_target_type`.
		require
			attached f ⇒ attached t
		local
			target_type: TYPE_A
			creation_procedure: FEATURE_I
			creation_type: TYPE_A
		do
			target_type := t
			creation_type := r
			if attached t and then attached c and then c.is_once then
				creation_procedure := f
				if not attached creation_procedure then
					creation_procedure :=
						if is_inherited then
							c.feature_of_rout_id (a.routine_ids.first)
						else
							c.feature_of_name_id (a.feature_name.name_id)
						end
				end
			end
			last_calls_target_type := target_type
			process_call (creation_type, Void, a.feature_name, f, a.parameters, False, False, False, False, False)
				-- Set type after evaluating the call to override `last_type` set to `VOID_A`.
			set_type (creation_type, n)
		end

	process_abstract_creation (a_creation_type: TYPE_A; a_call: ACCESS_FEAT_AS; a_name: STRING; typed_node: AST_EIFFEL; a_location: LOCATION_AS)
		require
			a_creation_type_not_void: a_creation_type /= Void
			a_location_not_void: a_location /= Void
		local
			l_call_access: ROUTINE_B
			l_formal_type: FORMAL_A
			l_generic_type: GEN_TYPE_A
			l_formal_dec: FORMAL_CONSTRAINT_AS
			l_creation_class: CLASS_C
			l_creation_type: TYPE_A
			l_renamed_creation_type: RENAMED_TYPE_A
			l_is_formal_creation, l_is_default_creation: BOOLEAN
			l_feature, l_feature_item: FEATURE_I
			l_orig_call, l_call: ACCESS_FEAT_AS
			l_vgcc1: VGCC1
			l_vgcc11: VGCC11
			l_vgcc2: VGCC2
			l_vgcc4: VGCC4
			l_vgcc5: VGCC5
			l_creators: like {CLASS_C}.creators
			l_needs_byte_node: BOOLEAN
			l_actual_creation_type: TYPE_A
			l_type_set: TYPE_SET_A
			l_constraint_type, l_last_type: TYPE_A
			l_deferred_classes: ARRAYED_LIST [CLASS_C]
			l_is_multi_constraint_case: BOOLEAN
			l_is_deferred: BOOLEAN
			l_constraint_creation_list: LIST [TUPLE [type_item: RENAMED_TYPE_A; feature_item: FEATURE_I]]
			l_ccl_item: TUPLE [type_item: RENAMED_TYPE_A; feature_item: FEATURE_I]
			l_mc_feature_info: MC_FEATURE_INFO
			l_result: LIST [TUPLE [feature_i: FEATURE_I; cl_type: RENAMED_TYPE_A]]
			l_result_item: TUPLE [feature_i: FEATURE_I; cl_type: RENAMED_TYPE_A]
			l_original_default_create_name_id: INTEGER
			l_context_current_class: CLASS_C
			l_error_level: NATURAL_32
			l_is_qualified_call: BOOLEAN
			is_target_type_known: BOOLEAN
		do
			l_error_level := error_level
			l_needs_byte_node := is_byte_node_enabled
			l_orig_call := a_call
			l_actual_creation_type := a_creation_type.actual_type
			l_context_current_class := context.current_class

			is_target_type_known := True

			l_generic_type ?= l_actual_creation_type

			if l_actual_creation_type.is_formal then
					-- Cannot be Void
				l_formal_type ?= l_actual_creation_type

				if l_formal_type.is_single_constraint_without_renaming (l_context_current_class) then
					l_constraint_type := l_formal_type.constrained_type (l_context_current_class).as_attached_in (context.current_class)
					l_creation_type := l_constraint_type
					l_creation_class := l_constraint_type.base_class
					l_is_deferred := l_creation_class.is_deferred
				else
					l_is_multi_constraint_case := True
					l_type_set := l_formal_type.constrained_types  (l_context_current_class)
					l_is_deferred := l_type_set.has_deferred
				end
					-- Get the corresponding constraint type of the current class
				l_formal_dec ?= l_context_current_class.generics.i_th (l_formal_type.position)
				check l_formal_dec_not_void: l_formal_dec /= Void end
				if
					l_formal_dec.has_constraint and then
					l_formal_dec.has_creation_constraint
				then
					l_is_formal_creation := True
						-- Ensure to update `has_default_create' from `l_formal_dec'
					l_formal_dec.constraint_creation_list (l_context_current_class).do_nothing
				else
						-- An entity of type a formal generic parameter cannot be
						-- created here because there is no creation routine constraints
					create l_vgcc1
					context.init_error (l_vgcc1)
					l_vgcc1.set_target_name (a_name)
					l_vgcc1.set_location (a_location)
					error_handler.insert_error (l_vgcc1);
				end
			else
				if l_generic_type /= Void  then
					l_generic_type.reset_constraint_error_list
					l_generic_type.check_constraints (l_context_current_class , context.current_feature, True)
					l_generic_type.generate_error_from_creation_constraint_list (l_context_current_class , context.current_feature, a_location)
				end
				l_constraint_type := l_actual_creation_type
				l_creation_type := l_constraint_type
				if l_creation_type.is_known then
					l_creation_class := l_constraint_type.base_class
					l_is_deferred := l_creation_class.is_deferred
				else
					is_target_type_known := False
				end
			end

			if error_level = l_error_level then
				if l_is_deferred and then not l_is_formal_creation then
						-- Associated class cannot be deferred
					if l_is_multi_constraint_case then
							-- We generate a list of all the deferred classes in the type set
						l_deferred_classes := l_type_set.deferred_classes
					else
							-- There's only one class and it is deferred
						create l_deferred_classes.make (1)
						l_deferred_classes.extend (l_creation_class)
					end

					create l_vgcc2
					context.init_error (l_vgcc2)
					l_vgcc2.set_type (a_creation_type)
					l_vgcc2.set_deferred_classes (l_deferred_classes)
					l_vgcc2.set_target_name (a_name)
					l_vgcc2.set_location (a_location)
					error_handler.insert_error (l_vgcc2)
				elseif is_target_type_known then
					if
						l_orig_call = Void and then
						((l_creation_class /= Void and then l_creation_class.allows_default_creation) or else
						(l_is_formal_creation and then l_formal_dec.has_default_create))
					then
						if l_creation_class /= Void  then
							check not_is_multi_constraint_case: not l_is_multi_constraint_case end
							l_feature := l_creation_class.default_create_feature
							l_creation_type := l_creation_class.actual_type
							l_original_default_create_name_id := l_feature.feature_name_id
						else
							check
								is_multi_constrainet_case: l_is_multi_constraint_case
								l_formal_type_not_void: l_formal_type /= Void
								l_formal_dec_not_void: l_formal_dec /= Void
								l_creation_class_is_void: l_creation_class = Void
								second_part_of_if_is_true: l_is_formal_creation and then l_formal_dec.has_default_create
							end
								-- What we want to do is the following:
								-- We go through the list of creation constraints and have a look at each feature.
								-- If a feature is a version of `default_create' from `ANY' we record it.
								-- We should find exactly one feature as otherwise l_formal_dec.has_default_create should not have been true.						
							l_constraint_creation_list := l_formal_dec.constraint_creation_list (l_context_current_class)
							from
								l_constraint_creation_list.start
							until
								l_constraint_creation_list.after or l_creation_class /= Void
							loop
								l_ccl_item := l_constraint_creation_list.item
								l_feature_item := l_ccl_item.feature_item
								if l_feature_item.rout_id_set.first = system.default_create_rout_id then
									l_feature := l_feature_item
									l_renamed_creation_type := l_ccl_item.type_item
									if l_renamed_creation_type.has_renaming then
										l_original_default_create_name_id := l_renamed_creation_type.renaming.new_name (l_feature.feature_name_id)
									else
										l_original_default_create_name_id  := l_feature.feature_name_id
									end
									l_creation_type := l_renamed_creation_type.type.as_attached_in (context.current_class)
									l_creation_class := l_creation_type.base_class
									set_type (l_creation_type, a_call)
								end
								l_constraint_creation_list.forth
							end

							check
								found_item_was_the_only_one:
									(agent (a_constraint_creation_list: LIST [TUPLE [type_item: RENAMED_TYPE_A; feature_item: FEATURE_I]]): BOOLEAN
											-- Check that there is no more version of default create.
											--| Otherwise we should never get in here as `l_formal_dec.has_default_create'
											--| should have returned false and prevented this from happening.
										do
											Result := True
											from do_nothing
											until
												a_constraint_creation_list.after
											loop
												if a_constraint_creation_list.item.feature_item.rout_id_set.first = system.default_create_rout_id then
													Result := False
												end
											a_constraint_creation_list.forth
											end
										end).item ([l_constraint_creation_list])
							end
						end

						check l_feature /= Void  end
						check l_creation_class /= Void  end

							-- Use default_create
						create {ACCESS_INV_AS} l_call.make (
							create {ID_AS}.initialize_from_id (l_original_default_create_name_id), Void, Void)
							-- For better error reporting as we insert a dummy call for type checking.
						l_call.feature_name.set_position (a_location.line, a_location.column, a_location.position, a_location.location_count,
							a_location.character_column, a_location.character_position, a_location.character_count)
							-- The line below is to ensure that a call to `default_create' will be
							-- generated (see eweasel test#exec280) but only for non .NET classes
							-- (see eweasel test#dotnet007).
						if l_creation_class = Void or else not l_creation_class.is_external then
							l_orig_call := l_call
						end
							-- The AST node is temporary, there is no need to keep track
							-- of its modification by calling `set_routine_ids'.
						l_call.set_routine_ids (l_feature.rout_id_set)
						l_is_default_creation := True
					else
						l_call := l_orig_call
					end

					if l_creation_class /= Void then
						l_creators := l_creation_class.creators
					end

					if l_call /= Void then
							-- A creation call has to be considered as a qualified call.
							-- This fixes eweasel test#term161.
						l_is_qualified_call := is_qualified_call
						is_qualified_call := True
						if is_inherited then
							if l_is_multi_constraint_case then
									-- We need to iterate through the type set to find the routine of ID
								check
										-- It should work as we are in the multi constraint case
									l_formal_type_not_void: l_formal_type /= Void
								end
								l_result := l_type_set.feature_i_list_by_rout_id (l_call.routine_ids.first)
								check at_least_one_feature_found: l_result.count > 0 end
								from
									l_result.start
								until
									l_result.after
								loop
									l_result_item := l_result.item
									l_feature := l_result_item.feature_i
									l_creation_type := l_result_item.cl_type.type
									l_creation_class := l_creation_type.base_class
									last_calls_target_type := l_creation_type
										-- Store `last_type' as it will be reset by call to `process_call' to the type
										-- of the procedure, that is to say Void and thus will cause an incorrect VKCN(3) error
										-- to be reported.
									l_last_type := last_type
										-- Type check the call
									process_creation_call (l_feature, l_creation_type, l_creation_class, l_call, typed_node, a_creation_type)
										-- Even though this code is very similar to the one in `process_access_feat_as' we do not
										-- need to adapt last_type as this is a creation procedure without a result, but we still
										-- need to restore it.
									last_type := l_last_type
									l_result.forth
								end
									-- Martins 3/29/2007
									-- After the loop we simply continue with whatever feature was last found.
									-- Is this a good idea? Well, it depends:
									-- We have done all checks, so whatever it might be, we're fine.
									-- But if we would have to generate new code (replication?) it is not decideable what to do
									-- because the selection of the static type of the call has an influence to the dynamic binding.
									-- And we have possibly more than one possibility to chose from and they are equally acceptable.
								fixme ("Possibly a multi constraint issue (in the future) regarding dynamic binding.")
							else
								check l_creation_class_not_void: l_creation_class /= Void end
								l_feature := l_creation_class.feature_of_rout_id (l_call.routine_ids.first)
								process_creation_call (l_feature, l_creation_type, l_creation_class, l_call, typed_node, a_creation_type)
							end
						else
								-- Type check the call
							process_creation_call (l_feature, l_creation_type, l_creation_class, l_call, typed_node, a_creation_type)
						end
						is_qualified_call := l_is_qualified_call

						if error_level = l_error_level then
							if not is_inherited then
									-- Set some type informations		
								if l_is_multi_constraint_case then
									check
										last_calls_target_not_void: last_calls_target_type /= Void
										conforming: l_creation_class /= Void implies
											last_calls_target_type.base_class.conform_to (l_creation_class)
									end
									l_call.set_class_id (last_calls_target_type.base_class.class_id)
								else
									l_call.set_class_id (l_creation_class.class_id)
								end
									-- Note that `last_routine_id_set' could be Void in case it is
									-- a named tuple access.
								if last_routine_id_set /= Void then
									set_routine_ids (last_routine_id_set, l_call)
								end
							end

							if l_needs_byte_node and then l_orig_call /= Void then
								l_call_access ?= last_byte_node
								if l_is_multi_constraint_case and then l_is_default_creation then
									check
										no_static_set: not l_call_access.has_multi_constraint_static
									end
									l_call_access.set_multi_constraint_static (l_creation_type)
								end
							end

							if not l_is_formal_creation then
									-- Check if creation routine is non-once procedure
								if not l_creation_class.valid_creation_procedure (last_feature_name) then
									create l_vgcc5
									context.init_error (l_vgcc5)
									l_vgcc5.set_target_name (a_name)
									l_vgcc5.set_type (a_creation_type)
									l_vgcc5.set_creation_feature (l_creation_class.feature_table.item (last_feature_name))
									l_vgcc5.set_location (l_call.feature_name)
									error_handler.insert_error (l_vgcc5)
								elseif
									attached l_creators and then
									not l_creators.item (last_feature_name_id).valid_for (l_context_current_class)
								then
										-- Creation procedure is not exported
									create l_vgcc5
									context.init_error (l_vgcc5)
									l_vgcc5.set_target_name (a_name)
									l_vgcc5.set_type (a_creation_type)
									l_vgcc5.set_creation_feature (
										l_creation_class.feature_table.item_id (last_feature_name_id))
									l_vgcc5.set_location (l_call.feature_name)
									error_handler.insert_error (l_vgcc5)
								end
							else
									-- Check that the creation feature used for creating the generic
									-- parameter has been listed in the constraint for the generic
									-- parameter.
								if not l_formal_dec.has_creation_feature_name_id (last_actual_feature_name_id) then
									create l_vgcc11
									context.init_error (l_vgcc11)
									l_vgcc11.set_target_name (a_name)
									if l_is_multi_constraint_case then
										l_mc_feature_info := l_type_set.info_about_feature_by_name_id (last_original_feature_name_id, l_formal_type.position, l_context_current_class)
										if not l_mc_feature_info.is_empty then
											l_vgcc11.set_creation_feature (l_mc_feature_info.first.feature_i)
										end
									else
										check l_creation_class /= Void end
										l_vgcc11.set_creation_feature (l_creation_class.feature_table.item (last_feature_name))
									end

									l_vgcc11.set_location (l_call.feature_name)
									error_handler.insert_error (l_vgcc11)
								end
							end
						end
					else
						if not l_is_formal_creation then
							if not attached l_creators or l_is_default_creation then
							elseif l_creators.is_empty then
								create l_vgcc5
								context.init_error (l_vgcc5)
								l_vgcc5.set_target_name (a_name)
								l_vgcc5.set_type (a_creation_type)
								l_vgcc5.set_creation_feature (Void)
								l_vgcc5.set_location (a_location)
								error_handler.insert_error (l_vgcc5)
							else
								create l_vgcc4
								context.init_error (l_vgcc4)
								l_vgcc4.set_target_name (a_name)
								l_vgcc4.set_type (a_creation_type)
								l_vgcc4.set_location (a_location)
								error_handler.insert_error (l_vgcc4)
							end
						else
								-- An entity of type a formal generic parameter cannot be
								-- created here because we need a creation routine call
							create l_vgcc1
							context.init_error (l_vgcc1)
							l_vgcc1.set_target_name (a_name)
							l_vgcc1.set_location (a_location)
							error_handler.insert_error (l_vgcc1)
						end
					end
					if l_needs_byte_node then
						last_byte_node := l_call_access
					end
				end
			end
		end

	generate_creation (
			l_is_active: BOOLEAN;
			l_access: ACCESS_B;
			l_call_access: ROUTINE_B;
			l_creation_type: TYPE_A;
			l_explicit_type: TYPE_A;
			l: LOCATION_AS)
		require
			l_access_attached: l_access /= Void
			l_creation_type_attached: l_creation_type /= Void
		local
			t: TYPE_A
			l_creation_expr: CREATION_EXPR_B
			l_assign: ASSIGN_B
			l_create_info: CREATE_INFO
		do
			t := l_creation_type
				-- Compute creation information
			if t.is_expanded then
					-- Even if there is an anchor, once a type is expanded it
					-- cannot change.
				t := t.conformance_type
				if t.is_formal then
						-- Even if the constraint is expanded, we still keep the formal information
						-- for creation. This fixes eweasel test#final093.
					l_create_info := t.create_info
				else
					create {CREATE_TYPE} l_create_info.make (t)
				end
			elseif not attached l_explicit_type and then attached {ATTRIBUTE_B} l_access as l_attribute then
					-- When we create an attribute without a type specification,
					-- then we need to create an instance matching the possible redeclared
					-- type of the attribute in descendant classes.
				create {CREATE_FEAT} l_create_info.make (l_attribute.attribute_id, l_attribute.routine_id)
			else
				l_create_info := t.create_info
			end

			if system.il_generation and attached {CREATE_FEAT} l_create_info as l_info then
					-- We need to record into current class that there is a creation
					-- using a feature, i.e. an anchor. This fixes eweasel test#dotnet100.
				context.current_class.extend_type_set (l_info.routine_id)
			end

			create l_creation_expr
			l_creation_expr.set_is_active (l_is_active)
			l_creation_expr.set_info (l_create_info)
				-- When this is not `default_create'.
			if l_call_access /= Void then
				l_creation_expr.set_call (l_call_access)
				l_creation_expr.set_multi_constraint_static (l_call_access.multi_constraint_static)
			end

			check t /= Void end
			l_creation_expr.set_type (t)
			l_creation_expr.set_creation_instruction (True)
			l_creation_expr.set_line_number (l.line)

			create l_assign.make (l_access, l_creation_expr)
			l_assign.set_line_number (l.line)
			check
				l_assign.is_creation_instruction
			end

			last_byte_node := l_assign
		end

	process_debug_as (l_as: DEBUG_AS)
		local
			l_debug: DEBUG_B
			l_list: BYTE_LIST [BYTE_NODE]
			l_node_keys: ARRAYED_LIST [STRING]
		do
			if l_as.compound /= Void then
				context.enter_realm
				process_compound (l_as.compound)
				context.leave_optional_realm
				if is_byte_node_enabled then
					l_list ?= last_byte_node
					create l_debug
					l_debug.set_compound (l_list)
					if l_as.keys /= Void then
						from
							create l_node_keys.make (0)
							l_node_keys.start
							l_as.keys.start
						until
							l_as.keys.after
						loop
							l_node_keys.extend (l_as.keys.item.value)
							l_as.keys.forth
						end
						l_debug.set_keys (l_node_keys)
					end
					l_debug.set_line_number (l_as.compound.start_location.line)
					l_debug.set_end_location (l_as.end_keyword)
					l_debug.set_line_pragma (l_as.line_pragma)
					last_byte_node := l_debug
				end
			elseif is_byte_node_enabled then
				create l_debug
				l_debug.set_end_location (l_as.end_keyword)
				last_byte_node := l_debug
			end
		end

	process_guard_as (l_as: GUARD_AS)
		local
			a: BYTE_LIST [BYTE_NODE]
			c: BYTE_LIST [BYTE_NODE]
			g: GUARD_B
			s: INTEGER
			l_needs_byte_node: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled
			context.enter_realm
			s := context.scope
			if attached l_as.check_list as l then
					-- Type check assertions.
				process_eiffel_list_with_matcher (l, create {AST_SCOPE_ASSERTION}.make (context), Void)
				if l_needs_byte_node then
					a ?= last_byte_node
				end
					-- If there is a false value, the instruction always fails.
				if
					l.there_exists (
						agent (t: TAGGED_AS): BOOLEAN
							do
								Result := attached {BOOL_AS} t.expr as b and then not b.value
							end
					)
				then
					context.set_all
				end
			end
			if attached l_as.compound as l then
					-- Type check compound.
				process_compound (l)
				if l_needs_byte_node then
					c ?= last_byte_node
				end
			end
			context.set_scope (s)
			context.leave_realm

			if l_needs_byte_node then
				create g.make (a, c, l_as.end_keyword)
				if attached l_as.start_location as l then
					g.set_line_number (l.line)
				end
				g.set_line_pragma (l_as.line_pragma)
				last_byte_node := g
			end
		end

	process_if_as (l_as: IF_AS)
		local
			l_vwbe1: VWBE1
			l_needs_byte_node: BOOLEAN
			l_if: IF_B
			l_expr: EXPR_B
			l_list: BYTE_LIST [BYTE_NODE]
			s: INTEGER
			scope_matcher: AST_SCOPE_MATCHER
		do
			l_needs_byte_node := is_byte_node_enabled
			break_point_slot_count := break_point_slot_count + 1

				-- Type check the test
			l_as.condition.process (Current)
			if last_type /= Void then
				if l_needs_byte_node then
					create l_if
					l_expr ?= last_byte_node
					l_if.set_condition (l_expr)
					l_if.set_line_pragma (l_as.line_pragma)
				end

					-- Check conformance to boolean
				if not last_type.actual_type.is_known then
						-- Record expected type.
					last_type.actual_type.conform_to (context.current_class, boolean_type).do_nothing
				elseif not last_type.actual_type.is_boolean then
					create l_vwbe1
					context.init_error (l_vwbe1)
					l_vwbe1.set_type (last_type)
					l_vwbe1.set_location (l_as.condition.end_location)
					error_handler.insert_error (l_vwbe1)
				end
			else
					-- An error occurred, no byte code generation can be allowed.
				l_needs_byte_node := False
			end

				-- Type check on compound
			context.enter_realm
			create {AST_SCOPE_CONJUNCTIVE_CONDITION} scope_matcher.make (context)
			s := context.scope
			scope_matcher.add_scopes (l_as.condition)
			if l_as.compound /= Void then
				process_compound (l_as.compound)
				if l_needs_byte_node then
					l_list ?= last_byte_node
					l_if.set_compound (l_list)
				end
			end
			context.set_scope (s)
			context.save_sibling

			create {AST_SCOPE_DISJUNCTIVE_CONDITION} scope_matcher.make (context)
			s := context.scope
			scope_matcher.add_scopes (l_as.condition)
			context.update_realm

				-- Type check on alternaltives compounds
			if l_as.elsif_list /= Void then
				l_as.elsif_list.process (Current)
				if l_needs_byte_node then
					l_list ?= last_byte_node
					l_if.set_elsif_list (l_list)
				end
			end
				-- Type check on default compound
			if l_as.else_part /= Void then
				process_compound (l_as.else_part)
				if l_needs_byte_node then
					l_list ?= last_byte_node
					l_if.set_else_part (l_list)
				end
			end
				-- Even though Else part might be empty,
				-- we record its void safety information.
			context.save_sibling

			context.set_scope (s)
			context.leave_realm

			if l_needs_byte_node then
				l_if.set_line_number (l_as.condition.start_location.line)
				l_if.set_end_location (l_as.end_keyword)
				last_byte_node := l_if
			end
		end

	process_if_expression_as (l_as: IF_EXPRESSION_AS)
			-- <Precursor>
		local
			l_vwbe1: VWBE1
			l_needs_byte_node: BOOLEAN
			l_if: IF_EXPRESSION_B
			l_condition: detachable EXPR_B
			l_then_expression: detachable EXPR_B
			l_else_expression: detachable EXPR_B
			l_list: BYTE_LIST [ELSIF_EXPRESSION_B]
			s: INTEGER
			scope_matcher: AST_SCOPE_MATCHER
			l_expression_type: detachable TYPE_A
			l_error_level: like error_level
			l_type_list: like last_expressions_type
			old_expressions_type: like last_expressions_type
		do
			old_expressions_type := last_expressions_type
			last_expressions_type := Void
			l_error_level := error_level
			l_needs_byte_node := is_byte_node_enabled
			break_point_slot_count := break_point_slot_count + 1

				-- Type check the test
			l_as.condition.process (Current)
			if last_type /= Void then
				if l_needs_byte_node and then attached {EXPR_B} last_byte_node as c then
					l_condition := c
				end

					-- Check conformance to boolean
				if not last_type.actual_type.is_known then
						-- Record expected type.
					last_type.actual_type.conform_to (context.current_class, boolean_type).do_nothing
				elseif not last_type.actual_type.is_boolean then
					create l_vwbe1
					context.init_error (l_vwbe1)
					l_vwbe1.set_type (last_type)
					l_vwbe1.set_location (l_as.condition.end_location)
					error_handler.insert_error (l_vwbe1)
				end
			end

				-- Type check on expression.
			context.enter_realm
			create {AST_SCOPE_CONJUNCTIVE_CONDITION} scope_matcher.make (context)
			s := context.scope
			scope_matcher.add_scopes (l_as.condition)
			l_as.then_expression.process (Current)
			if attached last_type as e then
				create l_type_list.make (if attached l_as.elsif_list as l then l.count else 0 end + 2)
				l_type_list.extend (e)
				last_expressions_type := l_type_list
				l_expression_type := e
				if l_needs_byte_node and then attached {EXPR_B} last_byte_node as t  then
					l_then_expression := t
				end
			end
			context.set_scope (s)
			context.save_sibling

			create {AST_SCOPE_DISJUNCTIVE_CONDITION} scope_matcher.make (context)
			s := context.scope
			scope_matcher.add_scopes (l_as.condition)
			context.update_realm

				-- Type check on alternaltives compounds
			if attached l_expression_type and then attached l_as.elsif_list as l then
				create l_list.make (l.count)
				process_eiffel_list_with_matcher (l, Void, l_list)
			end
				-- Type check on default expression.
			l_as.else_expression.process (Current)
			if attached last_type as t and then l_needs_byte_node and then attached {EXPR_B} last_byte_node as e then
				if attached l_type_list then
					l_type_list.extend (t)
					l_expression_type := maximal_type (l_type_list)
				end
				l_else_expression := e
			end
				-- Even though Else part might be empty,
				-- we record its void safety information.
			context.save_sibling

			context.set_scope (s)
			context.leave_realm

			if attached l_condition and then attached l_then_expression and then attached l_else_expression then
				create l_if.make (l_condition, l_then_expression, l_list, l_else_expression, l_expression_type, l_as.end_keyword)
				l_if.set_line_number (l_as.condition.start_location.line)
				last_byte_node := l_if
			end

			if error_level = l_error_level then
					-- Update expression type.
				set_type (l_expression_type, l_as)
			else
				reset_types
			end
			last_expressions_type := old_expressions_type
		end

	process_inspect_abstraction
		(a: INSPECT_ABSTRACTION_AS [CASE_ABSTRACTION_AS [detachable AST_EIFFEL], detachable AST_EIFFEL];
		f: MULTI_BRANCH_FACTORY)
		local
			l_vomb1: VOMB1
			l_controler: detachable INSPECT_CONTROL
			l_inspect: ABSTRACT_INSPECT_B [ABSTRACT_CASE_B [BYTE_NODE], BYTE_NODE]
			l_constraint_type: TYPE_A
			l_formal: FORMAL_A
			l_type: TYPE_A
			s: like context.scope
			local_info: LOCAL_INFO
			o: OBJECT_TEST_LOCAL_B
			nested_b: NESTED_B
		do
			break_point_slot_count := break_point_slot_count + 1

			a.switch.process (Current)
			if attached last_type as t then
				if is_byte_node_enabled and then attached {EXPR_B} last_byte_node as e then
					if
						not t.is_basic and then
						attached t.base_class as b and then
						attached b.feature_of_name_id (names_heap.inspect_attribute_name_id) as i
					then
						create local_info.make (t, context.next_object_test_local_position)
						local_info.enable_is_used
						context.add_object_test_local (local_info, create {ID_AS}.initialize ("dummy_" + context.hidden_local_counter.next.out))
						create o.make (local_info.position, current_feature.body_index, t)
						create nested_b
						nested_b.set_target (o)
						nested_b.set_message (i.access (i.type, True, False))
						nested_b.message.set_parent (nested_b)
						l_inspect := f.new_construct
							(create {IF_EXPRESSION_B}.make
								(create {OBJECT_TEST_B}.make (o, e, t.is_implicitly_attached, t.create_info, True),
								nested_b,
								Void,
								create {INTEGER_CONSTANT}.make_from_type (i.type, False, "0"),
								i.type,
								Void),
							a)
					else
						l_inspect := f.new_construct (e, a)
					end
				end

					-- Type check if it is an expression conform either to
					-- and integer or to a character
				l_type := t.actual_type
				if not l_type.is_formal then
					l_constraint_type := l_type
				elseif attached {FORMAL_A} l_type as formal_type and then not l_formal.is_multi_constrained (context.current_class) then
					l_constraint_type := formal_type.constrained_type (context.current_class)
				end

				if
					attached l_constraint_type implies (
					not l_constraint_type.is_integer and then not l_constraint_type.is_character and then
					not l_constraint_type.is_natural and then not l_constraint_type.is_enum and then
					not (attached l_constraint_type.base_class as b and then b.is_once) and then
					l_constraint_type.is_known)
				then
						-- Error
					create l_vomb1
					context.init_error (l_vomb1)
					l_vomb1.set_type (l_type)
					l_vomb1.set_location (a.switch.end_location)
					error_handler.insert_error (l_vomb1)
				else
						-- Initialization of the multi-branch controler if no errors are detected.
					create l_controler.make (l_constraint_type)
				end
			end

			inspect_controlers.put_front (l_controler)
			context.enter_realm
			if attached a.case_list as l then
				process_eiffel_list_with_matcher (l, Void, f.new_case_list (l.count))
				if
					attached l_inspect and then
					attached {like {ABSTRACT_INSPECT_B [ABSTRACT_CASE_B [detachable BYTE_NODE], detachable BYTE_NODE]}.case_list} last_byte_node as b
				then
					l_inspect.set_case_list (b.remove_voids)
				end
			end

			if attached a.else_part as e then
				s := context.scope
				e.process (Current)
				context.set_scope (s)
				context.save_sibling
				if attached last_expressions_type as ts and then attached last_type as t then
					ts.extend (t)
				end
				if attached l_inspect then
					if attached {BYTE_LIST [BYTE_NODE]} last_byte_node as b then
							-- Compound.
						l_inspect.set_else_part (b)
					elseif attached {EXPR_B} last_byte_node as b then
							-- Expression.
						l_inspect.set_else_part (b)
					end
				end
			end
			context.leave_realm
			if attached l_inspect then
				l_inspect.set_line_number (a.switch.start_location.line)
				l_inspect.set_end_location (a.end_keyword)
				last_byte_node := l_inspect
			end
			inspect_controlers.start
			inspect_controlers.remove
		end

	process_inspect_as (a: INSPECT_AS)
			-- <Precursor>
		local
			old_type_list: like last_expressions_type
		do
			old_type_list := last_expressions_type
			last_expressions_type := Void
			process_inspect_abstraction (a, multi_branch_instruction_factory)
			last_expressions_type := old_type_list
		end

	process_inspect_expression_as (a: INSPECT_EXPRESSION_AS)
			-- <Precursor>
		local
			old_type_list: like last_expressions_type
			old_error_level: like error_handler.error_level
			t: TYPE_A
		do
			old_error_level := error_handler.error_level
			old_type_list := last_expressions_type
			create last_expressions_type.make
				(if attached a.case_list as l then l.count else 0 end +
				if attached a.else_part then 1 else 0 end)
			process_inspect_abstraction (a, multi_branch_expression_factory)
			if old_error_level = error_handler.error_level then
				t := maximal_type (last_expressions_type)
				if attached {INSPECT_EXPRESSION_B} last_byte_node as b then
					b.set_type (t)
				end
				set_type (t, a)
			else
				reset_types
			end
			last_expressions_type := old_type_list
		end

	process_instr_call_as (l_as: INSTR_CALL_AS)
		local
			l_vkcn1: VKCN1
			l_call: CALL_B
			l_call_b: INSTR_CALL_B
			l_list: LEAF_AS_LIST
		do
			break_point_slot_count := break_point_slot_count + 1

			reset_for_unqualified_call_checking
			l_as.call.process (Current)
			if attached last_type as t then
				if not t.is_void and then t.is_known then
					create l_vkcn1
					context.init_error (l_vkcn1)
					l_vkcn1.set_location (l_as.call.end_location)
					l_list := match_list_of_class (context.written_class.class_id)
					if l_list /= Void and l_as.call.is_text_available (l_list) then
						l_vkcn1.set_called_feature (l_as.call.text (l_list))
					end
					error_handler.insert_error (l_vkcn1)
				elseif is_byte_node_enabled then
					l_call ?= last_byte_node
					create l_call_b.make (l_call, l_as.call.start_location.line)
					l_call_b.set_line_pragma (l_as.line_pragma)
					last_byte_node := l_call_b
				end
			end
		end

	process_loop_as (l_as: LOOP_AS)
		local
			l_vwbe4: VWBE4
			l_needs_byte_node: BOOLEAN
			l_list: BYTE_LIST [BYTE_NODE]
			l_loop: LOOP_B
			l_variant: VARIANT_B
			s, q: INTEGER
			iteration_cursor_scope: INTEGER
			scope_matcher: AST_SCOPE_MATCHER
			e: like error_level
			invariant_as: like {LOOP_AS}.invariant_part
			variant_as: VARIANT_AS
			exit_as: EXPR_AS
			i: detachable ITERATION_AS
			local_info: LOCAL_INFO
			local_type: TYPE_A
			iteration_cursor_type: TYPE_A
			is_infinite: BOOLEAN
		do
			has_loop := True
			l_needs_byte_node := is_byte_node_enabled

			if l_needs_byte_node then
				create l_loop
				l_loop.set_line_pragma (l_as.line_pragma)
			end

			i := l_as.iteration
			if i /= Void then
					-- Record the state of inner locals before iteration to restore it after the loop.
				iteration_cursor_scope := context.scope
					-- Process Iteration part.
				i.process (Current)
				if l_needs_byte_node and then attached {BYTE_LIST [BYTE_NODE]} last_byte_node as iteration_part then
					l_loop.set_iteration_initialization (iteration_part)
				end
					-- Record the type of the cursor that is used to drive the loop.
				iteration_cursor_type := last_type
				if iteration_cursor_type /= Void then
					local_info := context.object_test_local (l_as.iteration.identifier.name_id)
				end
				if local_info /= Void then
						-- Record original type of the cursor that is visible to the user.
					local_type := local_info.type
				end
			end
			if local_info = Void then
					-- There was an error or there is no iteration part, so we do not care which local info to modify.
				create local_info.make (none_type, 0)
			end
			if l_as.from_part /= Void then
					-- Type check the from part
					-- Processing is done on the same level as the outer instructions
					-- because the effective scope of setters is at that level
				l_as.from_part.process (Current)
				if l_needs_byte_node and then attached {BYTE_LIST [BYTE_NODE]} last_byte_node as from_part then
					l_loop.set_from_part (from_part)
				end
			end

			if attached i and then attached iteration_cursor_type then
					-- Avoid processing iteration exit condition and item access when iteration part has errors.
					-- Check iteration exit condition and item access assuming the cursor is of ITERATION_CURSOR type.
				if attached local_info.expression then
					local_info.disable_is_cursor
				end
				if is_inherited then
						-- Rely on routine ID computed earlier.
					i.exit_condition.process (Current)
				else
						-- Check the call and compute associated routine ID for the top iteration cursor type.
					local_info.set_type (iteration_cursor_type)
					is_byte_node_enabled := False
					i.exit_condition.process (Current)
					is_byte_node_enabled := l_needs_byte_node
					local_info.set_type (local_type)
						-- If everything is OK, recompute the code using actual local type.
					if last_type /= Void then
						is_inherited := True
						i.exit_condition.process (Current)
						is_inherited := False
					end
				end
				if attached local_info.expression then
					local_info.enable_is_cursor
				end
				if last_type /= Void then
						-- Check if it is a boolean expression.
					if not last_type.actual_type.is_known then
							-- Record expected type.
						last_type.actual_type.conform_to (context.current_class, boolean_type).do_nothing
					elseif not last_type.actual_type.is_boolean then
						create l_vwbe4
						context.init_error (l_vwbe4)
						l_vwbe4.set_type (last_type)
						l_vwbe4.set_location (i.end_location)
						error_handler.insert_error (l_vwbe4)
					elseif l_needs_byte_node and then attached {EXPR_B} last_byte_node as ec then
							-- Save generated code.
						l_loop.set_iteration_exit_condition (ec)
					end
				end
			end

			invariant_as := l_as.invariant_part
			variant_as := l_as.variant_part
			exit_as := l_as.stop

				-- Type check the loop invariant, variant, exit condition and compound
				-- in a loop that computes new attachment information at every iteration.
			context.enter_realm
			from
				e := error_level
				create {AST_SCOPE_DISJUNCTIVE_CONDITION} scope_matcher.make (context)
				s := context.scope
				check
					has_at_least_one_iteration: not context.is_sibling_dominating
				end
			until
				context.is_sibling_dominating or else e /= error_level
			loop
					-- Record most recent scope information before the loop, so that
					-- it can be compared with the information after the loop on next iteration.
				context.update_sibling
				if attached invariant_as then
						-- Type check the invariant loop
					context.enter_realm
					q := context.scope
					process_eiffel_list_with_matcher (invariant_as, create {AST_SCOPE_ASSERTION}.make (context), Void)
					context.set_scope (q)
					context.leave_optional_realm
					if is_byte_node_enabled then
						l_list ?= last_byte_node
						l_loop.set_invariant_part (l_list)
					end
				end
				if attached variant_as then
						-- Type check th variant loop
					variant_as.process (Current)
					if is_byte_node_enabled then
						l_variant ?= last_byte_node
						l_loop.set_variant_part (l_variant)
					end
				end
					-- Type check the exit test.
				if exit_as /= Void then
					exit_as.process (Current)
					if last_type /= Void then
							-- Check if it is a boolean expression
						if not last_type.actual_type.is_known then
								-- Record expected type.
							last_type.actual_type.conform_to (context.current_class, boolean_type).do_nothing
						elseif not last_type.actual_type.is_boolean then
							create l_vwbe4
							context.init_error (l_vwbe4)
							l_vwbe4.set_type (last_type)
							l_vwbe4.set_location (exit_as.end_location)
							error_handler.insert_error (l_vwbe4)
						elseif is_byte_node_enabled and then attached {EXPR_B} last_byte_node as ec then
							l_loop.set_stop (ec)
						end
						break_point_slot_count := break_point_slot_count + 1
							-- Mark loop as an infinite if it has no iteration part
							-- and the exit condition is constant false.
						is_infinite := i = Void and then attached {BOOL_AS} exit_as as b and then not b.value
					end
						-- It's safe to take loop exit condition into account even when iteration is present,
						-- because if the loop is entered neither iteration nor loop exit conditions are True.
					scope_matcher.add_scopes (exit_as)
				end
				if attached l_as.compound as c then
					process_compound (c)
						-- Save byte code if required.
					if is_byte_node_enabled then
						l_list ?= last_byte_node
						l_loop.set_compound (l_list)
					end
				else
						-- Make sure the compound byte code is empty in case we have Iteration part.
					l_list := Void
				end
					-- Set `is_byte_node_enabled' to `False' to avoid regenerating
					-- the code next time.
					-- The original value will be restored from `l_needs_byte_node'.
				is_byte_node_enabled := False
				context.set_scope (s)
			end
			is_byte_node_enabled := l_needs_byte_node
			context.leave_realm

			if i /= Void then
					-- Avoid processing iteration advancement when iteration part has errors.
				if attached iteration_cursor_type then
						-- Generate cursor movement assuming the cursor is of ITERATION_CURSOR type.
					e := error_level
					if attached local_info.expression then
						local_info.disable_is_cursor
					end
					if is_inherited then
							-- Rely on routine ID computed earlier.
						i.advance.process (Current)
					else
							-- Check the call and compute associated routine ID for the top iteration cursor type.
						local_info.set_type (iteration_cursor_type)
						is_byte_node_enabled := False
						i.advance.process (Current)
						is_byte_node_enabled := l_needs_byte_node
						local_info.set_type (local_type)
							-- If everything is OK, recompute the code using actual local type.
						if error_level = e then
							is_inherited := True
							i.advance.process (Current)
							is_inherited := False
						end
					end
					if attached local_info.expression then
						local_info.enable_is_cursor
					end
					if error_level = e and then l_needs_byte_node then
						create l_list.make (1)
						l_list.extend (last_byte_node)
						l_loop.set_advance_code (l_list)
					end
				end
					-- Remove cursor's scope.
				context.remove_object_test_scopes (iteration_cursor_scope)
			end

			if i = Void and then exit_as /= Void then
					-- Take exit condition into account if there is no iteration
					-- because if iteration is present, the loop can be exited prematurely
					-- ignoring the loop exit condition.
				create {AST_SCOPE_CONJUNCTIVE_CONDITION} scope_matcher.make (context)
				scope_matcher.add_scopes (exit_as)
			end

			if l_needs_byte_node then
				if attached exit_as then
					l_loop.set_line_number (exit_as.start_location.line)
				end
				l_loop.set_end_location (l_as.end_leaf)
				last_byte_node := l_loop
			end

				-- Record loop for optimizations in final mode
			system.optimization_tables.force (
				create {OPTIMIZE_UNIT}.make (context.current_class.class_id,
					current_feature.body_index))

				-- Mark the code after the loop unreachable if the loop is infinite.
			if is_infinite then
				context.set_all
			end
		end

	process_loop_expr_as (l_as: LOOP_EXPR_AS)
		local
			iteration_as: ITERATION_AS
			local_info: LOCAL_INFO
			local_type: TYPE_A
			iteration_cursor_type: TYPE_A
			exit_as: EXPR_AS
			iteration_cursor_scope: INTEGER
			iteration_code: detachable BYTE_LIST [BYTE_NODE]
			invariant_code: detachable BYTE_LIST [BYTE_NODE]
			variant_code: detachable VARIANT_B
			iteration_exit_condition_code: detachable EXPR_B
			exit_condition_code: detachable EXPR_B
			expression_code: detachable EXPR_B
			advance_code: detachable BYTE_NODE
			s: INTEGER
			l_vwbe4: VWBE4
			old_is_byte_node_enabled: BOOLEAN
		do
			iteration_as := l_as.iteration
				-- Record the state of inner locals before iteration to restore it after the loop.
			iteration_cursor_scope := context.scope
				-- Process Iteration part.
			iteration_as.process (Current)
				-- Remember generated code.
			if is_byte_node_enabled and then attached {BYTE_LIST [BYTE_NODE]} last_byte_node as iteration_part then
				iteration_code := iteration_part
			end
				-- Record the type of the cursor that is used to drive the loop.
			iteration_cursor_type := last_type
			if iteration_cursor_type /= Void then
				local_info := context.object_test_local (l_as.iteration.identifier.name_id)
			end
			if local_info /= Void then
					-- Record original type of the cursor that is visible to the user.
				local_type := local_info.type
			else
					-- There was an error, so we do not care where to set the type.
				create local_info.make (none_type, 0)
					-- Skip code generation for next parts.
				iteration_code := Void
			end
			if l_as.invariant_part /= Void then
					-- Type check the invariant loop
				context.enter_realm
				s := context.scope
				process_eiffel_list_with_matcher (l_as.invariant_part, create {AST_SCOPE_ASSERTION}.make (context), Void)
				context.set_scope (s)
				context.leave_optional_realm
				if iteration_code /= Void then
					if attached {BYTE_LIST [BYTE_NODE]} last_byte_node as invariant_part then
						invariant_code := invariant_part
					else
							-- Skip code generation for next parts.
						iteration_code := Void
					end
				end
			end
			if l_as.variant_part /= Void then
					-- Type check th variant loop
				l_as.variant_part.process (Current)
				if iteration_code /= Void then
					if attached {VARIANT_B} last_byte_node as variant_part then
						variant_code := variant_part
					else
							-- Skip code generation for next parts.
						iteration_code := Void
					end
				end
			end

				-- Avoid processing iteration exit condition when iteration part has errors.
			if attached iteration_cursor_type then
				if attached local_info.expression then
					local_info.disable_is_cursor
				end
				if is_inherited then
						-- Rely on routine ID computed earlier.
					iteration_as.exit_condition.process (Current)
				else
						-- Check iteration exit condition assuming the cursor is of ITERATION_CURSOR type.
					local_info.set_type (iteration_cursor_type)
					old_is_byte_node_enabled := is_byte_node_enabled
					is_byte_node_enabled := False
					iteration_as.exit_condition.process (Current)
					is_byte_node_enabled := old_is_byte_node_enabled
					local_info.set_type (local_type)
							-- If everything is OK, recompute the code using actual local type.
					if attached last_type then
						is_inherited := True
						iteration_as.exit_condition.process (Current)
						is_inherited := False
					end
				end
				if attached local_info.expression then
					local_info.enable_is_cursor
				end
				if last_type = Void then
						-- Skip code generation for next parts.
					iteration_code := Void
				else
						-- Check if it is a boolean expression
					if not last_type.actual_type.is_known then
							-- Record expected type.
						last_type.actual_type.conform_to (context.current_class, boolean_type).do_nothing
					elseif not last_type.actual_type.is_boolean then
						create l_vwbe4
						context.init_error (l_vwbe4)
						l_vwbe4.set_type (last_type)
						l_vwbe4.set_location (iteration_as.end_location)
						error_handler.insert_error (l_vwbe4)
							-- Skip code generation for next parts.
						iteration_code := Void
					elseif iteration_code /= Void then
						if attached {EXPR_B} last_byte_node as ec then
							iteration_exit_condition_code := ec
						else
								-- Skip code generation for next parts.
							iteration_code := Void
						end
					end
				end
			end

				-- Type check the exit test.
			exit_as := l_as.exit_condition
			if exit_as /= Void then
				exit_as.process (Current)
				if last_type /= Void then
						-- Check if it is a boolean expression
					if not last_type.actual_type.is_known then
							-- Record expected type.
						last_type.actual_type.conform_to (context.current_class, boolean_type).do_nothing
					elseif not last_type.actual_type.is_boolean then
						create l_vwbe4
						context.init_error (l_vwbe4)
						l_vwbe4.set_type (last_type)
						l_vwbe4.set_location (exit_as.end_location)
						error_handler.insert_error (l_vwbe4)
							-- Skip code generation for next parts.
						iteration_code := Void
					elseif iteration_code /= Void then
						if attached {EXPR_B} last_byte_node as exit_condition_part then
							exit_condition_code := exit_condition_part
						else
								-- Skip code generation for next parts.
							iteration_code := Void
						end
					end
					break_point_slot_count := break_point_slot_count + 1
				else
						-- Skip code generation for next parts.
					iteration_code := Void
				end
			end

				-- Type check the loop expression
			s := context.scope
			if exit_as /= Void then
					-- It's safe to take loop exit condition into account even when iteration is present,
					-- because if the loop is entered neither iteration nor loop exit conditions are True.
				(create {AST_SCOPE_DISJUNCTIVE_CONDITION}.make (context)).add_scopes (exit_as)
			end
			l_as.expression.process (Current)
			if last_type /= Void then
					-- Check if it is a boolean expression
				if not last_type.actual_type.is_known then
						-- Record expected type.
					last_type.actual_type.conform_to (context.current_class, boolean_type).do_nothing
				elseif not last_type.actual_type.is_boolean then
					error_handler.insert_error
						(create {VWBE5}.make (last_type, l_as.is_all, l_as.expression.end_location, context))
						-- Skip code generation for next parts.
					iteration_code := Void
				elseif iteration_code /= Void then
					if attached {EXPR_B} last_byte_node as expression_part then
						expression_code := expression_part
					else
							-- Skip code generation for next parts.
						iteration_code := Void
					end
				end
			else
					-- Skip code generation for next parts.
				iteration_code := Void
			end
			context.set_scope (s)

				-- Avoid processing iteration advancement when iteration part has errors.
			if attached iteration_cursor_type then
					-- Generate cursor movement assuming the cursor is of ITERATION_CURSOR type.
				if attached local_info.expression then
					local_info.disable_is_cursor
				end
				if is_inherited then
						-- Rely on routine ID computed earlier.
					iteration_as.advance.process (Current)
				elseif attached error_level as e then
						-- Check the call and compute associated routine ID for the top iteration cursor type.
					local_info.set_type (iteration_cursor_type)
					is_byte_node_enabled := False
					iteration_as.advance.process (Current)
					is_byte_node_enabled := old_is_byte_node_enabled
					local_info.set_type (local_type)
						-- If everything is OK, recompute the code using actual local type.
					if error_level = e then
						is_inherited := True
						iteration_as.advance.process (Current)
						is_inherited := False
					end
				end
				if attached local_info.expression then
					local_info.enable_is_cursor
				end
				if attached last_byte_node as advance_part then
					advance_code := advance_part
				else
						-- Skip code generation for next parts.
					iteration_code := Void
				end
			end

				-- Remove cursor's scope.
			context.remove_object_test_scopes (iteration_cursor_scope)

				-- As iteration may terminate before explicit exit condition is fulfilled
				-- the latter does not affect the scopes after the loop expression.

			if iteration_code /= Void then
				check
					iteration_exit_condition_code /= Void
					expression_code /= Void
					advance_code /= Void
				end
				create {LOOP_EXPR_B} last_byte_node.make (
					iteration_code,
					invariant_code,
					variant_code,
					iteration_exit_condition_code,
					exit_condition_code,
					expression_code,
					l_as.is_all,
					advance_code
				)
			elseif is_byte_node_enabled then
					-- Generate stub in case of errors.
				create {BOOL_CONST_B} last_byte_node.make (False)
			end

			set_type (boolean_type, l_as)
		end

	process_iteration_as (l_as: ITERATION_AS)
			-- <Precursor>
			-- Set `last_type' to the type on which features "start", "after" and "forth" are to be called.
		local
			local_id: ID_AS
			local_name_id: INTEGER
			unattached_local_type: TYPE_A
			local_type: TYPE_A
			local_info: LOCAL_INFO
			iteration_cursor_type: TYPE_A
			initialization_code: BYTE_LIST [INSTR_B]
			assign_b: ASSIGN_B
			access_expr_b: ACCESS_EXPR_B
			new_cursor_b: NESTED_B
			l_old_current_target_type: like current_target_type
			old_error_level: like error_level
			is_expression_controlled: BOOLEAN
		do
				-- Type check iteration expression.
				-- We save `current_target_type' and set it to Void before evaluating the
				-- expression. See eweasel test#valid288.
			l_old_current_target_type := current_target_type
			current_target_type := Void
			l_as.expression.process (Current)
			current_target_type := l_old_current_target_type
			is_expression_controlled := is_controlled

				-- Type check loop local name.
			local_id := l_as.identifier
			local_name_id := local_id.name_id
			if
				not is_inherited and then
				(feature_table.has_id (local_name_id) or else
				current_feature.has_argument_name (local_name_id) or else
				context.locals.has (local_name_id) or else
				context.is_name_used (local_name_id))
			then
					-- The local name is the same as one used for an entity in the current scope.
				error_handler.insert_error (create {VOIT2}.make_from_context (context, local_id))
					-- Clear `last_type' to make sure it is not set when there is an error.
				reset_types
			end

			if attached last_type as iteration_type then
					-- Calculate the type of an iteration local.
				context.find_iteration_classes (context.written_class)
				if not attached context.iterable_class as i then
						-- Suitable class ITERABLE is not found.
					error_handler.insert_error (create {LOOP_ITERATION_NO_CLASS_ERROR}.make (context, "ITERABLE [G]", local_id))
						-- Clear `last_type' to make sure it is not set when there is an error.
					reset_types
				elseif not attached context.iteration_cursor_class as c then
						-- Suitable class ITERATION_CURSOR is not found.
					error_handler.insert_error (create {LOOP_ITERATION_NO_CLASS_ERROR}.make (context, "ITERATION_CURSOR [G]", local_id))
						-- Clear `last_type' to make sure it is not set when there is an error.
					reset_types
				elseif not attached i.feature_of_name_id (names_heap.new_cursor_name_id) as n then
						-- Class "ITERABLE" has no feature "new_cursor".
					error_handler.insert_error (create {LOOP_ITERATION_NO_FEATURE_ERROR}.make (context, names_heap.item (names_heap.new_cursor_name_id), i, local_id))
						-- Clear `last_type' to make sure it is not set when there is an error.
					reset_types
				elseif n.argument_count > 0 or else n.type.is_void then
						-- Feature "new_cursor" has incorrect signature.
					error_handler.insert_error (create {LOOP_ITERATION_FEATURE_SIGNATURE_ERROR}.make (context, n, i, local_id))
						-- Clear `last_type' to make sure it is not set when there is an error.
					reset_types
				else
						-- Lookup for a feature using general feature finder to deal with formal generics correctly.
					feature_finder.find_by_routine_id (n.rout_id_set.first, iteration_type, context.current_class)
					if not attached feature_finder.found_feature as f or else not attached feature_finder.found_site as iteration_base_type then
							-- Iteration expression type does not conform to ITERABLE because feature "new_cursor" is not found.
						error_handler.insert_error (create {VOIT1}.make_conformance (context, iteration_type, i.actual_type, local_id))
							-- Clear `last_type' to make sure it is not set when there is an error.
						reset_types
					elseif not iteration_type.is_attached and then is_void_safe_call then
							-- Iteration expression type does not conform to ITERABLE because it is not attached.
						error_handler.insert_error (create {VOIT1}.make_attachment (context, iteration_type, i.actual_type, local_id))
							-- Clear `last_type' to make sure it is not set when there is an error.
						reset_types
					else
						-- Check the target of a separate feature call.
					if iteration_type.is_separate then
						validate_separate_target (n.feature_name_32, l_as.expression)
					end
							-- Record dependency on cursor creation.
						if not is_inherited then
							context.supplier_ids.extend_depend_unit_with_level (iteration_base_type.class_id, f, depend_unit_level)
						end
							-- Record current error level to avoid unnecessary errors for separate cursors.
						old_error_level := error_level
							-- Use an attached variant of a cursor type if required.
						unattached_local_type := f.type.actual_type.instantiated_in (iteration_base_type)
						local_type := unattached_local_type.as_attached_in (context.current_class)
						adapt_type_to_target (local_type, iteration_type, n, is_expression_controlled, local_id, old_error_level, local_id)
						local_type := last_type
						if not local_type.base_class.conform_to (c) then
								-- Type of a cursor does not conform to ITERATION_CURSOR.
							error_handler.insert_error
								(create {LOOP_ITERATION_NOT_ITERATION_CURSOR_ERROR}.make (context, last_type, local_id))
						elseif not unattached_local_type.conform_to (context.current_class, local_type) then
								-- Type of a cursor is not attached.
							error_handler.insert_error
								(create {LOOP_ITERATION_NOT_ATTACHED_ERROR}.make (context, unattached_local_type, local_id))
						else
								-- Evaluate a type of a cursor.
							iteration_cursor_type := c.actual_type.evaluated_type_in_descendant
								(i, iteration_base_type.base_class, Void).instantiated_in (iteration_base_type)
							adapt_type_to_target (iteration_cursor_type, iteration_type, f, is_expression_controlled, local_id, old_error_level, local_id)
							iteration_cursor_type := last_type
						end
						if current_feature.written_in = context.current_class.class_id then
							instantiator.dispatch (local_type, context.current_class)
							if iteration_cursor_type /= Void then
								instantiator.dispatch (iteration_cursor_type, context.current_class)
							end
						end
							-- Avoid generating new object test local record when processing a loop body multiple times.
						local_info := context.unchecked_object_test_local (local_id)
						if local_info = Void then
							create local_info.make (local_type, context.next_object_test_local_position)
							context.add_object_test_local (local_info, local_id)
							local_info.enable_is_used
							local_info.set_is_controlled (is_controlled)
							if attached l_as.item as cursor then
								local_info.set_cursor (cursor)
							end
						end
							-- Generate cursor creation code.
						if is_byte_node_enabled and then attached {EXPR_B} last_byte_node as e then
							create new_cursor_b
							if attached {ACCESS_B} e as a then
								a.set_parent (new_cursor_b)
								new_cursor_b.set_target (a)
							else
								create access_expr_b.make (e)
								access_expr_b.set_parent (new_cursor_b)
								new_cursor_b.set_target (access_expr_b)
							end
							new_cursor_b.set_message (f.access_for_feature (local_type, Void, True, iteration_type.is_separate, False))
							new_cursor_b.message.set_parent (new_cursor_b)

							create initialization_code.make (2)
							create assign_b.make
								(create {OBJECT_TEST_LOCAL_B}.make (
									local_info.position,
									current_feature.body_index,
									local_type
								),
								new_cursor_b)
							assign_b.set_line_number (l_as.start_location.line)
							initialization_code.extend (assign_b)
						end
							-- Make iteration variable visible to the loop.
						context.add_object_test_instruction_scope (local_id)
							-- Check if feature "start" to initialize a cursor object is available.
						if attached c.feature_of_name_id (names_heap.start_name_id) then
								-- Process AST tree that initializes the iteration.
							local_info.set_type (iteration_cursor_type)
							if attached local_info.expression then
								local_info.disable_is_cursor
							end
							l_as.initialization.process (Current)
							if attached local_info.expression then
								local_info.enable_is_cursor
							end
							local_info.set_type (local_type)
							if attached initialization_code and then attached {INSTR_B} last_byte_node as b then
								initialization_code.extend (b)
							end
						end
						if is_byte_node_enabled then
							last_byte_node := initialization_code
						end
							-- Set `last_type' to the type that is used to call
							-- features in the automatically generated code.
						set_type (iteration_cursor_type, l_as)
					end
				end
			end
		end

	process_retry_as (l_as: RETRY_AS)
		local
			l_vxrt: VXRT
			l_retry_b: RETRY_B
		do
			break_point_slot_count := break_point_slot_count + 1

			if not is_in_rescue then
					-- Retry instruction outside a recue clause
				create l_vxrt
				context.init_error (l_vxrt)
				l_vxrt.set_location (l_as.start_location)
				error_handler.insert_error (l_vxrt)
			elseif is_byte_node_enabled then
				create l_retry_b.make (l_as.line)
				l_retry_b.set_line_pragma (l_as.line_pragma)
				last_byte_node := l_retry_b
			end
			context.set_all
		end

	process_separate_instruction_as (a_as: SEPARATE_INSTRUCTION_AS)
			-- <Precursor>
		local
			local_id: ID_AS
			local_name_id: INTEGER
			location: LOCATION_AS
			e: EXPR_AS
			s: INTEGER
			local_info: LOCAL_INFO
			local_type: TYPE_A
			arguments: ARRAYED_LIST [ID_AS]
			argument_code: detachable BYTE_LIST [ASSIGN_B]
			assign_b: ASSIGN_B
		do
				-- Record current scope.
			s := context.scope
				-- Process arguments.
			create arguments.make (a_as.arguments.count)
			if is_byte_node_enabled then
				create argument_code.make (a_as.arguments.count)
			end
			across
				a_as.arguments as c
			loop
					-- Type check iteration expression.
				last_byte_node := Void
				e := c.item.expression
				e.process (Current)
				local_type := last_type
				if not is_inherited and then attached local_type and then not local_type.is_separate then
					if attached e.first_token (Void) as token then
						location := token
					else
						location := c.item.name
					end
					error_handler.insert_error (create {V1SE}.make (local_type, context, location))
				end
					-- Default to type "ANY" on error.
				if not attached local_type then
					local_type := system.any_type
				end
					-- Type check new local name.
				local_id := c.item.name
				local_name_id := local_id.name_id
				if
					not is_inherited and then
					(feature_table.has_id (local_name_id) or else
					current_feature.has_argument_name (local_name_id) or else
					context.locals.has (local_name_id) or else
					across arguments as a some a.item.name_id = local_name_id end or else
					context.is_name_used (local_name_id))
				then
						-- The local name is the same as one used for an entity in the current scope.
					error_handler.insert_error (create {FRESH_IDENTIFIER_ERROR}.make_from_context (context, local_id))
				end
					-- A name clash with object test locals, iteration cursors and separate instruction arguments will be reported when checking for their scopes.
				local_info := context.unchecked_object_test_local (local_id)
				if not attached local_info then
					create local_info.make (local_type, context.next_object_test_local_position)
					local_info.enable_is_used
						-- Mark this variable as controlled.
					local_info.enable_is_controlled
					context.add_object_test_local (local_info, local_id)
				end
				if attached argument_code and then attached {EXPR_B} last_byte_node as b then
					create assign_b.make (create {OBJECT_TEST_LOCAL_B}.make (local_info.position, current_feature.body_index, local_type), b)
					assign_b.set_line_number (c.item.expression.start_location.line)
					argument_code.extend (assign_b)
				end
					-- Record local to activate its scope for compound.
				arguments.extend (local_id)
					-- Reset scopes to original level to before computing next argument.
				context.set_scope (s)
			end
				-- Activate scopes of argument names.
			across
				arguments as c
			loop
				context.add_object_test_instruction_scope (c.item)
			end
				-- Process compound.
			if attached a_as.compound as c then
				process_compound (c)
			end
			if attached argument_code and then attached {BYTE_LIST [BYTE_NODE]} last_byte_node as b then
				create {SEPARATE_INSTRUCTION_B} last_byte_node.make (argument_code, b, a_as.end_location)
			end
				-- Remove arguments of the separate instruction.
			context.remove_object_test_scopes (s)
		end

	process_external_as (l_as: EXTERNAL_AS)
		local
			l_external: EXTERNAL_I
			l_lang: COMPILER_EXTERNAL_LANG_AS
		do
			l_lang ?= l_as.language_name
			check
				l_lang_not_void: l_lang /= Void
			end
			l_lang.extension.type_check (l_as)
			if is_byte_node_enabled then
				l_external ?= current_feature
				if l_external = Void then
					create {DEF_BYTE_CODE} last_byte_node
				else
					create {EXT_BYTE_CODE} last_byte_node.make (l_external.external_name_id)
				end
			end
		end

	process_deferred_as (l_as: DEFERRED_AS)
		do
			if is_byte_node_enabled then
				create {DEF_BYTE_CODE} last_byte_node
			end
		end

	process_attribute_as (l_as: ATTRIBUTE_AS)
		local
			l_list: BYTE_LIST [BYTE_NODE]
			l_std_byte_code: STD_BYTE_CODE
			l_needs_byte_node: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled
			l_as.set_first_breakpoint_slot_index (break_point_slot_count + 1)

			if l_as.compound /= Void then
				process_compound (l_as.compound)
				if l_needs_byte_node then
					l_list ?= last_byte_node
				end
			end
			if l_needs_byte_node then
				create l_std_byte_code
				l_std_byte_code.set_compound (l_list)
				last_byte_node := l_std_byte_code
			end
			break_point_slot_count := break_point_slot_count + 1
		end

	process_do_as (l_as: DO_AS)
		local
			l_list: BYTE_LIST [BYTE_NODE]
			l_std_byte_code: STD_BYTE_CODE
			l_needs_byte_node: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled
			l_as.set_first_breakpoint_slot_index (break_point_slot_count + 1)

			if l_as.compound /= Void then
				process_compound (l_as.compound)
				if l_needs_byte_node then
					l_list ?= last_byte_node
				end
			end
			if l_needs_byte_node then
				create l_std_byte_code
				l_std_byte_code.set_compound (l_list)
				last_byte_node := l_std_byte_code
			end
			break_point_slot_count := break_point_slot_count + 1
		end

	process_once_as (l_as: ONCE_AS)
		local
			ast_compound: like {ONCE_AS}.compound
			compound: BYTE_LIST [INSTR_B]
			l_once_byte_code: ONCE_BYTE_CODE
			l_body: FEATURE_AS
			s: like context.scope
			n: like {ONCE_AS}.compound.count
			f: FEATURE_I
		do
			l_as.set_first_breakpoint_slot_index (break_point_slot_count + 1)
			ast_compound := l_as.compound
			if attached ast_compound then
				n := ast_compound.count
			end
			if current_feature.is_once_creation (context.current_class) then
				create compound.make (1 + n)
					-- Record creator position (used in multi-branch constructs).
				f := context.current_class.feature_of_name_id (names_heap.inspect_attribute_name_id)
				compound.extend
					(create {ASSIGN_B}.make
						(f.access (f.type, False, False),
						create {INTEGER_CONSTANT}.make_from_type (f.type, False, context.current_feature.creator_position.out)))
			else
				create compound.make (n)
			end
			if attached ast_compound then
				s := context.scope
				process_eiffel_list_with_matcher (ast_compound, Void, compound)
				context.set_scope (s)
			end
			if is_byte_node_enabled then
				create l_once_byte_code
				l_once_byte_code.set_compound (compound)
				l_body := current_feature.body
				check
					l_body_not_void: l_body /= Void
				end
				if l_as.has_key_process (l_body) then
					l_once_byte_code.set_is_process_relative_once
				elseif l_as.has_key_object then
					l_once_byte_code.set_is_object_relative_once
				else
					l_once_byte_code.set_is_thread_relative_once
				end
				last_byte_node := l_once_byte_code
			end
			break_point_slot_count := break_point_slot_count + 1
		end

	process_list_dec_as (l_as: LIST_DEC_AS)
		do
			fixme ("what do we do about the identifiers?")
		end

	process_type_dec_as (l_as: TYPE_DEC_AS)
		do
			check_type (l_as.type)
			fixme ("what do we do about the identifiers?")
		end

	process_class_as (l_as: CLASS_AS)
		do
			-- Nothing to be done
		end

	process_parent_as (l_as: PARENT_AS)
		do
			-- Nothing to be done
		end

	process_like_id_as (l_as: LIKE_ID_AS)
		do
			check_type (l_as)
		end

	process_like_cur_as (l_as: LIKE_CUR_AS)
		do
			check_type (l_as)
		end

	process_qualified_anchored_type_as (l_as: QUALIFIED_ANCHORED_TYPE_AS)
		do
			check_type (l_as)
		end

	process_feature_id_as (l_as: FEATURE_ID_AS)
			-- <Precursor>
		do
			-- Nothing to be done.
		end

	process_formal_as (l_as: FORMAL_AS)
		do
			check_type (l_as)
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS)
		do
			-- Nothing to be done
		end

	process_constraining_type_as (l_as: CONSTRAINING_TYPE_AS)
		do
			-- Nothing to be done
		end

	process_class_type_as (l_as: CLASS_TYPE_AS)
		do
			check_type (l_as)
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS)
		do
			check_type (l_as)
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS)
		do
			check_type (l_as)
		end

	process_none_type_as (l_as: NONE_TYPE_AS)
		do
			check_type (l_as)
		end

	process_rename_as (l_as: RENAME_AS)
		do
			-- Nothing to be done
		end

	process_invariant_as (l_as: INVARIANT_AS)
		local
			s: INTEGER
		do
			break_point_slot_count := 0
			if attached l_as.assertion_list as l then
				reset_for_unqualified_call_checking
				set_is_checking_invariant (True)
				context.enter_realm
				s := context.scope
				process_eiffel_list_with_matcher (l, create {AST_SCOPE_ASSERTION}.make (context), create {BYTE_LIST [ASSERT_B]}.make (l.count))
				context.set_scope (s)
				context.leave_optional_realm
				set_is_checking_invariant (False)
			else
				reset_byte_node
			end
		end

	process_interval_as (l_as: INTERVAL_AS)
		local
			l_inspect_control: like inspect_control
		do
			l_inspect_control := inspect_control
			if l_inspect_control /= Void then
				l_inspect_control.process_interval (l_as, is_inherited)
				if is_byte_node_enabled then
					last_byte_node := l_inspect_control.last_interval_byte_node
				end
			end
		end

	process_index_as (l_as: INDEX_AS)
		do
			l_as.index_list.process (Current)
			fixme ("is this really needed here?")
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS)
		do
			-- Nothing to be done
		end

	process_elseif_as (l_as: ELSIF_AS)
		local
			l_vwbe2: VWBE2
			l_needs_byte_node: BOOLEAN
			l_expr: EXPR_B
			l_list: BYTE_LIST [BYTE_NODE]
			l_elsif: ELSIF_B
			l_has_error: BOOLEAN
			s: INTEGER
			scope_matcher: AST_SCOPE_MATCHER
		do
			break_point_slot_count := break_point_slot_count + 1

			l_needs_byte_node := is_byte_node_enabled

				-- Type check test first
			l_as.expr.process (Current)
			if last_type /= Void then
					-- Check conformance to boolean
				if not last_type.actual_type.is_known then
						-- Record expected type.
					last_type.actual_type.conform_to (context.current_class, boolean_type).do_nothing
				elseif not last_type.actual_type.is_boolean then
					create l_vwbe2
					context.init_error (l_vwbe2)
					l_vwbe2.set_type (last_type)
					l_vwbe2.set_location (l_as.expr.end_location)
					error_handler.insert_error (l_vwbe2)
					l_has_error := True
				elseif l_needs_byte_node then
					l_expr ?= last_byte_node
					create l_elsif
					l_elsif.set_expr (l_expr)
				end
			else
				l_has_error := True
			end

				-- Type check on compound
			create {AST_SCOPE_CONJUNCTIVE_CONDITION} scope_matcher.make (context)
			s := context.scope
			scope_matcher.add_scopes (l_as.expr)
			if l_as.compound /= Void then
				process_compound (l_as.compound)
				if not l_has_error and l_needs_byte_node then
					l_list ?= last_byte_node
					l_elsif.set_compound (l_list)
				end
			end
			context.set_scope (s)
			context.save_sibling

				-- Add scopes for the parts that follow this one.
			create {AST_SCOPE_DISJUNCTIVE_CONDITION} scope_matcher.make (context)
			scope_matcher.add_scopes (l_as.expr)
			context.update_realm

			if not l_has_error and l_needs_byte_node then
				l_elsif.set_line_number (l_as.expr.start_location.line)
				last_byte_node := l_elsif
			end
		end

	process_elseif_expression_as (l_as: ELSIF_EXPRESSION_AS)
		local
			l_vwbe2: VWBE2
			l_needs_byte_node: BOOLEAN
			l_condition: EXPR_B
			l_expression: EXPR_B
			l_elsif: ELSIF_EXPRESSION_B
			s: INTEGER
			scope_matcher: AST_SCOPE_MATCHER
			l_expression_type: TYPE_A
		do
			break_point_slot_count := break_point_slot_count + 1

			l_needs_byte_node := is_byte_node_enabled

				-- Type check test first
			l_as.condition.process (Current)
			if attached last_type then
					-- Check conformance to boolean
				if not last_type.actual_type.is_known then
						-- Record expected type.
					last_type.actual_type.conform_to (context.current_class, boolean_type).do_nothing
				elseif not last_type.actual_type.is_boolean then
					create l_vwbe2
					context.init_error (l_vwbe2)
					l_vwbe2.set_type (last_type)
					l_vwbe2.set_location (l_as.condition.end_location)
					error_handler.insert_error (l_vwbe2)
				elseif l_needs_byte_node and then attached {EXPR_B} last_byte_node as c then
					l_condition := c
				end
			end

				-- Type check on compound
			create {AST_SCOPE_CONJUNCTIVE_CONDITION} scope_matcher.make (context)
			s := context.scope
			scope_matcher.add_scopes (l_as.condition)
			l_as.expression.process (Current)
			l_expression_type := last_type
			if attached l_condition and then attached {EXPR_B} last_byte_node as e then
				if attached l_expression_type and then attached last_expressions_type as type_list then
					type_list.extend (l_expression_type)
				end
				l_expression := e
			end
			context.set_scope (s)
			context.save_sibling

				-- Add scopes for the parts that follow this one.
			create {AST_SCOPE_DISJUNCTIVE_CONDITION} scope_matcher.make (context)
			scope_matcher.add_scopes (l_as.condition)
			context.update_realm

			if attached l_condition and then attached l_expression then
				create l_elsif.make (l_condition, l_expression)
				l_elsif.set_line_number (l_as.condition.start_location.line)
				last_byte_node := l_elsif
			end

				-- Restore `last_type' to the type specified in Then_part.
			last_type := l_expression_type
		end

	process_create_as (l_as: CREATE_AS)
		do
			-- Nothing to be done
		end

	process_client_as (l_as: CLIENT_AS)
		do
			-- Nothing to be done
		end

	process_case_abstraction
		(a: CASE_ABSTRACTION_AS [detachable AST_EIFFEL];
		f: MULTI_BRANCH_FACTORY)
			-- Process `a`.
		local
			l_intervals: SORTABLE_ARRAY [INTERVAL_B]
			l_interval: INTERVAL_B
			l_next_interval: INTERVAL_B
			l_tmp: BYTE_LIST [INTERVAL_B]
			l_case: ABSTRACT_CASE_B [BYTE_NODE]
			l_is_empty: BOOLEAN
			s: like context.scope
		do
			if not is_byte_node_enabled then
				if attached inspect_control as l_inspect_control then
					across
						a.interval as interval_cursor
					from
						l_is_empty := True
					loop
						interval_cursor.item.process (Current)
						if attached l_inspect_control.last_interval_byte_node then
							l_is_empty := False
						end
					end
				end
				if attached a.content as c then
					s := context.scope
					c.process (Current)
					context.set_scope (s)
				end
			else
						-- Collect all intervals in an array
				across
					a.interval as interval_cursor
				from
					create l_intervals.make_empty
				loop
					interval_cursor.item.process (Current)
					if attached {INTERVAL_B} last_byte_node as interval_byte_code then
						l_intervals.force (interval_byte_code, l_intervals.upper + 1)
					end
				end
				if l_intervals.is_empty then
					l_is_empty := True
					if attached a.content as c then
						s := context.scope
						c.process (Current)
						context.set_scope (s)
						reset_byte_node
					end
				else
						-- Array of intervals is not empty
						-- Sort an array
					l_intervals.sort
						-- Copy intervals to `l_tmp' merging adjacent intervals
					across
						l_intervals as interval_cursor
					from
						create l_tmp.make (l_intervals.count)
						l_interval := interval_cursor.item
						l_tmp.extend (l_interval)
						interval_cursor.forth
					loop
						l_next_interval := interval_cursor.item
						if l_interval.upper.is_next (l_next_interval.lower) then
								-- Merge intervals
							l_interval.set_upper (l_next_interval.upper)
						else
								-- Add new interval
							l_interval := l_next_interval
							l_tmp.extend (l_interval)
						end
					end
					if attached a.content as c then
						s := context.scope
						c.process (Current)
						context.set_scope (s)
						l_case := f.new_case (l_tmp, last_byte_node)
					else
						l_case := f.new_case (l_tmp, Void)
					end
					l_case.set_line_number (a.interval.start_location.line)
				end
				last_byte_node := l_case
			end
			if not l_is_empty then
					-- If all intervals are empty, the scope information is not changed, otherwise it's updated.
				context.save_sibling
			end
		end

	process_case_as (a: CASE_AS)
			-- <Precursor>
		do
			process_case_abstraction (a, multi_branch_instruction_factory)
		end

	process_case_expression_as (a: CASE_EXPRESSION_AS)
			-- <Precursor>
		do
			process_case_abstraction (a, multi_branch_expression_factory)
			if attached last_expressions_type as ts and then attached last_type as t then
				ts.extend (t)
			end
		end

	process_ensure_as (l_as: ENSURE_AS)
		local
			a: EIFFEL_LIST [TAGGED_AS]
			b: ASSERTION_BYTE_CODE
			i: INTEGER
			s: INTEGER
		do
			a := l_as.assertions
			if a /= Void then
				if is_byte_node_enabled then
					create b.make (a.count)
					i := context.next_object_test_local_position
				end
				context.enter_realm
				s := context.scope
				process_eiffel_list_with_matcher (a, create {AST_SCOPE_ASSERTION}.make (context), b)
				context.set_scope (s)
				context.leave_optional_realm
				if b /= Void then
					if b.is_empty then
						b := Void
					else
						context.init_assertion_byte_code (b, i)
					end
					last_byte_node := b
				end
			end
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS)
		local
			a: EIFFEL_LIST [TAGGED_AS]
			b: ASSERTION_BYTE_CODE
			i: INTEGER
			s: INTEGER
		do
			a := l_as.assertions
			if a /= Void then
				if is_byte_node_enabled then
					create b.make (a.count)
					i := context.next_object_test_local_position
				end
				context.enter_realm
				s := context.scope
				process_eiffel_list_with_matcher (a, create {AST_SCOPE_ASSERTION}.make (context), b)
				context.set_scope (s)
				context.leave_optional_realm
				if b /= Void then
					if b.is_empty then
						b := Void
					else
						context.init_assertion_byte_code (b, i)
					end
					last_byte_node := b
				end
			end
		end

	process_require_as (l_as: REQUIRE_AS)
		local
			a: EIFFEL_LIST [TAGGED_AS]
			b: ASSERTION_BYTE_CODE
			i: INTEGER
			s: INTEGER
		do
			a := l_as.assertions
			if a /= Void then
				if is_byte_node_enabled then
					create b.make (a.count)
					i := context.next_object_test_local_position
				end
				s := context.scope
				if is_void_safe_construct then
						-- Strict void safety: no variables change their attachment status because of this assertion.
					context.enter_realm
					process_eiffel_list_with_matcher (a, create {AST_SCOPE_ASSERTION}.make (context), b)
					context.leave_optional_realm
					context.set_scope (s)
				else
						-- Soft void safety: variables may change attachment status because of this assertion.
					process_eiffel_list_with_matcher (a, create {AST_SCOPE_ASSERTION}.make (context), b)
					context.remove_object_test_scopes (s)
				end
				if b /= Void then
					if b.is_empty then
						b := Void
					else
						context.init_assertion_byte_code (b, i)
					end
					last_byte_node := b
				end
			end
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS)
		local
			a: EIFFEL_LIST [TAGGED_AS]
			b: ASSERTION_BYTE_CODE
			i: INTEGER
			s: INTEGER
		do
			a := l_as.assertions
			if a /= Void then
				if is_byte_node_enabled then
					create b.make (a.count)
					i := context.next_object_test_local_position
				end
				context.enter_realm
				s := context.scope
				process_eiffel_list_with_matcher (a, create {AST_SCOPE_ASSERTION}.make (context), b)
				context.set_scope (s)
				context.leave_optional_realm
				if b /= Void then
					if b.is_empty then
						b := Void
					else
						context.init_assertion_byte_code (b, i)
					end
					last_byte_node := b
				end
			end
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS)
		do
			-- Nothing to be done
		end

	process_void_as (l_as: VOID_AS)
		local
			l_class: CLASS_C
			l_vica2: VICA2
		do
			if is_checking_cas then
					-- When we have Void, it is only valid, if target is
					-- an array type.
				l_class := current_target_type.base_class
				if l_class = Void or else l_class.class_id /= system.native_array_id then
					create l_vica2.make (context.current_class, current_feature)
					l_vica2.set_location (l_as.start_location)
					error_handler.insert_error (l_vica2)
				end
			end
			set_type (detachable_none_type, l_as)
			if is_byte_node_enabled then
				create {VOID_B} last_byte_node
			end
		end

	process_type_list_as (l_as: TYPE_LIST_AS)
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
		end

	process_list_dec_list_as (l_as: LIST_DEC_LIST_AS)
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
		end

	process_type_dec_list_as (l_as: TYPE_DEC_LIST_AS)
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
		end

	process_convert_feat_list_as (l_as: CONVERT_FEAT_LIST_AS)
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
		end

	process_class_list_as (l_as: CLASS_LIST_AS)
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
		end

	process_parent_list_as (l_as: PARENT_LIST_AS)
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
		end

	process_local_dec_list_as (l_as: LOCAL_DEC_LIST_AS)
			-- Process `l_as'.
		do
			l_as.locals.process (Current)
		end

	process_formal_argu_dec_list_as (l_as: FORMAL_ARGU_DEC_LIST_AS)
			-- Process `l_as'.
		do
			l_as.arguments.process (Current)
		end

	process_key_list_as (l_as: KEY_LIST_AS)
			-- Process `l_as'.
		do
			l_as.keys.process (Current)
		end

	process_delayed_actual_list_as (l_as: DELAYED_ACTUAL_LIST_AS)
			-- Process `l_as'.
		do
			l_as.operands.process (Current)
		end

	process_parameter_list_as (l_as: PARAMETER_LIST_AS)
			-- Process `l_as'.
		do
			l_as.parameters.process (Current)
		end

	process_named_expression_as (a_as: NAMED_EXPRESSION_AS)
			-- <Precursor>
		do
				-- Processing is done by `process_separate_instruction_as'.
		end

	process_rename_clause_as (l_as: RENAME_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_export_clause_as (l_as: EXPORT_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_undefine_clause_as (l_as: UNDEFINE_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_redefine_clause_as (l_as: REDEFINE_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_select_clause_as (l_as: SELECT_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_formal_generic_list_as (l_as: FORMAL_GENERIC_LIST_AS)
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
		end

feature {NONE} -- Feature lookup

	lookup_feature_alias (n: STRING; a: ID_SET_ACCESSOR; l: LOCATION_AS; t: TYPE_A)
			-- Look for a feature alias `n' called on a target of type `t' for AST node `a' at location `l'
			-- and make it available in `last_alias_feature' if found without an error,
			-- or set `last_alias_error' otherwise.
		local
			c: CLASS_C
			target_type: TYPE_A
			base_target_type: detachable TYPE_A
			target_class: CLASS_C
			formal_generic: detachable FORMAL_A
			found_features: TUPLE [feature_item: FEATURE_I; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER_32]
			vkcn3: VKCN3
			vwbr: VWBR1
			vuex: VUEX
			f: FEATURE_I
		do
			last_alias_feature := Void
			last_alias_error := Void
			c := context.current_class
			target_type := t.actual_type
			check actual_type_called: target_type = target_type.actual_type end
			if attached {FORMAL_A} target_type as p then
				formal_generic := p
				if p.is_single_constraint_without_renaming (c) then
						-- This is a formal generic with one contraint without any feature renaming.
					base_target_type := p.constrained_type (c)
				end
			else
					-- This is a regular class type.
				base_target_type := target_type
			end

			if attached base_target_type then
					-- Base class is known.
				if base_target_type.is_void then
					create vkcn3
					context.init_error (vkcn3)
					vkcn3.set_location (l)
					last_alias_error := vkcn3
				elseif is_inherited then
					f := base_target_type.base_class.feature_of_rout_id (a.routine_ids.first)
				elseif base_target_type.is_none then
						-- Check if target is not of type NONE
					create vuex.make_for_none (n)
					context.init_error (vuex)
					vuex.set_location (l)
					last_alias_error := vuex
				elseif
					attached {LOCAL_TYPE_A} base_target_type as x and then
					attached x.operator_call (names_heap.id_of (n), c) as q
				then
					base_target_type := q.site
					target_class := base_target_type.base_class
					f := q.descriptor
						-- Update target type.
					last_type := q.target
				elseif base_target_type.is_known then
						-- Check if bracket feature exists.
					target_class := base_target_type.base_class
					f := target_class.feature_table.alias_item (n)
				end
			elseif is_inherited then
					-- We need to iterate through the type set to find the routine of ID.
				f := c.constraints (formal_generic.position).constraining_types
					(c).feature_i_list_by_rout_id (a.routine_ids.first).first.feature_item
			else
				found_features := formal_generic.constraints (c).feature_i_state_by_alias_name (n)
				if found_features.features_found_count > 1 then
					last_alias_error := new_vtmc_error (create {ID_AS}.initialize (n), formal_generic.position, c, True)
				elseif found_features.features_found_count = 1 then
					base_target_type := found_features.class_type_of_feature
					target_class := base_target_type.base_class
					f := found_features.feature_item
				end
			end

			if attached f then
				last_alias_feature := f
				last_calls_target_type := base_target_type
				if not is_inherited then
						-- Record routine and class IDs in the AST node for descendants.
					set_routine_ids (f.rout_id_set, a)
					a.set_class_id (target_class.class_id)
				end
			elseif not attached last_alias_error then
					-- Feature with given alias is not found.
				create vwbr
				context.init_error (vwbr)
				vwbr.set_location (l)
				if not attached base_target_type then
					check type_set_not_loose: not formal_generic.constraints (c).is_loose end
					vwbr.set_target_type_set (formal_generic.constraints (c))
				elseif base_target_type.is_known then
					vwbr.set_target_type (base_target_type)
				else
						-- The feature is not found because the target type is unknown.
					vwbr := Void
				end
				last_alias_error := vwbr
			end
		end

	feature_finder: TYPE_A_FEATURE_FINDER
			-- A facility to find a feature.
		once
			create Result
		end

feature {NONE} -- Predefined types

	manifest_string_8_type: CL_TYPE_A
			-- String type for 8-bit manifest strings.
		once
			Result := system.string_8_class.compiled_class.actual_type.duplicate
				-- Manifest string have a frozen type.
			Result.set_frozen_mark
		end

	manifest_string_32_type: CL_TYPE_A
			-- String type for 32-bit manifest strings.
		once
			Result := system.string_32_class.compiled_class.actual_type.duplicate
				-- Manifest string have a frozen type.
			Result.set_frozen_mark
		end

	strip_type: GEN_TYPE_A
			-- Type of strip expression (ARRAY [ANY]).
		require
			any_compiled: system.any_class.is_compiled
			array_compiled: system.array_class.is_compiled
		once
			create Result.make (system.array_id, create {ARRAYED_LIST [TYPE_A]}.make_from_array (<<create {CL_TYPE_A}.make (system.any_id)>>))
				-- Type of a strip is a frozen array.
			Result.set_frozen_mark
		end

feature {NONE} -- Parenthesis alias

	look_for_parenthesis_alias (p: PARAMETER_LIST_AS; e: ERROR; t: TYPE_A)
			-- Look for parenthesis alias for the last access with arguments `p' on type `t' and error `e' if there is no such an alias.
		require
			p_attached: attached p
		local
			old_assigner_source: like assigner_source
			constrained_target_type: TYPE_A
			target_access_expr: ACCESS_EXPR_B
			id_feature_name: ID_AS
			location: LOCATION_AS
			call_b: CALL_B
			nested_b: NESTED_B
			l_is_multi_constraint: BOOLEAN
			l_access_b: ACCESS_B
			l_is_qualified_call: BOOLEAN
			l_error_level: NATURAL_32
			l_report_error: BOOLEAN
			l_target_type: TYPE_A
		do
			last_alias_feature := Void
			last_alias_error := Void
				-- If something goes wrong, an original error is reported rather then related to parenthesis alias.
			l_report_error :=  True
				-- Clean assigner call flag for bracket target
			old_assigner_source := assigner_source
			assigner_source := Void

			l_error_level := error_level

				-- Check if there are parentheses.
			if attached p then
				l_target_type := t
			end

			if attached l_target_type then
				if is_byte_node_enabled then
					create nested_b
					if attached {ACCESS_B} last_byte_node as a then
							-- Target is a (potentially qualified) feature call.
						a.set_parent (nested_b)
						nested_b.set_target (a)
					else
							-- Target is an (unqualified) expression.
						check attached {EXPR_B} last_byte_node as v then
							create target_access_expr.make (v)
							target_access_expr.set_parent (nested_b)
							nested_b.set_target (target_access_expr)
						end
					end
				end
				l_is_multi_constraint := attached {FORMAL_A} t.actual_type as g and then not g.is_single_constraint_without_renaming (context.current_class)
				lookup_feature_alias (parentheses_str, p, p.first_token (void), l_target_type)
					-- Report original error if alias feature is not found.
				l_report_error := attached {VWBR} last_alias_error or else attached {VKCN3} last_alias_error
				if not l_report_error and then l_target_type.is_separate then
					validate_separate_target (last_alias_feature.feature_name_32, p)
				end
				if attached last_alias_feature as alias_feature then
						-- Process arguments
						-- Initialize feature name token.
					create id_feature_name.initialize_from_id (alias_feature.feature_name_id)
					location := p.start_location
					id_feature_name.set_position (location.line, location.column, location.position, location.location_count,
						location.character_column, location.character_position, location.character_count)
						-- Restore assigner source.
					assigner_source := old_assigner_source
					constrained_target_type := last_calls_target_type
						-- Process call to bracket feature
					l_is_qualified_call := is_qualified_call
					is_qualified_call := True
					process_call (constrained_target_type, Void, id_feature_name, alias_feature, p.parameters, False, False, True, False, False)
					is_qualified_call := l_is_qualified_call
					if error_level = l_error_level then
							-- Record feature ID for future use.
						if not is_inherited then
							set_routine_ids (last_routine_id_set, p)
						end
						if attached nested_b then
							if l_is_multi_constraint then
								l_access_b ?= last_byte_node
									-- Last generated bytenode is from `process_call'.
								check is_access_b: l_access_b /= Void end
								l_access_b.set_multi_constraint_static (constrained_target_type)
								call_b := l_access_b
							else
								call_b ?= last_byte_node
							end

							check
								call_b_not_void: call_b /= Void
							end
							call_b.set_parent (nested_b)
							nested_b.set_message (call_b)
							last_byte_node := nested_b
						end
					end
				else
						-- Parenthesis alias cannot be found for unknown type.
					set_type (unknown_type, p)
				end
			end
			if l_report_error then
				error_handler.insert_error (e)
				reset_types
			elseif error_level /= l_error_level then
				reset_types
			end
		end

	last_vuar_error: detachable ERROR
			-- Last VUAR error set by `process_call' when found feature has no formal arguments, but there are actual arguments.
			-- Used to delay error report in case there is a parenthesis alias.

feature {NONE} -- Assertions

	assertion_tag (a: TAGGED_AS): detachable STRING
			-- A tag associated with an assertion or a printable representation of the expression (if available).
		local
			e: EXPR_AS
			m: like match_list_of_class
			i: like assertion_tag.count
			has_space: BOOLEAN
		do
			if attached a.tag as t then
				Result := t.name
			else
				e := a.expr
				m := match_list_of_class (context.written_class.class_id)
				if e.is_text_available (m) then
						-- Obtain the text as written in source code.
					Result := e.text (m)
						-- Normalize the text: remove leading and trailing spaces, replace white space sequances (including line endings) with a single space.
					from
							-- Assume there are white spaces at the end of a string.
						has_space := True
						i := Result.count
					until
						i <= 0
					loop
						if Result [i].is_space then
							if has_space then
									-- Remove a subsequent white space character.
								Result.remove (i)
							else
									-- Replace a white space with a standard one.
								Result [i] := ' '
									-- Remember that there are white spaces.
								has_space := True
							end
						else
								-- Remember that the last character is not a white space.
							has_space := False
						end
						i := i - 1
					end
					if has_space and Result.count > 0 then
							-- Remove a leading white space.
						Result.remove (1)
					end
				end
			end
		end

	process_inherited_assertions (a_feature: FEATURE_I; process_preconditions: BOOLEAN)
			-- Process assertions inherited by `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		local
			assert_id_set: ASSERT_ID_SET
			assertion_info: INH_ASSERT_INFO
			body_index: INTEGER
			precursor_feature: FEATURE_AS
			routine_body: ROUTINE_AS
			i: INTEGER
			l_old_written_class: CLASS_C
			l_written_class: CLASS_C
			t: TYPE_A
			old_locals: like empty_locals
		do
			assert_id_set := a_feature.assert_id_set
			if assert_id_set /= Void then
					-- Save locals to make them usable after type checking completes.
				old_locals := context.locals
				context.set_locals (empty_locals)
				context.clear_local_context
				set_is_inherited (True)
				if context.local_scope = Void then
						-- Initialize structures to record and access scopes in assertions.
						-- This is required for result in postcondition, but also to make sure there is no call on void target
						-- because local scopes are processed together with attribute scopes.
					context.init_local_scopes
				end
				if not process_preconditions then
					t := a_feature.type
					if not t.is_void then
							-- Mark that result is initialized and attached if required.
						if t.is_initialization_required and then not context.local_initialization.is_result_set then
							context.set_result
						end
						if t.is_attached then
							context.add_result_instruction_scope
						end
					end
				end
				from
					i := assert_id_set.count
				until
					i <= 0
				loop
					assertion_info := assert_id_set.item (i)
					check assertion_info_attached: assertion_info /= Void end
					if assertion_info.has_assertion then
						body_index := assertion_info.body_index
						precursor_feature := body_server.item (assertion_info.written_in, body_index)
						check
							precursor_feature_not_void: precursor_feature /= Void
						end
						routine_body ?= precursor_feature.body.content
						check routine_body_attached: routine_body /= Void end
						l_old_written_class := context.written_class
						l_written_class := system.class_of_id (assertion_info.written_in)
						context.set_written_class (l_written_class)
						inherited_type_a_checker.init_for_checking (a_feature, l_written_class, Void, Void)
						if process_preconditions then
							if assertion_info.has_precondition then
								set_is_checking_precondition (True)
								routine_body.precondition.process (Current)
								set_is_checking_precondition (False)
								context.clear_local_context
							end
						else
							if assertion_info.has_postcondition then
								set_is_checking_postcondition (True)
								routine_body.postcondition.process (Current)
								set_is_checking_postcondition (False)
								context.clear_local_context
							end
						end
						context.set_written_class (l_old_written_class)
					end
					i := i - 1
				end
				if t /= Void and then t.is_attached then
					context.remove_result_scope
				end
				set_is_inherited (False)
					-- Restore previously computed locals in case they are used by later analysis.
				context.set_locals (old_locals)
			end
		end

feature {NONE} -- Implementation

	process_expressions_list (l_as: EIFFEL_LIST [EXPR_AS])
			-- Process `l_as' as an EIFFEL_LIST but also set `last_expressions_type' accordingly.
			-- Use `current_target_type' for proper evaluation of manifest arrays.
		require
			l_as_not_void: l_as /= Void
		local
			l_cursor: INTEGER
			l_list: BYTE_LIST [EXPR_B]
			l_type_list: like last_expressions_type
			i, nb: INTEGER
			l_cur_type: like current_target_type
			l_error_level: NATURAL_32
		do
			l_error_level := error_level
			l_cursor := l_as.index
			l_as.start
			i := 1
			nb := l_as.count
			create l_type_list.make (nb)
			l_cur_type := current_target_type
			if is_byte_node_enabled then
				from
					create l_list.make (nb)
					nb := nb + 1 -- for speeding up loop stop test.
				until
					i = nb
				loop
					reset_for_unqualified_call_checking
					current_target_type := l_cur_type
					l_as.item.process (Current)
					if attached {EXPR_B} last_byte_node as l_expr then
						l_list.extend (l_expr)
						l_type_list.extend (last_type)
					end
					i := i + 1
					l_as.forth
				end
				last_byte_node := l_list
			else
				from
					nb := nb + 1 -- for speeding up loop stop test.
				until
					i = nb
				loop
					reset_for_unqualified_call_checking
					current_target_type := l_cur_type
					l_as.item.process (Current)
					l_type_list.extend (last_type)
					i := i + 1
					l_as.forth
				end
			end
			l_as.go_i_th (l_cursor)
			if error_level = l_error_level then
				last_expressions_type := l_type_list
			else
				last_expressions_type := Void
				reset_byte_node
			end
		ensure
			last_expressions_type_not_void: error_level = old error_level implies last_expressions_type /= Void
			last_expressions_type_computed: error_level = old error_level implies old last_expressions_type /= last_expressions_type
			last_expressions_type_valid_count: error_level = old error_level implies last_expressions_type.count = l_as.count
			last_byte_node_valid: (error_level = old error_level and is_byte_node_enabled) implies
				((old last_byte_node /= last_byte_node) and then last_byte_node /= Void)
		end

	process_expressions_list_for_tuple (l_as: EIFFEL_LIST [EXPR_AS])
			-- Process `l_as' as an EIFFEL_LIST but also set `last_expressions_type' accordingly.
			-- Use `current_target_type' for proper evaluation of manifest arrays.
		require
			l_as_not_void: l_as /= Void
		local
			l_cursor: INTEGER
			l_list: BYTE_LIST [EXPR_B]
			l_type_list: like last_expressions_type
			i, nb: INTEGER
			l_types: ARRAYED_LIST [TYPE_A]
			l_error_level: NATURAL_32
		do
			l_error_level := error_level
			l_cursor := l_as.index
			l_as.start
			i := 1
			nb := l_as.count
			create l_type_list.make (nb)
			if attached {TUPLE_TYPE_A} current_target_type as l_tuple_type then
				l_types := l_tuple_type.generics
			end
			if is_byte_node_enabled then
				from
					create l_list.make (nb)
					nb := nb + 1 -- for speeding up loop stop test.
				until
					i = nb
				loop
					reset_for_unqualified_call_checking
					current_target_type :=
						if attached l_types and then l_types.valid_index (i) then l_types [i] else Void end
					l_as.item.process (Current)
					if attached {EXPR_B} last_byte_node as l_expr then
						l_list.extend (l_expr)
						l_type_list.extend (last_type)
					end
					i := i + 1
					l_as.forth
				end
				last_byte_node := l_list
			else
				from
					nb := nb + 1 -- for speeding up loop stop test.
				until
					i = nb
				loop
					reset_for_unqualified_call_checking
					current_target_type :=
						if attached l_types and then l_types.valid_index (i) then l_types [i] else Void end
					l_as.item.process (Current)
					if attached {LOCAL_TYPE_A} last_type as t and then attached t.minimum as m then
							-- Use most appropriate type instead of a variable one.
						last_type := m
					elseif attached last_type as t and then not last_type.is_known then
							-- Use NONE for the time being.
						last_type := unknown_type
					end
					l_type_list.extend (last_type)
					i := i + 1
					l_as.forth
				end
			end
			l_as.go_i_th (l_cursor)
			if error_level = l_error_level then
				last_expressions_type := l_type_list
			else
				last_expressions_type := Void
				reset_byte_node
			end
		ensure
			last_expressions_type_not_void: error_level = old error_level implies last_expressions_type /= Void
			last_expressions_type_computed: error_level = old error_level implies old last_expressions_type /= last_expressions_type
			last_expressions_type_valid_count: error_level = old error_level implies last_expressions_type.count = l_as.count
			last_byte_node_valid: (error_level = old error_level and is_byte_node_enabled) implies
				((old last_byte_node /= last_byte_node) and then last_byte_node /= Void)
		end

	check_tuple_validity_for_ca (a_creation_type: CL_TYPE_A; a_tuple: TUPLE_AS; a_ca_b: CUSTOM_ATTRIBUTE_B)
			-- Check validity of `a_tuple' in context of Current.
			-- i.e. it should be a tuple of tuple whose elements are
			-- a name and a value. For each name, a feature `f'
			-- should be available in context of class being created in `creation_expr'.
			-- To be more precise, tuple should look like:
			--  [["first_name", val1],["last_name", val2]]
		require
			a_creation_type_not_void: a_creation_type /= Void
			a_tuple_not_void: a_tuple /= Void
			a_ca_b_not_void: is_byte_node_enabled implies a_ca_b /= Void
		local
			l_vica2: VICA2
			l_vica3: VICA3
			l_vica4: VICA4
			l_veen: VEEN
			l_sub: TUPLE_AS
			l_name: STRING_AS
			l_value: EXPR_AS
			l_has_error: BOOLEAN
			l_feat: FEATURE_I
			vjar: VJAR
			l_expressions: ARRAYED_LIST [TUPLE [STRING_B, EXPR_B]]
			l_expr_b: EXPR_B
			l_strings: SEARCH_TABLE [STRING]
		do
				-- Let's first check that TUPLE elements are indeed of the form
				-- ["my_attribute", my_value]
			from
				create l_strings.make (a_tuple.expressions.count)
				a_tuple.expressions.start
			until
				a_tuple.expressions.after or l_has_error
			loop
				l_sub ?= a_tuple.expressions.item
				l_has_error := l_sub = Void or else l_sub.expressions.count /= 2
				if not l_has_error then
					l_name ?= l_sub.expressions.i_th (1)
					l_has_error := l_name = Void
					if not l_has_error then
						l_strings.search (l_name.value)
						if l_strings.found then
								-- The property/attribute appears twice, this is an error
							create l_vica4.make (context.current_class, current_feature,
								a_creation_type, l_name.value)
							l_vica4.set_location (l_name.start_location)
							error_handler.insert_error (l_vica4)
						else
							l_strings.put (l_name.value)
							l_value := l_sub.expressions.i_th (2)
							l_has_error := l_value = Void
						end
					end
				end
				a_tuple.expressions.forth
			end

			l_strings := Void

			if not l_has_error then
					-- Let's do the semantic analyzis of ["my_attribute", my_value]
					-- It consists to make sure that `my_attribute' is a feature of `a_creation_type'
					-- which is either an attribute or a property.
					-- We also need to check that `my_value' is a constant and that its type
					-- is valid for `my_attribute'.
				from
					a_tuple.expressions.start
					create l_expressions.make (a_tuple.expressions.count)
				until
					a_tuple.expressions.after or l_has_error
				loop
					l_sub ?= a_tuple.expressions.item
					l_name ?= l_sub.expressions.i_th (1)
					l_value := l_sub.expressions.i_th (2)
					l_feat := a_creation_type.base_class.feature_table.item (l_name.value.as_lower)
					l_has_error := l_feat = Void
					if not l_has_error then
						if not valid_feature_for_ca (l_feat, l_name) then
							create l_vica3.make (context.current_class, current_feature, a_creation_type)
							l_vica3.set_named_argument_feature (l_feat)
							l_vica3.set_location (l_name.start_location)
							error_handler.insert_error (l_vica3)
						else
							reset_for_unqualified_call_checking
							current_target_type := l_feat.type.actual_type
							l_value.process (Current)
							l_has_error := last_type = Void or else (not last_type.conform_to (context.current_class, l_feat.type.actual_type) and
								not last_type.convert_to (context.current_class, l_feat.type.deep_actual_type))
							if l_has_error then
								create vjar
								context.init_error (vjar)
								vjar.set_source_type (last_type)
								vjar.set_target_type (l_feat.type.actual_type)
								vjar.set_target_name (l_name.value)
								vjar.set_location (l_value.start_location)
								error_handler.insert_error (vjar)
							elseif is_byte_node_enabled then
								fixme ("Not great since it can only be done when byte code is enabled.")
								l_expr_b ?= last_byte_node
								check l_expr_b_not_void: l_expr_b /= Void end
								if not l_expr_b.is_constant_expression then
									l_has_error := True
									create l_vica2.make (context.current_class, current_feature)
									l_vica2.set_location (l_value.start_location)
									error_handler.insert_error (l_vica2)
								end
							end
						end
					else
						create l_veen
						context.init_error (l_veen)
						l_veen.set_identifier (l_name.value)
						l_veen.set_location (l_name.start_location)
						error_handler.insert_error (l_veen)
					end
					if not l_has_error and is_byte_node_enabled then
						l_expressions.extend ([create {STRING_B}.make (l_name.value, False, False), l_expr_b]) -- TODO: check for manifest immutable string [2019-05-28]
					end
					a_tuple.expressions.forth
				end

				if not l_has_error and is_byte_node_enabled then
					a_ca_b.set_named_arguments (l_expressions)
				end
			end
		end

	valid_feature_for_ca (a_feat: FEATURE_I; a_name: STRING_AS): BOOLEAN
			-- Is `a_feat' valid to be used as a named argument in custom attribute?
		require
			a_feat_not_void: a_feat /= Void
			a_name_not_void: a_name /= Void
		local
			l_vuex: VUEX
			l_ext_class: EXTERNAL_CLASS_C
		do
			if a_feat.is_exported_for (system.any_class.compiled_class) then
				Result := a_feat.is_attribute
				if not Result and a_feat.is_function then
						-- Let's find out if we have an associated property setter to function
						-- `a_feat'.
					l_ext_class ?= a_feat.written_class
					if l_ext_class /= Void then
							-- It has to have a setter
						Result := l_ext_class.has_associated_property_setter (a_feat)
					end
				end
			else
				create l_vuex
				context.init_error (l_vuex)
				l_vuex.set_static_class (system.any_class.compiled_class)
				l_vuex.set_exported_feature (a_feat)
				l_vuex.set_location (a_name)
				error_handler.insert_error (l_vuex)
			end
		end

	is_infix_valid (a_left_type, a_right_type: TYPE_A; a_name: STRING; location: LOCATION_AS): BOOLEAN
			-- Does infix routine `a_name' exists in `a_left_type' and if so is
			-- it valid for `a_right_type'?
		require
			a_left_type_not_void: a_left_type /= Void
			a_left_type_known: a_left_type.is_known
			a_right_type_not_void: a_right_type /= Void
			a_name_not_void: a_name /= Void
		local
			l_name: ID_AS
			l_type_set: TYPE_SET_A
			l_last_constrained: TYPE_A
			l_infix: FEATURE_I
			l_class: CLASS_C
			l_context_current_class: CLASS_C
			l_vwoe: VWOE
			l_result_tuple: TUPLE[feature_item: FEATURE_I; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER]
			l_is_multi_constraint_case: BOOLEAN
			l_feature_found_count: INTEGER
			l_vtmc_error: VTMC
		do
				-- Reset
			last_calls_target_type := Void
			l_context_current_class := context.current_class
			create l_name.initialize (a_name)
				-- No need for `a_left_type.actual_type' since it is done in callers of
				-- `is_infix_valid'.
			if a_left_type.is_formal  then
				if attached {FORMAL_A} a_left_type as l_formal then
					if not l_formal.is_single_constraint_without_renaming (l_context_current_class) then
						l_is_multi_constraint_case := True
							-- this is the multi constraint case
						l_type_set := a_left_type.to_type_set.constraining_types (l_context_current_class)
						check l_type_set /= Void end
						l_result_tuple := l_type_set.feature_i_state_by_alias_name_id (l_name.name_id)
							-- We raise an error if there are multiple infix features found
						l_feature_found_count := l_result_tuple.features_found_count
						if	l_feature_found_count > 1 then
							l_vtmc_error := new_vtmc_error (l_name, l_formal.position, l_context_current_class, True)
						elseif l_feature_found_count = 1 then
							l_infix :=  l_result_tuple.feature_item
							l_last_constrained := l_result_tuple.class_type_of_feature
							l_class := l_last_constrained.base_class
							last_calls_target_type := l_last_constrained
						else
							-- Evereything stays void, an error will be reported.
						end

					else
						l_last_constrained := l_formal.constrained_type (l_context_current_class)
					end
				else
					check is_formal: False end
					l_last_constrained := a_left_type
				end
			else
				l_last_constrained := a_left_type
			end

			if not l_is_multi_constraint_case then
				check
					l_last_constrained_not_void: l_last_constrained /= Void
					associated_class_not_void: l_last_constrained.base_class /= Void
					feature_table_not_void: l_last_constrained.base_class.feature_table /= Void
				end
				l_class := l_last_constrained.base_class
				l_infix := l_class.feature_table.alias_item (a_name)
				last_calls_target_type := l_class.actual_type
			end

				-- If there is no VTMC error, then we need to check more
			if l_vtmc_error = Void then
				if l_infix = Void then
					create l_vwoe
					context.init_error (l_vwoe)
					if l_class /= Void then
						l_vwoe.set_other_class (l_class)
					else
						l_vwoe.set_other_type_set (l_type_set)
					end

					l_vwoe.set_op_name (a_name)
					last_alias_error := l_vwoe
				else
						-- Export validity
					last_alias_feature := l_infix
					check_infix_feature (l_infix, l_class, a_name, a_left_type, l_last_constrained, a_right_type)
				end
			else
				last_alias_error := l_vtmc_error
			end
			if last_alias_error = Void and then a_left_type.is_separate and then system.is_scoop then
					-- Left operand is of a separate type, so the right operand is subject to SCOOP argument rules.
				if a_right_type.is_reference and then not l_infix.arguments.i_th (1).is_separate then
						-- If the right operand is of a reference type then formal feature argument must be separate.
					create {VUAR3} last_alias_error.make (context, l_infix, Void, l_class, 1, l_infix.arguments.i_th (1).actual_type, a_left_type, location)
				elseif a_right_type.is_expanded and then not a_right_type.is_processor_attachable_to (a_left_type) then
						-- If the right operand is of an expanded type then it should not have non-separate reference fields.
					create {VUAR4} last_alias_error.make (context, l_infix, Void, l_class, 1, l_infix.arguments.i_th (1).actual_type, a_left_type, location)
				end
			end
			if last_alias_error /= Void then
				last_alias_feature := Void
				last_infix_arg_type := Void
				last_infix_argument_conversion_info := Void
			else
				Result := True
			end
		ensure
			last_calls_target_type_computed: last_alias_error = Void implies last_calls_target_type /= Void
		end

	check_infix_feature (a_feature: FEATURE_I; a_context_class: CLASS_C; a_name: STRING; a_left_type, a_left_constrained, a_right_type: TYPE_A)
				-- Check validity of `a_feature'.
		require
			a_feature_attached: a_feature /= Void
			a_context_class_attached: a_context_class /= Void
			a_name_attached: a_name /= Void
			a_left_type_attached: a_left_type /= Void
			a_left_constrained_attached: a_left_constrained /= Void
			a_right_type_attached: a_right_type /= Void
		local
			l_arg_type: TYPE_A
			l_vuex: VUEX
			l_vape: VAPE
			l_vwoe1: VWOE1
		do
			if not (context.is_ignoring_export or a_feature.is_exported_for (context.current_class)) then
				create l_vuex
				context.init_error (l_vuex)
				l_vuex.set_static_class (a_context_class)
				l_vuex.set_exported_feature (a_feature)
				last_alias_error := l_vuex
			else
				if
					not System.do_not_check_vape and then is_checking_precondition and then
					not current_feature.export_status.is_subset (a_feature.export_status)
				then
						-- In precondition and checking for vape
					create l_vape
					context.init_error (l_vape)
					l_vape.set_exported_feature (current_feature)
					last_alias_error := l_vape
				else
						-- Conformance initialization
						-- Argument conformance: infix feature must have one argument
					l_arg_type := a_feature.arguments.i_th (1)
					l_arg_type := l_arg_type.recomputed_in (a_left_type.as_implicitly_detachable.as_variant_free, context.current_class.class_id,
						a_left_constrained.as_implicitly_detachable.as_variant_free, a_context_class.class_id).actual_type

					if not l_arg_type.backward_conform_to (context.current_class, a_right_type) then
						if not is_inherited and then a_right_type.convert_to (context.current_class, l_arg_type.deep_actual_type) then
							last_infix_argument_conversion_info := context.last_conversion_info
							last_infix_arg_type := l_arg_type
							last_alias_error := Void
						else
								-- No conformance on argument of infix
							create l_vwoe1
							context.init_error (l_vwoe1)
							l_vwoe1.set_other_class (a_context_class)
							l_vwoe1.set_op_name (a_name)
							l_vwoe1.set_formal_type (l_arg_type)
							l_vwoe1.set_actual_type (a_right_type)
							last_alias_error := l_vwoe1
							last_infix_argument_conversion_info := Void
						end
					else
						last_infix_arg_type := l_arg_type
						last_alias_error := Void
						last_infix_argument_conversion_info := Void
					end
				end
			end
		end

	check_prefix_feature (a_feature: FEATURE_I; a_context_class: CLASS_C)
				-- Check validity of `a_feature' for a prefix call.
		require
			a_feature_attached: a_feature /= Void
			a_context_class_attached: a_context_class /= Void
		local
			l_vuex: VUEX
			l_vape: VAPE
		do
			if not (context.is_ignoring_export or a_feature.is_exported_for (context.current_class)) then
				create l_vuex
				context.init_error (l_vuex)
				l_vuex.set_static_class (a_context_class)
				l_vuex.set_exported_feature (a_feature)
				last_alias_error := l_vuex
			else
				if
					not System.do_not_check_vape and then is_checking_precondition and then
					not current_feature.export_status.is_subset (a_feature.export_status)
				then
						-- In precondition and checking for vape
					create l_vape
					context.init_error (l_vape)
					l_vape.set_exported_feature (current_feature)
					last_alias_error := l_vape
				else
					last_alias_error := Void
				end
			end
		end

	last_alias_error: ERROR
	last_alias_feature: FEATURE_I
	last_infix_arg_type: TYPE_A
	last_infix_argument_conversion_info: CONVERSION_INFO
			-- Helpers to perform type check and byte_node generation.

	process_type_compatibility (l_target_type: like last_type)
			-- Test if `last_type' is compatible with `l_target_type' and
			-- make the result available in `is_type_compatible'.
			-- Adjust `last_byte_node' to reflect conversion if required.
		require
			is_type_compatible_set: is_type_compatible /= Void
			last_type_not_void: last_type /= Void
			last_byte_node_not_void: is_byte_node_enabled implies last_byte_node /= Void
		local
			l_source_type: like last_type
			l_source_expr: EXPR_B
			l_conv_info: CONVERSION_INFO
		do
			is_type_compatible.is_compatible := True
			is_type_compatible.conversion_info := Void
			l_source_type := last_type
				--| If `l_source_type' is of type NONE_A and if `l_target_type' does
				--| not conform to NONE, we generate in all the cases a VJAR error,
				--| we do not try to specify what kind of error, i.e.
				--| 1- if target was a basic or an expanded type, we should generate
				--|    a VNCE error.
				--| 2- if target was a BIT type, we should generate a VNCB error.
			if not l_target_type.backward_conform_to (context.current_class, l_source_type) then
				if
					not is_inherited and then
					l_source_type.convert_to (context.current_class, l_target_type.deep_actual_type)
				then
					l_conv_info := context.last_conversion_info
					is_type_compatible.conversion_info := l_conv_info
					if l_conv_info.has_depend_unit then
						context.supplier_ids.extend (l_conv_info.depend_unit)
					end
					if is_byte_node_enabled then
						l_source_expr ?= last_byte_node
						check
							l_source_expr_not_void: l_source_expr /= Void
						end
						last_byte_node := l_conv_info.byte_node (l_source_expr)
					end
				elseif
					l_source_type.is_expanded and then l_target_type.is_external and then
					l_source_type.is_conformant_to (context.current_class, l_target_type)
				then
						-- No need for conversion, this is currently done at the code
						-- generation level to properly handle the generic case.
						-- If not done at the code generation, we would need the following
						-- line.
					-- create {BOX_CONVERSION_INFO} l_conv_info.make (l_source_type)
				else
						-- Type does not convert neither, so we raise an error
						-- about non-conforming types.
					is_type_compatible.is_compatible := False
				end
			else
					-- Check that if `target' is frozen, `source' is also frozen.
				is_type_compatible.is_compatible := is_frozen_type_compatible (l_source_type, l_target_type, False)
			end
		ensure
			last_type_unchanged: last_type = old last_type
			last_byte_node_not_void: is_byte_node_enabled implies last_byte_node /= Void
		end

	is_frozen_type_compatible (a_source_type, a_target_type: TYPE_A; a_for_conversion: BOOLEAN): BOOLEAN
			-- Is `a_source_type' compatible with `a_target_type' with respect to the frozen mark?
		require
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
			type_conforms: not a_for_conversion implies a_target_type.backward_conform_to (context.current_class, a_source_type)
		local
			l_source, l_target: TYPE_A
		do
			if a_target_type.is_frozen then
				if a_source_type.actual_type.is_none then
						-- Assignment `a := Void' where `a' is frozen detachable,
						-- this is ok.
					Result := True
				elseif a_source_type.is_frozen then
						-- Both source and target are frozen.
					if a_for_conversion then
							-- We have a conversion to a frozen type, so nothing to be done.
						Result := True
					else
						l_source := a_source_type.conformance_type.as_attachment_mark_free
						l_target := a_target_type.conformance_type.as_attachment_mark_free
						Result := l_source.same_as (l_target)
						if not Result then
								-- Type are not exactly the same. So we check that they are the same
								-- base type. Note that if one of the source and target type was a formal
								-- the above test using `same_as' should succeed for the call to be valid.
							Result := attached {CL_TYPE_A} l_source as l_source_type and then
								attached {CL_TYPE_A} l_target as l_target_type and then
								l_source_type.class_id = l_target_type.class_id
						end
					end
				else
					Result := False
				end
			else
				Result := True
			end
		end

	process_assigner_command (a_target_type, a_target_constrained_type: TYPE_A; target_query: FEATURE_I)
			-- Attempt to calculate an assigner call associated with `target_query'
			-- called on type of `target_class_id'. Make the result available in
			-- `last_assigner_command'. Register client dependance on the target
			-- command.
		require
			target_query_not_void: target_query /= Void
		local
			l_assigner_name: STRING
			l_assigner_command: FEATURE_I
			l_type: TYPE_A
			l_target_class_id: INTEGER
		do
			last_assignment_target := target_query
			l_assigner_name := target_query.assigner_name
			if l_assigner_name = Void then
				last_assigner_command := Void
			else
				l_assigner_command := target_query.written_class.feature_named (l_assigner_name)
				if l_assigner_command /= Void then
						-- Evaluate assigner command in context of target type
					l_target_class_id := a_target_constrained_type.base_class.class_id
					l_assigner_command := system.class_of_id (l_target_class_id).feature_of_rout_id
						(l_assigner_command.rout_id_set.first)
					check
						assigner_command_attached: l_assigner_command /= Void
						assigner_command_valid: l_assigner_command.argument_count >= 1
					end
						-- Suppliers update
					if not is_inherited then
						context.supplier_ids.extend_depend_unit_with_level (l_target_class_id, l_assigner_command, depend_unit_level)
					end
					l_type := l_assigner_command.arguments.i_th (1).recomputed_in (
						a_target_type.as_implicitly_detachable.as_variant_free,
						context.current_class.class_id,
						a_target_constrained_type.as_implicitly_detachable.as_variant_free,
						l_target_class_id).actual_type
				end
				last_assigner_command := l_assigner_command
			end
		end

feature {NONE} -- Overloading

	overloaded_feature (
			a_type: TYPE_A; a_last_class: CLASS_C; a_arg_types: ARRAYED_LIST [TYPE_A];
			a_feature_name: ID_AS; is_static_access: BOOLEAN): FEATURE_I

			-- Find overloaded feature that could match Current. The rules are taken from
			-- C# ECMA specification "14.4.2 Overload Resolution".
		require
			a_type_not_void: a_type /= Void
			a_last_class_not_void: a_last_class /= Void
			feature_table_of_last_class_has_overloaded: a_last_class.feature_table.has_overloaded (a_feature_name.name_id)
		local
			last_id: INTEGER
			l_features: LIST [FEATURE_I]
			viof: VIOF
			l_list: ARRAYED_LIST [TYPE_A]
			i, nb: INTEGER
		do
			last_id := a_last_class.class_id

				-- At this stage we know this is an overloaded routine.
			l_features := a_last_class.feature_table.overloaded_items (a_feature_name.name_id)

				-- Remove all features that are not valid for Current call.
				-- C# ECMA 14.4.2.1
			l_features := applicable_overloaded_features (l_features, a_type, a_arg_types,
				last_id, is_static_access)

			if l_features.count = 1 then
				Result := l_features.first
			elseif not l_features.is_empty then
					-- Now that we have all valid features for this call, we need to find the
					-- best match. If we find more than one, there is an ambiguity.
					-- C# ECMA 14.4.2.2 and 14.4.2.3
				l_features := best_overloaded_features (l_features, a_type, a_arg_types, last_id)

				if l_features.count = 1 then
					Result := l_features.first
				elseif not l_features.is_empty then
						-- Raise a VIOF error which states type of arguments of current call and list
						-- all possible features that matches the above types.
					if a_arg_types /= Void then
						from
							i := 1
							nb := a_arg_types.count
							create l_list.make (nb)
						until
							i > nb
						loop
							l_list.extend (a_arg_types.i_th (i))
							i := i + 1
						end
					end
					create viof.make (context.current_class, current_feature,
						l_features, a_feature_name.name, last_id, l_list)
					viof.set_location (a_feature_name)
					error_handler.insert_error (viof)
				end
			end
		end

	applicable_overloaded_features
			(a_features: LIST [FEATURE_I]; a_type: TYPE_A; a_arg_types: ARRAYED_LIST [TYPE_A]; last_id: INTEGER;
			is_static_access: BOOLEAN): LIST [FEATURE_I]

			-- Use C# ECMA specification 14.4.2.1 to find list of matching features in
			-- `a_features' that matches given arguments.
			-- That is to say it keeps features that have the same number of parameters,
			-- that are agent creations with full open type specification and whose
			-- signature is valid for given arguments.
		require
			a_features_not_void: a_features /= Void
			a_type_not_void: a_type /= Void
			last_id_nonnegative: last_id >= 0
		local
			l_feature: FEATURE_I
			i, count: INTEGER
			l_done: BOOLEAN
			l_formal_arg_type: TYPE_A
			l_arg_type: TYPE_A
		do
			create {ARRAYED_LIST [FEATURE_I]} Result.make (a_features.count)
			if a_arg_types /= Void then
				count := a_arg_types.count
			end

				-- First remove not valid feature and feature with incorrect number of arguments.
			from
				a_features.start
			until
				a_features.after
			loop
				l_feature := a_features.item
				if
					l_feature /= Void and then l_feature.argument_count = count and then
					(not is_static_access or else l_feature.is_class)
				then
					Result.extend (l_feature)
				end
				a_features.forth
			end

			if Result.count >= 2 and then a_arg_types /= Void then
					-- Iterate through all found features and find all the features whose
					-- signature matches the one from the given arguments.
					-- In other words, for every `arg_i' of the given parameters, find
					-- all features where `arg_i' conforms to `formal_arg_i', formal argument
					-- type of the feature.
					-- Corresponds to second point of C# spec 14.4.2.1
				from
					Result.start
					count := count + 1
				until
					Result.after
				loop
					l_feature := Result.item

						-- Conformance checking
					from
						l_done := False
						i := 1
					until
						i = count or l_done
					loop
						l_formal_arg_type := feature_arg_type (l_feature, i, a_type, a_arg_types, last_id)
						l_arg_type := a_arg_types.i_th (i)
						if
							not (l_arg_type.conform_to (context.current_class, l_formal_arg_type) or
							l_arg_type.convert_to (context.current_class, l_formal_arg_type.deep_actual_type))
						then
								-- Error, we cannot continue. Let's check the next feature.
							l_done := True
						end
						i := i + 1
					end
					if l_done then
						Result.remove
					else
						Result.forth
					end
				end
			end
		ensure
			applicable_overloaded_features_not_void: Result /= Void
		end

	best_overloaded_features
			(a_features: LIST [FEATURE_I]; a_type: TYPE_A; a_arg_types: ARRAYED_LIST [TYPE_A];
			last_id: INTEGER): LIST [FEATURE_I]

			-- Use C# ECMA specification 14.4.2.2 and 14.4.2.3 to find list of best matching
			-- features in `a_features' that matches given arguments.
		require
			a_features_not_void: a_features /= Void
			a_features_has_two_items_at_least: a_features.count > 1
			all_features_have_arguments: a_features.for_all (agent {FEATURE_I}.has_arguments)
			a_type_not_void: a_type /= Void
			last_id_nonnegative: last_id >= 0
		local
			l_feature1, l_feature2, l_better_feature: FEATURE_I
			l_place_found: BOOLEAN
			l_set: SEARCH_TABLE [FEATURE_I]
			l_set_traversal: ARRAYED_LIST [FEATURE_I]
		do
				-- Our goal is to build `l_set' which is the set of features that are better
				-- functions. If this set contains only one item, then it is the best function,
				-- if it contains more than one element, it means that they are not comparable
				-- (meaning they are neither worse nor better than the other).
				--
				-- We iterate on all features in `a_features'. For each feature, we compare
				-- if it can be ordered in `l_set', if it can then we replace all worse feature
				-- by the one that can be ordered. Once all features of `a_features' have been
				-- handled, `l_set' is properly filled.
				--
				-- To summarize:
				-- For each feature f1 in `a_features' do
				--   For each feature f2 in `l_set' do
				--     if f1 better than f2, replace f2 by f1 in `l_set'
				--     if f2 better than f1, nothing
				--     if f1 is no better or no worse than f2, it is not ordered
				--   end for
				--   if f1 was for each iteration in `l_set' not ordered then
				--     we add it to `l_set'.
				--   end if
				-- end for
			from
				a_features.start
				create l_set.make (a_features.count)
			until
				a_features.after
			loop
				l_feature1 := a_features.item
				l_set_traversal := l_set.linear_representation
				from
					l_place_found := False
					l_set_traversal.start
				until
					l_set_traversal.after
				loop
					l_feature2 := l_set_traversal.item
					l_better_feature := better_feature (l_feature1, l_feature2, a_type, a_arg_types, last_id)
					if l_better_feature = l_feature1 then
							-- Replace `l_feature2' by `l_feature1' since we found a better match.
						l_set.remove (l_feature2)
						l_set.put (l_feature1)
						l_place_found := True
					elseif l_better_feature = l_feature2 then
						l_place_found := True
					end
					l_set_traversal.forth
				end
				if not l_place_found then
						-- `l_feature1' could not be ordered in `l_set_traversal'
						-- so we need to add it to `l_set'.
					l_set.put (l_feature1)
				end
				a_features.forth
			end
			Result := l_set.linear_representation
		ensure
			applicable_overloaded_features_not_void: Result /= Void
		end

	better_feature (
			a_feat1, a_feat2: FEATURE_I; a_type: TYPE_A; a_arg_types: ARRAYED_LIST [TYPE_A];
			last_id: INTEGER): FEATURE_I

			-- If `a_feat1' is better for overloading that `a_feat2', returns `a_feat1',
			-- if `a_feat2' is better for overloading than `a_feat1', returns `a_feat2',
			-- otherwise returns Void.
		require
			a_feat1_not_void: a_feat1 /= Void
			a_feat2_not_void: a_feat2 /= Void
			a_feat1_has_arguments: a_feat1.has_arguments
			a_feat2_has_arguments: a_feat2.has_arguments
			a_feat1_and_a_feat2_have_same_argument_count:
				a_feat1.argument_count = a_feat2.argument_count
			a_type_not_void: a_type /= Void
			last_id_nonnegative: last_id >= 0
		local
			l_target1, l_target2, l_better: TYPE_A
			l_current_item: TYPE_A
			i, l_formal_count: INTEGER
			l_done: BOOLEAN
		do
			from
				Result := Void
				l_done := False
				i := 1
				l_formal_count := a_feat1.argument_count + 1
			until
				i = l_formal_count or l_done
			loop
					-- Extract argument info from `a_feat1'.
				l_target1 := feature_arg_type (a_feat1, i, a_type, a_arg_types, last_id)

					-- Extract argument info from `a_feat2'.
				l_target2 := feature_arg_type (a_feat2, i, a_type, a_arg_types, last_id)

					-- Extract passed argument info.
				l_current_item := a_arg_types.i_th (i)

				if not l_target1.same_as (l_target2) then
					l_better := better_conversion (l_current_item, l_target1, l_target2)
					if l_better = Void then
							-- No better conversion found, it means that we can skip
							-- this feature `a_feat2'.
						l_done := True
						Result := Void
					else
						if Result = Void then
							if l_better = l_target1 then
									-- It means that at the moment `a_feat1' seems
									-- to be a better feature, we store `a_feat1'
									-- as best routine.
								Result := a_feat1
							else
								Result := a_feat2
							end
						else
								-- We had already assigned `Result', so we
								-- really have a better feature, so we need to ensure the new
								-- better conversion matches the better found feature.
							if Result = a_feat1 then
								l_done := l_better = l_target2
							else
								l_done := l_better = l_target1
							end
							if l_done then
								Result := Void
							end
						end
					end
				end
				i := i + 1
			end
		ensure
			better_function_valid: Result = Void or Result = a_feat1 or Result = a_feat2
		end

	better_conversion (source_type, target1, target2: TYPE_A): TYPE_A
			-- Using C# ECMA 14.4.2.3 terminology, given `source_type' find which of `target1'
			-- or `target2' is a better conversion.
			-- Return type is either `target1' or `target2' if there is a better conversion,
			-- otherwise Void.
		require
			source_type_not_void: source_type /= Void
			target1_not_void: target1 /= Void
			target2_not_void: target2 /= Void
			target1_different_from_target2: not target1.same_as (target2)
		local
			conform1, conform2: BOOLEAN
			convert1, convert2: BOOLEAN
		do
			if source_type.same_as (target1) then
				Result := target1
			elseif source_type.same_as (target2) then
				Result := target2
			else
					-- First process conformance.
				conform1 := source_type.conform_to (context.current_class, target1)
				conform2 := source_type.conform_to (context.current_class, target2)
				if conform1 and conform2 then
					if target1.conform_to (context.current_class, target2) then
						Result := target1
					elseif target2.conform_to (context.current_class, target1) then
						Result := target2
					end
				elseif conform1 then
					Result := target1
				elseif conform2 then
					Result := target2
				else
						-- Conformance failed, so let's check conversion.
					convert1 := source_type.convert_to (context.current_class, target1.deep_actual_type)
					convert2 := source_type.convert_to (context.current_class, target2.deep_actual_type)
					if convert1 and not convert2 then
						Result := target1
					elseif convert2 and not convert1 then
						Result := target2
					end
				end
			end
		ensure
			better_conversion_found: Result /= Void implies (Result = target1 or Result = target2)
		end

	feature_arg_type
			(a_feature: FEATURE_I; a_pos: INTEGER; a_type: TYPE_A; a_arg_types: ARRAYED_LIST [TYPE_A]; last_id: INTEGER): TYPE_A

			-- Find type of argument at position `a_pos' of feature `a_feature' in context
			-- of `a_type', `last_id'.
		require
			a_feature_not_void: a_feature /= Void
			a_feature_has_arguments: a_feature.has_arguments
			a_pos_valid: a_feature.arguments.valid_index (a_pos)
			a_type_not_void: a_type /= Void
			last_id_nonnegative: last_id >= 0
		do
				-- Get type from FEATURE_I. It should be evaluated already and therefore
				-- assignment attempt should work.
			Result ?= a_feature.arguments.i_th (a_pos)
			check
				feature_evaluated: Result /= Void
			end

				-- Evaluation of the actual type of the
				-- argument declaration
			if a_arg_types /= Void then
				Result := Result.actual_argument_type (a_arg_types)
			end

				-- Instantiation of `Result' in context of target represented by `a_type' and
				-- `last_id'.
			Result := Result.instantiation_in (a_type.as_implicitly_detachable.as_variant_free, last_id).actual_type
		ensure
			feature_arg_type_not_void: Result /= Void
		end

feature {NONE} -- Agents

	compute_routine (
			a_feature: FEATURE_I; a_is_query, a_has_args: BOOLEAN; cid : INTEGER; a_target_type: TYPE_A;
			a_feat_type: TYPE_A; an_agent: ROUTINE_CREATION_AS; an_access: ACCESS_B; a_target_node: EXPR_B)
			-- Type of routine object.
		require
			a_target_type_not_void: a_target_type /= Void
			valid_feature: is_byte_node_enabled or a_has_args implies a_feature /= Void;
			no_byte_code_for_attribute: is_byte_node_enabled implies not a_feature.is_attribute
		local
			l_type, l_query_type: TYPE_A
			l_generics: ARRAYED_LIST [TYPE_A]
			l_feat_args: FEAT_ARG
			l_oargtypes, l_cargtypes: ARRAYED_LIST [TYPE_A]
			l_tuple_type: TUPLE_TYPE_A
			l_arg_count, l_open_count, l_closed_count, l_idx, l_oidx: INTEGER
			l_operand: OPERAND_AS
			l_is_open, l_target_closed: BOOLEAN
			l_result_type: TYPE_A
			l_gen_type: GEN_TYPE_A
			l_last_open_positions: ARRAYED_LIST [INTEGER]
			l_routine_creation: ROUTINE_CREATION_B
			l_tuple_node: TUPLE_CONST_B
			l_expressions: BYTE_LIST [EXPR_B]
			l_parameters_node: BYTE_LIST [PARAMETER_B]
			l_expr: EXPR_B
			l_array_of_opens: ARRAY_CONST_B
			l_is_qualified_call: BOOLEAN
		do
				-- When the agent is a qualified call, we need to remove the anchors because otherwise
				-- we cannot create the proper agent type, see eweasel test#exec271.
			l_is_qualified_call := an_agent.target /= Void and then
				(not an_agent.target.is_open or else an_agent.target.class_type /= Void)

			if a_is_query then
					-- Evaluate type of Result in current context
				l_type := a_feat_type.instantiation_in (a_target_type.as_implicitly_detachable.as_variant_free, cid)
				if l_is_qualified_call or l_type.has_like_argument then
					l_type := l_type.deep_actual_type
				end
				if l_type.actual_type.is_boolean then
						-- generics are: open_types
					create l_generics.make (1)
					create l_gen_type.make (System.predicate_class_id, l_generics)
				else
						-- generics are: open_types, result_type
					create l_generics.make (2)
					l_query_type := l_type
					create l_gen_type.make (System.function_class_id, l_generics)
				end
			else
					-- generics are: open_types
				create l_generics.make (1)
				create l_gen_type.make (System.procedure_class_id, l_generics)
			end
				-- Type of an agent is frozen.
			l_gen_type.set_frozen_mark
			l_result_type := l_gen_type

			if a_has_args then
				l_feat_args := a_feature.arguments
				l_arg_count := l_feat_args.count + 1
			else
				l_arg_count := 1
			end

				-- Compute `operands_tuple' and type of TUPLE needed to determine current
				-- ROUTINE type.

				-- Create `l_oargtypes'. But first we need to find the `l_count', number
				-- of open operands.

			if an_agent.target /= Void and then an_agent.target.is_open then
					-- No target is specified, or just a class type is specified.
					-- Therefore there is at least one argument
				l_open_count := 1
				l_oidx := 2
			else
					-- Target was specified
				l_open_count := 0
				l_target_closed := True
			end

				-- Compute number of open positions.
			if an_agent.operands /= Void then
				from
					an_agent.operands.start
				until
					an_agent.operands.after
				loop
					if an_agent.operands.item.is_open then
						l_open_count := l_open_count + 1
					end
					an_agent.operands.forth
				end
			else
				if a_has_args then
					l_open_count := l_open_count + l_feat_args.count
				end
			end

				-- Create `oargytpes' with `l_count' parameters. This array
				-- is used to create current ROUTINE type.
			create l_oargtypes.make (l_open_count)

			if l_open_count > 0 then
				create l_last_open_positions.make (l_open_count)
				if l_oidx > 1 then
						-- Target is open, so insert it.
					l_last_open_positions.extend (1)
					l_oargtypes.extend (a_target_type)
				end
			end

				-- Create `l_cargtypes', array used to initialize type of `operands_tuple'.
				-- This array can hold the types for all closed arguments
			l_closed_count := l_arg_count - l_open_count
			create l_cargtypes.make (l_closed_count)

				-- Always insert target's type in `l_cargtypes' as first argument.
			if l_target_closed then
				l_cargtypes.extend (a_target_type)
			end

				-- Create argument types
			if l_feat_args /= Void then
				from
						-- `l_idx' is 2, because at position `1' we have target of call.
					l_idx := 2
					l_feat_args.start
					if an_agent.operands /= Void then
						an_agent.operands.start
					end
				until
					l_feat_args.after
				loop
					l_type := Void

						-- Let's find out if this is really an open operand.
					if an_agent.operands /= Void then
						l_operand := an_agent.operands.item
						if l_operand.is_open then
							l_is_open := True
							if l_operand.class_type /= Void then
								l_operand.process (Current)
								l_type := last_type
							end
						else
							l_is_open := False
						end
					else
						l_is_open := True
					end

						-- Get type of operand.
					if l_is_open then
						if l_type = Void then
							l_type := l_feat_args.item
						end
					else
						l_type := l_feat_args.item
					end

						-- Evaluate type of operand in current context
					l_type := l_type.instantiation_in (
						a_target_type.as_implicitly_detachable.as_variant_free, cid)
					if l_is_qualified_call then
						l_type := l_type.deep_actual_type
					elseif l_type.has_like_argument then
						l_type := l_type.deep_actual_type
					end

						-- If it is open insert it in `l_oargtypes' and insert
						-- position in `l_last_open_positions'.
					if l_is_open then
						l_oargtypes.extend (l_type)
						l_last_open_positions.extend (l_idx)
					else
						-- Add type to `l_argtypes'.
						l_cargtypes.extend (l_type)
					end

					l_idx := l_idx + 1
					l_feat_args.forth

					if an_agent.operands /= Void then
						an_agent.operands.forth
					end
				end
			end

				-- Create open argument type tuple
			create l_tuple_type.make (System.tuple_id, l_oargtypes)
			l_tuple_type.set_frozen_mark
				-- Type of an argument tuple is always attached.
			l_tuple_type := l_tuple_type.as_attached_in (context.current_class)
				-- Add argument parameter of ROUTINE.
			l_generics.extend (l_tuple_type)
				-- Add result paramater of FUNCTION (if required).
			if l_query_type /= Void then
				l_generics.extend (l_query_type)
			end

				-- Type of an agent is always attached.
			l_result_type := l_result_type.as_attached_in (context.current_class)

				-- If a target type is separate, a type of the agent is separate.
			adapt_type_to_target (l_result_type, a_target_type, a_feature, is_controlled, an_agent, 0, Void)
			l_result_type := last_type

			if is_byte_node_enabled then
				create l_routine_creation

				l_parameters_node := an_access.parameters

					-- Setup closed arguments in `l_cargtypes'.
				create l_expressions.make_filled (l_closed_count)
				l_expressions.start

				if
					attached a_target_node and then
					not attached {OPERAND_B} a_target_node
				then
						-- A target was specified, we need to check if it is an open argument or not
						-- by simply checking that its byte node is not an instance of OPERAND_B.
					l_expressions.replace (a_target_node)
					l_expressions.forth
				end

				if l_parameters_node /= Void then
						-- Insert values in `l_expressions'.
					from
						l_parameters_node.start
					until
						l_parameters_node.after
					loop
						l_expr := l_parameters_node.item.expression
						if not attached {OPERAND_B} l_expr then
								-- Closed operands, we insert its expression.
							l_expressions.replace (l_expr)
							l_expressions.forth
						end
						l_parameters_node.forth
					end
				end

					-- Create TUPLE_CONST_B instance which holds all closed arguments.
				l_expressions.start
				create l_tuple_type.make (System.tuple_id, l_cargtypes)
				l_tuple_type.set_frozen_mark
				create l_tuple_node.make (l_expressions, l_tuple_type, l_tuple_type.create_info)

					-- We need to instantiate the closed TUPLE type of the agent otherwise it
					-- causes eweasel test#agent007 to fail.
				instantiator.dispatch (l_tuple_node.type, context.current_class)

					-- Setup l_last_open_positions

				if l_last_open_positions /= Void then
					create l_expressions.make_filled (l_last_open_positions.count)
					from
						l_expressions.start
						l_last_open_positions.start
					until
						l_last_open_positions.after
					loop
						l_expressions.replace (
							create {INTEGER_CONSTANT}.make_with_value (l_last_open_positions.item))
						l_expressions.forth
						l_last_open_positions.forth
					end

						-- Create ARRAY_CONST_B which holds all open positions in
						-- above generated tuple.
					l_expressions.start
					create l_array_of_opens.make (l_expressions, integer_array_type)
				end

					-- Initialize ROUTINE_CREATION_B instance
					-- We need to use the conformance_type since it could be a like_current type which would
					-- be a problem with inherited assertions. See eweasel test execX10
				l_routine_creation.init (a_target_type.conformance_type,
					a_feature, l_result_type, l_tuple_node, l_array_of_opens, l_last_open_positions,
					a_feature.is_inline_agent, l_target_closed, a_target_type.base_class.is_basic)

				last_byte_node := l_routine_creation
			end
			set_type (l_result_type, an_agent)
		ensure
			exists: last_type /= Void
		end

	integer_array_type : GEN_TYPE_A
			-- Representation of an array of INTEGER
		local
			generics : ARRAYED_LIST [TYPE_A]
		once
			create generics.make (1)
			generics.extend (integer_type)
			create Result.make (System.array_id, generics)
				-- This array is used to create instances so it is frozen.
			Result.set_frozen_mark
		end

	compute_feature_fake_inline_agent (a_rc: ROUTINE_CREATION_AS; a_feature: FEATURE_I; a_target: EXPR_B;
								a_target_type: TYPE_A; a_agent_type: TYPE_A)
		local
			l_result_type: TYPE_A
		do
				-- We need to adapt type of agent to its context, as otherwise we have the wrong signature
				-- See eweasel test#agent010 where the FORMAL_A was not translated into CL_TYPE_A and we got
				-- a compilation crash at degree 2; as well as test#agent004.
			l_result_type := a_feature.type
			l_result_type := l_result_type.instantiation_in (a_target_type.as_implicitly_detachable.as_variant_free, a_rc.class_id)
			compute_fake_inline_agent (a_rc, a_feature.access (l_result_type, True, a_target_type.is_separate), l_result_type, a_target,
									a_target_type, a_agent_type, a_feature)
		end

	compute_named_tuple_fake_inline_agent (a_rc: ROUTINE_CREATION_AS; a_named_tuple: NAMED_TUPLE_TYPE_A; a_label_pos: INTEGER;
										a_target: EXPR_B; a_target_type: TYPE_A; a_agent_type: TYPE_A)
		local
			l_tuple_access_b: TUPLE_ACCESS_B
		do
			create l_tuple_access_b.make (a_named_tuple, a_label_pos)
			compute_fake_inline_agent (a_rc, l_tuple_access_b, l_tuple_access_b.type, a_target, a_target_type, a_agent_type, Void)
		end

	compute_fake_inline_agent (
			a_rc: ROUTINE_CREATION_AS
			a_feature: CALL_B
			a_feature_type: TYPE_A
			a_target: EXPR_B
			a_target_type: TYPE_A
			a_agent_type: TYPE_A
			a_for_feature: FEATURE_I)

			-- Creates an inline agent bytenode that is semanticaly equivalent to the agent on the target byte node
			-- It further creates the proper routine creation
			-- agent T.a becomes:
			-- agent(t: TYPE_T): TYPE_a do Result := t.a end (T)
		require
			a_for_feature /= Void implies (a_for_feature.is_attribute or a_for_feature.is_constant)
		local
			l_func: DYN_FUNC_I
			l_args: FEAT_ARG
			l_code: STD_BYTE_CODE
			l_byte_list: BYTE_LIST [BYTE_NODE]
			l_nested: NESTED_B
			l_argument: ARGUMENT_B
			l_tuple_node: TUPLE_CONST_B
			l_closed_args: BYTE_LIST [EXPR_B]
			l_agent_type: GEN_TYPE_A
			l_target: EXPR_B
			l_cur_class: EIFFEL_CLASS_C
			l_enclosing_feature: FEATURE_I
			l_tuple_type: TUPLE_TYPE_A
			l_target_closed: BOOLEAN
			l_rout_creation: ROUTINE_CREATION_B
			l_generics: ARRAYED_LIST [TYPE_A]
		do
			l_target_closed := not (a_rc.target /= Void and then a_rc.target.is_open)
			l_cur_class := context.current_class.eiffel_class_c
			create l_func
			create l_args.make (1)
			l_args.extend_with_name (a_target_type, {PREDEFINED_NAMES}.fake_inline_agent_target_name_id)
			l_func.set_arguments (l_args)
			l_func.set_type (a_feature_type, 0)

			l_func.set_is_fake_inline_agent (True)
			l_enclosing_feature := init_inline_agent_feature (l_func, a_for_feature, l_cur_class, l_cur_class)

			create l_byte_list.make (1)
			l_byte_list.start

			create l_argument
			l_argument.set_position (1)

			create l_nested
			l_nested.set_target (l_argument)
			l_nested.set_message (a_feature)
			a_feature.set_parent (l_nested)

			l_byte_list.extend (create {ASSIGN_B}.make (create {RESULT_B}, l_nested))
			create l_code
			l_code.set_compound (l_byte_list)

			l_code.set_arguments (<<a_target_type>>)

			l_code.set_rout_id (l_func.rout_id_set.first)
			l_code.set_body_index (l_func.body_index)
			l_code.set_start_line_number (a_rc.start_location.line)
			l_code.set_end_location (a_rc.end_location)
			l_code.set_result_type (a_feature_type)
			l_code.set_feature_name_id (l_func.feature_name_id)
			if inline_agent_byte_codes = Void then
				create inline_agent_byte_codes.make
			end
			inline_agent_byte_codes.extend (l_code)

			l_func.process_pattern
			l_cur_class.insert_changed_assertion (l_func)

			if l_target_closed then
				create l_closed_args.make (2)
				if a_target = Void or attached {OPERAND_B} a_target then
					create {CURRENT_B} l_target
				else
					l_target := a_target
				end
				l_closed_args.extend (create {CURRENT_B})
				l_closed_args.extend (l_target)

				create l_generics.make (2)
				l_generics.extend (context.current_class_type)
				l_generics.extend (a_target_type)
				create l_tuple_type.make (system.tuple_id, l_generics)
				l_tuple_type.set_frozen_mark
			else
				create l_closed_args.make (1)
				l_closed_args.extend (create {CURRENT_B})
				create l_generics.make (1)
				l_generics.extend (context.current_class_type)
				create l_tuple_type.make (system.tuple_id, l_generics)
				l_tuple_type.set_frozen_mark
			end

				-- We need to instantiate the closed TUPLE type of the agent otherwise it
				-- causes eweasel test#agent007 to fail.
			instantiator.dispatch (l_tuple_type, context.current_class)

			create l_tuple_node.make (l_closed_args, l_tuple_type, l_tuple_type.create_info)

				-- We need to use the conformence type since it could be a like_current type which would
				-- be a problem with inherited assertions. See eweasel test execX10
			l_agent_type ?= a_agent_type.conformance_type

			create l_rout_creation
			if l_target_closed  then
				l_rout_creation.init (context.current_class_type,
					l_func,
					l_agent_type,
					l_tuple_node,
					Void,
					Void,
					True,
					True,
					False)
			else
				l_rout_creation.init (context.current_class_type,
					l_func,
					l_agent_type,
					l_tuple_node,
					open_target_omap_bc,
					open_target_omap,
					True,
					False,
					False)
			end

			if not is_inherited then
					-- Record a dependance between the fake inline agent and the enclosing routine being analyzed.
				context.supplier_ids.extend_depend_unit_with_level (l_cur_class.class_id, l_enclosing_feature, depend_unit_level | {DEPEND_UNIT}.is_uniform_flag)
			end

			last_byte_node := l_rout_creation
		end

	open_target_omap: ARRAYED_LIST [INTEGER_32]
		do
			create Result.make (1)
			Result.extend (2)
		end

	open_target_omap_bc: ARRAY_CONST_B
		local
			l_byte_list: BYTE_LIST [BYTE_NODE]
		do
			create l_byte_list.make (1)
			l_byte_list.extend (create {INTEGER_CONSTANT}.make_with_value (2))
			create Result.make (l_byte_list, integer_array_type)
		end

	empty_omap_bc: ARRAY_CONST_B
		do
			create Result.make (create {BYTE_LIST [BYTE_NODE]}.make (0), integer_array_type)
		end

	init_inline_agent_feature (a_feat, a_real_feat: FEATURE_I; a_current_class, a_written_class: EIFFEL_CLASS_C): FEATURE_I
			-- a_feat may just be a fake wrapper to a_real_feat (for agents on attributes).
		require
			a_feat_not_void: a_feat /= Void
			a_feat_valid: a_feat.is_attribute implies a_real_feat /= Void
		local
			l_new_rout_id_set: ROUT_ID_SET
			l_cur_class: EIFFEL_CLASS_C
			l_enclosing_feature, l_new_enclosing_feature: FEATURE_I
			l_name: STRING
			l_number: INTEGER
			l_is_fake: BOOLEAN
			l_old_inline_agents: HASH_TABLE [FEATURE_I, INTEGER]
			l_old_feat: FEATURE_I
		do
			l_cur_class := a_current_class
			Result := a_feat

			l_is_fake := Result.is_fake_inline_agent

			create l_new_rout_id_set.make
			if l_is_fake then
				l_number := -1
			else
				l_number := context.inline_agent_counter.next
				l_old_inline_agents := context.old_inline_agents
				if l_old_inline_agents /= Void and then l_old_inline_agents.has_key (l_number) then
					l_old_feat := l_old_inline_agents.found_item
				end
			end
			if l_old_feat /= Void then
				Result.set_body_index (l_old_feat.body_index)
				l_new_rout_id_set.put (l_old_feat.rout_id_set.first)
				Result.set_feature_id (l_old_feat.feature_id)
				Result.set_origin_feature_id (l_old_feat.origin_feature_id)
			else
				Result.set_body_index (system.body_index_counter.next_id)
				l_new_rout_id_set.put (Result.new_rout_id)
				Result.set_feature_id (l_cur_class.feature_id_counter.next)
				Result.set_origin_feature_id (Result.feature_id)
			end
			Result.set_rout_id_set (l_new_rout_id_set)
			Result.set_written_in (a_written_class.class_id)
			Result.set_origin_class_id (Result.written_in)
			Result.set_export_status (create {EXPORT_ALL_I})

				-- calculate the enclosing feature
			from
				l_enclosing_feature := current_feature
			until
				not l_enclosing_feature.is_inline_agent
			loop
				l_new_enclosing_feature :=
					l_cur_class.feature_of_body_index (l_enclosing_feature.enclosing_body_id_or_creator_position)
				if l_new_enclosing_feature = Void then
						-- then it has to be the class invariant feature
					check
						l_enclosing_feature.enclosing_body_id_or_creator_position = l_cur_class.invariant_feature.body_index
					end
					l_enclosing_feature := l_cur_class.invariant_feature
				else
					l_enclosing_feature := l_new_enclosing_feature
				end
			end

			if is_replicated then
					-- We need to replicate the agent feature.
				Result := Result.replicated (a_current_class.class_id)
				Result.set_is_replicated_directly (True)
					-- Instantiate agent with respect to current class.
				Result := Result.instantiation_in (context.current_class_type.conformance_type.as_implicitly_detachable.as_variant_free)
				if l_enclosing_feature.has_replicated_ast then
					Result.set_has_replicated_ast (True)
				end
				if l_enclosing_feature.from_non_conforming_parent then
					Result.set_from_non_conforming_parent (True)
				end
			end

			Result.set_inline_agent (l_enclosing_feature.body_index, l_number)

			if l_is_fake then
				l_name := "fake inline-agent"
				l_name.append_character ('#')
				l_name.append_integer (Result.body_index)
				if a_real_feat /= Void then
					l_name.append_character ('#')
					l_name.append_integer (a_real_feat.written_in)
					l_name.append_character ('#')
					l_name.append_integer (a_real_feat.feature_id)
					l_name.append_character ('#')
				end
			else
				l_name := "inline-agent"
				l_name.append_character ('#')
				l_name.append_integer (Result.inline_agent_nr)
			end
			l_name.append_string (" of ")
			l_name.append (l_enclosing_feature.feature_name)
			Result.set_feature_name (l_name)

			if is_byte_node_enabled then
				system.rout_info_table.put (l_new_rout_id_set.first, l_cur_class)
				l_cur_class.put_inline_agent (Result)

				degree_2.insert_class (l_cur_class)
			end
		end

	init_inline_agent_dep (a_feat: FEATURE_I; a_new_feat_dep: FEATURE_DEPENDANCE)
			-- When an inline agent X of an enclosing feature f is a client of
			-- feature g, we make the enclosing feature f a client of g.
		require
			not_inherited: not is_inherited
			a_feat_not_void: a_feat /= Void
			a_new_feat_dep_not_void: a_new_feat_dep /= Void
		do
			from
				a_new_feat_dep.start
			until
				a_new_feat_dep.after
			loop
				context.supplier_ids.extend (a_new_feat_dep.item)
				a_new_feat_dep.forth
			end
			if attached a_new_feat_dep.instance_suppliers as s then
				across
					s as i
				loop
					context.supplier_ids.add_instance_supplier (i.item)
				end
			end
			a_feat.process_pattern
			context.current_class.insert_changed_assertion (a_feat)
		end

	check_agent_call_validity (a_feature: FEATURE_I; a_last_type: TYPE_A; a_parameters: EIFFEL_LIST [EXPR_AS]; a_arg_types: ARRAYED_LIST [TYPE_A])
			-- Is the call to `{ROUTINE}.call' or `{FUNCTION}.item' and descendants valid with
			-- respects to the variance mark of the TUPLE actual generic parameter of the agent
			-- type. To be valid, the tuple type should not have any variant actual generic
			-- parameters as otherwise we could have a catcall.
		local
			l_tcat: CAT_CALL_WARNING
		do
			check
				has_generics: attached a_last_type.generics as l_generics and then not l_generics.is_empty
			end
				-- The type `a_last_type' represents a ROUTINE/PROCEDURE/FUNCTION/PREDICATE
				-- and its first actual generic parameter represents the type of the TUPLE.
				-- In the event, it is not generics, it means that the type is a formal one.
				-- In this case, we do not do anything because it should be taken care with
				-- existing rules governing calls on features involving formal generic parameters.
			if attached a_last_type.generics.first.actual_type.generics as l_generics then
				across
					l_generics as l_types
				loop
					if l_types.item.is_variant then
						if l_tcat = Void then
							create l_tcat.make (a_parameters.start_location)
							context.init_error (l_tcat)
							l_tcat.set_called_feature (a_feature)
							error_handler.insert_error (l_tcat)
						end
						l_tcat.add_covariant_generic_violation
					end
				end
			end
		end

	agent_call_routine_ids: SEARCH_TABLE [INTEGER]
			-- Set of the routine IDs for routines `call' and `item' of the agent classes (ROUTINE,
			-- PROCEDURE, FUNCTION and PREDICATE).
		do
			if attached internal_agent_call_routine_ids as l_result then
				Result := l_result
			else
				create Result.make (10)
					-- Adding {ROUTINE}.call.
				if
					attached system.routine_class as l_rout_class and then
					attached l_rout_class.compiled_class as l_class and then
					attached l_class.feature_table.item_id ({NAMES_HEAP}.call_name_id) as l_feat
				then
					Result.put (l_feat.rout_id_set.first)
				end

					-- Adding {PROCEDURE}.call.
				if
					attached system.procedure_class as l_proc_class and then
					attached l_proc_class.compiled_class as l_class and then
					attached l_class.feature_table.item_id ({NAMES_HEAP}.call_name_id) as l_feat
				then
					Result.put (l_feat.rout_id_set.first)
				end

					-- Adding {FUNCTION}.item (and implicitely {PREDICATE}.item).
				if
					attached system.function_class as l_func_class and then
					attached l_func_class.compiled_class as l_class and then
					attached l_class.feature_table.item_id ({NAMES_HEAP}.item_name_id) as l_feat
				then
					Result.put (l_feat.rout_id_set.first)
				end

				internal_agent_call_routine_ids := Result
			end
		end

	internal_agent_call_routine_ids: SEARCH_TABLE [INTEGER]
			-- Storage for `agent_call_routine_ids'.

feature {AST_FEATURE_CHECKER_GENERATOR}

	break_point_slot_count: INTEGER
			-- Counts the breakpoint slots that occurred during processing the feature.

feature {NONE} -- Precursor handling

	precursor_table (l_as: PRECURSOR_AS; a_current_class: CLASS_C; a_rout_id_set: ROUT_ID_SET): LINKED_LIST [TUPLE [feat: FEATURE_I; parent_type: CL_TYPE_A]]
			-- Table of parent types which have an effective
			-- precursor of current feature. Indexed by
			-- routine ids.
		require
			l_as_not_void: l_as /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A]
			a_parent: CLASS_C
			p_name: STRING
			spec_p_name: STRING
			p_list: HASH_TABLE [CL_TYPE_A, STRING]
			i, rc: INTEGER
			couple: TUPLE [written_in, body_index: INTEGER]
			check_written_in: LINKED_LIST [TUPLE [written_in, body_index: INTEGER]]
			r_class_i: CLASS_I
		do
			rc := a_rout_id_set.count

			if l_as.parent_base_class /= Void then
				-- Take class renaming into account
				r_class_i := Universe.class_named (l_as.parent_base_class.class_name.name, a_current_class.group)

				if r_class_i /= Void then
					spec_p_name := r_class_i.name
				else
					-- A class of name `l_as.parent_base_class' does not exist
					-- in the universe. Use an empty name to trigger
					-- an error message later.
					spec_p_name := ""
				end
			end

			from
				parents := a_current_class.parents
				create Result.make
				create check_written_in.make
				check_written_in.compare_objects
				create p_list.make (parents.count)
				parents.start
			until
				parents.after
			loop
				a_parent := parents.item.base_class
				p_name := a_parent.name

					-- Don't check the same parent twice.
					-- If construct is qualified, check
					-- specified parent only.
				if
					not (p_list.has_key (p_name) and then
					p_list.found_item.is_equivalent (parents.item)) and then
					(spec_p_name = Void or else spec_p_name.is_equal (p_name))
				then
						-- Check if parent has an effective precursor
					from
						i := 1
					until
						i > rc
					loop
						if
							attached a_parent.feature_of_rout_id (a_rout_id_set.item (i)) as a_feature and then
							not a_feature.is_deferred
						then
								-- Ok, add parent.
							couple := [a_feature.written_in, a_feature.body_index]
								-- Before entering the new info in `Result' we
								-- need to make sure that we do not have the same
								-- item, because if we were adding it, it will
								-- cause a VDPR3 error when it is not needed.
							if not check_written_in.has (couple) then
								Result.extend ([a_feature, parents.item])
								check_written_in.extend (couple)
							end
						end
						i := i + 1
					end
						-- Register parent
					p_list.put (parents.item, p_name)
				end
				parents.forth
			end
		end

feature {NONE} -- Implementation

	feature_with_name_using (a_feature_name: ID_AS; a_feature_table: FEATURE_TABLE): FEATURE_I
			-- Feature with feature_name `a_feature_name' using among other means `a_feature_table'
		require
			a_feature_name_not_void: a_feature_name /= Void
		do
			Result := a_feature_table.item_id  (a_feature_name.name_id)
		end

	class_id_of (a_type: TYPE_A): INTEGER
			-- Sets the class id of `a_type' in `a_as' if possible
		require
			a_type_not_void: a_type /= Void
		local
			l_formal: FORMAL_A
			l_type_a: TYPE_A
			cl: CLASS_C
		do
			l_type_a := a_type.actual_type
			Result := -1
			if l_type_a.is_formal then
				cl := context.current_class
				l_formal ?= l_type_a
				if not l_formal.is_multi_constrained (cl) then
					l_type_a := l_formal.constrained_type (cl)
					if not (l_type_a.is_none or l_type_a.is_void) then
						Result := l_type_a.base_class.class_id
					end
				end
			elseif not (l_type_a.is_none or l_type_a.is_void or not l_type_a.is_known) then
				Result := l_type_a.base_class.class_id
			end
		end

	match_list_of_class (a_class_id: INTEGER): LEAF_AS_LIST
			-- Match list object for class id `a_class_id'
		require
			id_not_null: a_class_id /= 0
		do
			Result := match_list_server.item (a_class_id)
		end

feature {NONE} -- Implementation: Add type informations

	last_routine_id_set: ROUT_ID_SET
			-- The last routine ids.

feature {NONE} -- Implementation: type validation

	check_type (a_type: TYPE_AS)
			-- Evaluate `a_type' into a TYPE_A instance if valid.
			-- If not valid, raise a compiler error and return Void.
		require
			a_type_not_void: a_type /= Void
		local
			l_type: detachable TYPE_A
			l_error_level: NATURAL
		do
			l_error_level := error_level
			if is_inherited or else is_replicated then
					-- Convert TYPE_AS into TYPE_A.
				l_type := type_a_generator.evaluate_type (a_type, context.written_class)
					-- Perform simple check that TYPE_A is valid, `l_type' should not be
					-- Void after this call since it was not Void when checking the parent
					-- class
				l_type := inherited_type_a_checker.solved (l_type, a_type)
				check l_type_not_void: l_type /= Void end
				l_type := l_type.evaluated_type_in_descendant (context.written_class,
					context.current_class, current_feature)
			else
				l_type := type_a_generator.evaluate_type (a_type, context.current_class)
					-- Perform simple check that TYPE_A is valid.
				l_type := type_a_checker.check_and_solved (l_type, a_type)
			end
			if error_level = l_error_level then
					-- Check validity of type declaration
				type_a_checker.check_type_validity (l_type, a_type)
					-- Update `last_type' with found type.
				set_type (l_type, a_type)
			end

			if error_level /= l_error_level then
				reset_types
			end
		ensure
			definition:
				(last_type = Void implies (error_level /= old error_level)) or
				(last_type /= Void implies (error_level = old error_level))
		end

	adapted_type (a_type, a_last_type, a_last_constrained: TYPE_A): TYPE_A
			-- If `a_type' is formal or like, it adapts it to the context given by `a_last_type'
			-- and `a_constrainted_type'.
		require
			a_type_not_void: a_type /= Void
			a_last_type_not_void: a_last_type /= Void
			a_last_constrained_not_void: a_type.is_formal implies a_last_constrained /= Void
		local
			l_formal_type: FORMAL_A
		do
				-- If the declared target type is formal
				-- and if the corresponding generic parameter is
				-- constrained to a class which is also generic
				-- Result is a FORMAL_A object with no more information
				-- than the position of the formal in the generic parameter
				-- list of the class in which the feature "l_feature_name" is
				-- declared.
				-- Example:
				--
				-- 	class TEST [G -> ARRAY [STRING]]
				--	...
				--	x: G
				-- 		x.item (1)
				--
				-- For the evaluation of `item', l_last_type is "G#1" (of TEST)
				-- `l_last_constrained_type' is ARRAY [STRING], `l_feature.type'
				-- is "G#1" (of ARRAY)
				-- We need to convert the type to the constrained type for proper
				-- type evaluation of remote calls.
				-- "G#1" (of ARRAY) is thus replaced by the corresponding actual
				-- type in the declaration of the constraint class type (in this case
				-- class STRING).
				-- Note: the following conditional instruction will not be executed
				-- if the class type of the constraint is not generic since in that
				-- case `Result' would not be formal.
			Result := a_type
			if a_last_type.is_formal then
				if Result.is_formal then
					l_formal_type ?= Result
				else
					l_formal_type ?= Result.actual_type
				end
				if l_formal_type /= Void then
					Result := a_last_constrained.generics.i_th (l_formal_type.position)
				end
			elseif a_last_type.is_like then
				if Result.is_formal then
					l_formal_type ?= Result
				else
					l_formal_type ?= Result.actual_type
				end
				if l_formal_type /= Void then
					Result := a_last_type.actual_type.generics.i_th (l_formal_type.position)
				end
			end
			if l_formal_type /= Void then
					-- Preserve attachment status of the original type.
				Result := Result.to_other_attachment (a_type).to_other_variant (a_type).to_other_separateness (a_type)
			end
		ensure
			adapated_type_not_void: Result /= Void
		end

	maximal_type (ts: ARRAYED_LIST [TYPE_A]): TYPE_A
			-- A type that is maximal in the list `ts`, if present, or a properly adapted version of "ANY".
		local
			c: CLASS_C
			l: LOCAL_TYPE_A
		do
			c := context.current_class
				-- Use `l` to collect type information about all types.
			create l.make (0, System.detachable_separate_any_type, c)
				-- Iterate over all types.
			across
				ts as t
			loop
					-- Mimic attachment of `t.item` to a local of type `l`.
				l.backward_conform_to (c, t.item).do_nothing
			end
				-- Obtain a type to which all elements conform.
			Result := l.minimum
				-- There is no restriction on the type to which the found type should conform.
				-- Therefore, the type always exists.
			check attached Result end
		end

feature {NONE} -- Implementation: checking locals

	check_locals (l_as: ROUTINE_AS)
			-- Check validity of local declarations: a local variable
			-- name cannot be a final name of the current feature table or
			-- an argument name of the current analyzed feature.
			-- Also an external or a deferred routine cannot have
			-- locals.
			-- Local variables without type declarations are not reported as an error,
			-- but are recorded in `untyped_local' instead. If there are no untyped
			-- local variables, `untyped_local' is detached.
		require
			l_as_not_void: l_as /= Void
			locals_not_void: l_as.locals /= Void
		local
			l_id_list: IDENTIFIER_LIST
			l_local_name_id: INTEGER
			l_local_name: STRING
			i: INTEGER
			l_local_info: LOCAL_INFO
			local_type: TYPE_A
			l_context_locals: HASH_TABLE [LOCAL_INFO, INTEGER]
			l_vrle1: VRLE1
			l_vrle2: VRLE2
			l_vreg: VREG
			l_vpir: VPIR1
			l_curr_feat: FEATURE_I
			l_vrrr2: VRRR2
			l_missing_type: detachable MISSING_LOCAL_TYPE_ERROR
			l_untyped_local: like untyped_local
		do
			untyped_local := Void
			if l_as.is_deferred or l_as.is_external then
				create l_vrrr2
				context.init_error (l_vrrr2)
				l_vrrr2.set_is_deferred (l_as.is_deferred)
				l_vrrr2.set_location (l_as.locals.start_location)
				error_handler.insert_error (l_vrrr2)
			elseif not l_as.locals.is_empty then
				from
					l_curr_feat := current_feature
					l_context_locals := context.locals
					l_as.locals.start
				until
					l_as.locals.after
				loop
					if attached l_as.locals.item.type as l_local_type then
							-- A type is present.
						l_missing_type := Void
						check_type (l_local_type)
					else
							-- No type is specified.
							-- Try to infer it without reporting an error immediately.
						create l_missing_type.make (l_as.locals.item.id_list, context, l_as.locals.item.first_token (match_list_of_class (context.written_class.class_id)))
						last_type := void_type
					end
					if attached last_type as l_solved_type then
						from
							if not is_inherited then
								instantiator.dispatch (l_solved_type, context.current_class)
							end
							l_id_list := l_as.locals.item.id_list
							l_id_list.start
						until
							l_id_list.after
						loop
							l_local_name_id := l_id_list.item
							l_local_name := Names_heap.item (l_local_name_id)
							if not is_inherited then
								if not is_replicated and then feature_table.has_id (l_local_name_id) then
										-- The local name is a feature name of the
										-- current analyzed class.
									create l_vrle1
									context.init_error (l_vrle1)
									l_vrle1.set_local_name (l_local_name_id)
									l_vrle1.set_location (l_as.locals.item.start_location)
									error_handler.insert_error (l_vrle1)
								elseif context.is_name_used (l_local_name_id) then
										-- The local name is the same as one used for an entity in the current scope.
									create l_vpir
									context.init_error (l_vpir)
									l_vpir.set_entity_name (l_local_name_id)
									l_vpir.set_location (match_list_of_class(context.written_class.class_id) [l_id_list.id_list [l_id_list.index]])
									error_handler.insert_error (l_vpir)
								elseif l_curr_feat.has_argument_name (l_local_name_id) then
										-- The local name is an argument name of the
										-- current analyzed feature
									create l_vrle2
									context.init_error (l_vrle2)
									l_vrle2.set_local_name (l_local_name_id)
									l_vrle2.set_location (l_as.locals.item.start_location)
									error_handler.insert_error (l_vrle2)
								end
							end

								-- Build the local table in the context
							i := i + 1
								-- Check an expanded local type
							if attached l_missing_type then
								local_type := create {LOCAL_TYPE_A}.make (i, system.detachable_separate_any_type, context.current_class)
									-- Record an error for this local.
								l_untyped_local := untyped_local
								if not attached l_untyped_local then
									create l_untyped_local.make (1)
									untyped_local := l_untyped_local
								end
								l_untyped_local.force (l_missing_type, i)
							else
								local_type := l_solved_type
							end
							create l_local_info.make (local_type, i)
							if l_context_locals.has (l_local_name_id) then
									-- Error: two locals with the same name
								create l_vreg
								l_vreg.set_entity_name (l_local_name)
								context.init_error (l_vreg)
								l_vreg.set_location (l_as.locals.item.start_location)
								error_handler.insert_error (l_vreg)
							else
								l_context_locals.put (l_local_info, l_local_name_id)
							end

								-- Update instantiator for changed class
							l_id_list.forth
						end

						if l_solved_type.has_associated_class then
								-- Add the supplier in the feature_dependance list
							context.supplier_ids.add_supplier (l_solved_type.base_class)
						end

						if not is_inherited then
								-- No need to recheck for obsolete classes when checking inherited code.
							l_solved_type.check_for_obsolete_class (context.current_class, context.current_feature)
							if
								(l_solved_type.is_basic implies not {SYSTEM_I}.is_basic_class_alive) and then
								l_solved_type.is_expanded_creation_possible
							then
								record_expanded_dependence (l_solved_type)
							end
						end
					end
					l_as.locals.forth
				end
			end
		end

	resolve_locals (is_untyped_local_allowed: BOOLEAN; missing_types: like untyped_local)
			-- Compute types of untyped locals.
			-- Update `has_untyped_local' accordingly.
			-- Allow some locals to remain untyped if `is_untyped_local_allowed'.
			-- Report `missing_types' errors otherwise, with a fix action if possible.
		require
			has_untyped_local
		local
			l: LOCAL_INFO
			r: detachable TYPE_A
			t: HASH_TABLE [TYPE_A, LOCAL_TYPE_A]
			u: MISSING_LOCAL_TYPE_ERROR
		do
				-- Pretend that all types of locals are resolved now.
			has_untyped_local := False
			create t.make (0)
			across
				context.locals as c
			loop
				l := c.item
				if attached {LOCAL_TYPE_A} l.type as x then
						-- Update local type information.
						-- Check if the type was computed earlier.
					r := t [x]
					if not attached r then
							-- The type was not computed.
							-- Compute the type now.
						local_type_a_resolver.resolve (x)
						r := local_type_a_resolver.last_type
					end
					if is_untyped_local_allowed then
							-- The type may be changed on a next iteration of type inference.
						if not attached r then
								-- Record that fixed-point is not reached yet.
							has_untyped_local := True
						end
							-- Prepare type collector for the next iteration.
						x.reset
						r := x
					else
						if attached missing_types and then attached missing_types [x.position] as e then
								-- Report the error.
							error_handler.insert_error (e)
								-- Remove the error from the list.
							from
								missing_types.start
							until
								not missing_types.has_item (e)
							loop
								missing_types.prune (e)
							variant
								missing_types.count + 1
							end
								-- Keep the error for reporting a fix option.
							u := e
						end
						if not attached r or else not r.is_known then
								-- Record that fixed-point cannot be reached or does not exist.
								-- The type cannot be computed.
								-- Force the type to be "NONE" for mandatory type inference:
								--    r := none_type
								-- Behave as if the type is still unresolved for suggestive type inference.
							x.reset
							r := x
						elseif attached u and then not r.is_none then
								-- Suggest computed type as a fix.
							u.set_suggested_type (r)
						end
					end
						-- Update local type information.
					l.set_type (r)
						-- Keep computed type to avoid recomputing it again.
					t.force (r, x)
				end
			end
				-- Remove all information about object test locals.
				-- It will be recomputed again.
			context.clear_object_test_locals
		end

	check_unused_locals (a_locals: HASH_TABLE [LOCAL_INFO, INTEGER])
			-- Check that all locals are used in Current. If not raise
			-- a warning.
		require
			a_locals_not_void: a_locals /= Void
		local
			l_local: LOCAL_INFO
			l_warning: UNUSED_LOCAL_WARNING
		do
			from
				a_locals.start
			until
				a_locals.after
			loop
				l_local := a_locals.item_for_iteration
				if not l_local.is_used then
					if l_warning = Void then
						create l_warning.make (context.current_class, current_feature.enclosing_feature)
					end
					l_warning.add_unused_local (a_locals.key_for_iteration, l_local.type)
				end
				a_locals.forth
			end
			if l_warning /= Void then
				error_handler.insert_warning (l_warning, context.current_class.is_warning_reported_as_error (w_unused_local))
			end
		end

	untyped_local: detachable HASH_TABLE [MISSING_LOCAL_TYPE_ERROR, INTEGER]
			-- Errors about missing type declaration indexed by local indexes.
			-- Because several locals may be listed in one declaration,
			-- the same error can appear in the table more than once.

	empty_locals: like {AST_CONTEXT}.locals
			-- Empty locals that are used when processing inherited assertions.
		once
			create Result.make (10)
		end

	local_type_a_resolver: LOCAL_TYPE_A_RESOLVER
			-- Resolver for types of locals without type declarations.
		once
			create Result.make
		end

feature {NONE} -- Variable initialization

	last_reinitialized_variable: INTEGER_32
			-- Name ID of the last reinitialized local (the one that is assigned a new value)
			-- or negated name ID of the last reinitialized stable attribute.

	result_name_id: INTEGER_32 = 0x7fffffff
			-- Value of `last_reinitialized_variable' that indicates
			-- that the local is a special entity "Result"

feature {NONE} -- Implementation: Error handling

	new_vtmc_error (a_problematic_feature: ID_AS; a_formal_position: INTEGER; a_context_class: CLASS_C; is_alias: BOOLEAN): VTMC
			-- Computes everything needed to report a proper VTMC error, inserts and raises an error.
			--
			-- `a_type_set' for which we produce the error.
			-- `a_problematic_feature' is the feature which is not unique in the type set.
			-- If you don't have formals inside your type set you don't need to provide a context class.
		require
			is_really_a_problematic_feature: not is_alias implies
				a_context_class.constraints (a_formal_position).constraining_types (a_context_class).feature_i_state_by_name_id (a_problematic_feature.name_id).features_found_count /= 1
			is_really_a_problematic_alias_feature: is_alias implies
				a_context_class.constraints (a_formal_position).constraining_types (a_context_class).feature_i_state_by_alias_name_id (a_problematic_feature.name_id).features_found_count /= 1

		local
			l_error_report: MC_FEATURE_INFO
			l_vtmc1: VTMC1
			l_vtmc2: VTMC2
			l_constraints: TYPE_SET_A
		do
			l_constraints := a_context_class.constraints (a_formal_position)
			if is_alias then
				l_error_report := l_constraints.info_about_feature_by_alias_name_id (a_problematic_feature.name_id, a_formal_position, a_context_class)
			else
				l_error_report := l_constraints.info_about_feature_by_name_id (a_problematic_feature.name_id, a_formal_position, a_context_class)
			end

			if l_error_report.count < 1 then
				create l_vtmc1
				context.init_error (l_vtmc1)
				l_vtmc1.set_location (a_problematic_feature)
				l_vtmc1.set_feature_call_name (a_problematic_feature.name)
				l_vtmc1.set_type_set (l_constraints.constraining_types (a_context_class))
				Result := l_vtmc1
			else
				check l_error_report.count > 1 end

				create l_vtmc2
				context.init_error (l_vtmc2)
				l_vtmc2.set_location (a_problematic_feature)
				l_vtmc2.set_error_report (l_error_report)
				Result := l_vtmc2
			end
		end

feature {NONE} -- Implementation: catcall check

	is_query_stable (a_callee_type: TYPE_A; a_feature: FEATURE_I; a_query_type: CL_TYPE_A): BOOLEAN
			-- Check if a query `a_feature' has the same base type in all descendants.
			--
			-- `a_callee_type': Type on which the call happens
			-- `a_feature': Feature which is called on callee
		require
			a_callee_type_not_void: a_callee_type /= Void
			a_feature_not_void: a_feature /= Void
		local
			l_descendant_class: CLASS_C
			l_descendant_feature: FEATURE_I
		do
					-- Limitation of the compiler: if there are no descendants, we cannot ensure it is stable.
			if attached conforming_descendants (a_feature, a_callee_type) as l_descendants then
					-- Loop through all descendants
				from
					Result := True
					l_descendants.start
				until
					not Result or else l_descendants.after
				loop
						-- Get descendant class and the feature in the context of the descendant\
					l_descendant_class := l_descendants.item.base_class
					l_descendant_feature := l_descendant_class.feature_of_rout_id (a_feature.rout_id_set.first)

					Result := attached {CL_TYPE_A} l_descendant_feature.type.actual_type as l_class_type and then
						l_class_type.class_id = a_query_type.class_id

					l_descendants.forth
				end
			end
		end

	check_cat_call (a_callee_type: TYPE_A; a_feature: FEATURE_I; a_params: ARRAYED_LIST [TYPE_A]; a_location: LOCATION_AS; a_parameters: EIFFEL_LIST [EXPR_AS])
			-- Check if a call can potentially be a cat call.
			--
			-- `a_callee_type': Type on which the call happens
			-- `a_feature': Feature which is called on callee
			-- `a_params': Parameters of call, already evaluated to their types
			-- `a_location': Location where warning will be linked to
		require
			a_callee_type_not_void: a_callee_type /= Void
			a_feature_not_void: a_feature /= Void
			a_params_not_void: a_feature.argument_count > 0 implies a_params /= Void
			same_number_of_params: a_feature.argument_count > 0 implies a_feature.argument_count = a_params.count
		local
			l_descendants: ARRAYED_LIST [TYPE_A]
			l_descendant_type: TYPE_A
			l_descendant_class: CLASS_C
			l_descendant_feature: FEATURE_I
			l_tcat, l_acat: CAT_CALL_WARNING
			i: INTEGER
			l_formal_arg_type: TYPE_A
			l_arg_type: TYPE_A
			l_desc_class_id: INTEGER
			l_like_arg_type: TYPE_A
		do
			l_descendants := conforming_descendants (a_feature, a_callee_type)

			if l_descendants = Void then
					-- Limitation of the compiler, we declare the call to be potentially a catcall.
				create l_tcat.make (a_location)
				context.init_error (l_tcat)
				l_tcat.set_called_feature (a_feature)
				l_tcat.add_compiler_limitation (a_callee_type)
				error_handler.insert_error (L_tcat)
			elseif not l_descendants.is_empty then
					-- Loop through all descendants
				from
					l_descendants.start
				until
					l_descendants.after
				loop
						-- Get descendant class and the feature in the context of the descendant\
					l_descendant_type := l_descendants.item
					l_descendant_class := l_descendant_type.base_class
					l_desc_class_id := l_descendant_class.class_id
					l_descendant_feature := l_descendant_class.feature_of_rout_id (a_feature.rout_id_set.first)

						-- Check argument validity
					from
						i := 1
					until
						i > a_feature.argument_count
					loop
						l_arg_type := a_params.i_th (i)
						l_formal_arg_type := l_descendant_feature.arguments.i_th (i)
							-- Take care of anchoring to argument
						if l_formal_arg_type.is_like_argument then
							l_like_arg_type := l_formal_arg_type.instantiation_in (l_descendant_type, l_desc_class_id)
							l_like_arg_type := l_like_arg_type.actual_argument_type (a_params)
							l_like_arg_type := l_like_arg_type.actual_type
								-- Check that `l_arg_type' is compatible to its `like argument'.
								-- Once this is done, then type checking is done on the real
								-- type of the routine, not the anchor.
							if not l_arg_type.conform_to (context.current_class, l_like_arg_type) then
								error_handler.insert_error
									(create {VUAR2}.make (context, l_descendant_feature, Void, l_descendant_class,
										i, l_like_arg_type, l_arg_type, a_parameters [i].start_location))
							end
						end

							-- Adapted type in case it is a formal generic parameter or a like.
						l_formal_arg_type := adapted_type (l_formal_arg_type, l_descendant_type, l_descendant_type)
							-- Actual type of feature argument
						l_formal_arg_type := l_formal_arg_type.instantiation_in (l_descendant_type, l_desc_class_id).actual_type

							-- Check if actual parameter conforms to the possible type of the descendant feature if conformance
							-- was involved in the original call, otherwise nothing to be done.
						if not l_arg_type.conform_to (context.current_class, l_formal_arg_type) then
								-- Conformance is violated. Add notice to warning.
							if l_tcat = Void then
								create l_tcat.make (a_location)
								context.init_error (l_tcat)
								l_tcat.set_called_feature (a_feature)
								error_handler.insert_error (l_tcat)
							end
							l_tcat.add_covariant_argument_violation (l_descendant_type, l_descendant_feature, a_params.i_th (i), i)
						elseif l_formal_arg_type.is_variant then
								-- Check if the formal parameter is a formal, then the actual generic parameter has to be frozen.
							if l_tcat = Void then
								create l_tcat.make (a_location)
								context.init_error (l_tcat)
								l_tcat.set_called_feature (a_feature)
								error_handler.insert_error (l_tcat)
							end
							l_tcat.add_covariant_generic_violation
						end

						i := i + 1
					end

						-- Check export status validity for descendant feature
					if
						not context.is_ignoring_export and
						not l_descendant_feature.is_exported_for (context.current_class)
					then
							-- Export status violated. Add notice to warning.
						if l_acat = Void then
							create l_acat.make (a_location)
							context.init_error (l_acat)
							l_acat.set_called_feature (a_feature)
							error_handler.insert_warning (l_acat, context.current_class.lace_class.options.is_warning_as_error)
						end
						l_acat.add_export_status_violation (l_descendant_class, l_descendant_feature)
					end
					l_descendants.forth
				end
			end
			if l_tcat /= Void then
				system.update_statistics (l_tcat)
			end
			if l_acat /= Void then
				system.update_statistics (l_acat)
			end
		end

	conforming_descendants (a_feature: FEATURE_I; a_type: TYPE_A): ARRAYED_LIST [TYPE_A]
			-- List of all descendants of the type `a_type' that are covariantly redefining
			-- `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
		local
			l_parent_type, l_descendant_type, l_constraint_type: TYPE_A
			l_formal: FORMAL_A
			l_parent_class: CLASS_C
			l_descendant_class: CLASS_C
			l_generics: ARRAYED_LIST [TYPE_A]
			l_target_types: ARRAYED_LIST [TYPE_A]
			i, nb: INTEGER
			l_rout_id_set: ROUT_ID_SET
			l_needs_formal_check, l_compiler_limitation, l_fail_if_constraint_not_met: BOOLEAN
			l_classes: ARRAYED_LIST [CLASS_C]
		do
			if a_type.is_frozen or a_type.is_like_current then
					-- When it is monomorphic then nothing to be done.
					-- When type is `like Current' then it was shown that doing a flat checking would catch
					-- the potential catcalls so no need to check it.
				create Result.make (0)
			else
					-- Proper instance of the lower bound of the intervals with the anchors removed.
				l_parent_type := a_type.instantiated_in (context.current_class_type.conformance_type)
					-- First take all classes for `l_parent_type'
				create l_target_types.make (1)
				if l_parent_type.is_formal then
					l_formal ?= l_parent_type
					if l_formal.is_multi_constrained (context.current_class) then
							-- Type is a multi constrained formal. Get all associated classes of
							-- constraints.
						l_target_types.append (l_formal.to_type_set.constraining_types (context.current_class).renamed_types)
					else
							-- Type is formal. Take associated class of constraint
						l_target_types.extend (l_formal.constrained_type (context.current_class))
					end
				else
						-- Normal type. Take associated class
					l_target_types.extend (l_parent_type)
				end

				from
					l_target_types.start
				until
					l_target_types.after or l_compiler_limitation
				loop
						-- Check that `a_feature' is indeed part of one of the constraint in case `l_parent_type' is a multiconstraint.
					l_parent_type := l_target_types.item
					l_parent_class := l_parent_type.base_class
					if l_parent_class /= Void and then l_parent_class.feature_of_rout_id_set (a_feature.rout_id_set) /= Void then
						l_classes := l_parent_class.leaf_descendants
						if l_classes /= Void and then not l_classes.is_empty then
								-- Go through leaf descendants and build the proper type.
							from
								l_classes.start
								if Result = Void then
									create Result.make (l_classes.count)
								end
							until
								l_classes.after or l_compiler_limitation
							loop
									-- If descendant is generic, instantiate it with same
									-- generics as `l_parent_type.generics'
								l_descendant_class := l_classes.item
								l_classes.forth
								l_descendant_type := l_descendant_class.actual_type
								if l_descendant_type.generics /= Void then
									from
										l_descendant_type := l_descendant_type.duplicate
										l_generics := l_descendant_type.generics
										i := l_generics.lower
										nb := l_generics.upper
										l_needs_formal_check := False
										l_fail_if_constraint_not_met := False
									until
										i > nb or l_compiler_limitation
									loop
										l_rout_id_set := l_descendant_class.formal_rout_id_set_at_position (i)
										if attached {TYPE_FEATURE_I} l_parent_class.feature_of_rout_id_set (l_rout_id_set) as l_type_feat then
											l_constraint_type := l_parent_type.generics.i_th (l_type_feat.position)
											if l_constraint_type.is_variant then
												l_fail_if_constraint_not_met := True
											end
											l_generics.put_i_th (l_constraint_type, i)
										else
												-- We cannot find a definition for the new formal, we simply use its
												-- constraint, at least if it is not a multiconstraint.
											if attached {FORMAL_CONSTRAINT_AS} l_descendant_class.generics.i_th (i) as l_formal_dec and then not l_formal_dec.has_multi_constraints then
												l_constraint_type := l_formal_dec.constraint_type (l_descendant_class).type
												if attached {CL_TYPE_A} l_constraint_type as l_cl_type then
													-- l_cl_type.set_variant_mark
													l_needs_formal_check := l_needs_formal_check or l_cl_type.has_formal_generic
												else
													l_needs_formal_check := True
												end
												l_generics.put_i_th (l_constraint_type, i)
											else
												l_compiler_limitation := True
											end
										end
										i := i + 1
									end
									if not l_compiler_limitation then
										if l_needs_formal_check then
												-- This line will properly instantiate the type with its formals.
												-- For example, if you have A [G -> FOO, H-> ARRAY [G]], then with the above
												-- where a type A [FOO, ARRAY [G]] will appear, we need to replace the G with
												-- the constraint type. We need to repeat this operation at least `nb ^ 2' times
												-- in case you have the following A [H -> A [K], K -> B [L], L -> C [G], G]
											from
												i := 1
											until
												i > nb or not l_descendant_type.has_formal_generic
											loop
												l_descendant_type := l_descendant_type.instantiated_in (l_descendant_type)
												i := i + 1
											end

												-- If we still have some formal generics, it means that one constraint is
												-- constraint to another formal generic parameter that is also constraint
												-- to a formal generic and there is a cycle. Simply replace all the formals with
												-- ANY.
											if l_descendant_type.has_formal_generic then
												from
													i := 1
												until
													i > nb
												loop
													if l_descendant_type.generics.i_th (i).is_formal then
														l_descendant_type.generics.put_i_th (create {CL_TYPE_A}.make (system.any_id), i)
													end
													i := i + 1
												end
											end
										end
											-- Check that the instantiated type `l_descendant_type' makes sense before
											-- checking its conformance against the parent type. This is
											-- useful when the constrait is more precise in a descendant:
											-- `A [G]' and descendant is `B [G -> STRING]', and if parent
											-- type is `A [INTEGER]' then `B [INTEGER]' would not make sense.
										l_descendant_type.reset_constraint_error_list
										l_descendant_type.check_constraints (context.current_class, context.current_feature, l_descendant_type.is_expanded)
										if
											not l_descendant_type.constraint_error_list.is_empty and then
											(l_fail_if_constraint_not_met or l_descendant_type.is_expanded)
										then
												-- We could not validate but since it is an expanded, we are in the case of
												-- a compiler limitation. If we have substitued a parent formal generic from
												-- the parent to the descendant, but the subsituted formal generic parameter
												-- does not meet the constraint and the actual generic parameter is marked variant
												-- we cannot invent a type that would work, so this is a compiler limitation.
											l_compiler_limitation := True
										end
										if
											not l_compiler_limitation and then l_descendant_type.constraint_error_list.is_empty and then
											l_descendant_type.conform_to (context.current_class, l_parent_type)
										then
												-- Only add descendants, if it makes sense.
												-- For example, if you have `l_parent_type' be `ARRAYED_LIST [INTEGER]'
												-- then it does not make sense to have `l_descendant_type' be
												-- `ACTION_SEQUENCE [G]' since the later inherits from
												-- `ARRAYED_LIST [PROCEDURE [ANY, EVENT_DATA]]'
												-- which does not conform to `ARRAYED_LIST [INTEGER]'.
											Result.extend (l_descendant_type)
										end
									end
								elseif l_descendant_type.conform_to (context.current_class, l_parent_type) then
										-- Even if `l_descendant_type' is not generic, it does not mean it conforms to `l_parent_type'.
										-- For example `l_parent_type' is `ARRAY [STRING]' and a descendant of `ARRAY' is
										-- `MY_ARRAY' which inherits from `ARRAY [INTEGER]'.
									Result.extend (l_descendant_type)
								end
							end
						end
					end
					l_target_types.forth
				end
			end
			if l_compiler_limitation then
				Result := Void
			elseif Result = Void then
				create Result.make (0)
			end
		end

feature {NONE} -- Instance-free checks

	report_vucr (e: VUCR)
			-- Report a VUCR error `e`.
		require
			current_feature_is_class: current_feature.is_class
		do
			e.set_written_class (context.written_class)
			error_handler.insert_error (e)
		end

	check_instance_free (f: FEATURE_I; c: CLASS_C; e: PROCEDURE; l: LOCATION_AS)
			-- Check that feature `f` of class `c` is correctly called as instance-free at location `l` and report an error by calling `e` if not.
		do
			if not system.absent_explicit_assertion or else c.is_precompiled then
					-- Assertions are specified explicitly. Raise an error.
				e.call
			elseif not c.is_full_class_checking then
					-- Full class checking of the target class is required.
				error_handler.insert_error (create {VD02}.make (f, c, context.written_class, l))
			end
		end

feature {INSPECT_CONTROL} -- AST modification

	is_inherited: BOOLEAN
			-- Is code being processed inherited?

	last_type: TYPE_A
			-- Type of last computed expression. If Void it means an error occurred.

	set_is_inherited (a_inherited: BOOLEAN)
		do
			is_inherited := a_inherited
		end

	set_routine_ids (ids: ID_SET; a: ID_SET_ACCESSOR)
			-- Set routine IDs `ids' for the given AST node `a'
			-- and register the modification to save modified AST.
		require
			ids_attached: attached ids
			a_attached: attached a
		do
			if not ids.is_equal_id_list (a) then
				a.set_routine_ids (ids)
					-- Record that AST node is modified.
				tmp_ast_server.touch (context.current_class.class_id)
				is_ast_modified := True
			end
		ensure
			routine_ids_set: ids.is_equal_id_list (a)
		end

	set_argument_position (p: like {ACCESS_INV_AS}.argument_position; a: ACCESS_INV_AS)
			-- Set position of an argument `a` to `p`.
		do
			if not a.is_argument or a.argument_position /= p then
				a.enable_argument
				a.set_argument_position (p)
					-- Record that AST node is modified.
				tmp_ast_server.touch (context.current_class.class_id)
				is_ast_modified := True
			end
		end

	set_local (a: ACCESS_INV_AS)
			-- Mark `a` as a local variable.
		do
			if not a.is_local then
				a.enable_local
					-- Record that AST node is modified.
				tmp_ast_server.touch (context.current_class.class_id)
				is_ast_modified := True
			end
		end

	set_inline_local (a: ACCESS_INV_AS)
			-- Mark `a` as an inline local variable.
		do
			if not a.is_object_test_local then
				a.enable_object_test_local
					-- Record that AST node is modified.
				tmp_ast_server.touch (context.current_class.class_id)
				is_ast_modified := True
			end
		end

feature {NONE} -- Separateness

	is_controlled: BOOLEAN
			-- Is last expression of a separate type controlled?

	validate_separate_target (f: detachable STRING_32; a: AST_EIFFEL)
			-- Check validity rules for the target `a` of a separate type on which `f` is called.
		require
			a_attached: attached a
			is_last_type_separate: attached last_type as t and then t.is_separate
		do
			if system.is_scoop and then not is_controlled and then not is_inherited then
				error_handler.insert_error (create {VUTA3}.make
					(context, last_type, f, a.start_location))
			end
		end

	adapt_type_to_target (non_adapted_type: detachable TYPE_A; target_type: TYPE_A; a_feature: FEATURE_I; c: BOOLEAN; n: AST_EIFFEL; e: like error_level; error_location: detachable LOCATION_AS)
			-- Adapt separateness status of the last message type `non_adapted_type' of the AST node `n'
			-- to the target of type `target_type' which has a controlled status `c' and update `is_controlled' accordingly.
			-- If `error_location' is attached and the target type is separate, check that the type `l' has no non-separate reference attributes
			-- and report an error using if `e' is the same as `error_level'.
		require
			target_type_attached: attached target_type
		local
			result_type: TYPE_A
		do
			if attached non_adapted_type then
				if target_type.is_separate and then not non_adapted_type.is_separate then
						-- Separate call is controlled if target is controlled
						-- and message type is not separate.
					is_controlled := c
					result_type := non_adapted_type.to_other_separateness (target_type)
				else
					is_controlled := False
					result_type := non_adapted_type
				end
				set_type (result_type, n)

					-- If the target of the call is `frozen' then we can keep `non_adapted_type' as is. Meaning that
					-- if it was frozen, it will stay frozen. For other cases, we check if we can still
					-- keep the frozen mark.
				if a_feature /= Void and not target_type.is_frozen and result_type.is_frozen then
					if a_feature.is_frozen and then attached {CL_TYPE_A} a_feature.type then
						-- Optimization: The feature is `frozen' (i.e. it cannot be redefined) and
						-- its base type is a Class_type which is not a formal, then it
						-- cannot change.
						-- We can keep the `frozen' mark.
					elseif
						attached {CL_TYPE_A} a_feature.type.actual_type as l_feature_type and then
						is_query_stable (target_type.actual_type, a_feature, l_feature_type)
					then
						-- The type of `a_feature' resolves into a Class_type and all descendants are using
						-- the exact same one.
						-- We can keep the `frozen' mark.
					else
							-- Remove frozen status of type.
						set_type (result_type.as_variant_free, n)
					end
				end

					-- Verify that if result type of a separate feature call is expanded it has no non-separate reference attributes.
				if
					error_level = e and then
					target_type.is_separate and then
					result_type.is_expanded and then
					not result_type.is_processor_attachable_to (target_type)
				then
					error_handler.insert_error (create {VUER}.make (context, result_type, error_location))
				end
			else
					-- Set `last_type' to Void to indicate an error.
				is_controlled := False
				set_type (Void, n)
			end
		end

feature {NONE} -- Conversion

	converted_expression (e: EXPR_AS; i: CONVERSION_INFO): EXPR_AS
			-- An expression converted from `e` using conversion information `i`.
		local
			p: PARENT_CONVERSION_INFO
		do
			create p.make (i)
			if
				not is_inherited and then
				not p.is_null_conversion
			then
				if p.is_from_conversion then
					record_creation_dependence (p.creation_type)
				end
				if
					attached system.class_of_id (p.class_id) as c and then
					attached c.feature_of_rout_id (p.routine_id) as f
				then
					check_obsolescence (f, c, e.start_location)
				end
			end
			Result := e.converted_expression (p)
		end

feature -- Type recording

	type_recorder: detachable PROCEDURE [TUPLE [t: TYPE_A; a: AST_EIFFEL; w: CLASS_C; f: FEATURE_I; c: CLASS_C]]
			-- A procedure to record type `t' of AST node `a' written in class `w'
			-- when evaluated in a feature `f' of class `c'.

	set_type_recorder (r: like type_recorder)
			-- Set `type_recorder' to `r'.
		do
			type_recorder := r
		ensure
			type_recorder_set: type_recorder = r
		end

feature {NONE} -- Type recording

	set_type (t: TYPE_A; a: AST_EIFFEL)
			-- Associate type `t' with AST node `a'.
		do
			if attached type_recorder as r then
					-- Use index of last token to associate type information with the node.
				r.call ([t, a, context.written_class, current_feature, context.current_class])
			end
			last_type := t
		end

	record_creation_dependence (t: TYPE_A)
			-- Record that current feature depends on type `t` used to create an object.
		require
			not is_inherited
		do
			dependence_generator.generate (t, {INSTANCE_DEPENDENCE_GENERATOR}.regular_creation_kind, context.current_class)
			if attached dependence_generator.dependence as d then
				context.supplier_ids.add_instance_supplier (d)
			end
		end

	record_expanded_dependence (t: TYPE_A)
			-- Record that current feature depends on type `t` used to create an object if it is expanded.
		require
			not is_inherited
			t.is_expanded_creation_possible
		do
			dependence_generator.generate (t, {INSTANCE_DEPENDENCE_GENERATOR}.expanded_creation_kind, context.current_class)
			if attached dependence_generator.dependence as d then
				context.supplier_ids.add_instance_supplier (d)
			end
		end

	record_non_object_call_dependence (t: TYPE_A)
			-- Record that current feature depends on type `t` used as a target of a non-object call.
		require
			not is_inherited
		do
			dependence_generator.generate (t, {INSTANCE_DEPENDENCE_GENERATOR}.call_kind, context.current_class)
			if attached dependence_generator.dependence as d then
				context.supplier_ids.add_instance_supplier (d)
			end
		end

	dependence_generator: INSTANCE_DEPENDENCE_GENERATOR
			-- A generator to compute instance dependencies for given creation or non-object call types.
		once
			create Result
		end

feature {INSPECT_CONTROL} -- Checks for obsolete features

	check_obsolescence (f: FEATURE_I; c: CLASS_C; l: LOCATION_AS)
			-- Check that feature `f` from type `t` is obsolete and report a warning if so.
		do
			if
					-- Report a warning if the feature is obsolete.
				f.is_obsolete
					-- Unless current class is obsolete.
				and then not context.current_class.is_obsolete
					-- Or unless current feature is obsolete.
				and then (attached current_feature as cf implies not cf.is_obsolete)
					-- Provided that the code is not inherited (obsolescence is reported for immediate code).
				and then not is_inherited
					-- And this is not a target of an assignment.
				and then not is_in_assignment
					-- Or of a creation instruction.
				and then not is_target_of_creation_instruction
			then
				report (f, c, current_feature, context.current_class, l, context.current_class.obsolete_call_warning_index)
			end
		end

feature {NONE} -- Byte node factory

	multi_branch_expression_factory: MULTI_BRANCH_EXPRESSION_FACTORY
			-- A factory to generate multi-branch expression byte nodes.
		once
			create Result
		end

	multi_branch_instruction_factory: MULTI_BRANCH_INSTRUCTION_FACTORY
			-- A factory to generate multi-branch instruction byte nodes.
		once
			create Result
		end

note
	ca_ignore:
		"CA011", "CA011 — too many arguments",
		"CA032", "CA032 — too long routine",
		"CA033", "CA033 — too long class"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
