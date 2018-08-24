note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_ENTITY_MAPPING

inherit

	IV_SHARED_TYPES

	IV_SHARED_FACTORY

	E2B_SHARED_CONTEXT

create
	make,
	make_copy

feature {NONE} -- Initialization

	make
			-- Initialize name mapping.
		do
			create {IV_ENTITY} current_expression.make (default_current_name, types.ref)
			result_expression := Void
			create {IV_ENTITY} heap.make (global_heap_name, types.heap)
			old_heap := factory.old_ (heap)
			create argument_mapping.make (5)
			create local_mapping.make (5)
		end

	make_copy (a_other: E2B_ENTITY_MAPPING)
			-- Initialize with data from `a_other'.
		do
			current_expression := a_other.current_expression
			result_expression := a_other.result_expression
			heap := a_other.heap
			old_heap := a_other.old_heap
			create argument_mapping.make (5)
			argument_mapping.copy (a_other.argument_mapping)
			create local_mapping.make (5)
			local_mapping.copy (a_other.local_mapping)
		end

feature -- Access

	current_expression: IV_EXPRESSION
			-- Expression for `Current'.

	result_expression: IV_EXPRESSION
			-- Expression for `Result'.

	argument (a_feature: FEATURE_I; a_type: CL_TYPE_A; a_position: INTEGER): IV_EXPRESSION
			-- Argument of feature `a_feature' at position `a_position'.
		local
			l_name: STRING
			l_type: IV_TYPE
		do
			if argument_mapping.has_key (a_position) then
				Result := argument_mapping.item (a_position)
			else
				l_name := a_feature.arguments.item_name (a_position)
				l_type := types.for_class_type (helper.class_type_in_context (a_feature.arguments.i_th (a_position), a_type.base_class, a_feature, a_type))
				create {IV_ENTITY} Result.make (l_name, l_type)
			end
		end

	local_ (a_position: INTEGER): IV_ENTITY
			-- Local of feature `a_feature' at position `a_position'.
		do
			check local_mapping.has_key (a_position) end
			Result := local_mapping.item (a_position).expr
			local_mapping.replace ([Result, True], a_position)
		end

	is_local_used (a_position: INTEGER): BOOLEAN
			-- Has local at position `a_position' been accessed already?
		do
			check local_mapping.has_key (a_position) end
			Result := local_mapping.item (a_position).used
		end

	heap: IV_EXPRESSION
			-- Expression for heap.

	old_heap: IV_EXPRESSION
			-- Expression for old heap.

	default_result_name: STRING = "Result"
			-- Default name for `Result'.

	default_current_name: STRING = "Current"
			-- Default name for `Current'.

	global_heap_name: STRING = "Heap"
			-- Name of global heap.

	bound_heap_name: STRING = "heap"
			-- Name of heap as bound variable.

feature -- Element change

	set_current (a_current: IV_EXPRESSION)
			-- Set `current_entity' to `a_current'.
		require
			a_current_attached: attached a_current
		do
			current_expression := a_current
		ensure
			current_expression_set: current_expression = a_current
		end

	set_result (a_result: IV_EXPRESSION)
			-- Set `result_expression' to `a_result'.
		require
			a_result_attached: attached a_result
		do
			result_expression := a_result
		ensure
			result_expression_set: result_expression = a_result
		end

	set_default_result (a_type: CL_TYPE_A)
			-- Set `result_expression' to a default result entity fo type `a_type'.
		do
			create {IV_ENTITY} result_expression.make (default_result_name, types.for_class_type (a_type))
		end

	set_argument (a_position: INTEGER; a_expression: IV_EXPRESSION)
			-- Set arguement at position `a_position' to `a_expression'.
		do
			argument_mapping.extend (a_expression, a_position)
		end

	clear_arguments
			-- Clear argument mapping.
		do
			argument_mapping.wipe_out
		end

	set_local (a_position: INTEGER; a_expression: IV_ENTITY)
			-- Set local at position `a_position' to `a_expression'.
		do
			local_mapping.extend ([a_expression, False], a_position)
		end

	clear_locals
			-- Clear local mapping.
		do
			local_mapping.wipe_out
		end

	set_heap (a_expr: IV_EXPRESSION)
			-- Set `heap' to `a_expr'.
		require
			a_expr_attached: attached a_expr
		do
			heap := a_expr
		ensure
			heap_set: heap = a_expr
		end

	set_old_heap (a_expr: IV_EXPRESSION)
			-- Set `old_heap' to `a_expr'.
		require
			a_expr_attached: attached a_expr
		do
			old_heap := a_expr
		ensure
			old_heap_set: old_heap = a_expr
		end

feature {E2B_ENTITY_MAPPING} -- Implementation

	argument_mapping: HASH_TABLE [IV_EXPRESSION, INTEGER]
			-- Mapping for arguments.

	local_mapping: HASH_TABLE [TUPLE [expr: IV_ENTITY; used: BOOLEAN], INTEGER]
			-- Mapping for locals.

end
