indexing
	description:

		"Serializes request so they can be sent to interpreter"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_REQUEST_PRINTER

inherit

	AUT_REQUEST_PROCESSOR

	KL_SHARED_STREAMS
		export {NONE} all end

	REFACTORING_HELPER

	AUT_SHARED_TYPE_FORMATTER

	ERL_G_TYPE_ROUTINES

	SHARED_SERVER
		rename
			universe as system_universe,
			system as system_system
		end

	AUT_BYTE_NODE_FACTORY
		export {NONE} all end

	AUT_SHARED_INTERPRETER_INFO

	EXCEPTIONS

	ITP_SHARED_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_system: like system; a_variable_table: like variable_table) is
			-- Create new request.
		require
			a_system_not_void: a_system /= Void
			a_variable_table_attached: a_variable_table /= Void
		do
			system := a_system
			variable_table := a_variable_table

			load_object_feature := interpreter_root_class.feature_named (load_object_feature_name)
			store_object_feature := interpreter_root_class.feature_named (store_object_feature_name)

			create expression_type_visitor.make (system, variable_table)
			create expression_b_visitor.make (system, load_object_feature)
		ensure
			system_set: system = a_system
		end

feature -- Access

	system: SYSTEM_I
			-- system

	variable_table: AUT_VARIABLE_TABLE
			-- Variable table

	last_request: TUPLE [flag: NATURAL_8; data: STRING]
			-- Last request

feature {AUT_REQUEST} -- Processing

	process_start_request (a_request: AUT_START_REQUEST) is
		do
			last_request := [start_request_flag, ""]
		end

	process_stop_request (a_request: AUT_STOP_REQUEST) is
		do
			last_request := [quit_request_flag, ""]
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST) is
		local
			l_compound: BYTE_LIST [BYTE_NODE]

			l_assign: ASSIGN_B
			l_target: LOCAL_B
			l_source: CREATION_EXPR_B

			l_feature: FEATURE_I
			l_arguments: LIST [TYPE_A]
			l_argument_count: INTEGER
			l_locals: ARRAYED_LIST [TYPE_A]
			l_compound_count: INTEGER
			l_local_count: INTEGER
		do
			l_feature := a_request.creation_procedure
			l_argument_count := a_request.argument_count
			l_local_count := l_argument_count + 1
			l_compound_count := l_argument_count + 2

			create l_locals.make (l_local_count)
			create l_compound.make (l_compound_count)

				-- Setup locals needed in the feature. Local orders:			
				-- 1: target which willl be created.
				-- 2~`l_argument_count'+1: arguments

			l_locals.extend (a_request.target_type)
			if a_request.has_argument then
				l_arguments := feature_argument_types (l_feature, a_request.target_type)
				l_locals.append (l_arguments)
			end
			setup_byte_code_in_context (l_locals)

				-- Create nodes to load objects from object pool into local variables.
			if a_request.has_argument then
				l_compound.append (new_load_local_nodes (a_request.argument_list, 2))
			end

				-- Create nodes for creation expression
			l_target := new_local_b (1)
			l_source := new_creation_byte_code (l_feature, a_request.target_type, new_local_access_parameter_expressions (l_arguments, 2))
			l_assign := new_assign_b (l_target, l_source)
			l_compound.extend (l_assign)

				-- Create nodes to store created object into object pool.
			l_compound.extend (new_store_variable_byte_code (1, a_request.target.index))

				-- Print request into `output_stream'.
			print_execute_request (l_compound)
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST) is
		local
			l_locals: ARRAYED_LIST [TYPE_A]
			l_target_type: CL_TYPE_A
			l_receiver_TYPE: TYPE_A
			l_feature: FEATURE_I
			l_arguments: LIST [TYPE_A]
			l_argument_count: INTEGER
			l_nested: NESTED_B
			l_compound: BYTE_LIST [BYTE_NODE]
			l_target: DS_LINKED_LIST [ITP_EXPRESSION]
			l_compound_count: INTEGER
			l_target_index: INTEGER
			l_local_count: INTEGER
			l_receiver_index: INTEGER
			l_extra_local_count: INTEGER
		do
				-- If the to be called feature is a query, we need one more instruction
				-- at the end to store the result in object pool
			if a_request.is_feature_query then
				l_extra_local_count := 1
			else
				l_local_count := l_argument_count + 1
			end

			l_feature := a_request.feature_to_call
			l_argument_count := a_request.argument_count
			l_compound_count := l_argument_count + 2 + l_extra_local_count
			l_local_count := l_argument_count + 1 + l_extra_local_count
			l_receiver_index := l_argument_count + 2
			l_target_index := 1

			create l_compound.make (l_compound_count)
			create l_locals.make (l_local_count)

				-- Setup locals for byte-code. Order of locals in byte-code:
				-- 1: target of feature call
				-- 2~`l_argument_count'+1: arguments
				-- `l_argument_count' + 2: receiver (if `l_feature' is a query)
			l_target_type ?= expression_type_visitor.type (a_request.target)
			l_locals.extend (l_target_type)

			if a_request.has_argument then
				l_arguments := feature_argument_types (l_feature, l_target_type)
				l_locals.append (l_arguments)
			end

			l_receiver_type := l_feature.type.actual_type.instantiation_in (l_target_type, l_feature.written_in)
			if a_request.is_feature_query then
				l_locals.extend (l_receiver_type)
			end

				-- Setup context for byte-node generation.
			setup_byte_code_in_context (l_locals)

				-- Create nodes to load target into local.
			create l_target.make
			l_target.force_last (a_request.target)
			l_compound.append (new_load_local_nodes (l_target, 1))

				-- Create nodes to load objects from object pool into local variables.
			if a_request.has_argument then
				l_compound.append (new_load_local_nodes (a_request.argument_list, 2))
			end

				-- Create nodes to represent a feature call.
			l_nested := new_nested_b (
				new_local_b (1),
				new_access_b (
					a_request.feature_to_call,
					l_receiver_type,
					new_local_access_parameter_expressions (l_arguments, l_target_index + 1)))

			if a_request.is_feature_query then
				l_compound.extend (new_assign_b (new_local_b (l_local_count), l_nested))

					-- If the feature to call is a query, create nodes to store created object into object pool.
				l_compound.extend (new_store_variable_byte_code (l_receiver_index, a_request.receiver.index))
			else
				l_compound.extend (l_nested)
			end

				-- Dump request into `output_stream'.
			print_execute_request (l_compound)
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST) is
		local
			l_compound: BYTE_LIST [BYTE_NODE]
			l_byte_node: STD_BYTE_CODE
			l_locals: ARRAYED_LIST [TYPE_A]
		do
			create l_byte_node
			create l_compound.make (2)
			create l_locals.make (1)
			l_locals.extend (system.any_class.compiled_representation.actual_type)
			setup_byte_code_in_context (l_locals)

			l_compound.extend (new_assign_b (new_local_b (1), expression_b_visitor.expression (a_request.expression)))
			l_compound.extend (new_store_variable_byte_code (1, a_request.receiver.index))

				-- Print request into `output_stream'.
			print_execute_request (l_compound)
		end

	process_type_request (a_request: AUT_TYPE_REQUEST) is
		do
			last_request := [type_request_flag, a_request.variable.index.out]
		end

