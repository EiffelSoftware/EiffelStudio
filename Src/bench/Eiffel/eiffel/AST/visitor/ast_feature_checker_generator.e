indexing
	description: "Perform type checking as well as generation of BYTE_NODE tree."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_FEATURE_CHECKER_GENERATOR

inherit
	AST_VISITOR

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

	SHARED_EVALUATOR
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

feature -- Initialization

	init (a_context: AST_CONTEXT) is
		do
			if type_checker = Void then
				create type_checker
			end
			if byte_anchor = Void then
				create byte_anchor
			end
			context := a_context
		end

feature -- Type checking

	type_check_only (a_feature: FEATURE_I) is
			-- Type check `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		do
			type_checker.init (a_feature, context.current_class)
			is_byte_node_enabled := False
			a_feature.record_suppliers (context.supplier_ids)
			current_feature := a_feature
			reset
			a_feature.body.process (Current)
		end

	type_check_and_code (a_feature: FEATURE_I) is
			-- Type check `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		do
			type_checker.init (a_feature, context.current_class)
			is_byte_node_enabled := True
			a_feature.record_suppliers (context.supplier_ids)
			current_feature := a_feature
			reset
			a_feature.body.process (Current)
		end

	expression_type_check_and_code (a_feature: FEATURE_I; an_exp: EXPR_AS) is
			-- Type check `an_exp' in the context of `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
			an_exp_not_void: an_exp /= Void
		do
			type_checker.init (a_feature, context.current_class)
			is_byte_node_enabled := True
			current_feature := a_feature
			reset
			an_exp.process (Current)
		end

	invariant_type_check_and_code (a_feature: FEATURE_I; a_clause: INVARIANT_AS) is
			-- Type check `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
			a_clause_not_void: a_clause /= Void
		local
			l_list: BYTE_LIST [BYTE_NODE]
			l_invariant: INVARIANT_B
		do
			type_checker.init (a_feature, context.current_class)
			is_byte_node_enabled := True
			current_feature := a_feature
			reset
			a_clause.process (Current)
			l_list ?= last_byte_node
			create l_invariant
			l_invariant.set_class_id (context.current_class.class_id)
			l_invariant.set_byte_list (l_list)
			l_invariant.set_once_manifest_string_count (a_clause.once_manifest_string_count)
			last_byte_node := l_invariant
		end

	custom_attributes_type_check_and_code (a_feature: FEATURE_I; a_cas: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]) is
			-- Type check `a_cas' for `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
			a_cas_not_void: a_cas /= Void
		do
			type_checker.init (a_feature, context.current_class)
			is_byte_node_enabled := True
			current_feature := a_feature
			reset
			a_cas.process (Current)
		end

	check_local_names (a_procedure: PROCEDURE_I; a_node: FEATURE_AS) is
			-- Check validity of the names of the locals of `a_procedure'.
			-- Useful when a feature has been added, we need to make sure that
			-- locals of existing features have a different name.
		require
			a_procedure_not_void: a_procedure /= Void
			a_node_not_void: a_node /= Void
		local
			l_routine: ROUTINE_AS
			l_id_list: ARRAYED_LIST [INTEGER]
			l_feat_tbl: FEATURE_TABLE
			l_vrle1: VRLE1
			l_local_name_id: INTEGER
		do
			l_routine ?= a_node.body.content
			if l_routine /= Void then
				if l_routine.locals /= Void and not l_routine.locals.is_empty then
					from
						l_feat_tbl := context.current_class.feature_table
						l_routine.locals.start
					until
						l_routine.locals.after
					loop
						from
							l_id_list := l_routine.locals.item.id_list
							l_id_list.start
						until
							l_id_list.after
						loop
							l_local_name_id := l_id_list.item
							if l_feat_tbl.has_id (l_local_name_id) then
									-- The local name is a feature name of the
									-- current analyzed class.
								create l_vrle1
								context.init_error (l_vrle1)
								l_vrle1.set_local_name (l_local_name_id)
								l_vrle1.set_location (l_routine.locals.item.start_location)
								error_handler.insert_error (l_vrle1)
							end
							l_id_list.forth
						end
						l_routine.locals.forth
					end
				end
			end
		end

feature -- Status report

	byte_code: BYTE_CODE is
			-- Last computed BYTE_CODE instance if any.
		do
			Result ?= last_byte_node
		end

	invariant_byte_code: INVARIANT_B is
			-- Last computed invariant byte node if any.
		do
			Result ?= last_byte_node
		end

	last_byte_node: BYTE_NODE
			-- Last computed BYTE_NODE after a call to one of the `process_xx' routine

feature {NONE} -- Implementation: Access

	type_checker: AST_TYPE_CHECKER
			-- To check a type

	byte_anchor: AST_BYTE_NODE_ANCHOR
			-- To get node type for UNARY_AS and BINARY_AS nodes

feature {NONE} -- Implementation: Context

	context: AST_CONTEXT
			-- Context in which current checking is done

	current_feature: FEATURE_I
			-- Feature which is checked

feature {NONE} -- Implementation: State

	is_byte_node_enabled: BOOLEAN
			-- Are we also doing BYTE_NODE generation as well as type checking?

	has_loop: BOOLEAN
			-- Does Current have a loop instruction?

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

	depend_unit_level: INTEGER_8
			-- Current level used to create new instances of DEPEND_UNIT.

	is_checking_postcondition: BOOLEAN is
			-- Are we currently checking a postcondition.
			-- Needed to ensure that old expression only appears in
			-- postconditions
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_ensure_flag) =
				{DEPEND_UNIT}.is_in_ensure_flag
		end

	is_checking_invariant: BOOLEAN is
			-- Level of analysis for access, When analyzing an access id,
			-- (instance of ACCESS_ID_AS), locals, arguments
			-- are not taken into account if set to True.
			-- Useful for analyzing class invariant.
			-- [Set on when analyzing invariants].
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_invariant_flag) =
				{DEPEND_UNIT}.is_in_invariant_flag
		end

	is_checking_precondition: BOOLEAN is
			-- Level for analysis of precondition
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_require_flag) =
				{DEPEND_UNIT}.is_in_require_flag
		end

	is_checking_check: BOOLEAN is
			-- Level for analyzis of check clauses
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_check_flag) =
				{DEPEND_UNIT}.is_in_check_flag
		end

	is_in_assignment: BOOLEAN is
			-- Level for analysis of target of an assignment
		do
			Result := (depend_unit_level & {DEPEND_UNIT}.is_in_assignment_flag) =
				{DEPEND_UNIT}.is_in_assignment_flag
		end

	last_expressions_type: ARRAY [TYPE_A]
			-- Last computed types of a list of expressions

	last_tuple_type: TUPLE_TYPE_A
			-- Type of last computed manifest tuple

	last_type: TYPE_A
			-- Type of last computed expression

	constrained_type (a_type: TYPE_A): TYPE_A is
			-- Constrained type of `a_type'.
		require
			a_type_not_void: a_type /= Void
		local
			l_formal_type: FORMAL_A
		do
			if a_type.is_formal then
				l_formal_type ?= a_type
				Result := context.current_class.constraint (l_formal_type.position)
			else
				Result := a_type
			end
		end

	current_target_type: TYPE_A
			-- Type of target of expression being processed
			-- Only useful for type checking of manifest array.

	old_expressions: LINKED_LIST [UN_OLD_B]
			-- List of old expressions found during feature type checking

	is_type_compatible: BOOLEAN
			-- Is `last_type' compatible with type passed to `process_type_compatibility'?

	last_assigner_command: FEATURE_I
			-- Last assigner command associated with a feature

	is_assigner_call: BOOLEAN
			-- Is an assigner call being processed?

	is_checking_cas: BOOLEAN
			-- Is a custom attribute being processed?

feature {NONE} -- Implementation: Access

	last_access_writable: BOOLEAN
			-- Is last ACCESS_AS node creatable?

	last_feature_name: STRING
			-- Actual name of last ACCESS_AS (might be different from original name
			-- in case an overloading resolution took place)

