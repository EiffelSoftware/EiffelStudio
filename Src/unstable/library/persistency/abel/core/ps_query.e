note
	description:"[
	Represents a general query on objects of type G to a repository.
	To reuse a query object, invoke feature reset first.
	]"
	author: "Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_QUERY [G -> ANY]

inherit PS_EIFFELSTORE_EXPORT

feature -- Access

	repository: PS_REPOSITORY
			-- The repository against which `Current' has been executed.
		require
			executed: is_executed
		do
			Result := transaction.repository
		end

	transaction_context: detachable PS_TRANSACTION_CONTEXT
			-- The transaction context in which `Current' has been executed, if any.
		require
			executed: is_executed
		attribute
		end

feature -- Status report

	is_executed: BOOLEAN
			-- Has query been executed?

	is_closed: BOOLEAN
			-- Has the query been closed?

	is_object_query: BOOLEAN
			-- Is `Current' an instance of PS_OBJECT_QUERY?
		deferred
		end

	is_tuple_query: BOOLEAN
			-- Is `Current' an instance of PS_TUPLE_QUERY?
		do
			Result := not is_object_query
		end

feature -- Access: query parameter

	criteria: PS_CRITERION
			-- Criteria for `Current' query.

	is_non_root_ignored: BOOLEAN
			-- Are non-root objects ignored?
		do
			fixme ("Implement root concept")
			Result := False
		end

	object_initialization_depth: INTEGER
			-- The depth up to which objects shall be initialized.
			-- Default to -1, which means full initialization.

feature -- Element change

	set_criterion (a_criterion: PS_CRITERION)
			-- Set the criteria `a_criterion', against which the objects will be selected.
		require
			set_before_execution: not is_executed
			only_predefined: not a_criterion.has_agent_criterion
			criterion_can_handle_objects: is_criterion_fitting_generic_type (a_criterion)
		do
			criteria := a_criterion
		ensure
			criteria_set: criteria = a_criterion
		end

	set_is_non_root_ignored (value: BOOLEAN)
			-- Set `is_non_root_ignored' to `value'
		do
			fixme ("implement")
		end

	set_object_initialization_depth (depth: INTEGER)
			-- Set `object_initialization_depth' to `depth'.
			-- A depth of 1 means only the object will be loaded, but none of its referenced objects.
			-- A depth of 2 means the object will be loaded an all its referenced objects
			-- will be loaded with depth 1 (and so on...).
			-- | Note: This setting may increase performance but is very dangerous because
			-- | you may get invariant violations and void references even in void-safe mode!
		do
			object_initialization_depth := depth
		end

feature -- Disposal

	reset
			-- Reset the query result, do not change criterion or projection.
			-- Invoke if you want to reuse current query.
		do
			if not is_closed and is_executed then
				close
			end

			is_closed := False
			transaction_impl := Void
			create_result_cursor
			result_cursor.set_query (Current)
			is_executed := False
			backend_identifier := 0
			create result_cache.make (100)
			-- object_initialization_depth := -1
		ensure
			not_executed: not is_executed
			not_bound_to_transaction: transaction_impl = Void
			unrecognizable_to_backend: backend_identifier = 0

			criteria_unchanged: criteria = old criteria
			root_setting_unchanged: is_non_root_ignored = old is_non_root_ignored
			initialization_depth_unchanged: object_initialization_depth = old object_initialization_depth
			type_unchagned: generic_type  = old generic_type
		end

	close
			-- Close the current query
		do
			if not is_closed and is_executed then
				fixme ("Remove the hack for readonly queries through EXECUTOR (-> attached transacion_context)")
				if transaction.is_readonly and attached transaction_context then
					transaction.repository.commit_transaction (transaction)
				end
				if attached transaction_context as ctx then
					ctx.internal_active_queries.prune_all (Current)
				end
				fixme ("TODO: clean up internal data structures")
			end
			is_closed := True


		end