feature {NONE} -- Byte code generation

	new_store_object_feature_call (a_local_index: INTEGER; a_pool_index: INTEGER; a_type: TYPE_A): CALL_ACCESS_B is
			-- New FEATURE_B instance to store the `a_local_index'-th local variable into object pool at position `a_pool_index'
		require
			a_local_index_positive: a_local_index > 0
			a_pool_index_positive: a_pool_index > 0
		local
			l_local_index_param: PARAMETER_B
			l_object_pool_index_param: PARAMETER_B
			l_parameters: BYTE_LIST [PARAMETER_B]
			l_local: LOCAL_B
		do
			create l_parameters.make (2)

			create l_local_index_param
			create l_local
			l_local.set_position (a_local_index)
			l_local_index_param.set_expression (l_local)
			l_local_index_param.set_attachment_type (a_type)

			create l_object_pool_index_param
			l_object_pool_index_param.set_expression (create {INTEGER_CONSTANT}.make_with_value (a_pool_index))
			l_object_pool_index_param.set_attachment_type (integer_32_type)

			l_parameters.extend (l_local_index_param)
			l_parameters.extend (l_object_pool_index_param)
			Result := new_feature_b (store_object_feature, void_type, l_parameters)
		ensure
			result_attached: Result /= Void
		end

	new_load_local_nodes (a_expressions: DS_LINEAR [ITP_EXPRESSION]; a_start_local_index: INTEGER): BYTE_LIST [BYTE_NODE] is
			-- Byte nodes for loading `a_expressions' in locals starting from `a_start_local_index'.
			-- For example, if `a_expression's contains 2 expressions and `a_start_local_index' is 3,
			-- then byte nodes will be generated for loading those two expressions into the 3rd and the 4th locals.
		require
			a_expressions_attached: a_expressions /= Void
			a_start_local_index_valid: a_start_local_index > 0
		local
			l_cursor: DS_LINEAR_CURSOR [ITP_EXPRESSION]
			i: INTEGER
			l_expr_visitor: like expression_b_visitor
		do
			create Result.make (a_expressions.count)

			from
				l_expr_visitor := expression_b_visitor
				i := a_start_local_index
				l_cursor := a_expressions.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				Result.extend (new_reverse_b (new_local_b (i), l_expr_visitor.expression (l_cursor.item)))
				l_cursor.forth
				i := i + 1
			end
		ensure
			result_attached: Result /= Void
		end

	new_store_variable_byte_code (a_local_index: INTEGER; a_object_pool_index: INTEGER): BYTE_NODE is
			-- New byte-node to store local at `a_local_index' in object pool at index `a_index'.
		require
			a_local_index_positive: a_local_index > 0
			a_object_pool_index_positive: a_object_pool_index > 0
		do
			Result :=
				new_instr_call_b (
					new_store_object_feature_call (
						a_local_index,
						a_object_pool_index,
						store_object_feature.arguments.i_th (1).actual_type))
		ensure
			result_attached: Result /= Void
		end

	setup_byte_code_in_context (a_locals: ARRAY [TYPE_A]) is
			-- Setup for byte-code generation for feature `feature_for_byte_code_injection' in `context'.
		require
			a_locals_attached: a_locals /= Void
		local
			l_byte_code: STD_BYTE_CODE
			l_feature: like feature_for_byte_code_injection
			l_local_count: INTEGER
		do
			l_feature := feature_for_byte_code_injection

				-- Setup new byte code.
			create l_byte_code
			l_byte_code.set_body_index (l_feature.body_index)
			l_byte_code.set_feature_name_id (l_feature.feature_name_id)
			l_byte_code.set_pattern_id (l_feature.pattern_id)
			l_byte_code.set_real_body_id (l_feature.real_body_id (interpreter_root_class.types.first))
			l_byte_code.set_result_type (l_feature.type)
			l_byte_code.set_rout_id (l_feature.rout_id_set.first)
			l_byte_code.set_written_class_id (l_feature.written_in)
			l_byte_code.set_real_body_id (feature_for_byte_code_injection.real_body_id (interpreter_root_class.types.first))
			if a_locals /= Void then
				l_local_count := a_locals.count
			end
			l_byte_code.set_locals (a_locals, l_local_count)
			last_byte_code := l_byte_code
			context.set_byte_code (last_byte_code)
			context.init (interpreter_root_class.types.first)
			context.set_byte_code (l_byte_code)
			context.set_current_feature (feature_for_byte_code_injection)
			context.set_class_type (interpreter_root_class.types.first)
			context.set_workbench_mode
		ensure
			last_byte_code_attached: last_byte_code /= Void
			byte_code_set_in_context: context.byte_code = last_byte_code
		end

	last_byte_code: STD_BYTE_CODE
			-- Last generated byte-code

	print_execute_request (a_compound: BYTE_LIST [BYTE_NODE]) is
			-- Print execute request to `output_stream'.
			-- The execute request contains the byte code defined by `a_locals' and `a_compound'.
		require
			a_compound_attached: a_compound /= Void
		local
			l_byte_code: STD_BYTE_CODE
			l_feature: like feature_for_byte_code_injection
			l_byte_array: BYTE_ARRAY
			l_byte_code_data: STRING
		do
			l_feature := feature_for_byte_code_injection

				-- Setup new byte node.
			l_byte_code := last_byte_code
			l_byte_code.set_compound (a_compound)

				-- Generate byte-code
			Byte_array.clear
			l_byte_code.make_byte_code (Byte_array)
			context.clear_feature_data
			l_byte_array := Byte_array
			l_byte_code_data := l_byte_array.melted_feature.string_representation

			last_request := [execute_request_flag, l_byte_code_data]
		end

feature{NONE} -- Implementation

	expression_type_visitor: AUT_EXPRESSION_TYPE_VISITOR
			-- Type visitor for expressions

	expression_b_visitor: AUT_EXPRESSION_B_VISITOR
			-- Visitor to generate EXPR_B nodes for expressions

	store_object_feature: FEATURE_I
			-- Feature to store an object into object pool

	store_object_feature_name: STRING is "store_variable_at_index"
			-- Name of feature to store an object into object pool

	load_object_feature_name: STRING is "variable_at_index"
			-- Name of feature to load an object from object pool

	load_object_feature: FEATURE_I
			-- Feature to load an object from object pool

invariant
	system_not_void: system /= Void
	feature_for_byte_code_injection_attached: feature_for_byte_code_injection /= Void
	variable_table_attached: variable_table /= Void
	expression_type_visitor_attached: expression_type_visitor /= Void
	expression_b_visitor_attached: expression_b_visitor /= Void

end