feature -- Settings

	reset is
			-- Reset all attributes to their default value
		do
			old_expressions := Void
			reset_types
			has_loop := False
			once_manifest_string_index := 0
			is_in_rescue := False
			is_in_creation_expression := False
			is_target_of_creation_instruction := False
			check_for_vaol := False
			depend_unit_level := 0
			last_access_writable := False
			last_feature_name := Void
			is_type_compatible := False
			last_assigner_command := Void
		end

	reset_types is
			-- Reset attributes storing types to Void
		do
			last_tuple_type := Void
			last_type := Void
			last_expressions_type := Void
			current_target_type := Void
		end

	reset_for_unqualified_call_checking is
		do
			last_type := context.current_class_type
		end

	set_is_checking_postcondition (b: BOOLEAN) is
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

	set_is_checking_invariant (b: BOOLEAN) is
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

	set_is_checking_precondition (b: BOOLEAN) is
			-- Assign `b' to `is_checking_precondition'.
			-- Also set `b' to check_for_vape.
		do
			if b then
				depend_unit_level := depend_unit_level | {DEPEND_UNIT}.is_in_require_flag
			else
				depend_unit_level := depend_unit_level &
					{DEPEND_UNIT}.is_in_require_flag.bit_not
			end
		ensure
			is_checking_precondition_set: is_checking_precondition = b
		end

	set_is_checking_check (b: BOOLEAN) is
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

	set_is_in_assignment (b: BOOLEAN) is
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

feature -- Roundtrip

	process_keyword_as (l_as: KEYWORD_AS) is
			-- Process `l_as'.
		do
		end

	process_symbol_as (l_as: SYMBOL_AS) is
			-- Process `l_as'.
		do
		end

	process_separator_as (l_as: SEPARATOR_AS) is
			-- Process `l_as'.
		do
		end

	process_new_line_as (l_as: NEW_LINE_AS) is
			-- Process `l_as'.
		do
		end

	process_comment_as (l_as: COMMENT_AS) is
			-- Process `l_as'.
		do
		end

	process_break_as (l_as: BREAK_AS) is
			-- Process `l_as'.
		do
		end

	process_none_id_as (l_as: NONE_ID_AS) is
			-- Process `l_as'.
		do
			process_id_as (l_as)
		end

	process_typed_char_as (l_as: TYPED_CHAR_AS) is
			-- Process `l_as'.
		do
			process_char_as (l_as)
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS) is
			-- Process `l_as'.
		do
			process_routine_creation_as (l_as)
		end

	process_tilda_routine_creation_as (l_as: TILDA_ROUTINE_CREATION_AS) is
			-- Process `l_as'.
		do
			process_routine_creation_as (l_as)
		end

	process_create_creation_as (l_as: CREATE_CREATION_AS) is
			-- Process `l_as'.
		do
			process_creation_as (l_as)
		end

	process_bang_creation_as (l_as: BANG_CREATION_AS) is
			-- Process `l_as'.
		do
			process_creation_as (l_as)
		end

	process_create_creation_expr_as (l_as: CREATE_CREATION_EXPR_AS) is
			-- Process `l_as'.
		do
			process_creation_expr_as (l_as)
		end

	process_bang_creation_expr_as (l_as: BANG_CREATION_EXPR_AS) is
			-- Process `l_as'.
		do
			process_creation_expr_as (l_as)
		end

feature -- Implementation

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS) is
		local
			l_creation: CREATION_EXPR_B
			l_creation_type: CL_TYPE_A
			l_ca_b: CUSTOM_ATTRIBUTE_B
		do
			is_checking_cas := True
			l_as.creation_expr.process (Current)
			l_creation_type ?= last_type
			if
				l_creation_type = Void or else not l_creation_type.has_like or else
				l_creation_type.has_formal_generic
			then
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

	process_id_as (l_as: ID_AS) is
		do
			-- Nothing to be done
		end

	process_integer_as (l_as: INTEGER_CONSTANT) is
		do
			last_type := l_as.manifest_type
			if is_byte_node_enabled then
				last_byte_node := l_as
			end
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
		local
			l_type: TYPE_A
			l_needs_byte_node: BOOLEAN
			l_vsta1: VSTA1
		do
			l_needs_byte_node := is_byte_node_enabled
			l_as.class_type.process (Current)
			l_type := last_type

				-- Check validity of type declaration
			type_checker.check_type_validity (l_type, l_as.class_type)

				-- Check validity of type declaration for static access
			if l_type.is_formal or l_type.has_like or l_type.is_none then
				create l_vsta1.make (l_type.dump, l_as.feature_name)
				l_vsta1.set_class (context.current_class)
				l_vsta1.set_location (l_as.class_type.start_location)
				error_handler.insert_error (l_vsta1)
				error_handler.raise_error
			end

			instantiator.dispatch (l_type, context.current_class)

			process_call (l_type, Void, l_as.feature_name, Void, l_as.parameters, True, False, True, False)
			error_handler.checksum
		end

	process_call (
			a_type, a_precursor_type: TYPE_A; a_name: ID_AS; a_feature: FEATURE_I;
			a_params: EIFFEL_LIST [EXPR_AS]; is_static, is_agent, is_qualified, is_precursor: BOOLEAN)
		is
			-- Process call to `a_name' in context of `a_type' with `a_params' if ANY.
			-- If `is_static' it is a static call.
		require
			a_type_not_void: a_type /= Void
			a_precursor_type_not_void: is_precursor implies a_precursor_type /= Void
			a_name_not_void: a_name /= Void
		local
			l_arg_nodes: BYTE_LIST [EXPR_B]
			l_arg_types: like last_expressions_type
			l_formal_arg_type, l_like_arg_type: TYPE_A
			l_feature: FEATURE_I
			i, l_actual_count, l_formal_count: INTEGER
				-- Id of the class type on the stack
			l_arg_type: TYPE_A
			l_last_type, l_last_constrained: TYPE_A
				-- Type onto the stack
			l_last_id: INTEGER
				-- Id of the class correponding to `l_last_type'
			l_last_class: CLASS_C
			l_depend_unit: DEPEND_UNIT
			l_access: ACCESS_B
			l_ext: EXTERNAL_B
			l_vuar1: VUAR1
			l_vuex: VUEX
			l_vkcn3: VKCN3
			l_obs_warn: OBS_FEAT_WARN
			l_vape: VAPE
			l_formal_type: FORMAL_A
			l_open_type: OPEN_TYPE_A
			l_is_in_creation_expression, l_is_target_of_creation_instruction: BOOLEAN
			l_feature_name: ID_AS
			l_parameters: EIFFEL_LIST [EXPR_AS]
			l_needs_byte_node: BOOLEAN
			l_conv_info: CONVERSION_INFO
			l_expr: EXPR_B
			l_result_type: TYPE_A
			l_veen: VEEN
			l_vsta2: VSTA2
			l_vica2: VICA2
			l_cl_type_i: CL_TYPE_I
			l_parameter: PARAMETER_B
			l_parameter_list: BYTE_LIST [PARAMETER_B]
			l_is_assigner_call: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled

				-- Retrieve if we are type checking a routine that is the creation
				-- routine of a creation expression. As soon as we know this, we
				-- reset `l_is_in_creation_expression' to False, so that if any parameter
				-- of the creation routine is also a creation expression we perform
				-- a correct type checking of the VAPE errors.
			l_is_in_creation_expression := is_in_creation_expression
			l_is_target_of_creation_instruction := is_target_of_creation_instruction
			is_in_creation_expression := False
			is_target_of_creation_instruction := False

				-- Reset assigner call flag
			l_is_assigner_call := is_assigner_call
			is_assigner_call := False

			l_feature_name := a_name

			l_last_type := a_type.actual_type
			l_last_constrained := constrained_type (l_last_type)

			if l_last_constrained.is_void then
					-- No call when target is a procedure
				create l_vkcn3
				context.init_error (l_vkcn3)
				l_vkcn3.set_location (l_feature_name)
				error_handler.insert_error (l_vkcn3)
					-- Cannot go on here
				error_handler.raise_error
			elseif l_last_constrained.is_none then
				create l_vuex.make_for_none (l_feature_name)
				context.init_error (l_vuex)
				l_vuex.set_location (l_feature_name)
				error_handler.insert_error (l_vuex)
					-- Cannot go on here
				error_handler.raise_error
			end

			l_last_class := l_last_constrained.associated_class
			l_last_id := l_last_class.class_id

			l_parameters := a_params
			if l_parameters /= Void then
				l_actual_count := l_parameters.count
			end

			if a_feature /= Void then
				l_feature := a_feature
			else
					-- Look for a feature in the class associated to the
					-- last actual type onto the context type stack. If it
					-- is a generic take the associated constraint.
				if l_last_class.feature_table.has_overloaded (l_feature_name) then
						-- Evaluate parameters. This is needed for overloading resolution.
						-- Note: if one parameter is a manifest array, then its type is resolved
						-- without context.
					if l_parameters /= Void then
						l_actual_count := l_parameters.count
						current_target_type := Void
						process_expressions_list (l_parameters)
						l_arg_types := last_expressions_type
						if l_needs_byte_node then
							l_arg_nodes ?= last_byte_node
						end
					end
					l_feature := overloaded_feature (l_last_type, l_last_class, l_arg_types,
						l_feature_name, is_static)
					if l_feature /= Void then
							-- Update `l_feature_name' with appropriate resolved name.
							-- Otherwise some routine using `l_feature_name' will fail although
							-- it succeeds here (e.g. CREATION_EXPR_AS and CREATION_AS)
						create l_feature_name.initialize (l_feature.feature_name)
					end
				else
					l_feature := l_last_class.feature_table.item (l_feature_name)
				end
			end
			if l_feature /= Void and then (not is_static or else l_feature.has_static_access) then
					-- Attachments type check
				l_formal_count := l_feature.argument_count
				if is_agent and l_actual_count = 0 and l_formal_count > 0 then
						-- Delayed call with all arguments open.
						-- Create l_parameters.
					from
						create l_parameters.make_filled (l_formal_count)
						l_parameters.start
					until
						l_parameters.after
					loop
						l_parameters.put (create {OPERAND_AS}.initialize (Void, Void, Void))
						l_parameters.forth
					end
					l_actual_count := l_formal_count
					current_target_type := Void
					process_expressions_list (l_parameters)
					l_arg_types := last_expressions_type
					if l_needs_byte_node then
						l_arg_nodes ?= last_byte_node
					end
					l_parameters.start
				end
				if l_actual_count /= l_formal_count then
					create l_vuar1
					context.init_error (l_vuar1)
					l_vuar1.set_called_feature (l_feature, l_last_id)
					l_vuar1.set_argument_count (l_actual_count)
					l_vuar1.set_location (l_feature_name)
					error_handler.insert_error (l_vuar1)
						-- Cannot go on here: too dangerous
					error_handler.raise_error
				elseif l_parameters /= Void then
					if l_needs_byte_node then
						create l_parameter_list.make (l_actual_count)
					end
					if l_arg_types /= Void then
							-- Parameters have been evaluated, nothing to be done.
							-- Case for overloaded routine call or agent with all open arguments.
						l_actual_count := l_actual_count + 1 -- Optimization for loop exit
					else
							-- Parameters haven't yet evaluated
						from
							i := 1
							create l_arg_types.make (1, l_actual_count)
							if l_needs_byte_node then
								create l_arg_nodes.make (l_actual_count)
							end
							l_actual_count := l_actual_count + 1 -- Optimization for loop exit
						until
							i = l_actual_count
						loop
								-- Get formal argument type.
							l_formal_arg_type ?= l_feature.arguments.i_th (i)
							check
								l_formal_arg_type_not_void: l_formal_arg_type /= Void
							end

							reset_for_unqualified_call_checking
							if l_formal_arg_type.is_like_argument then
									-- To bad we are not able to evaluate with a target context a manifest array
									-- passed as argument where formal is an anchor type.
								current_target_type := Void
							else
								current_target_type :=
									l_formal_arg_type.instantiation_in (l_last_type, l_last_id).actual_type
							end
							l_parameters.i_th (i).process (Current)
							l_arg_types.put (last_type, i)
							if l_needs_byte_node then
								l_expr ?= last_byte_node
								l_arg_nodes.extend (l_expr)
							end
							i := i + 1
						end
					end

						-- Conformance checking of arguments
					from
						i := 1
					until
						i = l_actual_count
					loop
							-- Get actual argument type.
						l_arg_type := l_arg_types.item (i)

							-- Get formal argument type.
						l_formal_arg_type ?= l_feature.arguments.i_th (i)
						check
							l_formal_arg_type_not_void: l_formal_arg_type /= Void
						end

							-- Take care of anchoring to argument
						if l_formal_arg_type.is_like_argument then
							l_like_arg_type := l_formal_arg_type.actual_argument_type (l_arg_types)
							l_like_arg_type :=
								l_like_arg_type.instantiation_in (l_last_type, l_last_id).actual_type
								-- Check that `l_arg_type' is compatible to its `like argument'.
								-- Once this is done, then type checking is done on the real
								-- type of the routine, not the anchor.
							if
								not l_arg_type.conform_to (l_like_arg_type) and then
								not l_arg_type.convert_to (context.current_class, l_like_arg_type)
							then
								insert_vuar2_error (l_feature, l_parameters, l_last_id, i, l_arg_type,
									l_like_arg_type)
							end
						end
							-- Actual type of feature argument
						l_formal_arg_type := l_formal_arg_type.instantiation_in (l_last_type, l_last_id).actual_type

							-- Conformance: take care of constrained genericity
							-- We must generate an error when `l_formal_arg_type' becomes
							-- an OPEN_TYPE_A, for example "~equal (?, b)" will
							-- check that the type of `b' conforms to type of `?'
							-- since `equal' is defined as `equal (a: ANY; b: like a)'.
							-- However `conform_to' does not work when parameter
							-- is an OPEN_TYPE_A type. Since this checks can only
							-- happens in type checking of an agent, we can do it
							-- at only one place, ie here.
						l_open_type ?= l_formal_arg_type
						if l_open_type /= Void or else not l_arg_type.conform_to (l_formal_arg_type) then
							if
								l_open_type = Void and
								l_arg_type.convert_to (context.current_class, l_formal_arg_type)
							then
								l_conv_info := context.last_conversion_info
								if l_conv_info.has_depend_unit then
									context.supplier_ids.extend (l_conv_info.depend_unit)
								end
									-- Generate conversion byte node only if we are not checking
									-- a custom attribute. Indeed in that case, we do not want those
									-- conversion routines, we will use the attachment type to figure
									-- out how the custom attribute will be generated.
								if l_needs_byte_node and not is_checking_cas then
									l_expr ?= l_arg_nodes.i_th (i)
									l_arg_nodes.put_i_th (l_conv_info.byte_node (l_expr), i)
								end
							elseif
								l_arg_type.is_expanded and then l_formal_arg_type.is_external and then
								l_arg_type.is_conformant_to (l_formal_arg_type)
							then
									-- No need for conversion, this is currently done at the code
									-- generation level to properly handle the generic case.
									-- If not done at the code generation, we would need the
									-- following lines.
--								l_expr ?= l_arg_nodes.i_th (i)
--								l_arg_nodes.put_i_th ((create {BOX_CONVERSION_INFO}.make (l_arg_type)).
--									byte_node (l_expr), i)
							else
								insert_vuar2_error (l_feature, l_parameters, l_last_id, i, l_arg_type,
									l_formal_arg_type)
							end
						end
						if l_needs_byte_node then
							create l_parameter
							l_expr ?= l_arg_nodes.i_th (i)
							l_parameter.set_expression (l_expr)
							l_parameter.set_attachment_type (l_formal_arg_type.type_i)
							l_parameter_list.extend (l_parameter)

							if is_checking_cas then
								fixme ("[
									Validity checking should not be done when byte code generation
									is required. But unfortunately we need the compiled version to get
									information about the parameters.
									]")
								if not l_expr.is_constant_expression then
									create l_vica2.make (context.current_class, current_feature)
									l_vica2.set_location (l_parameters.i_th (i).start_location)
									error_handler.insert_error (l_vica2)
								end
							end
						end
						i := i + 1
					end
				end

					-- Get the type of Current feature.
				l_result_type ?= l_feature.type

					-- If the declared target type is formal
					-- and if the corresponding generic parameter is
					-- constrained to a class which is also generic
					-- Result id a FORMAL_A object with no more information
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
					-- For the evaluation of `item', l_last_type is "Generic #1" (of TEST)
					-- `l_last_constrained_type' is ARRAY [STRING], `l_feature.type'
					-- is "Generic #1" (of ARRAY)
					-- We need to convert the type to the constrained type for proper
					-- type evaluation of remote calls.
					-- "Generic #1" (of ARRAY) is thus replaced by the corresponding actual
					-- type in the declaration of the constraint class type (in this case
					-- class STRING).
					-- Note: the following conditional instruction will not be executed
					-- if the class type of the constraint id not generic since in that
					-- case `Result' would not be formal.

				if l_last_type.is_formal then
					if l_result_type.is_formal then
						l_formal_type ?= l_result_type
					else
						l_formal_type ?= l_result_type.actual_type
					end

					if l_formal_type /= Void then
						l_result_type := l_last_constrained.generics.item (l_formal_type.position)
					end
				elseif l_last_type.is_like then
					if l_result_type.is_formal then
						l_formal_type ?= l_result_type
					else
						l_formal_type ?= l_result_type.actual_type
					end
					if l_formal_type /= Void then
						l_result_type := l_last_type.actual_type.generics.item (l_formal_type.position)
					end
				end
				if l_arg_types /= Void then
					l_result_type := l_result_type.actual_argument_type (l_arg_types)
				end
				l_result_type := l_result_type.instantiation_in (l_last_type, l_last_id).actual_type
					-- Export validity
				if
					not context.is_ignoring_export and is_qualified and
					not l_feature.is_exported_for (context.current_class)
				then
					create l_vuex
					context.init_error (l_vuex)
					l_vuex.set_static_class (l_last_class)
					l_vuex.set_exported_feature (l_feature)
					l_vuex.set_location (l_feature_name)
					error_handler.insert_error (l_vuex)
				end
				if
					l_feature.is_obsolete
						-- If the obsolete call is in an obsolete class,
						-- no message is displayed
					and then not context.current_class.is_obsolete
						-- The current feature is whether the invariant or
						-- a non obsolete feature
					and then (current_feature = Void or else
						not current_feature.is_obsolete)
				then
					create l_obs_warn
					l_obs_warn.set_class (context.current_class)
					l_obs_warn.set_obsolete_class (l_last_constrained.associated_class)
					l_obs_warn.set_obsolete_feature (l_feature)
					l_obs_warn.set_feature (current_feature)
					error_handler.insert_warning (l_obs_warn)
				end
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
					error_handler.raise_error
				end

					-- Supplier dependances update
				if l_is_target_of_creation_instruction then
					create l_depend_unit.make_with_level (l_last_id, l_feature,
						{DEPEND_UNIT}.is_in_creation_flag | depend_unit_level)
				else
					if is_precursor then
						create l_depend_unit.make_with_level (a_precursor_type.associated_class.class_id, l_feature,
							depend_unit_level)
						context.supplier_ids.extend (l_depend_unit)
					end
					create l_depend_unit.make_with_level (l_last_id, l_feature, depend_unit_level)
				end
				context.supplier_ids.extend (l_depend_unit)

				if l_is_assigner_call then
					process_assigner_command (l_last_id, l_feature)
				end

				if l_needs_byte_node then
					if not is_static then
						if is_precursor then
							l_cl_type_i ?= a_precursor_type.type_i
							l_access := l_feature.access_for_feature (l_result_type.type_i, l_cl_type_i)
						else
							l_access := l_feature.access (l_result_type.type_i)
						end
					else
						l_cl_type_i ?= a_type.type_i
						l_access := l_feature.access_for_feature (l_result_type.type_i, l_cl_type_i)
						l_ext ?= l_access
						if l_ext /= Void then
							l_ext.enable_static_call
						end
					end
					l_access.set_parameters (l_parameter_list)
					last_byte_node := l_access
				end
				last_type := l_result_type
				last_access_writable := l_feature.is_attribute
				last_feature_name := l_feature.feature_name
			else
					-- `l_feature' was not valid for current, report
					-- corresponding error.
				if l_feature = Void then
						-- Not a valid feature name.
					create l_veen
					context.init_error (l_veen)
					l_veen.set_identifier (l_feature_name)
					l_veen.set_parameter_count (l_actual_count)
					l_veen.set_location (l_feature_name)
					error_handler.insert_error (l_veen)
					error_handler.raise_error
				elseif is_static then
						-- Not a valid feature for static access.	
					create l_vsta2
					context.init_error (l_vsta2)
					l_vsta2.set_non_static_feature (l_feature)
					l_vsta2.set_location (l_feature_name)
					error_handler.insert_error (l_vsta2)
					error_handler.raise_error
				end
			end
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS) is
		do
			-- Nothing to be done
		end

	process_unique_as (l_as: UNIQUE_AS) is
		do
			-- Nothing to be done
		end

	process_tuple_as (l_as: TUPLE_AS) is
		local
			l_tuple_type: TUPLE_TYPE_A
			l_list: BYTE_LIST [EXPR_B]
		do
			reset_for_unqualified_call_checking

				-- Type check expression list
			process_expressions_list_for_tuple (l_as.expressions)

				-- Update type stack
			create l_tuple_type.make (system.tuple_id, last_expressions_type)
			instantiator.dispatch (l_tuple_type, context.current_class)
			last_tuple_type := l_tuple_type
			last_type := l_tuple_type

			if is_byte_node_enabled then
				l_list ?= last_byte_node
				create {TUPLE_CONST_B} last_byte_node.make (l_list, l_tuple_type.type_i)
			end
		ensure then
			last_tuple_type_set: last_tuple_type /= Void
		end

	process_real_as (l_as: REAL_AS) is
		do
			if l_as.constant_type = Void then
				last_type := Real_64_type
			else
				fixme ("We should check the `constant_type' matches the real `value' and%
					%possibly remove `constant_type' from REAL_AS.")
				last_type := l_as.constant_type.actual_type
			end
			if is_byte_node_enabled then
				create {REAL_CONST_B} last_byte_node.make (l_as.value, last_type)
			end
		end

	process_bool_as (l_as: BOOL_AS) is
		do
			last_type := Boolean_type
			if is_byte_node_enabled then
				create {BOOL_CONST_B} last_byte_node.make (l_as.value)
			end
		end

	process_bit_const_as (l_as: BIT_CONST_AS) is
		do
			create {BITS_A} last_type.make (l_as.value.count)
			if is_byte_node_enabled then
				create {BIT_CONST_B} last_byte_node.make (l_as.value)
			end
		end

	process_array_as (l_as: ARRAY_AS) is
		local
			i, nb: INTEGER
			l_array_type: GEN_TYPE_A
			l_generics: ARRAY [TYPE_A]
			l_type_a, l_element_type: TYPE_A
			l_list: BYTE_LIST [EXPR_B]
			l_gen_type: GEN_TYPE_A
			l_last_types: like last_expressions_type
			l_has_error: BOOLEAN
			l_has_array_target: BOOLEAN
		do
			reset_for_unqualified_call_checking
				-- Get target for manifest array creation (either through assignment or
				-- argument passing).
			l_gen_type ?= current_target_type
				-- Let's try to find the type of the manifest array.
			if l_gen_type /= Void then
					-- Check that it is either an ARRAY, or a NATIVE_ARRAY when used
					-- in a custom attribute.
				if
					l_gen_type.class_id = system.array_id or
					(is_checking_cas and then l_gen_type.class_id = system.native_array_id)
				then
					l_has_array_target := True
						-- Check that expressions' type matches element's type of `l_gen_type' array.
					l_element_type := l_gen_type.generics.item (1).actual_type
				end
			end

				-- Type check expression list
				-- If there is a manifest array within a manifest array, we consider there is
				-- no target type specified.
			nb := l_as.expressions.count
			current_target_type := l_element_type
			process_expressions_list (l_as.expressions)
			l_last_types := last_expressions_type

			if is_byte_node_enabled then
				l_list ?= last_byte_node
			end

				-- Let's try to find the type of the manifest array.
			if l_has_array_target then
					-- Check that expressions' type matches element's type of `l_gen_type' array.
				l_type_a := l_element_type
				if nb > 0 then
					from
						i := 1
					until
						i > nb
					loop
						l_element_type := l_last_types.item (i)
						if not l_element_type.conform_to (l_type_a) then
							if l_element_type.convert_to (context.current_class, l_type_a) then
								if is_byte_node_enabled and not is_checking_cas then
									l_list.put_i_th (context.last_conversion_info.byte_node (
										l_list.i_th (i)), i)
								end
							else
								l_has_error := True
								i := nb + 1	-- Exit the loop
							end
						end
						i := i + 1
					end
				end
				if not l_has_error then
						-- We could keep `l_gen_type' for `l_array_type', but unfortunately it
						-- causes the eweasel test `term131' to fail because if it contains an
						-- anchor then it is not marked as used for dead code removal (because
						-- anchor appears in signature and signatures are not solved for dependances
						-- at degree 4) and we would crash while generating the table at the very
						-- end of finalization.
						-- For now we use `l_type_a.deep_actual_type' (which removes any usage of
						-- the anchor) to solve the problem.
					create l_generics.make (1, 1)
					l_generics.put (l_type_a.deep_actual_type, 1)
					if is_checking_cas then
						check l_gen_type.class_id = system.native_array_id end
						create {NATIVE_ARRAY_TYPE_A} l_array_type.make (system.native_array_id, l_generics)
					else
						create l_array_type.make (system.array_id, l_generics)
					end
					instantiator.dispatch (l_array_type, context.current_class)
				end
			end
			if l_array_type = Void then
				if nb > 0 then
					if is_checking_cas then
							-- `l_gen_type' is not an array type, so for now we compute as if
							-- there was no context the type of the manifest array by taking the lowest
							-- common type.
						from
							l_has_error := False
								-- Take first element in manifest array and let's suppose
								-- it is the lowest type.
							l_type_a := l_last_types.item (1)
							i := 2
						until
							i > nb
						loop
							l_element_type := l_last_types.item (i)
								-- Let's try to find the type to which everyone conforms to.
								-- If not found it will be ANY.
							if
								l_element_type.conform_to (l_type_a) or
								l_element_type.convert_to (context.current_class, l_type_a)
							then
									-- Nothing to be done
							elseif
								l_type_a.conform_to (l_element_type) or
								l_type_a.convert_to (context.current_class, l_element_type)
							then
									-- Found a lowest type.
								l_type_a := l_element_type
							else
									-- Cannot find a common type
								l_has_error := True
								i := nb + 1 -- Exit the loop
							end
							i := i + 1
						end
					else
							-- `l_gen_type' is not an array type, so for now we compute as if
							-- there was no context the type of the manifest array by taking the lowest
							-- common type.
						from
							l_has_error := False
								-- Take first element in manifest array and let's suppose
								-- it is the lowest type.
							l_type_a := l_last_types.item (1)
							i := 2
						until
							i > nb
						loop
							l_element_type := l_last_types.item (i)
								-- Let's try to find the type to which everyone conforms to.
								-- If not found it will be ANY.
							if l_element_type.conform_to (l_type_a) then
									-- Nothing to be done
							elseif l_type_a.conform_to (l_element_type) then
									-- Found a lowest type.
								l_type_a := l_element_type
							else
									-- Cannot find a common type
								l_has_error := True
								i := nb + 1 -- Exit the loop
							end
							i := i + 1
						end
					end
					if l_has_error then
							-- We could not find a common type, so let's iterate again to ensure that
							-- elements conform or convert to ANY.
						from
							i := 1
							l_has_error := False
							create {CL_TYPE_A} l_type_a.make (system.any_id)
						until
							i > nb
						loop
							l_element_type := l_last_types.item (i)
							if not l_element_type.conform_to (l_type_a) then
								if l_element_type.convert_to (context.current_class, l_type_a) then
									if is_byte_node_enabled and not is_checking_cas then
										l_list.put_i_th (context.last_conversion_info.byte_node (
											l_list.i_th (i)), i)
									end
								else
									l_has_error := True
									i := nb + 1	-- Exit the loop
								end
							end
							i := i + 1
						end
					end
					if not l_has_error then
						create l_generics.make (1, 1)
						l_generics.put (l_type_a, 1)
						create l_array_type.make (system.array_id, l_generics)
						instantiator.dispatch (l_array_type, context.current_class)
					end
				else
						-- Empty manifest array
					create l_generics.make (1, 1)
					l_generics.put (create {CL_TYPE_A}.make (system.any_id), 1)
					create l_array_type.make (system.array_id, l_generics)
					instantiator.dispatch (l_array_type, context.current_class)
				end
			end

			if not l_has_error then
					-- Update type stack
				last_type := l_array_type
				if is_byte_node_enabled then
					create {ARRAY_CONST_B} last_byte_node.make (l_list,
						l_array_type.type_i, l_array_type.create_info)
				end
			else
				fixme ("Insert new validity error saying that manifest array is not valid")
			end
		end

	process_char_as (l_as: CHAR_AS) is
		do
			last_type := character_type
			if is_byte_node_enabled then
				create {CHAR_CONST_B} last_byte_node.make (l_as.value)
			end
		end

	process_string_as (l_as: STRING_AS) is
		do
			last_type := string_type
			if is_byte_node_enabled then
				if l_as.is_once_string then
					once_manifest_string_index := once_manifest_string_index + 1
					create {ONCE_STRING_B} last_byte_node.make (l_as.value, once_manifest_string_index)
				else
					create {STRING_B} last_byte_node.make (l_as.value)
				end
			end
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS) is
		do
			process_string_as (l_as)
		end

	process_body_as (l_as: BODY_AS) is
		do
			safe_process (l_as.content)
		end

	process_result_as (l_as: RESULT_AS) is
		local
			l_feat_type: TYPE_A
			l_vrle3: VRLE3
			l_has_error: BOOLEAN
			l_veen2a: VEEN2A
		do
				-- Error if in procedure or invariant
			l_has_error := is_checking_invariant
			if not l_has_error then
				l_feat_type ?= current_feature.type
				l_has_error := l_feat_type.actual_type.conform_to (Void_type)
			end

			if l_has_error then
				create l_vrle3
				context.init_error (l_vrle3)
				l_vrle3.set_location (l_as.start_location)
				error_handler.insert_error (l_vrle3)
					-- Cannot go on here
				error_handler.raise_error
			else
				if is_checking_precondition then
						-- Result entity in precondition
					create l_veen2a
					context.init_error (l_veen2a)
					l_veen2a.set_location (l_as.start_location)
					error_handler.insert_error (l_veen2a)
				end

					-- Update the type stack
				last_type := l_feat_type
				last_access_writable := True
				if is_byte_node_enabled then
					create {RESULT_B} last_byte_node
				end
			end
		end

	process_current_as (l_as: CURRENT_AS) is
		do
			last_type := context.current_class_type
			if is_byte_node_enabled then
				create {CURRENT_B} last_byte_node
			end
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
		do
			process_call (last_type, Void, l_as.feature_name, Void, l_as.parameters, False, False, True, False)
			error_handler.checksum
		end

	process_access_inv_as (l_as: ACCESS_INV_AS) is
		do
			process_call (last_type, Void, l_as.feature_name, Void, l_as.parameters, False, False, False, False)
			error_handler.checksum
		end

	process_access_id_as (l_as: ACCESS_ID_AS) is
		local
			l_arg_pos: INTEGER
			l_last_id: INTEGER
			l_local: LOCAL_B
			l_argument: ARGUMENT_B
			l_local_info: LOCAL_INFO
			l_feature: FEATURE_I
			l_has_vuar_error: BOOLEAN
			l_vuar1: VUAR1
			l_veen2b: VEEN2B
			l_needs_byte_node: BOOLEAN
			l_type: TYPE_A
		do
			l_needs_byte_node := is_byte_node_enabled
				-- No need for `last_type.actual_type' as here `last_type' is equal to
				-- `context.current_class_type' since we start a feature call.
			l_last_id := constrained_type (last_type).associated_class.class_id

			l_feature := current_feature
				-- Look for an argument
			if l_feature /= Void then
				l_arg_pos := l_feature.argument_position (l_as.feature_name)
			end
			if l_arg_pos /= 0 then
					-- Found argument
				l_type ?= l_feature.arguments.i_th (l_arg_pos)
				l_type := l_type.actual_type.instantiation_in (last_type, l_last_id)
				l_has_vuar_error := l_as.parameters /= Void
				if l_needs_byte_node then
					create l_argument
					l_argument.set_position (l_arg_pos)
					last_byte_node := l_argument
				end
			else
					-- Look for a local if not in a pre- or postcondition
				l_local_info := context.locals.item (l_as.feature_name)
				if l_local_info /= Void then
						-- Local found
					l_local_info.set_is_used (True)
					last_access_writable := True
					l_has_vuar_error := l_as.parameters /= Void
					l_type := l_local_info.type
					l_type := l_type.instantiation_in (last_type, l_last_id)
					if l_needs_byte_node then
						create l_local
						l_local.set_position (l_local_info.position)
						last_byte_node := l_local
					end

					if is_checking_postcondition or else is_checking_precondition then
							-- Local in post- or precondition
							--|Note: this should not happen since
							--|in the context of assertions we would have
							--|ACCESS_ASSERT_AS and not ACCESS_ID_AS objects.
							--|(Fred)
						create l_veen2b
						context.init_error (l_veen2b)
						l_veen2b.set_identifier (l_as.feature_name)
						l_veen2b.set_location (l_as.feature_name)
						error_handler.insert_error (l_veen2b)
					end
				else
						-- Look for a feature
					process_call (last_type, Void, l_as.feature_name, Void, l_as.parameters, False, False, False, False)
					l_type := last_type
				end
			end
			if l_has_vuar_error then
				create l_vuar1
				if l_arg_pos /= 0 then
					l_vuar1.set_arg_name (l_as.feature_name)
				else
					l_vuar1.set_local_name (l_as.feature_name)
				end
				context.init_error (l_vuar1)
				l_vuar1.set_location (l_as.feature_name)
				error_handler.insert_error (l_vuar1)
			else
				last_type := l_type
			end
			error_handler.checksum
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS) is
		local
			l_arg_pos: INTEGER
			l_local_info: LOCAL_INFO
			l_argument: ARGUMENT_B
			l_arg_type: TYPE_A
			l_feature: FEATURE_I
			l_vuar1: VUAR1
			l_veen2b: VEEN2B
			l_last_id: INTEGER
		do
			l_feature := current_feature
				-- Look for an argument
			l_arg_pos := l_feature.argument_position (l_as.feature_name)
			if l_arg_pos /= 0 then
					-- Found argument
				l_arg_type ?= l_feature.arguments.i_th (l_arg_pos)
					-- No need for `last_type.actual_type' as here `last_type' is equal to
					-- `context.current_class_type' since we start a feature call.
				l_last_id := constrained_type (last_type).associated_class.class_id
				last_type := l_arg_type.actual_type.instantiation_in (last_type, l_last_id)
				if l_as.parameters /= Void then
					create l_vuar1
					context.init_error (l_vuar1)
					l_vuar1.set_arg_name (l_as.feature_name)
					l_vuar1.set_location (l_as.feature_name)
					error_handler.insert_error (l_vuar1)
				end
				if is_byte_node_enabled then
					create l_argument
					l_argument.set_position (l_arg_pos)
					last_byte_node := l_argument
				end
			else
					-- Look for a local if in a pre- or postcondition
				l_local_info := context.locals.item (l_as.feature_name)
				if l_local_info /= Void then
						-- Local found
					create l_veen2b
					context.init_error (l_veen2b)
					l_veen2b.set_identifier (l_as.feature_name)
					l_veen2b.set_location (l_as.feature_name)
					error_handler.insert_error (l_veen2b)
				else
						-- Look for a feature
					process_call (last_type, Void, l_as.feature_name, Void, l_as.parameters, False, False, False, False)
				end
			end
			error_handler.checksum
		end

	process_precursor_as (l_as: PRECURSOR_AS) is
		local
			l_vupr1: VUPR1
			l_vupr2: VUPR2
			l_vupr3: VUPR3
			l_pre_table: LINKED_LIST [PAIR[CL_TYPE_A, INTEGER]]
			l_feature_i: FEATURE_I
			l_parent_type: CL_TYPE_A
			l_parent_class: CLASS_C
			l_feat_ast: FEATURE_AS
			l_precursor_id: ID_AS
			l_instatiation_type: LIKE_CURRENT
		do
			l_feat_ast := context.current_class.feature_with_name (current_feature.feature_name).ast

				-- Check that feature has a unique name (vupr1)
				-- Check that we're in the body of a routine (l_vupr1).
			if
				l_feat_ast.feature_names.count > 1 or
				is_checking_precondition or is_checking_postcondition or is_checking_invariant
			then
				create l_vupr1
				context.init_error (l_vupr1)
				error_handler.insert_error (l_vupr1)
					-- Cannot go on here.
				error_handler.raise_error
			end

				-- Create table of routine ids of all parents which have
				-- an effective precursor of the current feature.
			l_pre_table := precursor_table (l_as)

				-- Check that current feature is a redefinition.
			if l_pre_table.count = 0 then
				if l_as.parent_base_class /= Void then
						-- The specified parent does not have
						-- an effective precursor.
					create l_vupr2
					context.init_error (l_vupr2)
					error_handler.insert_error (l_vupr2)
						-- Cannot go on here.
					error_handler.raise_error
				else
						-- No parent has an effective precursor
						-- (not a redefinition)
					create l_vupr3
					context.init_error (l_vupr3)
					error_handler.insert_error (l_vupr3)
						-- Cannot go on here.
					error_handler.raise_error
				end
			end

				-- Check that an unqualified precursor construct
				-- is not ambiguous.
			if l_pre_table.count > 1 then
					-- Ambiguous construct
				create l_vupr3
				context.init_error (l_vupr3)
				error_handler.insert_error (l_vupr3)
					-- Cannot go on here.
				error_handler.raise_error
			end

				-- Table has exactly one entry.
			l_pre_table.start
			l_parent_type := l_pre_table.item.first
			l_parent_class := l_parent_type.associated_class
			l_feature_i := l_parent_class.feature_table.feature_of_rout_id (l_pre_table.item.second)

				-- Update signature of parent `l_feature_i' in context of its instantiation
				-- in current class.
			l_feature_i := l_feature_i.duplicate
				-- Adapt `l_feature_i' to context of current class (e.g. if `l_parent_type' is
				-- generic then we need to resolve formals used in `l_feature_i' but the one from
				-- the instantiation `l_parent_type'.
			create l_instatiation_type
			l_instatiation_type.set_actual_type (l_parent_type)
			l_feature_i.instantiate (l_instatiation_type)
				-- Now that we have the fully instantiated type, we need to adapt it to
				-- the current class type (e.g. like Current).
			l_feature_i.instantiate (context.current_class_type)

			create l_precursor_id.initialize ("Precursor")
			l_precursor_id.set_position (l_as.precursor_keyword.line, l_as.precursor_keyword.column,
				l_as.precursor_keyword.position, l_as.precursor_keyword.location_count)
			process_call (context.current_class_type, l_parent_type, l_precursor_id, l_feature_i,
				l_as.parameters, False, False, False, True)
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS) is
		local
			l_target_type: TYPE_A
			l_target_expr: EXPR_B
			l_access_expr: ACCESS_EXPR_B
			l_call: CALL_B
			l_nested: NESTED_B
		do
				-- Type check the target
			l_as.target.process (Current)
			l_target_type := last_type
			if is_byte_node_enabled then
				l_target_expr ?= last_byte_node
				create l_access_expr
				l_access_expr.set_expr (l_target_expr)
			end

				-- Type check the message
			l_as.message.process (Current)
			if is_byte_node_enabled then
				l_call ?= last_byte_node
				check
					l_call_not_void: l_call /= Void
				end
				create l_nested
				l_nested.set_target (l_access_expr)
				fixme ("Should we set `parent' on `l_access_expr' as we do for a NESTED_AS")
				l_nested.set_message (l_call)
				l_call.set_parent (l_nested)
				last_byte_node := l_nested
			end
		end

	process_nested_as (l_as: NESTED_AS) is
		local
			l_target_access: ACCESS_B
			l_call: CALL_B
			l_nested: NESTED_B
			l_is_assigner_call: BOOLEAN
		do
				-- Mask out assigner call flag for target of the call
			l_is_assigner_call := is_assigner_call
			is_assigner_call := False
				-- Type check the target
			l_as.target.process (Current)
			if not is_byte_node_enabled then
					-- Type check the message
				l_as.message.process (Current)
			else
				l_target_access ?= last_byte_node

					-- Restore assigner call flag for nested call
				is_assigner_call := l_is_assigner_call
					-- Type check the message
				l_as.message.process (Current)

					-- Create byte node.
				l_call ?= last_byte_node
				check
					l_call_not_void: l_call /= Void
				end
				create l_nested
				l_nested.set_target (l_target_access)
				l_nested.set_message (l_call)

				l_target_access.set_parent (l_nested)
				l_call.set_parent (l_nested)

				last_byte_node := l_nested
			end
		end

	process_routine_as (l_as: ROUTINE_AS) is
		local
			l_vxrc: VXRC
			l_byte_code: BYTE_CODE
			l_list: BYTE_LIST [BYTE_NODE]
			l_needs_byte_node: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled

				-- Check local variables
			if l_as.locals /= Void then
				check_locals (l_as)
			end
				-- Check preconditions
			if l_as.precondition /= Void then
					-- Set Result access analysis level to `is_checking_precondition': locals
					-- and Result cannot be found in preconditions
				set_is_checking_precondition (True)
				l_as.precondition.process (Current)
				if l_needs_byte_node then
					l_list ?= last_byte_node
				end
					-- Reset the levels to default values
				set_is_checking_precondition (False)
			end

				-- Check body
			l_as.routine_body.process (Current)
			if l_needs_byte_node then
				l_byte_code ?= last_byte_node
				context.init_byte_code (l_byte_code)
				l_byte_code.set_precondition (l_list)
			end

				-- Check postconditions
			if l_as.postcondition /= Void then
					-- Set access id level analysis to `is_checking_postcondition': locals
					-- are not taken into account
				set_is_checking_postcondition (True)
				l_as.postcondition.process (Current)
				if l_needs_byte_node then
					l_list ?= last_byte_node
					l_byte_code.set_postcondition (l_list)
				end
					-- Reset the level
				set_is_checking_postcondition (False)
			end

				-- Check rescue-clause
			if l_as.rescue_clause /= Void then
					-- A deferred or external feature cannot have a rescue
					-- clause
				if l_as.routine_body.is_deferred or else l_as.routine_body.is_external	then
					create l_vxrc
					context.init_error (l_vxrc)
					l_vxrc.set_deferred (l_as.routine_body.is_deferred)
					l_vxrc.set_location (l_as.rescue_clause.start_location)
					error_handler.insert_error (l_vxrc)
				else
						 -- Set mark of context
					is_in_rescue := True
					l_as.rescue_clause.process (Current)
					if l_needs_byte_node then
						l_list ?= last_byte_node
						l_byte_code.set_rescue_clause (l_list)
					end
					is_in_rescue := False
				end
			end

			if l_as.locals /= Void then
				check_unused_locals (context.locals)
			end

			if l_needs_byte_node then
				if old_expressions /= Void and then not old_expressions.is_empty then
					l_byte_code.set_old_expressions (old_expressions)
				end
				l_byte_code.set_end_location (l_as.end_location)
				l_byte_code.set_once_manifest_string_count (l_as.once_manifest_string_count)
				last_byte_node := l_byte_code
			end
		end

	process_constant_as (l_as: CONSTANT_AS) is
		do
			-- Nothing to be done
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL]) is
		local
			l_cursor: INTEGER
			l_list: BYTE_LIST [BYTE_NODE]
		do
			l_cursor := l_as.index
			l_as.start

			if is_byte_node_enabled then
				from
					create l_list.make (l_as.count)
				until
					l_as.after
				loop
					l_as.item.process (Current)
					l_list.extend (last_byte_node)
					l_as.forth
				end
				last_byte_node := l_list
			else
				from
				until
					l_as.after
				loop
					l_as.item.process (Current)
					l_as.forth
				end
			end
			l_as.go_i_th (l_cursor)
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS) is
		do
			-- Nothing to be done
		end

	process_operand_as (l_as: OPERAND_AS) is
		local
			l_class_type: TYPE_A
		do
			if l_as.target /= Void then
				l_as.target.process (Current)
			elseif l_as.expression /= Void then
				reset_for_unqualified_call_checking
				l_as.expression.process (Current)
			elseif l_as.class_type /= Void then
				l_as.class_type.process (Current)
				l_class_type := last_type
				type_checker.check_type_validity (l_class_type, l_as.class_type)
				instantiator.dispatch (l_class_type, context.current_class)
				if is_byte_node_enabled then
					create {OPERAND_B} last_byte_node
				end
			else
				create {OPEN_TYPE_A} last_type
				if is_byte_node_enabled then
					create {OPERAND_B} last_byte_node
				end
			end
		end

	process_tagged_as (l_as: TAGGED_AS) is
		local
			l_vwbe3: VWBE3
			l_assert: ASSERT_B
			l_expr: EXPR_B
		do
			reset_for_unqualified_call_checking

			l_as.expr.process (Current)

				-- Check if the type of the expression is boolean
			if not last_type.actual_type.is_boolean then
				create l_vwbe3
				context.init_error (l_vwbe3)
				l_vwbe3.set_type (last_type)
				l_vwbe3.set_location (l_as.expr.end_location)
				error_handler.insert_error (l_vwbe3)
			end

			if is_byte_node_enabled then
				l_expr ?= last_byte_node
				check
					l_expr_not_void: l_expr /= Void
				end
				create l_assert
				l_assert.set_tag (l_as.tag)
				l_assert.set_expr (l_expr)
				l_assert.set_line_number (l_as.expr.start_location.line)
				last_byte_node := l_assert
			end
		end

	process_variant_as (l_as: VARIANT_AS) is
		local
			l_vave: VAVE
			l_assert: VARIANT_B
			l_expr: EXPR_B
		do
			reset_for_unqualified_call_checking
			l_as.expr.process (Current)

				-- Check if the type of the expression is integer
			if not last_type.is_integer then
				create l_vave
				context.init_error (l_vave)
				l_vave.set_type (last_type)
				l_vave.set_location (l_as.expr.end_location)
				error_handler.insert_error (l_vave)
			end

			if is_byte_node_enabled then
				l_expr ?= last_byte_node
				check
					l_expr_not_void: l_expr /= Void
				end
				create l_assert
				l_assert.set_tag (l_as.tag)
				l_assert.set_expr (l_expr)
				l_assert.set_line_number (l_as.expr.start_location.line)
				last_byte_node := l_assert
			end
		end

	process_un_strip_as (l_as: UN_STRIP_AS) is
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
						create l_depend_unit.make (context.current_class.class_id,
											l_attribute_i)
						context.supplier_ids.extend (l_depend_unit)
						if l_needs_byte_node then
							l_strip.feature_ids.put (l_attribute_i.feature_id)
						end
					end
				end
				l_as.id_list.go_i_th (l_index)
				l_as.id_list.forth
			end
			last_type := strip_type
			if l_needs_byte_node then
				last_byte_node := l_strip
			end
		end

	process_paran_as (l_as: PARAN_AS) is
		local
			l_expr: EXPR_B
		do
			l_as.expr.process (Current)
			if is_byte_node_enabled then
				l_expr ?= last_byte_node
				create {PARAN_B} last_byte_node.make (l_expr)
			end
		end

	process_expr_call_as (l_as: EXPR_CALL_AS) is
		local
			l_vkcn3: VKCN3
		do
			reset_for_unqualified_call_checking
			l_as.call.process (Current)
			if last_type.is_void then
				create l_vkcn3
				context.init_error (l_vkcn3)
				l_vkcn3.set_location (l_as.call.end_location)
				error_handler.insert_error (l_vkcn3)
				error_handler.raise_error
			end

			-- Nothing to be done for `last_byte_node' as it was computed in previous call
			-- `l_as.call.process'.
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS) is
		local
			l_expr: EXPR_B
		do
			l_as.expr.process (Current)
			last_type := pointer_type
			if is_byte_node_enabled then
				l_expr ?= last_byte_node
				create {EXPR_ADDRESS_B} last_byte_node.make (l_expr)
			end
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS) is
		local
			l_vrle3: VRLE3
			l_veen2a: VEEN2A
			l_type: TYPE_A
		do
			if
				is_checking_invariant or else not current_feature.has_return_value
			then
					-- It means that we are in a location where `Result' is not
					-- acceptable (e.g. an invariant, or within the body of a procedure).
				create l_vrle3
				context.init_error (l_vrle3)
				l_vrle3.set_location (l_as.start_location)
				error_handler.insert_error (l_vrle3)
					-- Cannot go on here
				error_handler.raise_error
			elseif is_checking_precondition then
					-- Result entity in precondition
				create l_veen2a
				context.init_error (l_veen2a)
				l_veen2a.set_location (l_as.start_location)
				error_handler.insert_error (l_veen2a)
			end
			l_type ?= current_feature.type
			create {TYPED_POINTER_A} last_type.make_typed (l_type)
			if is_byte_node_enabled then
				create {HECTOR_B} last_byte_node.make (create {RESULT_B})
			end
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS) is
		local
			l_like_current: LIKE_CURRENT
		do
			l_like_current := context.current_class_type
			create {TYPED_POINTER_A} last_type.make_typed (l_like_current)
			if is_byte_node_enabled then
				create {HECTOR_B} last_byte_node.make (create {CURRENT_B})
			end
		end

	process_address_as (l_as: ADDRESS_AS) is
		local
			l_access: ACCESS_B
			l_argument: ARGUMENT_B
			l_local: LOCAL_B
			l_local_info: LOCAL_INFO
			l_unsupported: NOT_SUPPORTED
			l_feature: FEATURE_I
			l_vzaa1: VZAA1
			l_veen: VEEN
			l_veen2b: VEEN2B
			l_arg_pos: INTEGER
			l_last_id: INTEGER
			l_type: TYPE_A
			l_depend_unit: DEPEND_UNIT
			l_needs_byte_node: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled

				-- Initialization of the type stack
			reset_for_unqualified_call_checking

			l_last_id := context.current_class.class_id

			l_feature := current_feature
				-- Look for an argument
			if l_feature /= Void then
				l_arg_pos := l_feature.argument_position (l_as.feature_name.internal_name)
			end
			if l_arg_pos /= 0 then
					-- Found argument
				l_type ?= l_feature.arguments.i_th (l_arg_pos)
				l_type := l_type.actual_type.instantiation_in (last_type, l_last_id)
				create {TYPED_POINTER_A} last_type.make_typed (l_type)
				if l_needs_byte_node then
					create l_argument
					l_argument.set_position (l_arg_pos)
					create {HECTOR_B} last_byte_node.make_with_type (l_argument, last_type.type_i)
				end
			else
					-- Look for a local if not in a pre- or postcondition
				l_local_info := context.locals.item (l_as.feature_name.internal_name)
				if l_local_info /= Void then
						-- Local found
					l_local_info.set_is_used (True)
					l_type := l_local_info.type
					l_type := l_type.instantiation_in (last_type, l_last_id)
					create {TYPED_POINTER_A} last_type.make_typed (l_type)
					if l_needs_byte_node then
						create l_local
						l_local.set_position (l_local_info.position)
						create {HECTOR_B} last_byte_node.make_with_type (l_local, last_type.type_i)
					end

					if is_checking_postcondition or else is_checking_precondition then
							-- Local in post- or precondition
							--|Note: this should not happen since
							--|in the context of assertions we would have
							--|ACCESS_ASSERT_AS and not ACCESS_ID_AS objects.
							--|(Fred)
						create l_veen2b
						context.init_error (l_veen2b)
						l_veen2b.set_identifier (l_as.feature_name.internal_name)
						l_veen2b.set_location (l_as.feature_name.start_location)
						error_handler.insert_error (l_veen2b)
					end
				else
					l_feature := context.current_class.feature_table.item (l_as.feature_name.internal_name)
					if l_feature = Void then
						create l_veen
						context.init_error (l_veen)
						l_veen.set_identifier (l_as.feature_name.internal_name)
						l_veen.set_location (l_as.feature_name.start_location)
						error_handler.insert_error (l_veen)
					else
						if l_feature.is_constant then
							create l_vzaa1
							context.init_error (l_vzaa1)
							l_vzaa1.set_address_name (l_as.feature_name.internal_name)
							l_vzaa1.set_location (l_as.feature_name.start_location)
							error_handler.insert_error (l_vzaa1)
						elseif l_feature.is_external then
							create l_unsupported
							context.init_error (l_unsupported)
							l_unsupported.set_message ("The $ operator is not supported on externals.")
							l_unsupported.set_location (l_as.feature_name.start_location)
							error_handler.insert_error (l_unsupported)
						elseif l_feature.is_attribute then
							l_type ?= l_feature.type
							l_type := l_type.actual_type
							create {TYPED_POINTER_A} last_type.make_typed (l_type)
						else
							last_type := Pointer_type
						end

							-- Dependance
						create l_depend_unit.make_with_level (l_last_id, l_feature, depend_unit_level)
						context.supplier_ids.extend (l_depend_unit)

						if l_needs_byte_node then
							if l_feature.is_attribute then
								l_access := l_feature.access (l_type.type_i)
								create {HECTOR_B} last_byte_node.make_with_type (l_access, last_type.type_i)
							else
								create {ADDRESS_B} last_byte_node.make (context.current_class.class_id, l_feature)
							end
						end
					end
				end
			end
			instantiator.dispatch (last_type, context.current_class)
			error_handler.checksum
		end

	process_type_expr_as (l_as: TYPE_EXPR_AS) is
 		local
			l_type: TYPE_A
			l_type_type: GEN_TYPE_A
		do
			l_as.type.process (Current)
			l_type := last_type

				-- Check validity of type declaration
			type_checker.check_type_validity (l_type, l_as.type)

			create l_type_type.make (system.type_class.compiled_class.class_id, << l_type >>)
			instantiator.dispatch (l_type_type, context.current_class)
			last_type := l_type_type
			if is_byte_node_enabled then
				create {TYPE_EXPR_B} last_byte_node.make (l_type_type.type_i)
			end
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS) is
		local
			l_class: CLASS_C
			l_feature: FEATURE_I
			l_table: FEATURE_TABLE
			l_unsupported: NOT_SUPPORTED
			l_target_type: TYPE_A
			l_target_node: BYTE_NODE
			l_needs_byte_node: BOOLEAN
			l_feature_name: ID_AS
			l_access: ACCESS_B
			l_open: OPEN_TYPE_A
		do
			l_needs_byte_node := is_byte_node_enabled

				-- Type check the target
			reset_for_unqualified_call_checking

			if l_as.target = Void then
					-- Target is the open operand `Current'.
				l_target_type := context.current_class_type
			else
				l_as.target.process (Current)
				l_target_type := last_type
				l_open ?= l_target_type
				if l_open /= Void then
						-- Target is the closed operand `Current'.
					l_target_type := context.current_class_type
					create {CURRENT_B} l_target_node
				elseif l_needs_byte_node then
					l_target_node := last_byte_node
				end
			end

			l_feature_name := l_as.feature_name
			l_class := l_target_type.associated_class

			if l_target_type.is_formal or l_target_type.is_basic then
					-- Not supported. May change in the future - M.S.
					-- Reason: We cannot call a feature with basic call target!
				create l_unsupported
				context.init_error (l_unsupported)
				l_unsupported.set_message ("Type of target in a agent call may not be a basic type or a formal.")
				if l_as.target /= Void then
					l_unsupported.set_location (l_as.target.start_location)
				else
					l_unsupported.set_location (l_feature_name)
				end
				error_handler.insert_error (l_unsupported)
				error_handler.raise_error
			end

				-- Type check the call
			process_call (l_target_type, Void, l_feature_name, Void, l_as.operands, False, True, l_as.has_target, False)

				-- Check that it's a function or procedure
				-- which is not external.
			l_table := l_class.feature_table
			l_feature := l_table.item (l_feature_name)
			if (l_feature = Void) or else (not l_feature.is_routine or else l_feature.is_external) then
				create l_unsupported
				context.init_error (l_unsupported)
				l_unsupported.set_message ("Agent creation on `" + l_feature_name + "' is%
					% not supported because it is either an attribute, a constant or%
					% an external feature")
				l_unsupported.set_location (l_feature_name)
				error_handler.insert_error (l_unsupported)
			else
				l_access ?= last_byte_node
				compute_routine (l_table, l_feature, l_class.class_id, l_target_type, last_type,
					l_as, l_access, l_target_node)
				System.instantiator.dispatch (last_type, context.current_class)
			end
			error_handler.checksum
		end

	process_unary_as (l_as: UNARY_AS) is
		require
			l_as_not_void: l_as /= Void
		local
			l_prefix_feature: FEATURE_I
			l_prefix_feature_type, l_last_constrained: TYPE_A
			l_last_class: CLASS_C
			l_depend_unit: DEPEND_UNIT
			l_vwoe: VWOE
			l_vuex: VUEX
			l_vape: VAPE
			l_manifest: MANIFEST_INTEGER_A
			l_value: ATOMIC_AS
			l_needs_byte_node: BOOLEAN
			l_expr: EXPR_B
			l_access: ACCESS_B
			l_unary: UNARY_B
			l_is_assigner_call: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled

				-- Reset assigner call flag
			l_is_assigner_call := is_assigner_call
			is_assigner_call := False

				-- Check operand
			l_as.expr.process (Current)
			l_last_constrained := constrained_type (last_type.actual_type)
			if l_needs_byte_node then
				l_expr ?= last_byte_node
			end
			if l_last_constrained.is_none then
				create l_vuex.make_for_none (l_as.prefix_feature_name)
				context.init_error (l_vuex)
				l_vuex.set_location (l_as.expr.end_location)
				error_handler.insert_error (l_vuex)
					-- Cannot go on here
				error_handler.raise_error
			end

			l_last_class := l_last_constrained.associated_class
			l_prefix_feature := l_last_class.feature_table.alias_item (l_as.prefix_feature_name)

			if l_prefix_feature = Void then
					-- Error: not prefixed function found
				create l_vwoe
				context.init_error (l_vwoe)
				l_vwoe.set_other_class (l_last_class)
				l_vwoe.set_op_name (l_as.prefix_feature_name)
				l_vwoe.set_location (l_as.operator_location)
				error_handler.insert_error (l_vwoe)
					-- Cannot go on here.
				error_handler.raise_error
			end

				-- Export validity
			if
				not (context.is_ignoring_export or l_prefix_feature.is_exported_for (l_last_class))
			then
				create l_vuex
				context.init_error (l_vuex)
				l_vuex.set_static_class (l_last_class)
				l_vuex.set_exported_feature (l_prefix_feature)
				l_vuex.set_location (l_as.operator_location)
				error_handler.insert_error (l_vuex)
				error_handler.raise_error
			end

			if
				not System.do_not_check_vape and then is_checking_precondition and then
				not current_feature.export_status.is_subset (l_prefix_feature.export_status)
			then
					-- In precondition and checking for vape
				create l_vape
				context.init_error (l_vape)
				l_vape.set_exported_feature (current_feature)
				l_vape.set_location (l_as.operator_location)
				error_handler.insert_error (l_vape)
				error_handler.raise_error
			end

				-- Suppliers update
			create l_depend_unit.make_with_level (l_last_class.class_id, l_prefix_feature, depend_unit_level)
			context.supplier_ids.extend (l_depend_unit)

				-- Assumes here that a prefix feature has no argument
				-- Update the type stack; instantiate the result of the
				-- refixed feature
			l_prefix_feature_type ?= l_prefix_feature.type
			if l_last_constrained.is_bits and then l_prefix_feature_type.is_like_current then
					-- For feature prefix "not" of symbolic class BIT_REF.
				l_prefix_feature_type := l_last_constrained
			else
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
					l_manifest ?= l_last_constrained
					l_value ?= l_as.expr
					if l_value /= Void and l_manifest /= Void then
						l_prefix_feature_type := l_last_constrained
					else
							-- Usual case
						l_prefix_feature_type := l_prefix_feature_type.instantiation_in
										(last_type, l_last_class.class_id).actual_type
					end
				else
						-- Usual case
					l_prefix_feature_type := l_prefix_feature_type.instantiation_in
									(last_type, l_last_class.class_id).actual_type
				end
			end
			if l_is_assigner_call then
				process_assigner_command (l_last_class.class_id, l_prefix_feature)
			end

			if l_needs_byte_node then
				l_access := l_prefix_feature.access (l_prefix_feature_type.type_i)
					-- If we have something like `a.f' where `a' is predefined
					-- and `f' is a constant then we simply generate a byte
					-- node that will be the constant only. Otherwise if `a' is
					-- not predefined and `f' is a constant, we generate the
					-- complete evaluation `a.f'. However during generation,
					-- we will do an optimization by hardwiring value of constant.
				if not (l_access.is_constant and l_expr.is_predefined) then
					l_unary := byte_anchor.unary_node (l_as)
					l_unary.set_expr (l_expr)
					l_unary.init (l_access)
					last_byte_node := l_unary
				else
					last_byte_node := l_access
				end
			end

			last_type := l_prefix_feature_type
		end

	process_un_free_as (l_as: UN_FREE_AS) is
		do
			process_unary_as (l_as)
		end

	process_un_minus_as (l_as: UN_MINUS_AS) is
		do
			process_unary_as (l_as)
		end

	process_un_not_as (l_as: UN_NOT_AS) is
		do
			process_unary_as (l_as)
		end

	process_un_old_as (l_as: UN_OLD_AS) is
		local
			l_vaol1: VAOL1
			l_vaol2: VAOL2
			l_saved_vaol_check: BOOLEAN
			l_expr: EXPR_B
			l_un_old: UN_OLD_B
		do
			if not is_checking_postcondition then
					-- Old expression found somewhere else that in a
					-- postcondition
				create l_vaol1
				context.init_error (l_vaol1)
				l_vaol1.set_location (l_as.expr.start_location)
				error_handler.insert_error (l_vaol1)
				error_handler.raise_error
			end

			l_saved_vaol_check := check_for_vaol
			if not l_saved_vaol_check then
					-- Set flag for vaol check.
					-- Check for an old expression within
					-- an old expression.
				check_for_vaol := True
			end
				-- Expression type check
			l_as.expr.process (Current)
			if not l_saved_vaol_check then
					-- Reset flag for vaol check
				check_for_vaol := False
			end

			if last_type.conform_to (Void_type) or else check_for_vaol then
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

			if not l_saved_vaol_check then
					-- Reset flag for vaol check
				check_for_vaol := False
			end
		end

	process_un_plus_as (l_as: UN_PLUS_AS) is
		do
			process_unary_as (l_as)
		end

	process_binary_as (l_as: BINARY_AS) is
		require
			l_as_not_void: l_as /= Void
		local
			l_infix_type: TYPE_A
			l_left_type, l_right_type: TYPE_A
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
			l_is_assigner_call: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled

				-- Reset assigner call
			l_is_assigner_call := is_assigner_call
			is_assigner_call := False

				-- First type check the left operand
			l_as.left.process (Current)
			l_left_type := last_type.actual_type
			l_left_constrained := constrained_type (l_left_type)
			if l_needs_byte_node then
				l_left_expr ?= last_byte_node
			end

				-- Check if target is not of type NONE
			if l_left_constrained.is_none then
				create l_vuex.make_for_none (l_as.infix_function_name)
				context.init_error (l_vuex)
				l_vuex.set_location (l_as.operator_location)
				error_handler.insert_error (l_vuex)
				error_handler.raise_error
			end

				-- Then type check the right operand
			l_as.right.process (Current)
			l_right_type := last_type.actual_type
			l_right_constrained := constrained_type (l_right_type)
			if l_needs_byte_node then
				l_right_expr ?= last_byte_node
			end

				-- Conformance: take care of constrained genericity and
				-- of the balancing rule for the simple numeric types

			if is_infix_valid (l_left_type, l_right_type, l_as.infix_function_name) then
			else
				l_error := last_infix_error
				if l_left_type.convert_to (context.current_class, l_right_type) then
					l_target_conv_info := context.last_conversion_info
					if not is_infix_valid (l_right_type, l_right_type, l_as.infix_function_name) then
						l_target_conv_info := Void
					end
				end
			end

			if last_infix_feature = Void then
					-- Raise error here
				l_error.set_location (l_as.operator_location)
				error_handler.insert_error (l_error)
				error_handler.raise_error
			else
					-- Process conversion if any.
				if l_target_conv_info /= Void then
					l_left_id := l_right_constrained.associated_class.class_id
					if l_target_conv_info.has_depend_unit then
						context.supplier_ids.extend (l_target_conv_info.depend_unit)
					end
					l_target_type := l_target_conv_info.target_type
					if l_needs_byte_node then
						l_left_expr := l_target_conv_info.byte_node (l_left_expr)
					end
				else
					l_left_id := l_left_constrained.associated_class.class_id
					l_target_type := l_left_type
				end

				if last_infix_argument_conversion_info /= Void then
					if last_infix_argument_conversion_info.has_depend_unit then
						context.supplier_ids.extend (last_infix_argument_conversion_info.depend_unit)
					end
					if l_needs_byte_node then
						l_right_expr ?= last_infix_argument_conversion_info.byte_node (l_right_expr)
					end
				end

					-- Suppliers update
				create l_depend_unit.make_with_level (l_left_id, last_infix_feature, depend_unit_level)
				context.supplier_ids.extend (l_depend_unit)

					-- Update the type stack: instantiate result type of the
					-- infixed feature
				l_infix_type ?= last_infix_feature.type
				if
					l_target_type.is_bits and then l_right_constrained.is_bits and then
					l_infix_type.is_like_current
				then
						-- For non-balanced features of symbolic class BIT_REF
						-- like infix "^" or infix "#"
					l_infix_type := l_target_type
				else
						-- Usual case
					l_infix_type := l_infix_type.instantiation_in (l_target_type, l_left_id).actual_type
				end

				if l_is_assigner_call then
					process_assigner_command (l_left_id, last_infix_feature)
				end

				if l_needs_byte_node then
					l_binary := byte_anchor.binary_node (l_as)
					l_binary.set_left (l_left_expr)
					l_binary.set_right (l_right_expr)
					l_call_access ?= last_infix_feature.access (l_infix_type.type_i)
					l_binary.init (l_call_access)
						-- Add type to `parameters' in case we will need it later.
					l_binary.set_attachment (last_infix_arg_type.type_i)
					last_byte_node := l_binary
				end
				last_type := l_infix_type
			end
			last_infix_error := Void
			last_infix_feature := Void
			last_infix_arg_type := Void
			last_infix_argument_conversion_info := Void
		end

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_free_as (l_as: BIN_FREE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_implies_as (l_as: BIN_IMPLIES_AS) is
		local
			l_implies: B_IMPLIES_B
			l_bool_val: VALUE_I
			l_old_expr: like old_expressions
		do
			l_old_expr := old_expressions
			old_expressions := Void
			process_binary_as (l_as)
			if is_byte_node_enabled then
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

	process_bin_or_as (l_as: BIN_OR_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_or_else_as (l_as: BIN_OR_ELSE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_xor_as (l_as: BIN_XOR_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_ge_as (l_as: BIN_GE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_gt_as (l_as: BIN_GT_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_le_as (l_as: BIN_LE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_lt_as (l_as: BIN_LT_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_div_as (l_as: BIN_DIV_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_minus_as (l_as: BIN_MINUS_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_mod_as (l_as: BIN_MOD_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_plus_as (l_as: BIN_PLUS_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_power_as (l_as: BIN_POWER_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_slash_as (l_as: BIN_SLASH_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_star_as (l_as: BIN_STAR_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_and_as (l_as: BIN_AND_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_eq_as (l_as: BIN_EQ_AS) is
		local
			l_left_type, l_right_type: TYPE_A
			l_left_expr, l_right_expr: EXPR_B
			l_conv_info: CONVERSION_INFO
			l_binary: BINARY_B
			l_vweq: VWEQ
			l_needs_byte_node: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled

				-- First type check the left member
			l_as.left.process (Current)
			l_left_type := last_type
			if l_needs_byte_node then
				l_left_expr ?= last_byte_node
			end

				-- Then type check the right member
			l_as.right.process (Current)
			l_right_type := last_type
			if l_needs_byte_node then
				l_right_expr ?= last_byte_node
			end

				-- Check if `l_left_type' conforms to `l_right_type' or if
				-- `l_right_type' conforms to `l_left_type'.
			if
				not (l_left_type.conform_to (l_right_type.actual_type) or else
				l_right_type.conform_to (l_left_type.actual_type))
			then
				if l_right_type.convert_to (context.current_class, l_left_type.actual_type) then
					l_conv_info := context.last_conversion_info
					if l_conv_info.has_depend_unit then
						context.supplier_ids.extend (l_conv_info.depend_unit)
					end
					if l_needs_byte_node then
						l_right_expr := l_conv_info.byte_node (l_right_expr)
					end
				else
					if l_left_type.convert_to (context.current_class, l_right_type.actual_type) then
						l_conv_info := context.last_conversion_info
						if l_conv_info.has_depend_unit then
							context.supplier_ids.extend (l_conv_info.depend_unit)
						end
						if l_needs_byte_node then
							l_left_expr := l_conv_info.byte_node (l_left_expr)
						end
					else
						create l_vweq
						context.init_error (l_vweq)
						l_vweq.set_left_type (l_left_type)
						l_vweq.set_right_type (l_right_type)
						l_vweq.set_location (l_as.operator_location)
						error_handler.insert_error (l_vweq)
					end
				end
			end

			if l_needs_byte_node then
				l_binary := byte_anchor.binary_node (l_as)
				l_binary.set_left (l_left_expr)
				l_binary.set_right (l_right_expr)
				last_byte_node := l_binary
			end

			last_type := boolean_type
		end

	process_bin_ne_as (l_as: BIN_NE_AS) is
		do
			process_bin_eq_as (l_as)
		end

	process_bracket_as (l_as: BRACKET_AS) is
		local
			was_assigner_call: BOOLEAN
			target_type: TYPE_A
			constrained_target_type: TYPE_A
			target_expr: EXPR_B
			target_access: ACCESS_EXPR_B
			target_class: CLASS_C
			bracket_feature: FEATURE_I
			id_feature_name: ID_AS
			location: LOCATION_AS
			call_b: CALL_B
			nested_b: NESTED_B
			vuex: VUEX
			vwbr: VWBR
		do
				-- Clean assigner call flag for bracket target
			was_assigner_call := is_assigner_call
			is_assigner_call := False

				-- Check target
			l_as.target.process (Current)
			target_type := last_type.actual_type
			constrained_target_type := constrained_type (target_type)
			if is_byte_node_enabled then
				target_expr ?= last_byte_node
			end

				-- Check if target is not of type NONE
			if constrained_target_type.is_none then
				create vuex.make_for_none (bracket_str)
				context.init_error (vuex)
				vuex.set_location (l_as.left_bracket_location)
				error_handler.insert_error (vuex)
				error_handler.raise_error
			end

				-- Check if bracket feature exists
			target_class := constrained_target_type.associated_class
			bracket_feature := target_class.feature_table.alias_item (bracket_str)
			if bracket_feature = Void then
					-- Feature with bracket alias is not found
				create {VWBR1} vwbr
				context.init_error (vwbr)
				vwbr.set_location (l_as.left_bracket_location)
				vwbr.set_target_class (target_class)
				error_handler.insert_error (vwbr)
				error_handler.raise_error
			end

				-- Process arguments
			create id_feature_name.initialize (bracket_feature.feature_name)
			location := l_as.left_bracket_location
			id_feature_name.set_position (location.line, location.column, location.position, location.location_count)
				-- Restore assigner call flag
			is_assigner_call := was_assigner_call
				-- Process call to bracket feature
			process_call (last_type, Void, id_feature_name, bracket_feature, l_as.operands, False, False, True, False)
			error_handler.checksum
			if is_byte_node_enabled then
				create nested_b
				create target_access
				target_access.set_expr (target_expr)
				target_access.set_parent (nested_b)
				call_b ?= last_byte_node
				check
					call_b_not_void: call_b /= Void
				end
				call_b.set_parent (nested_b)
				nested_b.set_message (call_b)
				nested_b.set_target (target_access)
				last_byte_node := nested_b
			end
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS) is
		do
			-- Nothing to be done
		end

	process_feature_as (l_as: FEATURE_AS) is
		local
			l_byte_code: BYTE_CODE
			l_list: BYTE_LIST [BYTE_NODE]
		do
			reset_for_unqualified_call_checking
			l_as.body.process (Current)
			if is_byte_node_enabled then
				l_byte_code ?= last_byte_node
				l_byte_code.set_start_line_number (l_as.start_location.line)
				l_byte_code.set_has_loop (has_loop)
			end
			if l_as.custom_attributes /= Void then
				l_as.custom_attributes.process (Current)
				if is_byte_node_enabled then
					l_list ?= last_byte_node
					l_byte_code.set_custom_attributes (l_list)
				end
			end
			if is_byte_node_enabled then
				last_byte_node := l_byte_code
			end
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
		do
			-- Nothing to be done
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS) is
		do
			-- Nothing to be done
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS) is
		do
			-- Nothing to be done.
		end

	process_feature_list_as (l_as: FEATURE_LIST_AS) is
		do
			-- Nothing to be done
		end

	process_all_as (l_as: ALL_AS) is
		do
			-- Nothing to be done
		end

	process_assign_as (l_as: ASSIGN_AS) is
		local
			l_target_node: ACCESS_B
			l_source_expr: EXPR_B
			l_assign: ASSIGN_B
			l_ve03: VE03
			l_source_type, l_target_type: TYPE_A
			l_vjar: VJAR
			l_vncb: VNCB
		do
				-- Init type stack
			reset_for_unqualified_call_checking

				-- Type check the target
			set_is_in_assignment (True)
			last_access_writable := False
			l_as.target.process (Current)
			set_is_in_assignment (False)
			l_target_type := last_type
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

				-- Type check the source
			l_as.source.process (Current)
			l_source_type := last_type

				-- Type checking
			process_type_compatibility (l_target_type)
			if not is_type_compatible then
				if l_source_type.is_bits then
					create l_vncb
					context.init_error (l_vncb)
					l_vncb.set_target_name (l_as.target.access_name)
					l_vncb.set_source_type (l_source_type)
					l_vncb.set_target_type (l_target_type)
					l_vncb.set_location (l_as.start_location)
					error_handler.insert_error (l_vncb)
				else
					create l_vjar
					context.init_error (l_vjar)
					l_vjar.set_source_type (l_source_type)
					l_vjar.set_target_type (l_target_type)
					l_vjar.set_target_name (l_as.target.access_name)
					l_vjar.set_location (l_as.start_location)
					error_handler.insert_error (l_vjar)
				end
			end

			if is_byte_node_enabled then
				create l_assign
				l_assign.set_target (l_target_node)
				l_assign.set_line_number (l_as.target.start_location.line)
				l_source_expr ?= last_byte_node
				l_assign.set_source (l_source_expr)
				last_byte_node := l_assign
			end
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS) is
		local
			target_byte_node: like last_byte_node
			target_type: like last_type
			target_assigner: like last_assigner_command
			source_byte_node: EXPR_B
			source_type: like last_type
			vbac1: VBAC1
			vbac2: VBAC2
			outer_nested_b: NESTED_B
			inner_nested_b: NESTED_B
			access_b: ACCESS_B
			binary_b: BINARY_B
			unary_b: UNARY_B
			call_b: CALL_B
			arguments: BYTE_LIST [PARAMETER_B]
			argument: PARAMETER_B
			assigner_arguments: BYTE_LIST [PARAMETER_B]
		do
				-- Set assigner call flag for target expression
			is_assigner_call := True
			l_as.target.process (Current)
			check
				assigner_command_computed: not is_assigner_call
			end
			target_byte_node := last_byte_node
			target_type := last_type
			target_assigner := last_assigner_command
			l_as.source.process (Current)
			process_type_compatibility (target_type)
			source_type := last_type
			if not is_type_compatible then
				create vbac1
				context.init_error (vbac1)
				vbac1.set_source_type (source_type)
				vbac1.set_target_type (target_type)
				vbac1.set_location (l_as.start_location)
				error_handler.insert_error (vbac1)
			elseif target_assigner = Void then
				create vbac2
				context.init_error (vbac2)
				vbac2.set_location (l_as.start_location)
				error_handler.insert_error (vbac2)
			end
			if is_byte_node_enabled then
					-- Make sure all byte node is correct
				error_handler.checksum
					-- Preserve source byte node
				source_byte_node ?= last_byte_node
					-- Discriminate over expression kind:
					-- it should be either a qualified call,
					-- a binary or an unary
				outer_nested_b ?= target_byte_node
				binary_b ?= target_byte_node
				unary_b ?= target_byte_node
				if outer_nested_b /= Void then
					call_b := outer_nested_b
						-- Find end of call chain
					from
						inner_nested_b ?= outer_nested_b.message
					until
						inner_nested_b = Void
					loop
						outer_nested_b := inner_nested_b
						inner_nested_b ?= outer_nested_b.message
					end
						-- Evaluate assigner command arguments
					access_b ?= outer_nested_b.message
					check
						access_b_not_void: access_b /= Void
					end
					arguments := access_b.parameters
				elseif binary_b /= Void then
						-- Create call chain
					outer_nested_b := binary_b.nested_b
					call_b := outer_nested_b
						-- Evaluate assigner command arguments
					create arguments.make (1)
					create argument
					argument.set_expression (binary_b.right)
					argument.set_attachment_type (binary_b.attachment)
					arguments.extend (argument)
				else
					check
						unary_b_not_void: unary_b /= Void
					end
						-- Create call chain
					outer_nested_b := unary_b.nested_b
					call_b := outer_nested_b
						-- There are no arguments in unary expression
				end
					-- Evaluate assigner command arguments:
					--   first is a source of an assigner command
					--   next are those from target call
				if arguments = Void then
					create assigner_arguments.make (1)
				else
					create assigner_arguments.make (arguments.count + 1)
				end
				create argument
				argument.set_expression (source_byte_node)
				argument.set_attachment_type (target_type.type_i)
				assigner_arguments.extend (argument)
				if arguments /= Void then
					assigner_arguments.append (arguments)
				end
					-- Evaluate assigner command byte node
				access_b := target_assigner.access (void_type.type_i)
				access_b.set_parameters (assigner_arguments)
					-- Replace end of call chain with an assigner command
				access_b.set_parent (outer_nested_b)
				outer_nested_b.set_message (access_b)
				create {INSTR_CALL_B} last_byte_node.make (call_b, l_as.start_location.line)
			end
		end

	process_reverse_as (l_as: REVERSE_AS) is
		local
			l_target_node: ACCESS_B
			l_source_expr: EXPR_B
			l_reverse: REVERSE_B
			l_ve03: VE03
			l_source_type, l_target_type: TYPE_A
			l_conv_info: CONVERSION_INFO
			l_formal: FORMAL_A
			l_vjrv1: VJRV1
			l_vjrv2: VJRV2
			l_attribute: ATTRIBUTE_B
			l_create_info: CREATE_INFO
		do
				-- Init type stack
			reset_for_unqualified_call_checking

				-- Type check the target
			set_is_in_assignment (True)
			last_access_writable := False
			l_as.target.process (Current)
			set_is_in_assignment (False)
			l_target_type := last_type
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

				-- Type check the source
			l_as.source.process (Current)
			l_source_type := last_type
			if is_byte_node_enabled then
				l_source_expr ?= last_byte_node
				create l_reverse
				l_reverse.set_target (l_target_node)
				l_reverse.set_line_number (l_as.target.start_location.line)
			end

				-- Type checking
			if l_target_type.is_expanded then
				if not System.il_generation then
					create l_vjrv1
					context.init_error (l_vjrv1)
					l_vjrv1.set_target_name (l_as.target.access_name)
					l_vjrv1.set_target_type (l_target_type)
					l_vjrv1.set_location (l_as.target.end_location)
					error_handler.insert_error (l_vjrv1)
				end
			elseif l_target_type.is_formal then
				l_formal ?= l_target_type
				check
					l_formal_not_void: l_formal /= Void
				end
				if not l_formal.is_reference and not system.il_generation then
					create l_vjrv2
					context.init_error (l_vjrv2)
					l_vjrv2.set_target_name (l_as.target.access_name)
					l_vjrv2.set_target_type (l_target_type)
					l_vjrv2.set_location (l_as.target.end_location)
					error_handler.insert_error (l_vjrv2)
				end
			else
					-- Target is a reference, but source is not.
				if l_source_type.is_expanded then
						-- Special case `ref ?= exp' where we convert
						-- `exp' to its associated reference before
						-- doing the assignment.
					if l_source_type.convert_to (context.current_class, l_target_type) then
						l_conv_info := context.last_conversion_info
						if l_conv_info.has_depend_unit then
							context.supplier_ids.extend (l_conv_info.depend_unit)
						end
						if is_byte_node_enabled then
							l_source_expr := l_conv_info.byte_node (l_source_expr)
						end
					end
				elseif l_source_type.is_formal then
						-- Special case `ref ?= formal' where we force
						-- a conversion of the formal to its associated reference
						-- type when `formal' will be instantiated as an expanded
						-- type. Then after the conversion we perform the normal
						-- assignment attempt to the target which is a reference.
					l_formal ?= l_source_type
					if
						l_source_type.convert_to (context.current_class,
							context.current_class.constraint (l_formal.position))
					then
						l_conv_info := context.last_conversion_info
						if l_conv_info.has_depend_unit then
							context.supplier_ids.extend (l_conv_info.depend_unit)
						end
						if is_byte_node_enabled then
							l_source_expr := l_conv_info.byte_node (l_source_expr)
						end
					end
				end
			end

			if is_byte_node_enabled then
				l_reverse.set_source (l_source_expr)
				if l_target_node.is_attribute then
					l_attribute ?= l_target_node
					create {CREATE_FEAT} l_create_info.make (l_attribute.attribute_id,
						l_attribute.routine_id, context.current_class)
				else
					l_create_info := l_target_type.create_info
				end

				l_reverse.set_info (l_create_info)
				last_byte_node := l_reverse
			end
		end

	process_check_as (l_as: CHECK_AS) is
		local
			l_check: CHECK_B
			l_list: BYTE_LIST [BYTE_NODE]
		do
			if l_as.check_list /= Void then
				set_is_checking_check (True)
				l_as.check_list.process (Current)
				set_is_checking_check (False)

				if is_byte_node_enabled then
					l_list ?= last_byte_node
					create l_check
					l_check.set_check_list (l_list)
					l_check.set_line_number (l_as.check_list.start_location.line)
					l_check.set_end_location (l_as.end_keyword)
					last_byte_node := l_check
				end
			elseif is_byte_node_enabled then
				create l_check
				l_check.set_end_location (l_as.end_keyword)
				last_byte_node := l_check
			end
		end

	process_abstract_creation (a_creation_type: TYPE_A; a_call: ACCESS_INV_AS; a_name: STRING; a_location: LOCATION_AS) is
		require
			a_creation_type_not_void: a_creation_type /= Void
			a_location_not_void: a_location /= Void
		local
			l_call_access: CALL_ACCESS_B
			l_formal_type: FORMAL_A
			l_formal_dec: FORMAL_DEC_AS
			l_creation_class: CLASS_C
			l_is_formal_creation, l_is_default_creation: BOOLEAN
			l_dcr_feat: FEATURE_I
			l_orig_call, l_call: ACCESS_INV_AS
			l_vgcc1: VGCC1
			l_vgcc11: VGCC11
			l_vgcc2: VGCC2
			l_vgcc4: VGCC4
			l_vgcc5: VGCC5
			l_creators: HASH_TABLE [EXPORT_I, STRING]
			l_needs_byte_node: BOOLEAN
			l_actual_creation_type: TYPE_A
		do
			l_needs_byte_node := is_byte_node_enabled
			l_orig_call := a_call
			l_actual_creation_type := a_creation_type.actual_type

			if l_actual_creation_type.is_formal then
					-- Cannot be Void
				l_formal_type ?= l_actual_creation_type
					-- Get the corresponding constraint type of the current class
				l_formal_dec := context.current_class.generics.i_th (l_formal_type.position)
				if
					l_formal_dec.has_constraint and then
					l_formal_dec.has_creation_constraint
				then
					l_is_formal_creation := True
						-- Ensure to update `has_default_create' from `l_formal_dec'
					l_formal_dec.constraint_creation_list.do_nothing
				else
						-- An entity of type a formal generic parameter cannot be
						-- created here because there is no creation routine constraints
					create l_vgcc1
					context.init_error (l_vgcc1)
					l_vgcc1.set_target_name (a_name)
					l_vgcc1.set_location (a_location)
					error_handler.insert_error (l_vgcc1);
				end
			end

			error_handler.checksum

			l_creation_class := constrained_type (l_actual_creation_type).associated_class
			if l_creation_class.is_deferred and then not l_is_formal_creation then
					-- Associated class cannot be deferred
				create l_vgcc2
				context.init_error (l_vgcc2)
				l_vgcc2.set_type (a_creation_type)
				l_vgcc2.set_target_name (a_name)
				l_vgcc2.set_location (a_location)
				error_handler.insert_error (l_vgcc2)
				error_handler.raise_error
			end

			if
				l_orig_call = Void and then
				(l_creation_class.allows_default_creation or
				(l_is_formal_creation and then l_formal_dec.has_default_create))
			then
				l_dcr_feat := l_creation_class.default_create_feature

					-- Use default_create
				create {ACCESS_INV_AS} l_call.make (
					create {ID_AS}.initialize (l_dcr_feat.feature_name), Void, Void)
					-- For better error reporting as we insert a dummy call for type checking.
				l_call.feature_name.set_position (a_location.line, a_location.column,
					a_location.position, a_location.location_count)
				if l_is_formal_creation or else not l_dcr_feat.is_empty then
						-- We want to generate a call only when needed:
						-- 1 - In a formal generic creation call
						-- 2 - When body of `default_create' is not empty
					l_orig_call := l_call
				end
				l_is_default_creation := True
			else
				l_call := l_orig_call
			end

			l_creators := l_creation_class.creators

			if l_call /= Void then
					-- Type check the call: as if it was an unqualified call (as export checking
					-- is done later below)
				process_call (last_type, Void, l_call.feature_name, Void, l_call.parameters, False, False, False, False)
					-- We need to reset `last_type' as it now `VOID_A' after checking the call
					-- which a procedure.
				last_type := a_creation_type
				if l_needs_byte_node and then l_orig_call /= Void then
					l_call_access ?= last_byte_node
				end

				if not l_is_formal_creation then
						-- Check if creation routine is non-once procedure
					if
						not l_creation_class.valid_creation_procedure (last_feature_name)
					then
						create l_vgcc5
						context.init_error (l_vgcc5)
						l_vgcc5.set_target_name (a_name)
						l_vgcc5.set_type (a_creation_type)
						l_vgcc5.set_creation_feature (l_creation_class.feature_table.item (last_feature_name))
						l_vgcc5.set_location (l_call.feature_name)
						error_handler.insert_error (l_vgcc5)
					elseif l_creators /= Void then
						if not l_creators.item (last_feature_name).valid_for (context.current_class) then
								-- Creation procedure is not exported
							create l_vgcc5
							context.init_error (l_vgcc5)
							l_vgcc5.set_target_name (a_name)
							l_vgcc5.set_type (a_creation_type)
							l_vgcc5.set_creation_feature (
								l_creation_class.feature_table.item (last_feature_name))
							l_vgcc5.set_location (l_call.feature_name)
							error_handler.insert_error (l_vgcc5)
						end
					end
				else
						-- Check that the creation feature used for creating the generic
						-- parameter has been listed in the constraint for the generic
						-- parameter.
					if not l_formal_dec.has_creation_feature_name (last_feature_name) then
						create l_vgcc11
						context.init_error (l_vgcc11)
						l_vgcc11.set_target_name (a_name)
						l_vgcc11.set_creation_feature (l_creation_class.feature_table.item (last_feature_name))
						l_vgcc11.set_location (l_call.feature_name)
						error_handler.insert_error (l_vgcc11)
					end
				end
			else
				if not l_is_formal_creation then
					if (l_creators = Void) or l_is_default_creation then
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
					error_handler.insert_error (l_vgcc1);
				end
			end
			error_handler.checksum
			if l_needs_byte_node then
				last_byte_node := l_call_access
			end
		end

	process_creation_as (l_as: CREATION_AS) is
		local
			l_access: ACCESS_B
			l_call_access: CALL_ACCESS_B
			l_creation_expr: CREATION_EXPR_B
			l_assign: ASSIGN_B
			l_attribute: ATTRIBUTE_B
			l_target_type, l_explicit_type, l_creation_type: TYPE_A
			l_create_info: CREATE_INFO
			l_vgcc3: VGCC3
			l_vgcc31: VGCC31
			l_vgcc7: VGCC7
			l_needs_byte_node: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled
			reset_for_unqualified_call_checking

				-- Set flag so that depend_unit knows it is used as a creation routine
				-- not just a normal feature call. It is reset as soon as it is processed.
			is_target_of_creation_instruction := True
			last_access_writable := False
			l_as.target.process (Current)
			l_target_type := last_type
			if l_needs_byte_node then
				l_access ?= last_byte_node
			end

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
					type_checker.check_type_validity (l_explicit_type, l_as.type)
				end

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
					error_handler.raise_error
				end

				if
					l_explicit_type /= Void and then
					not l_explicit_type.conform_to (l_target_type)
				then
						-- Specified creation type must conform to
						-- the entity type
					create l_vgcc31
					context.init_error (l_vgcc31)
					l_vgcc31.set_target_name (l_as.target.access_name)
					l_vgcc31.set_type (l_explicit_type)
					l_vgcc31.set_location (l_as.type.start_location)
					error_handler.insert_error (l_vgcc31)
				end

				if l_explicit_type /= Void then
					instantiator.dispatch (l_explicit_type, context.current_class)
					l_creation_type := l_explicit_type
				else
					l_creation_type := l_target_type
				end

					-- Check call validity for creation.
				process_abstract_creation (l_creation_type, l_as.call,
					l_as.target.access_name, l_as.target.start_location)

				if l_needs_byte_node then
					l_call_access ?= last_byte_node

						-- Compute creation information
					if l_creation_type.is_expanded then
							-- Even if there is an anchor, once a type is expanded it
							-- cannot change.
						create {CREATE_TYPE} l_create_info.make (l_creation_type.type_i)
					elseif l_access.is_attribute and l_explicit_type = Void then
							-- When we create an attribute without a type specification,
							-- then we need to create an instance matching the possible redeclared
							-- type of the attribute in descendant classes.
						l_attribute ?= l_access
						create {CREATE_FEAT} l_create_info.make (l_attribute.attribute_id,
							l_attribute.routine_id, context.current_class)
					else
						l_create_info := l_creation_type.create_info
					end

					create l_creation_expr
					l_creation_expr.set_call (l_call_access)
					l_creation_expr.set_info (l_create_info)
					l_creation_expr.set_type (l_creation_type.type_i)
					l_creation_expr.set_line_number (l_as.target.start_location.line)

					create l_assign
					l_assign.set_target (l_access)
					l_assign.set_source (l_creation_expr)
					l_assign.set_line_number (l_as.target.start_location.line)

					last_byte_node := l_assign
				end
			end
			reset_types
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS) is
		local
			l_call_access: CALL_ACCESS_B
			l_creation_expr: CREATION_EXPR_B
			l_creation_type: TYPE_A
			l_create_info: CREATE_INFO
			l_vgcc3: VGCC3
			l_needs_byte_node: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled
			reset_for_unqualified_call_checking

			l_as.type.process (Current)
			l_creation_type := last_type
			type_checker.check_type_validity (l_creation_type, l_as.type)
			if l_creation_type.is_none then
					-- Cannot create instance of NONE.
				create l_vgcc3
				context.init_error (l_vgcc3)
				l_vgcc3.set_type (l_creation_type)
				l_vgcc3.set_location (l_as.type.start_location)
				error_handler.insert_error (l_vgcc3)
			else
				instantiator.dispatch (l_creation_type, context.current_class)

					-- Check call validity for creation.
				is_in_creation_expression := True
				process_abstract_creation (l_creation_type, l_as.call, Void,
					l_as.type.start_location)

				if l_needs_byte_node then
					l_call_access ?= last_byte_node

						-- Compute creation information
					l_create_info := l_creation_type.create_info

					create l_creation_expr
					l_creation_expr.set_call (l_call_access)
					l_creation_expr.set_info (l_create_info)
					l_creation_expr.set_type (l_creation_type.type_i)
					l_creation_expr.set_line_number (l_as.type.start_location.line)

					last_byte_node := l_creation_expr
				end
				last_type := l_creation_type
			end
		end

	process_debug_as (l_as: DEBUG_AS) is
		local
			l_debug: DEBUG_B
			l_list: BYTE_LIST [BYTE_NODE]
			l_node_keys: ARRAYED_LIST [STRING]
		do
			if l_as.compound /= Void then
				l_as.compound.process (Current)
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
					last_byte_node := l_debug
				end
			elseif is_byte_node_enabled then
				create l_debug
				l_debug.set_end_location (l_as.end_keyword)
				last_byte_node := l_debug
			end
		end

	process_if_as (l_as: IF_AS) is
		local
			l_vwbe1: VWBE1
			l_needs_byte_node: BOOLEAN
			l_if: IF_B
			l_expr: EXPR_B
			l_list: BYTE_LIST [BYTE_NODE]
		do
			l_needs_byte_node := is_byte_node_enabled

				-- Type check the test
			l_as.condition.process (Current)
			if l_needs_byte_node then
				create l_if
				l_expr ?= last_byte_node
				l_if.set_condition (l_expr)
			end

				-- Check conformance to boolean
			if not last_type.actual_type.is_boolean then
				create l_vwbe1
				context.init_error (l_vwbe1)
				l_vwbe1.set_type (last_type)
				l_vwbe1.set_location (l_as.condition.end_location)
				error_handler.insert_error (l_vwbe1)
			end

				-- Type check on compound
			if l_as.compound /= Void then
				l_as.compound.process (Current)
				if l_needs_byte_node then
					l_list ?= last_byte_node
					l_if.set_compound (l_list)
				end
			end

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
				l_as.else_part.process (Current)
				if l_needs_byte_node then
					l_list ?= last_byte_node
					l_if.set_else_part (l_list)
				end
			end

			if l_needs_byte_node then
				l_if.set_line_number (l_as.condition.start_location.line)
				l_if.set_end_location (l_as.end_keyword)
				last_byte_node := l_if
			end
		end

	process_inspect_as (l_as: INSPECT_AS) is
		local
			l_vomb1: VOMB1
			l_controler: INSPECT_CONTROL
			l_needs_byte_node: BOOLEAN
			l_inspect: INSPECT_B
			l_expr: EXPR_B
			l_list: BYTE_LIST [BYTE_NODE]
			l_constrained_type: TYPE_A
		do
			l_needs_byte_node := is_byte_node_enabled

			l_as.switch.process (Current)
			if l_needs_byte_node then
				l_expr ?= last_byte_node
				create l_inspect
				l_inspect.set_switch (l_expr)
			end

				-- Type check if it is an expression conform either to
				-- and integer or to a character
			l_constrained_type := constrained_type (last_type.actual_type)
			if
				not l_constrained_type.is_integer and then not l_constrained_type.is_character and then
				not l_constrained_type.is_natural
			then
					-- Error
				create l_vomb1
				context.init_error (l_vomb1)
				l_vomb1.set_type (last_type)
				l_vomb1.set_location (l_as.switch.end_location)
				error_handler.insert_error (l_vomb1)
					-- Cannot go on here
				error_handler.raise_error
			end

				-- Initialization of the multi-branch controler
			create l_controler.make (l_constrained_type)
			inspect_controlers.put_front (l_controler)

			if l_as.case_list /= Void then
				l_as.case_list.process (Current)
				if l_needs_byte_node then
					l_list ?= last_byte_node
					l_list := l_list.remove_voids
					l_inspect.set_case_list (l_list)
				end
			end

			if l_as.else_part /= Void then
				l_as.else_part.process (Current)
				if l_needs_byte_node then
					l_list ?= last_byte_node
					l_inspect.set_else_part (l_list)
				end
			end
			if l_needs_byte_node then
				l_inspect.set_line_number (l_as.switch.start_location.line)
				l_inspect.set_end_location (l_as.end_keyword)
				last_byte_node := l_inspect
			end
			inspect_controlers.start
			inspect_controlers.remove
		end

	process_instr_call_as (l_as: INSTR_CALL_AS) is
		local
			l_vkcn1: VKCN1
			l_call: CALL_B
		do
			reset_for_unqualified_call_checking
			l_as.call.process (Current)
			if not last_type.conform_to (void_type) then
				create l_vkcn1
				context.init_error (l_vkcn1)
				l_vkcn1.set_location (l_as.call.end_location)
				error_handler.insert_error (l_vkcn1)
			elseif is_byte_node_enabled then
				l_call ?= last_byte_node
				create {INSTR_CALL_B} last_byte_node.make (l_call, l_as.call.start_location.line)
			end
		end

	process_loop_as (l_as: LOOP_AS) is
		local
			l_vwbe4: VWBE4
			l_needs_byte_node: BOOLEAN
			l_list: BYTE_LIST [BYTE_NODE]
			l_expr: EXPR_B
			l_loop: LOOP_B
			l_variant: VARIANT_B
		do
			has_loop := True
			l_needs_byte_node := is_byte_node_enabled

			if l_needs_byte_node then
				create l_loop
			end

			if l_as.from_part /= Void then
					-- Type check the from part
				l_as.from_part.process (Current)
				if l_needs_byte_node then
					l_list ?= last_byte_node
					l_loop.set_from_part (l_list)
				end
			end
			if l_as.invariant_part /= Void then
					-- Type check the invariant loop
				l_as.invariant_part.process (Current)
				if l_needs_byte_node then
					l_list ?= last_byte_node
					l_loop.set_invariant_part (l_list)
				end
			end
			if l_as.variant_part /= Void then
					-- Type check th variant loop
				l_as.variant_part.process (Current)
				if l_needs_byte_node then
					l_variant ?= last_byte_node
					l_loop.set_variant_part (l_variant)
				end
			end
				-- Type check the exit test.
			l_as.stop.process (Current)

				-- Check if if is a boolean expression
			if not last_type.actual_type.is_boolean then
				create l_vwbe4
				context.init_error (l_vwbe4)
				l_vwbe4.set_type (last_type)
				l_vwbe4.set_location (l_as.stop.end_location)
				error_handler.insert_error (l_vwbe4)
			elseif l_needs_byte_node then
				l_expr ?= last_byte_node
				l_loop.set_stop (l_expr)
			end

			if l_as.compound /= Void then
					-- Type check the loop compound
				l_as.compound.process (Current)
				if l_needs_byte_node then
					l_list ?= last_byte_node
					l_loop.set_compound (l_list)
				end
			end

			if l_needs_byte_node then
				l_loop.set_line_number (l_as.stop.start_location.line)
				l_loop.set_end_location (l_as.end_keyword)
				last_byte_node := l_loop
			end

				-- Record loop for optimizations in final mode
			system.optimization_tables.force (
				create {OPTIMIZE_UNIT}.make (context.current_class.class_id,
					current_feature.body_index))
		end

	process_retry_as (l_as: RETRY_AS) is
		local
			l_vxrt: VXRT
		do
			if not is_in_rescue then
					-- Retry instruction outside a recue clause
				create l_vxrt
				context.init_error (l_vxrt)
				l_vxrt.set_location (l_as.start_location)
				error_handler.insert_error (l_vxrt)
			elseif is_byte_node_enabled then
				create {RETRY_B} last_byte_node.make (l_as.line)
			end
		end

	process_external_as (l_as: EXTERNAL_AS) is
		local
			l_external: EXTERNAL_I
		do
			l_as.language_name.extension.type_check (l_as)
			if is_byte_node_enabled then
				l_external ?= current_feature
				if l_external = Void then
					create {DEF_BYTE_CODE} last_byte_node
				else
					create {EXT_BYTE_CODE} last_byte_node.make (l_external.external_name_id)
				end
			end
		end

	process_deferred_as (l_as: DEFERRED_AS) is
		do
			if is_byte_node_enabled then
				create {DEF_BYTE_CODE} last_byte_node
			end
		end

	process_do_as (l_as: DO_AS) is
		local
			l_list: BYTE_LIST [BYTE_NODE]
			l_std_byte_code: STD_BYTE_CODE
			l_needs_byte_node: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled
			if l_as.compound /= Void then
				l_as.compound.process (Current)
				if l_needs_byte_node then
					l_list ?= last_byte_node
				end
			end
			if l_needs_byte_node then
				create l_std_byte_code
				l_std_byte_code.set_compound (l_list)
				last_byte_node := l_std_byte_code
			end
		end

	process_once_as (l_as: ONCE_AS) is
		local
			l_list: BYTE_LIST [BYTE_NODE]
			l_once_byte_code: ONCE_BYTE_CODE
			l_body: FEATURE_AS
			l_needs_byte_node: BOOLEAN
		do
			l_needs_byte_node := is_byte_node_enabled
			if l_as.compound /= Void then
				l_as.compound.process (Current)
				if l_needs_byte_node then
					l_list ?= last_byte_node
				end
			end
			if context.current_class.is_generic then
				error_handler.insert_warning (
					create {ONCE_IN_GENERIC_WARNING}.make (context.current_class, current_feature))
			end
			if l_needs_byte_node then
				create l_once_byte_code
				l_once_byte_code.set_compound (l_list)
				l_body := current_feature.body
				check
					l_body_not_void: l_body /= Void
				end

				if l_body.indexes /= Void then
					l_once_byte_code.set_is_global_once (l_body.indexes.has_global_once)
				end

				last_byte_node := l_once_byte_code
			end
		end

	process_type_dec_as (l_as: TYPE_DEC_AS) is
		do
			last_type := type_checker.solved_type (l_as.type)
			fixme ("what do we do about the identifiers?")
		end

	process_class_as (l_as: CLASS_AS) is
		do
			-- Nothing to be done
		end

	process_parent_as (l_as: PARENT_AS) is
		do
			-- Nothing to be done
		end

	process_like_id_as (l_as: LIKE_ID_AS) is
		do
			last_type := type_checker.solved_type (l_as)
		end

	process_like_cur_as (l_as: LIKE_CUR_AS) is
		do
			last_type := type_checker.solved_type (l_as)
		end

	process_formal_as (l_as: FORMAL_AS) is
		do
			last_type := type_checker.solved_type (l_as)
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS) is
		do
			-- Nothing to be done
		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		do
			last_type := type_checker.solved_type (l_as)
		end

	process_none_type_as (l_as: NONE_TYPE_AS) is
		do
			last_type := type_checker.solved_type (l_as)
		end

	process_bits_as (l_as: BITS_AS) is
		do
			last_type := type_checker.solved_type (l_as)
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS) is
		do
			last_type := type_checker.solved_type (l_as)
		end

	process_rename_as (l_as: RENAME_AS) is
		do
			-- Nothing to be done
		end

	process_invariant_as (l_as: INVARIANT_AS) is
		do
			if l_as.assertion_list /= Void then
				reset_for_unqualified_call_checking
				set_is_checking_invariant (True)
				l_as.assertion_list.process (Current)
				set_is_checking_invariant (False)
			else
				last_byte_node := Void
			end
		end

	process_interval_as (l_as: INTERVAL_AS) is
		do
			inspect_control.process_interval (l_as)
			if is_byte_node_enabled then
				last_byte_node := inspect_control.last_interval_byte_node
			end
		end

	process_index_as (l_as: INDEX_AS) is
		do
			l_as.index_list.process (Current)
			fixme ("is this really needed here?")
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS) is
		do
			-- Nothing to be done
		end

	process_elseif_as (l_as: ELSIF_AS) is
		local
			l_vwbe2: VWBE2
			l_needs_byte_node: BOOLEAN
			l_expr: EXPR_B
			l_list: BYTE_LIST [BYTE_NODE]
			l_elsif: ELSIF_B
		do
			l_needs_byte_node := is_byte_node_enabled

				-- Type check test first
			l_as.expr.process (Current)

				-- Check conformance to boolean
			if not last_type.actual_type.is_boolean then
				create l_vwbe2
				context.init_error (l_vwbe2)
				l_vwbe2.set_type (last_type)
				l_vwbe2.set_location (l_as.expr.end_location)
				error_handler.insert_error (l_vwbe2)
			else
				if l_needs_byte_node then
					l_expr ?= last_byte_node
					create l_elsif
					l_elsif.set_expr (l_expr)
				end

					-- Type check on compound
				if l_as.compound /= Void then
					l_as.compound.process (Current)
					if l_needs_byte_node then
						l_list ?= last_byte_node
						l_elsif.set_compound (l_list)
					end
				end

				if l_needs_byte_node then
					l_elsif.set_line_number (l_as.expr.start_location.line)
					last_byte_node := l_elsif
				end
			end
		end

	process_create_as (l_as: CREATE_AS) is
		do
			-- Nothing to be done
		end

	process_client_as (l_as: CLIENT_AS) is
		do
			-- Nothing to be done
		end

	process_case_as (l_as: CASE_AS) is
		local
			l_intervals: SORTABLE_ARRAY [INTERVAL_B]
			l_interval: INTERVAL_B
			l_next_interval: INTERVAL_B
			l_tmp: BYTE_LIST [INTERVAL_B]
			i, j, nb: INTEGER
			l_case: CASE_B
			l_list: BYTE_LIST [BYTE_NODE]
		do
			if not is_byte_node_enabled then
				l_as.interval.process (Current)
				if l_as.compound /= Void then
					l_as.compound.process (Current)
				end
			else
						-- Collect all intervals in an array
				from
					nb := l_as.interval.count
					i := nb
					j := nb + 1
					create l_intervals.make (1, i)
				until
					i <= 0
				loop
					l_as.interval.i_th (i).process (Current)
					l_interval ?= last_byte_node
					if l_interval /= Void then
						j := j - 1
						l_intervals.put (l_interval, j)
					end
					i := i - 1
				end
				if j <= nb then
						-- Array of intervals is not empty
					if j > 1 then
							-- Remove voids
						fixme ("Replace the following instruction with a call to ARRAY.resize as soon as it allows to shrink.")
						l_intervals := l_intervals.subarray (j, nb)
					end
						-- Sort an array
					l_intervals.sort
						-- Copy intervals to `l_tmp' merging adjacent intervals
					from
						create l_tmp.make (nb - j + 1)
						l_interval := l_intervals.item (j)
						l_tmp.extend (l_interval)
						j := j + 1
					until
						j > nb
					loop
						l_next_interval := l_intervals.item (j)
						if l_interval.upper.is_next (l_next_interval.lower) then
								-- Merge intervals
							l_interval.set_upper (l_next_interval.upper)
						else
								-- Add new interval
							l_interval := l_next_interval
							l_tmp.extend (l_interval)
						end
						j := j + 1
					end
					create l_case
					l_case.set_interval (l_tmp)
					if l_as.compound /= Void then
						l_as.compound.process (Current)
						l_list ?= last_byte_node
						l_case.set_compound (l_list)
					end
					l_case.set_line_number (l_as.interval.start_location.line)
				end
				last_byte_node := l_case
			end
		end

	process_ensure_as (l_as: ENSURE_AS) is
		do
			if l_as.assertions /= Void then
				l_as.assertions.process (Current)
			end
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS) is
		do
			if l_as.assertions /= Void then
				l_as.assertions.process (Current)
			end
		end

	process_require_as (l_as: REQUIRE_AS) is
		do
			if l_as.assertions /= Void then
				l_as.assertions.process (Current)
			end
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS) is
		do
			if l_as.assertions /= Void then
				l_as.assertions.process (Current)
			end
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS) is
		do
			-- Nothing to be done
		end

	process_use_list_as (l_as: USE_LIST_AS) is
		do
			-- Nothing to be done
		end

	process_void_as (l_as: VOID_AS) is
		local
			l_class: CLASS_C
			l_vica2: VICA2
		do
			if is_checking_cas then
					-- When we have Void, it is only valid, if target is
					-- an array type.
				l_class := current_target_type.associated_class
				if l_class = Void or else l_class.class_id /= system.native_array_id then
					create l_vica2.make (context.current_class, current_feature)
					l_vica2.set_location (l_as.start_location)
					error_handler.insert_error (l_vica2)
				end
			end
			last_type := none_type
			if is_byte_node_enabled then
				create {VOID_B} last_byte_node
			end
		end

feature {NONE} -- Predefined types

	string_type: CL_TYPE_A is
			-- Actual string type
		once
			Result := system.string_class.compiled_class.actual_type
		end

	strip_type: GEN_TYPE_A is
			-- Type of strip expression (ARRAY [ANY])
		require
			any_compiled: system.any_class.is_compiled
			array_compiled: system.array_class.is_compiled
		local
			generics: ARRAY [TYPE_A]
			any_type: CL_TYPE_A
		once
			create generics.make (1,1)
			create any_type.make (system.any_id)
			generics.put (any_type, 1)

			create Result.make (system.array_id, generics)
		end

feature {NONE} -- Implementation

	process_expressions_list (l_as: EIFFEL_LIST [EXPR_AS]) is
			-- Process `l_as' as an EIFFEL_LIST but also set `last_expressions_type' accordingly.
			-- Use `current_target_type' for proper evaluation of manifest arrays.
		require
			l_as_not_void: l_as /= Void
		local
			l_cursor: INTEGER
			l_list: BYTE_LIST [EXPR_B]
			l_expr: EXPR_B
			l_type_list: like last_expressions_type
			i, nb: INTEGER
			l_cur_type: like current_target_type
		do
			l_cursor := l_as.index
			l_as.start
			i := 1
			nb := l_as.count
			create l_type_list.make (1, nb)
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
					l_expr ?= last_byte_node
					check
						l_expr_not_void: l_expr /= Void
					end
					l_list.extend (l_expr)
					l_type_list.put (last_type, i)
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
					l_type_list.put (last_type, i)
					i := i + 1
					l_as.forth
				end
			end
			last_expressions_type := l_type_list
			l_as.go_i_th (l_cursor)
		ensure
			last_expressions_type_not_void: last_expressions_type /= Void
			last_expressions_type_computed: old last_expressions_type /= last_expressions_type
			last_expressions_type_valid_count: last_expressions_type.count = l_as.count
			last_byte_node_valid: is_byte_node_enabled implies
				((old last_byte_node /= last_byte_node) and then last_byte_node /= Void)
		end

	process_expressions_list_for_tuple (l_as: EIFFEL_LIST [EXPR_AS]) is
			-- Process `l_as' as an EIFFEL_LIST but also set `last_expressions_type' accordingly.
			-- Use `current_target_type' for proper evaluation of manifest arrays.
		require
			l_as_not_void: l_as /= Void
		local
			l_cursor: INTEGER
			l_list: BYTE_LIST [EXPR_B]
			l_expr: EXPR_B
			l_type_list: like last_expressions_type
			i, nb: INTEGER
			l_tuple_type: TUPLE_TYPE_A
			l_types: ARRAY [TYPE_A]
		do
			l_cursor := l_as.index
			l_as.start
			i := 1
			nb := l_as.count
			create l_type_list.make (1, nb)
			l_tuple_type ?= current_target_type
			if l_tuple_type /= Void then
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
					if l_types /= Void and then l_types.valid_index (i) then
						current_target_type := l_types.item (i)
					else
						current_target_type := Void
					end
					l_as.item.process (Current)
					l_expr ?= last_byte_node
					check
						l_expr_not_void: l_expr /= Void
					end
					l_list.extend (l_expr)
					l_type_list.put (last_type, i)
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
					if l_types /= Void and then l_types.valid_index (i) then
						current_target_type := l_types.item (i)
					else
						current_target_type := Void
					end
					l_as.item.process (Current)
					l_type_list.put (last_type, i)
					i := i + 1
					l_as.forth
				end
			end
			last_expressions_type := l_type_list
			l_as.go_i_th (l_cursor)
		ensure
			last_expressions_type_not_void: last_expressions_type /= Void
			last_expressions_type_computed: old last_expressions_type /= last_expressions_type
			last_expressions_type_valid_count: last_expressions_type.count = l_as.count
			last_byte_node_valid: is_byte_node_enabled implies
				((old last_byte_node /= last_byte_node) and then last_byte_node /= Void)
		end

	check_tuple_validity_for_ca (a_creation_type: CL_TYPE_A; a_tuple: TUPLE_AS; a_ca_b: CUSTOM_ATTRIBUTE_B) is
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
					l_feat := a_creation_type.associated_class.feature_table.item (l_name.value.as_lower)
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
							l_has_error := not last_type.conform_to (l_feat.type.actual_type) and
								not last_type.convert_to (context.current_class, l_feat.type.actual_type)
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
						l_expressions.extend ([create {STRING_B}.make (l_name.value), l_expr_b])
					end
					a_tuple.expressions.forth
				end

				if not l_has_error and is_byte_node_enabled then
					a_ca_b.set_named_arguments (l_expressions)
				end
			end
		end

	valid_feature_for_ca (a_feat: FEATURE_I; a_name: STRING_AS): BOOLEAN is
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

	is_infix_valid (a_left_type, a_right_type: TYPE_A; a_name: STRING): BOOLEAN is
			-- Does infix routine `a_name' exists in `a_left_type' and if so is
			-- it valid for `a_right_type'?
		require
			a_left_type_not_void: a_left_type /= Void
			a_right_type_not_void: a_right_type /= Void
			a_name_not_void: a_name /= Void
		local
			l_infix: FEATURE_I
			l_class: CLASS_C
			l_vwoe: VWOE
			l_vwoe1: VWOE1
			l_vuex: VUEX
			l_vape: VAPE
			l_arg_type: TYPE_A
		do
			last_infix_error := Void
				-- No need for `a_left_type.actual_type' since it is done in callers of
				-- `is_infix_valid'.
			l_class := constrained_type (a_left_type).associated_class
			l_infix := l_class.feature_table.alias_item (a_name)
			if l_infix = Void then
				create l_vwoe
				context.init_error (l_vwoe)
				l_vwoe.set_other_class (l_class)
				l_vwoe.set_op_name (a_name)
				last_infix_error := l_vwoe
			else
					-- Export validity
				last_infix_feature := l_infix
				if not (context.is_ignoring_export or l_infix.is_exported_for (l_class)) then
					create l_vuex
					context.init_error (l_vuex)
					l_vuex.set_static_class (l_class)
					l_vuex.set_exported_feature (l_infix)
					last_infix_error := l_vuex
				else
					if
						not System.do_not_check_vape and then is_checking_precondition and then
						not current_feature.export_status.is_subset (l_infix.export_status)
					then
							-- In precondition and checking for vape
						create l_vape
						context.init_error (l_vape)
						l_vape.set_exported_feature (current_feature)
						last_infix_error := l_vape
					else
							-- Conformance initialization
							-- Argument conformance: infix feature must have one argument
						l_arg_type ?= l_infix.arguments.i_th (1)
						l_arg_type := l_arg_type.instantiation_in (a_left_type,
							l_class.class_id).actual_type

						if not a_right_type.conform_to (l_arg_type) then
							if a_right_type.convert_to (context.current_class, l_arg_type) then
								last_infix_argument_conversion_info := context.last_conversion_info
								last_infix_arg_type := l_arg_type
							else
									-- No conformance on argument of infix
								create l_vwoe1
								context.init_error (l_vwoe1)
								l_vwoe1.set_other_class (l_class)
								l_vwoe1.set_op_name (a_name)
								l_vwoe1.set_formal_type (l_arg_type)
								l_vwoe1.set_actual_type (a_right_type)
								last_infix_error := l_vwoe1
							end
						else
							last_infix_arg_type := l_arg_type
						end
					end
				end
			end
			if last_infix_error /= Void then
				last_infix_feature := Void
				last_infix_argument_conversion_info := Void
			else
				Result := True
			end
		end

	last_infix_error: ERROR
	last_infix_feature: FEATURE_I
	last_infix_arg_type: TYPE_A
	last_infix_argument_conversion_info: CONVERSION_INFO
			-- Helpers to perform type check and byte_node generation.

	insert_vuar2_error (a_feature: FEATURE_I; a_params: EIFFEL_LIST [EXPR_AS]; a_in_class_id, a_pos: INTEGER; a_actual_type, a_formal_type: TYPE_A) is
			-- Insert a VUAR2 error in call to `a_feature' from `a_in_class_id' class for argument
			-- at position `a_pos'.
		require
			a_feature_not_void: a_feature /= Void
			a_params_not_void: a_params /= Void
			a_params_matches: a_params.valid_index (a_pos)
			a_in_class_id_non_negative: a_in_class_id >= 0
			a_pos_positive: a_pos > 0
			a_pos_valid: a_pos <= a_feature.argument_count
			a_actual_type_not_void: a_actual_type /= Void
			a_formal_type_not_void: a_formal_type /= Void
		local
			l_vuar2: VUAR2
		do
			create l_vuar2
			context.init_error (l_vuar2)
			l_vuar2.set_called_feature (a_feature, a_in_class_id)
			l_vuar2.set_argument_position (a_pos)
			l_vuar2.set_argument_name (a_feature.arguments.item_name (a_pos))
			l_vuar2.set_actual_type (a_actual_type)
			l_vuar2.set_formal_type (a_formal_type)
			l_vuar2.set_location (a_params.i_th (a_pos).start_location)
			error_handler.insert_error (l_vuar2)
		end

	process_type_compatibility (l_target_type: like last_type) is
			-- Test if `last_type' is compatible with `l_target_type' and
			-- make the result available in `is_type_compatible'.
			-- Adjust `last_byte_node' to reflect conversion if required.
		require
			last_type_not_void: last_type /= Void
			last_byte_node_not_void: is_byte_node_enabled implies last_byte_node /= Void
		local
			l_source_type: like last_type
			l_source_expr: EXPR_B
			l_conv_info: CONVERSION_INFO
		do
			is_type_compatible := True
			l_source_type := last_type
				--| If `l_source_type' is of type NONE_A and if `l_target_type' does
				--| not conform to NONE, we generate in all the cases a VJAR error,
				--| we do not try to specify what kind of error, i.e.
				--| 1- if target was a basic or an expanded type, we should generate
				--|    a VNCE error.
				--| 2- if target was a BIT type, we should generate a VNCB error.
			if not l_source_type.conform_to (l_target_type) then
				if l_source_type.convert_to (context.current_class, l_target_type) then
					l_conv_info := context.last_conversion_info
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
					l_source_type.is_conformant_to (l_target_type)
				then
						-- No need for conversion, this is currently done at the code
						-- generation level to properly handle the generic case.
						-- If not done at the code generation, we would need the following
						-- line.
					-- create {BOX_CONVERSION_INFO} l_conv_info.make (l_source_type)
				else
						-- Type does not convert neither, so we raise an error
						-- about non-conforming types.
					is_type_compatible := False
				end
			end
		ensure
			last_type_unchanged: last_type = old last_type
			last_byte_node_not_void: is_byte_node_enabled implies last_byte_node /= Void
		end

	process_assigner_command (target_class_id: INTEGER; target_query: FEATURE_I) is
			-- Attempt to calculate an assigner call associated with `target_query'
			-- called on type of `target_class_id'. Make the result available in
			-- `last_assigner_command'. Register client dependance on the target
			-- command.
		require
			target_query_not_void: target_query /= Void
		local
			assigner_name: STRING
			assigner_command: FEATURE_I
		do
			assigner_name := target_query.assigner_name
			if assigner_name = Void then
				last_assigner_command := Void
			else
				assigner_command := target_query.written_class.feature_named (assigner_name)
				if assigner_command /= Void then
						-- Evaluate assigner command in context of target type
					assigner_command := system.class_of_id (target_class_id).feature_of_rout_id
						(assigner_command.rout_id_set.first)
						-- Suppliers update
					context.supplier_ids.extend (create {DEPEND_UNIT}.make_with_level
						(target_class_id, assigner_command, depend_unit_level))
				end
				last_assigner_command := assigner_command
			end
		end

feature {NONE} -- Implementation: overloading

	overloaded_feature (
			a_type: TYPE_A; last_class: CLASS_C; a_arg_types: ARRAY [TYPE_A];
			a_feature_name: ID_AS; is_static_access: BOOLEAN): FEATURE_I
		is
			-- Find overloaded feature that could match Current. The rules are taken from
			-- C# ECMA specification "14.4.2 Overload Resolution".
		require
			a_type_not_void: a_type /= Void
			last_class_not_void: last_class /= Void
			last_class_has_overloaded: last_class.feature_table.has_overloaded (a_feature_name)
		local
			last_id: INTEGER
			l_features: LIST [FEATURE_I]
			viof: VIOF
			l_list: ARRAYED_LIST [TYPE_A]
			i, nb: INTEGER
		do
			last_id := last_class.class_id

				-- At this stage we know this is an overloaded routine.
			l_features := last_class.feature_table.overloaded_items (a_feature_name)

				-- Remove all features that are not valid for Current call.
				-- C# ECMA 14.4.2.1
			l_features := applicable_overloaded_features (l_features, a_type, a_arg_types,
				last_id, is_static_access)

			if l_features.is_empty then
			elseif l_features.count = 1 then
				Result := l_features.first
			else
					-- Now that we have all valid features for this call, we need to find the
					-- best match. If we find more than one, there is an ambiguity.
					-- C# ECMA 14.4.2.2 and 14.4.2.3
				l_features := best_overloaded_features (l_features, a_type, a_arg_types, last_id)

				if l_features.is_empty then
				elseif l_features.count = 1 then
					Result := l_features.first
				else
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
							l_list.extend (a_arg_types.item (i))
							i := i + 1
						end
					end
					create viof.make (context.current_class, current_feature,
						l_features, a_feature_name, last_id, l_list)
					viof.set_location (a_feature_name)
					error_handler.insert_error (viof)
						-- Cannot go on here
					error_handler.raise_error
				end
			end
		end

	applicable_overloaded_features
			(a_features: LIST [FEATURE_I]; a_type: TYPE_A; a_arg_types: ARRAY [TYPE_A]; last_id: INTEGER;
			is_static_access: BOOLEAN): LIST [FEATURE_I]
		is
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
			l_open_type: OPEN_TYPE_A
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
					(not is_static_access or else l_feature.has_static_access)
				then
					Result.extend (l_feature)
				end
				a_features.forth
			end

			if Result.is_empty then
			elseif Result.count = 1 then
			elseif a_arg_types /= Void then
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
						l_arg_type := a_arg_types.item (i)
							-- We must generate an error when `l_formal_arg_type' becomes
							-- an OPEN_TYPE_A, for example "~equal (?, b)" will
							-- check that the type of `b' conforms to type of `?'
							-- since `equal' is defined as `equal (a: ANY; b: like a)'.
							-- However `conform_to' does not work when parameter
							-- is an OPEN_TYPE_A type. Since this checks can only
							-- happens in type checking of an agent, we can do it
							-- at only one place, ie here.
						l_open_type ?= l_formal_arg_type
						if
							l_open_type /= Void or else
							not (l_arg_type.conform_to (l_formal_arg_type) or
							l_arg_type.convert_to (context.current_class, l_formal_arg_type))
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
			(a_features: LIST [FEATURE_I]; a_type: TYPE_A; a_arg_types: ARRAY [TYPE_A];
			last_id: INTEGER): LIST [FEATURE_I]
		is
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
			feature_count, l_formal_count: INTEGER
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
				feature_count := a_features.count
				l_formal_count := a_features.first.argument_count
				create l_set.make (feature_count)
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
			a_feat1, a_feat2: FEATURE_I; a_type: TYPE_A; a_arg_types: ARRAY [TYPE_A];
			last_id: INTEGER): FEATURE_I
		is
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
				l_current_item := a_arg_types.item (i)

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

	better_conversion (source_type, target1, target2: TYPE_A): TYPE_A is
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
				conform1 := source_type.conform_to (target1)
				conform2 := source_type.conform_to (target2)
				if conform1 and conform2 then
					if target1.conform_to (target2) then
						Result := target1
					elseif target2.conform_to (target1) then
						Result := target2
					end
				elseif conform1 then
					Result := target1
				elseif conform2 then
					Result := target2
				else
						-- Conformance failed, so let's check conversion.
					convert1 := source_type.convert_to (context.current_class, target1)
					convert2 := source_type.convert_to (context.current_class, target2)
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
			(a_feature: FEATURE_I; a_pos: INTEGER; a_type: TYPE_A; a_arg_types: ARRAY [TYPE_A]; last_id: INTEGER): TYPE_A
		is
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
			Result := Result.instantiation_in (a_type, last_id).actual_type
		ensure
			feature_arg_type_not_void: Result /= Void
		end

feature {NONE} -- Agents

	compute_routine (
			a_table: FEATURE_TABLE; a_feature: FEATURE_I; cid : INTEGER; a_target_type: TYPE_A;
			a_feat_type: TYPE_A; an_agent: ROUTINE_CREATION_AS; an_access: ACCESS_B; a_target_node: BYTE_NODE)
		is
			-- Type of routine object.
		require
			valid_table: a_table /= Void
			valid_feature: a_feature /= Void;
			function_or_procedure: a_feature.is_routine
			not_external: not a_feature.is_external
		local
			l_arg_type:TYPE_A
			l_generics: ARRAY [TYPE_A]
			l_feat_args: FEAT_ARG
			l_oargtypes, l_argtypes: ARRAY [TYPE_A]
			l_tuple: TUPLE_TYPE_A
			l_count, l_idx, l_oidx: INTEGER
			l_operand: OPERAND_AS
			l_is_open: BOOLEAN
			l_result_type: GEN_TYPE_A
			l_last_open_positions: ARRAYED_LIST [INTEGER]
			l_routine_creation: ROUTINE_CREATION_B
			l_tuple_node: TUPLE_CONST_B
			l_expressions: BYTE_LIST [BYTE_NODE]
			l_parameters_node: BYTE_LIST [PARAMETER_B]
			l_expr: EXPR_B
			l_array_of_opens: ARRAY_CONST_B
			l_void: VOID_B
			l_operand_node: OPERAND_B
			l_actual_target_type: TYPE_A
		do

			if a_feature.is_function then
					-- generics are: base_type, open_types, result_type
				create l_generics.make (1, 3)
				l_generics.put (a_feat_type, 3)
				create l_result_type.make (System.function_class_id, l_generics)
			else
					-- generics are: base_type, open_types
				create l_generics.make (1, 2)
				create l_result_type.make (System.procedure_class_id, l_generics)
			end

			l_actual_target_type := a_target_type.actual_type
			l_generics.put (a_target_type, 1)

			l_feat_args := a_feature.arguments

				-- Compute `operands_tuple' and type of TUPLE needed to determine current
				-- ROUTINE type.

				-- Create `l_argtypes', array used to initialize type of `operands_tuple'.
				-- This array can hold all arguments of the routine plus Current.
			if l_feat_args /= Void then
				l_count := l_feat_args.count + 1
			else
				l_count := 1
			end
			create l_argtypes.make (1, l_count)


				-- Create `l_oargtypes'. But first we need to find the `l_count', number
				-- of open operands.
			if an_agent.target = Void or else an_agent.target.class_type /= Void then
					-- No target is specified, or just a class type is specified.
					-- Therefore there is at least one argument
				l_count := 1
				l_oidx := 2
			else
					-- Target was specified
				l_count := 0
				l_oidx  := 1
			end

				-- Compute number of open positions.
			if an_agent.operands /= Void then
				from
					an_agent.operands.start
				until
					an_agent.operands.after
				loop
					if an_agent.operands.item.is_open then
						l_count := l_count + 1
					end
					an_agent.operands.forth
				end
			else
				if l_feat_args /= Void then
					l_count := l_count + l_feat_args.count
				end
			end

				-- Create `oargytpes' with `l_count' parameters. This array
				-- is used to create current ROUTINE type.
			create l_oargtypes.make (1, l_count)

			if l_count > 0 then
				create l_last_open_positions.make (l_count)
				if l_oidx > 1 then
						-- Target is open, so insert it.
					l_last_open_positions.extend (1)
					l_oargtypes.put (a_target_type, 1)
				end
			end

				-- Always insert target's type in `l_argtypes' as first argument.
			l_argtypes.put (a_target_type, 1)

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
					l_arg_type := Void

						-- Let's find out if this is really an open operand.
					if an_agent.operands /= Void then
						l_operand := an_agent.operands.item
						if l_operand.is_open then
							l_is_open := True
							if l_operand.class_type /= Void then
								l_operand.process (Current)
								l_arg_type := last_type
							end
						else
							l_is_open := False
						end
					else
						l_is_open := True
					end

						-- Get type of operand.
					if l_is_open then
						if l_arg_type = Void then
							l_arg_type := l_feat_args.item.actual_type
						end
					else
						l_arg_type := l_feat_args.item.actual_type
					end

						-- Evaluate type of operand in current context
					l_arg_type := l_arg_type.instantiation_in (l_actual_target_type, cid).deep_actual_type

						-- If it is open insert it in `l_oargtypes' and insert
						-- position in `l_last_open_positions'.
					if l_is_open then
						l_oargtypes.put (l_arg_type, l_oidx)
						l_last_open_positions.extend (l_idx)
						l_oidx := l_oidx + 1
					end

						-- Add type to `l_argtypes'.
					l_argtypes.put (l_arg_type, l_idx)

					l_idx := l_idx + 1
					l_feat_args.forth

					if an_agent.operands /= Void then
						an_agent.operands.forth
					end
				end
			end

				-- Create open argument type tuple
			create l_tuple.make (System.tuple_id, l_oargtypes)
				-- Insert it as second generic parameter of ROUTINE.
			l_generics.put (l_tuple, 2)

			if is_byte_node_enabled then
				create l_routine_creation

				l_parameters_node := an_access.parameters

					-- Setup closed arguments in `l_argtypes'.
				create l_expressions.make_filled (l_argtypes.count)
				l_expressions.start

					-- Generate `VOID_B' instance that corresponds to
					-- a non-initialized value of `l_argtypes'.
				create l_void

				if a_target_node /= Void then
						-- A target was specified, we need to check if it is an open argument or not
						-- by simply checking that its byte node is not an instance of OPERAND_B.
					l_expr ?= a_target_node
					l_operand_node ?= l_expr
					if l_operand_node /= Void then
						l_expressions.put (l_void)
					else
						l_expressions.put (l_expr)
					end
				else
					l_expressions.put (l_void)
				end
				l_expressions.forth

				if l_parameters_node /= Void then
						-- Insert values in `l_expressions'.
					from
						l_parameters_node.start
					until
						l_parameters_node.after
					loop
						l_expr := l_parameters_node.item.expression
						l_operand_node ?= l_expr
						if l_operand_node /= Void then
								-- Open operands, we insert Void.
							l_expressions.put (l_void)
						else
								-- Closed operands, we insert its expression.
							l_expressions.put (l_expr)
						end
						l_expressions.forth
						l_parameters_node.forth
					end
				end

					-- Create TUPLE_CONST_B instance which holds all closed arguments.
				l_expressions.start
				create l_tuple_node.make (l_expressions,
					(create {TUPLE_TYPE_A}.make (System.tuple_id, l_argtypes)).type_i)

					-- Setup l_last_open_positions
				if l_last_open_positions /= Void then
					create l_expressions.make_filled (l_last_open_positions.count)
					from
						l_expressions.start
						l_last_open_positions.start
					until
						l_last_open_positions.after
					loop
						l_expressions.put (
							create {INTEGER_CONSTANT}.make_with_value (l_last_open_positions.item))
						l_expressions.forth
						l_last_open_positions.forth
					end

						-- Create ARRAY_CONST_B which holds all open positions in
						-- above generated tuple.
					l_expressions.start
					create l_array_of_opens.make (l_expressions, integer_array_type.type_i,
						integer_array_type.create_info)
				end

					-- Initialize ROUTINE_CREATION_B instance
				l_routine_creation.init (a_target_type.type_i, a_target_type.associated_class.class_id,
					a_feature, l_result_type.type_i, l_tuple_node, l_array_of_opens)
				last_byte_node := l_routine_creation
			end
			last_type := l_result_type
		ensure
			exists: last_type /= Void
		end

	integer_array_type : GEN_TYPE_A is
			-- Representation of an array of INTEGER
		local
			generics : ARRAY [TYPE_A]
			int_a: INTEGER_A
		once
			create generics.make (1,1)
			create  int_a.make (32)
			generics.put (int_a, 1)
			create Result.make (System.array_id, generics)
		end

feature {NONE} -- Precursor handling

	precursor_table (l_as: PRECURSOR_AS): LINKED_LIST [PAIR[CL_TYPE_A, INTEGER]] is
				-- Table of parent types which have an effective
				-- precursor of current feature. Indexed by
				-- routine ids.
		require
			l_as_not_void: l_as /= Void
		local
			rout_id_set: ROUT_ID_SET
			rout_id: INTEGER
			parents: FIXED_LIST [CL_TYPE_A]
			a_parent: CLASS_C
			a_feature: E_FEATURE
			p_name: STRING
			spec_p_name: STRING
			p_list: HASH_TABLE [CL_TYPE_A, STRING]
			i, rc: INTEGER
			pair: PAIR [CL_TYPE_A, INTEGER]
			couple: PAIR [INTEGER, INTEGER]
			check_written_in: LINKED_LIST [PAIR [INTEGER, INTEGER]]
			r_class_i: CLASS_I
			a_cluster: CLUSTER_I
		do
			rout_id_set := current_feature.rout_id_set
			rc := rout_id_set.count

			if l_as.parent_base_class /= Void then
				-- Take class renaming into account
				a_cluster := context.current_class.cluster
				r_class_i := Universe.class_named (l_as.parent_base_class.class_name, a_cluster)

				if r_class_i /= Void then
					spec_p_name := r_class_i.name_in_upper
				else
					-- A class of name `l_as.parent_base_class' does not exist
					-- in the universe. Use an empty name to trigger
					-- an error message later.
					spec_p_name := ""
				end
			end

			from
				parents := context.current_class.parents
				create Result.make
				create check_written_in.make
				check_written_in.compare_objects
				create p_list.make (parents.count)
				parents.start
			until
				parents.after
			loop
				a_parent := parents.item.associated_class
				p_name := a_parent.name_in_upper

					-- Don't check the same parent twice.
					-- If construct is qualified, check
					-- specified parent only.
				if
					not (p_list.has (p_name) and then
					p_list.found_item.is_equivalent (parents.item)) and then
					(spec_p_name = Void or else spec_p_name.is_equal (p_name))
				then
						-- Check if parent has an effective precursor
					from
						i := 1
					until
						i > rc
					loop
						rout_id   := rout_id_set.item (i)
						a_feature := a_parent.feature_with_rout_id (rout_id)

						if a_feature /= Void and then not a_feature.is_deferred  then
								-- Ok, add parent.
							create pair
							pair.set_first (parents.item)
							pair.set_second (rout_id)

							create couple
							couple.set_first (rout_id)
							couple.set_second (a_feature.written_in)

								-- Before entering the new info in `Result' we
								-- need to make sure that we do not have the same
								-- item, because if we were adding it, it will
								-- cause a VUPR3 error when it is not needed.
							if not special_has (check_written_in, couple) then
								Result.extend (pair)
								check_written_in.extend (couple)
							end

								-- Register parent
							p_list.put (parents.item, p_name)
							i := rc -- terminate loop
						end

						i := i + 1
					end
				end
				parents.forth
			end
		end

feature {NONE} -- Implementation

	special_has (l: LINKED_LIST [PAIR [INTEGER, INTEGER]]; p: PAIR [INTEGER, INTEGER]): BOOLEAN is
			-- Does `l' contain `p'?
		require
			valid_pair: p /= Void
			valid_pair_first: p.first /= 0
			valid_pair_second: p.second /= 0
		local
			l_item: PAIR [INTEGER, INTEGER]
		do
			from
				l.start
				Result := False
			until
				l.after or Result
			loop
				l_item := l.item
				Result := l_item.first = p.first and then
								l_item.second = p.second
				l.forth
			end
		end

