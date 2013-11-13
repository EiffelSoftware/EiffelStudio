note
	description:"[
		This class contains the shared parts of both PS_TUPLE_QUERY
		and PS_OBJECT_QUERY.

		The generic parameter OBJECT_TYPE denotes the type of the objects
		to be queried. This does not include any descendants.

		The general workflow with queries is as follows:
		
			1) Create a new query object.
			2) Adjust the retrieval paramaters
			3) Execute them in a transaction or repository
			4) Iterate over the results
			5) Close the query.
		
		Iterating over the result can be done with the convenient 
		across syntax. Example:
		
			across 
				some_query as cursor
			loop
				print (cursor.item)
			end
		
		The type of `cursor.item' is RESULT_TYPE, i.e. TUPLE for tuple
		queries and OBJECT_TYPE for object queries.
	]"
	author: "Marco Piccioni, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_QUERY [OBJECT_TYPE -> ANY, RESULT_TYPE -> ANY]

inherit

	PS_EIFFELSTORE_EXPORT

	ITERABLE [RESULT_TYPE]

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

	new_cursor: ITERATION_CURSOR [RESULT_TYPE]
			-- Return a fresh cursor over the query result.
			-- Note: The result is loaded lazily upon calling `{ITERATION_CURSOR}.forth'.
			-- Note: The results are cached interanlly, thus it is possible to iterate over the result
			--   many times without performance impact.
		do
			create {PS_ITERATION_CURSOR [RESULT_TYPE]} Result.make (Current)
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

feature -- Access: Retrieval Parameter

	criterion: PS_CRITERION
			-- The criterion against which the result will be filtered.

	is_non_root_ignored: BOOLEAN
			-- Are non-root objects ignored?

	object_initialization_depth: INTEGER
			-- The depth up to which objects shall be initialized.
			-- Default to -1, which means full initialization.

feature -- Element change

	set_criterion (a_criterion: PS_CRITERION)
			-- Set `criterion' to  `a_criterion'.
		require
			set_before_execution: not is_executed
			only_predefined_for_tuples: is_tuple_query implies not a_criterion.has_agent_criterion
			criterion_can_handle_objects: is_criterion_fitting_generic_type (a_criterion)
		do
			criterion := a_criterion
		ensure
			criteria_set: criterion = a_criterion
		end

	set_is_non_root_ignored (value: BOOLEAN)
			-- Set `is_non_root_ignored' to `value'
		do
			is_non_root_ignored := value
		end

feature {PS_EIFFELSTORE_EXPORT} -- Element change (unsafe)

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
			create result_cursor.make
			result_cursor.set_query (Current)
			is_executed := False
			backend_identifier := 0
			create result_cache.make (100)
		ensure
			not_executed: not is_executed
			not_bound_to_transaction: transaction_impl = Void
			unrecognizable_to_backend: backend_identifier = 0

			criteria_unchanged: criterion = old criterion
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
			-- Can `a_criterion' handle objects of type `OBJECT_TYPE'?
		local
			reflection: INTERNAL
			type: TYPE[OBJECT_TYPE]
		do
			fixme ("Use internal type, but take care of `make_with_criterion' contract")
			type:= {OBJECT_TYPE}
			create reflection
			Result := a_criterion.can_handle_object (reflection.new_instance_of (type.type_id))
		end

feature {PS_EIFFELSTORE_EXPORT} -- Implementation

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

	result_cursor: PS_RESULT_CURSOR [RESULT_TYPE]
			-- Iteration cursor containing the result of the query.

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
			-- Create a query for all objects of type `OBJECT_TYPE' (without filtering criteria).
		local
			reflection: INTERNAL
		do
			object_initialization_depth := -1
			create {PS_EMPTY_CRITERION} criterion
			create reflection
			generic_type := reflection.type_of_type (reflection.detachable_type (reflection.generic_dynamic_type (Current, 1)))
			reset
		ensure
			not_executed: not is_executed
			query_result_after: result_cursor.after
			query_result_initialized: result_cursor.query = Current
			default_criterion: attached {PS_EMPTY_CRITERION} criterion
		end

	make_with_criterion (a_criterion: PS_CRITERION)
			-- Create a query for object of type `OBJECT_TYPE' filtered using `a_criterion'.
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
			criteria_set: criterion = a_criterion
		end

invariant
	query_result_correctly_initialized: result_cursor.query = Current
	transaction_set_if_executed: is_executed implies transaction_impl /= Void
	not_executed_implies_after: not is_executed implies result_cursor.after
	valid_initialization_depth: object_initialization_depth > 0 or object_initialization_depth = -1

end
