note
	description:"[
		This class contains the shared parts of both PS_TUPLE_QUERY
		and PS_QUERY.

		The generic parameter OBJECT_TYPE denotes the type of the objects
		to be queried.
		Note: Due to a limitation in the underlying reflection library,
		ABEL will not return any descendants of OBJECT_TYPE. In a future
		release this behaviour may change however.

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
		queries and OBJECT_TYPE for normal queries.
	]"
	author: "Marco Piccioni, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_ABSTRACT_QUERY [OBJECT_TYPE -> ANY, RESULT_TYPE -> ANY]

inherit

	PS_ABEL_EXPORT

	ITERABLE [RESULT_TYPE]

feature -- Access

	repository: PS_REPOSITORY
			-- The repository against which `Current' has been executed.
		require
			executed: is_executed
		do
			Result := internal_transaction.repository
		end

	transaction: detachable PS_TRANSACTION
			-- The transaction context in which `Current' has been executed, if any.
		require
			executed: is_executed
		attribute
		end

	new_cursor: ITERATION_CURSOR [RESULT_TYPE]
			-- Return a fresh cursor over the query result.
			-- Note: The result is loaded lazily upon calling `{ITERATION_CURSOR}.forth'.
			-- Note: The results are cached internally, thus it is possible to iterate over the result
			--   many times without performance impact.
		do
			if is_executed and not is_closed then
				create {PS_ITERATION_CURSOR [RESULT_TYPE]} Result.make (Current)
			else
				Result := (create {LINKED_LIST [RESULT_TYPE]}.make).new_cursor
			end
		end

feature -- Status report

	is_executed: BOOLEAN
			-- Has query been executed?

	is_closed: BOOLEAN
			-- Has the query been closed?

	is_tuple_query: BOOLEAN
			-- Is `Current' an instance of PS_TUPLE_QUERY?
		deferred
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

feature {PS_UNSAFE} -- Element change (unsafe)

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
			transaction := Void
			transaction_impl := Void
			read_manager := Void
			create {PS_ITERATION_CURSOR [RESULT_TYPE]} stable_cursor.make (Current)
			is_executed := False
			create result_cache.make (100)
			is_after := True
		ensure
			not_executed: not is_executed
			not_closed: not is_closed
			no_internal_transaction: transaction_impl = Void
			no_read_manager: read_manager = Void

			criteria_unchanged: criterion = old criterion
			root_setting_unchanged: is_non_root_ignored = old is_non_root_ignored
			initialization_depth_unchanged: object_initialization_depth = old object_initialization_depth
			type_unchagned: generic_type  = old generic_type
		end

	close
			-- Close the current query
		do
			if not is_closed and is_executed then

				is_closed := True
				check
					readonly_or_embedded: internal_transaction.is_readonly xor attached transaction
				end

				if attached transaction as tr then
					tr.internal_active_queries.prune_all (Current)
				else
					internal_transaction.repository.commit_transaction (internal_transaction)
				end

				fixme ("TODO: clean up internal data structures")
			end
			is_closed := True
		end

feature -- Contract support functions

	is_criterion_fitting_generic_type (a_criterion: PS_CRITERION): BOOLEAN
			-- Can `a_criterion' handle objects of type `OBJECT_TYPE'?
		do
			Result := a_criterion.can_handle_type (generic_type)
		end

feature {PS_ABEL_EXPORT} -- Testing support

	set_type (type: TYPE [detachable ANY])
			-- Helper function for testing.
		local
			reflection: INTERNAL
		do
			create reflection
			generic_type := reflection.type_of_type (reflection.detachable_type (type.type_id))
		end

	stable_cursor: ITERATION_CURSOR [RESULT_TYPE]
			-- A cursor which won't be generated anew each time.
		obsolete
			"Store the cursor at client side"
		attribute
		end

feature {PS_ABEL_EXPORT} -- Implementation : Access

	is_after: BOOLEAN
			-- Has `Current' retrieved all items?

	generic_type: TYPE [detachable ANY]
			-- Get the (detachable) generic type of `Current'.

	result_cache: ARRAYED_LIST [ANY]
			-- The cached results.

	internal_transaction: PS_INTERNAL_TRANSACTION
			-- The transaction in which this query is embedded.
		require
			already_executed: is_executed
		do
			check attached transaction_impl as transact then
				Result := transact
			end
		end

	read_manager: detachable PS_READ_MANAGER
			-- The read manager associated to `Current'.

	transaction_impl: detachable PS_INTERNAL_TRANSACTION

feature {PS_ABEL_EXPORT} -- Implementation: Element change

	prepare_execution (a_transaction: PS_INTERNAL_TRANSACTION; a_read_manager: PS_READ_MANAGER)
			-- Set `is_executed' to True and initialize the internal data structures.
		require
			not_yet_executed: not is_executed
		do
			is_executed := True
			is_after := False
			transaction_impl := a_transaction
			read_manager := a_read_manager
		ensure
			executed: is_executed = True
			transaction_set: internal_transaction = a_transaction
			read_manager_set: read_manager = a_read_manager
		end

	set_transaction (context: like transaction)
		do
			transaction := context
		end

	set_result_item (object: ANY)
			-- Add `object' to the results.
		require
			actual_type_is_G: attached {RESULT_TYPE} object
		do
			result_cache.extend (object)
		end

	set_is_after
			-- Set `is_after' to True.
		do
			is_after := True
		end

	retrieve_next
			-- Retrieve the next item from the database and store it in `result_cache'.
		require
			not_after: not is_after
			executed: is_executed
			active_transaction: internal_transaction.is_active
		deferred
		ensure
			active_transaction: internal_transaction.is_active
			no_error: not internal_transaction.has_error
		end

feature {NONE} -- Initialization

	make
			-- Create a query for all objects of type `OBJECT_TYPE' (without filtering criteria).
		do
			object_initialization_depth := -1
			create {PS_EMPTY_CRITERION} criterion
			generic_type := {detachable OBJECT_TYPE}
			reset
		ensure
			not_executed: not is_executed
			query_result_after: is_after
			default_criterion: attached {PS_EMPTY_CRITERION} criterion
		end

	make_with_criterion (a_criterion: PS_CRITERION)
			-- Create a query for object of type `OBJECT_TYPE' filtered using `a_criterion'.
		require
			only_predefined_for_tuples: is_tuple_query implies not a_criterion.has_agent_criterion
			criterion_can_handle_objects: a_criterion.can_handle_type ({detachable OBJECT_TYPE})
		do
			make
			set_criterion (a_criterion)
		ensure
			not_executed: not is_executed
			query_result_after: is_after
			criteria_set: criterion = a_criterion
		end

invariant
	valid_initialization_depth: object_initialization_depth > 0 or object_initialization_depth = -1

	attached_transaction_when_executed: is_executed = attached transaction_impl
	attached_read_manager_when_executed: is_executed = attached read_manager
	after_when_closed: is_closed implies new_cursor.after
	after_when_not_executed: not is_executed implies new_cursor.after
end