feature {NONE} -- Implementation: checking locals

	check_locals (l_as: ROUTINE_AS) is
			-- Check validity of local declarations: a local variable
			-- name cannot be a final name of the current feature table or
			-- an argument name of the current analyzed feature.
			-- Also an external or a deferred routine cannot have
			-- locals.
		require
			l_as_not_void: l_as /= Void
			locals_not_void: l_as.locals /= Void
		local
			l_id_list: ARRAYED_LIST [INTEGER]
			l_local_type: TYPE_AS
			l_local_class_c: CLASS_C
			l_local_name_id: INTEGER
			l_local_name: STRING
			l_solved_type: TYPE_A
			l_track_local: BOOLEAN
			i: INTEGER
			l_local_info: LOCAL_INFO
			l_context_locals: HASH_TABLE [LOCAL_INFO, STRING]
			l_vrle1: VRLE1
			l_vrle2: VRLE2
			l_vreg: VREG
			l_curr_feat: FEATURE_I
			l_vrrr2: VRRR2
		do
			if (l_as.is_deferred or l_as.is_external) then
				create l_vrrr2
				context.init_error (l_vrrr2)
				l_vrrr2.set_is_deferred (l_as.is_deferred)
				l_vrrr2.set_location (l_as.locals.start_location)
				error_handler.insert_error (l_vrrr2)
			elseif not l_as.locals.is_empty then
				from
					l_curr_feat := current_feature
					l_track_local := l_curr_feat.written_in = context.current_class.class_id
					l_context_locals := context.locals
					l_as.locals.start
				until
					l_as.locals.after
				loop
					from
						l_local_type := l_as.locals.item.type
						l_solved_type := type_checker.solved_type (l_local_type)

							-- Check validity of type declaration
						type_checker.check_type_validity (l_solved_type, l_local_type)

						if l_track_local then
							Instantiator.dispatch (l_solved_type, context.current_class)
						end

						l_id_list := l_as.locals.item.id_list
						l_id_list.start
					until
						l_id_list.after
					loop
						l_local_name_id := l_id_list.item
						l_local_name := Names_heap.item (l_local_name_id)
						if l_curr_feat.has_argument_name (l_local_name_id) then
								-- The local name is an argument name of the
								-- current analyzed feature
							create l_vrle2
							context.init_error (l_vrle2)
							l_vrle2.set_local_name (l_local_name_id)
							l_vrle2.set_location (l_as.locals.item.start_location)
							error_handler.insert_error (l_vrle2)
						elseif context.current_feature_table.has_id (l_local_name_id) then
								-- The local name is a feature name of the
								-- current analyzed class.
							create l_vrle1
							context.init_error (l_vrle1)
							l_vrle1.set_local_name (l_local_name_id)
							l_vrle1.set_location (l_as.locals.item.start_location)
							error_handler.insert_error (l_vrle1)
						end
							-- Build the local table in the context
						i := i + 1
						create l_local_info
							-- Check an expanded local type

						l_local_info.set_type (l_solved_type)
						l_local_info.set_position (i)
						if l_context_locals.has (l_local_name) then
								-- Error: two locals withe the same name
							create l_vreg
							l_vreg.set_entity_name (l_local_name)
							context.init_error (l_vreg)
							l_vreg.set_location (l_as.locals.item.start_location)
							error_handler.insert_error (l_vreg)
						else
							l_context_locals.put (l_local_info, l_local_name)
						end
							-- We do NOT want to update the type in the instantiator
							-- if there is an error!!!! (Xavier)
						error_handler.checksum

							-- Update instantiator for changed class
						l_id_list.forth
					end

					l_local_class_c := l_solved_type.associated_class
					if l_local_class_c /= Void then
							-- Add the supplier in the feature_dependance list
						context.supplier_ids.add_supplier (l_local_class_c)
					end

					if l_solved_type /= Void then
						l_solved_type.check_for_obsolete_class (context.current_class)
					end
					l_as.locals.forth
				end
			end
		end

	check_unused_locals (a_locals: HASH_TABLE [LOCAL_INFO, STRING]) is
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
						create l_warning.make (context.current_class, current_feature)
					end
					l_warning.add_unused_local (a_locals.key_for_iteration, l_local.type)
				end
				a_locals.forth
			end
			if l_warning /= Void then
				error_handler.insert_warning (l_warning)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