feature -- Contract support functions

	is_criterion_fitting_generic_type (a_criterion: PS_CRITERION): BOOLEAN
			-- Can `a_criterion' handle objects of type `G'?
		local
			reflection: INTERNAL
			type: TYPE[G]
		do
			type:= {G}
			create reflection
			Result := a_criterion.can_handle_object (reflection.new_instance_of (type.type_id))
		end

feature {PS_EIFFELSTORE_EXPORT} -- Internal

	set_type (type: TYPE[detachable ANY])
			-- Helper function for testing.
		local
			reflection: INTERNAL
		do
			create reflection
			generic_type := reflection.type_of_type (reflection.detachable_type (type.type_id))
		end

	result_cache: ARRAYED_LIST [ANY]
			-- The cached results.

	result_cursor: PS_RESULT_CURSOR [ANY]
			-- Iteration cursor containing the result of the query.
		deferred
		end

	transaction: PS_TRANSACTION
			-- The transaction in which this query is embedded.
		require
			already_executed: is_executed
		do
			check attached transaction_impl as transact then
				Result := transact
			end
		end

	register_as_executed (a_transaction: PS_TRANSACTION)
			-- Set `is_executed' to true and bind query to `a_transaction'.
		require
			not_yet_executed: not is_executed
		do
			is_executed := True
			transaction_impl := a_transaction
		ensure
			is_executed = True
			transaction_set: transaction = a_transaction
		end

	generic_type: TYPE [detachable ANY]
			-- Get the (detachable) generic type of `Current'.
--		local
--			reflection: INTERNAL
--		once ("OBJECT")
--			create reflection
--			Result := reflection.type_of_type (reflection.detachable_type (reflection.generic_dynamic_type (Current, 1)))
--		end

	backend_identifier: INTEGER
			-- Identifier for the backend to recognize an already executed query.

	set_identifier (identifier: INTEGER)
			-- Set backend_identifier with `identifier'.
		do
			backend_identifier := identifier
		ensure
			identifier_set: backend_identifier = identifier
		end

	set_transaction_context (context: like transaction_context)
		do
			transaction_context := context
		end

feature {NONE} -- Implementation

	transaction_impl: detachable PS_TRANSACTION

feature {NONE} -- Initialization

	make
			-- Create a query for all objects of type G (no filtering criteria).
		deferred
		ensure
			not_executed: not is_executed
			query_result_after: result_cursor.after
			query_result_initialized: result_cursor.query = Current
			default_criterion: attached {PS_EMPTY_CRITERION} criteria
		end

	make_with_criterion (a_criterion: PS_CRITERION)
			-- Create a query for object of type G filtered using `a_criterion'.
		require
			only_predefined_for_tuples: is_tuple_query implies not a_criterion.has_agent_criterion
			criterion_can_handle_objects: is_criterion_fitting_generic_type (a_criterion)
		do
			make
			set_criterion (a_criterion)
		ensure
			not_executed: not is_executed
			query_result_after: result_cursor.after
			query_result_initialized: result_cursor.query = Current
			criteria_set: criteria = a_criterion
		end


	initialize
			-- Initialize the shared parts between object and tuple queries.
		local
			reflection: INTERNAL
		do
			object_initialization_depth := -1
			create {PS_EMPTY_CRITERION} criteria
			create result_cache.make (100)
			create reflection
			generic_type := reflection.type_of_type (reflection.detachable_type (reflection.generic_dynamic_type (Current, 1)))
			reset
		end

	create_result_cursor
			-- Create a new result set.
		deferred
		end

invariant
	query_result_correctly_initialized: result_cursor.query = Current
	transaction_set_if_executed: is_executed implies transaction_impl /= Void
	not_executed_implies_after: not is_executed implies result_cursor.after
	valid_initialization_depth: object_initialization_depth > 0 or object_initialization_depth = -1

end
