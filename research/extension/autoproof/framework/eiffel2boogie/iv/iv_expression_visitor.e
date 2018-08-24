note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IV_EXPRESSION_VISITOR

feature -- Visitor

	process_binary_operation (a_operation: IV_BINARY_OPERATION)
			-- Process `a_operation'.
		require
			a_operation_attached: attached a_operation
		deferred
		end

	process_conditional_expression (a_value: IV_CONDITIONAL_EXPRESSION)
			-- Process `a_value'.
		require
			a_value_attached: attached a_value
		deferred
		end

	process_entity (a_entity: IV_ENTITY)
			-- Process `a_entity'.
		require
			a_entity_attached: attached a_entity
		deferred
		end

	process_exists (a_exists: IV_EXISTS)
			-- Process `a_exists'.
		require
			a_exists_attached: attached a_exists
		deferred
		end

	process_forall (a_forall: IV_FORALL)
			-- Process `a_forall'.
		require
			a_forall_attached: attached a_forall
		deferred
		end

	process_function_call (a_call: IV_FUNCTION_CALL)
			-- Process `a_call'.
		require
			a_call_attached: attached a_call
		deferred
		end

	process_map_access (a_map_access: IV_MAP_ACCESS)
			-- Process `a_map_access'.
		require
			a_map_access_attached: attached a_map_access
		deferred
		end

	process_map_update (a_map_update: IV_MAP_UPDATE)
			-- Process `a_map_update'.
		require
			a_map_update_attached: attached a_map_update
		deferred
		end

	process_unary_operation (a_operation: IV_UNARY_OPERATION)
			-- Process `a_operation'.
		require
			a_operation_attached: attached a_operation
		deferred
		end

	process_value (a_value: IV_VALUE)
			-- Process `a_value'.
		require
			a_value_attached: attached a_value
		deferred
		end

end
