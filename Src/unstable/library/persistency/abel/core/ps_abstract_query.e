note
	description:"[
		The shared parts for both PS_TUPLE_QUERY and PS_QUERY.

		The generic parameter OBJECT_TYPE denotes the type of the objects
		to be queried. By default ABEL will also return all objects of
		a subtype of OBJECT_TYPE, but you can change this behaviour with
		the feature `set_is_subtype_included'.

		The general workflow with queries is as follows:
		
			1) Create a new query object.
			2) Adjust the retrieval paramaters.
			3) Execute them in a transaction or repository.
			4) Iterate over the results.
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

	last_error: detachable PS_ERROR
			-- The last encountered error.
		require
			executed: is_executed
		do
			Result := internal_transaction.error
		end

	new_cursor: ITERATION_CURSOR [RESULT_TYPE]
			-- Return a fresh cursor over the query result.
			-- If the query is not executed or already closed, the cursor will point to an empty structure.
			-- Note: The result is loaded lazily upon calling `{ITERATION_CURSOR}.forth'.
			-- Note: The results are cached internally, thus it is possible to iterate over the result
			--   many times without performance impact.
		do
			if is_executed and not is_closed then
				create {PS_ITERATION_CURSOR [RESULT_TYPE]} Result.make (Current)
			else
				Result := (create {LINKED_LIST [RESULT_TYPE]}.make).new_cursor
			end
		ensure then
			after_when_not_executed: not is_executed implies Result.after
			after_when_closed: is_closed implies Result.after
		end

feature -- Status report

	is_executed: BOOLEAN
			-- Has query been executed?
		do
			Result := attached internal_cursor
		end

	is_closed: BOOLEAN
			-- Has the query been closed?

	has_error: BOOLEAN
			-- Has an error happened during query execution or lazy loading?
		do
			Result := is_executed and then attached last_error
		ensure
			correct: Result = attached last_error
		end

	is_tuple_query: BOOLEAN
			-- Is `Current' an instance of PS_TUPLE_QUERY?
		deferred
		end

feature -- Access: Retrieval Parameter

	criterion: PS_CRITERION
			-- The criterion against which the result will be filtered.

	is_non_root_ignored: BOOLEAN
			-- Are non-root objects ignored?

	is_subtype_included: BOOLEAN
			-- Are objects of a subtype of `OBJECT_TYPE' included in the result?

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
			-- Set `is_non_root_ignored' to `value'.
		do
			is_non_root_ignored := value
		ensure
			is_non_root_ignored_set: is_non_root_ignored = value
		end

	set_is_subtype_included (value: BOOLEAN)
			-- Set `is_subtype_included' to `value'.
		do
			is_subtype_included := value
		ensure
			is_subtype_included_set: is_subtype_included = value
		end

feature {PS_UNSAFE} -- Element change (unsafe)

	set_object_initialization_depth (depth: INTEGER)
			-- Set `object_initialization_depth' to `depth'.
			-- A depth of 1 means only the object will be loaded, but none of its referenced objects.
			-- A depth of 2 means the object will be loaded an all its referenced objects
			-- will be loaded with depth 1 (and so on...).
			-- Note: This setting may increase performance but is very dangerous because
			-- you may get invariant violations and void references even in void-safe mode!
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
			internal_cursor := Void
			create {PS_ITERATION_CURSOR [RESULT_TYPE]} stable_cursor.make (Current)
			result_cache.wipe_out
			is_after := True
		ensure
			not_executed: not is_executed
			not_closed: not is_closed
			no_internal_transaction: transaction_impl = Void
			no_internal_cursor: internal_cursor = Void


			criteria_unchanged: criterion = old criterion
			root_setting_unchanged: is_non_root_ignored = old is_non_root_ignored
			initialization_depth_unchanged: object_initialization_depth = old object_initialization_depth
			type_unchagned: generic_type  = old generic_type
		end

	close
			-- Close the current query.
		do
			if not is_closed and is_executed then
				check
					readonly_or_embedded: internal_transaction.is_readonly xor attached transaction
				end

				if attached transaction as tr then
					tr.internal_active_queries.prune_all (Current)
				else
					internal_transaction.repository.internal_active_queries.prune_all (Current)
					internal_transaction.repository.commit_transaction (internal_transaction)
				end
			end
			is_after := True
			is_closed := True
		ensure
			closed: is_closed
			not_active: attached transaction as tr implies not tr.active_queries.has (Current)
			not_active_in_repository: is_executed and not attached transaction implies not repository.active_queries.has (Current)
			criteria_unchanged: criterion = old criterion
			root_setting_unchanged: is_non_root_ignored = old is_non_root_ignored
			initialization_depth_unchanged: object_initialization_depth = old object_initialization_depth
			type_unchagned: generic_type  = old generic_type
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
			"Store the cursor at client side [2017-05-31]."
		attribute
		end

feature {PS_ABEL_EXPORT} -- Implementation : Access

	is_after: BOOLEAN
			-- Has `Current' retrieved all items?

	generic_type: TYPE [detachable ANY]
			-- Get the (detachable) generic type of `Current'.

	result_cache: ARRAYED_LIST [RESULT_TYPE]
			-- The cached results.

	internal_transaction: PS_INTERNAL_TRANSACTION
			-- The transaction in which this query is embedded.
		require
			already_executed: is_executed
		do
			check from_precondition_and_invariant: attached transaction_impl as transact then
				Result := transact
			end
		end

	transaction_impl: detachable PS_INTERNAL_TRANSACTION
			-- The detachable field for `internal_transaction'.

	internal_cursor: detachable ITERATION_CURSOR [ANY]
			-- The internal result cursor.

feature {PS_ABEL_EXPORT} -- Implementation: Element change

	prepare_execution (a_transaction: PS_INTERNAL_TRANSACTION; cursor: ITERATION_CURSOR [ANY])
			-- Set `is_executed' to True and initialize the internal data structures.
		require
			not_yet_executed: not is_executed
		do
			is_after := False
			transaction_impl := a_transaction
			internal_cursor := cursor
		ensure
			executed: is_executed = True
			transaction_set: internal_transaction = a_transaction
			cursor_set: internal_cursor = cursor
		end

	set_transaction (a_transaction: like transaction)
			-- Set `transaction' to `a_transaction'.
		do
			transaction := a_transaction
		ensure
			transaction_set: transaction = a_transaction
		end

	retrieve_next
			-- Retrieve the next item from the database and store it in `result_cache'.
		require
			not_after: not is_after
			executed: is_executed
			active_transaction: internal_transaction.is_active
			not_closed: not is_closed
		deferred
		ensure
			active_or_error: internal_transaction.is_active xor has_error
			type_correct: not is_after implies attached {RESULT_TYPE} result_cache.last
		end

	do_rescue
			-- The rescue action when an error on `retrieve_next' happens.
		require
			executed: is_executed
		do
			is_after := True
			is_closed := True

			if not has_error then
				internal_transaction.set_default_error
			end

			if internal_transaction.is_active then
				internal_transaction.repository.rollback_transaction (internal_transaction)
				internal_transaction.close
			end

			if attached transaction as tr then
				internal_transaction.repository.internal_active_transactions.remove (internal_transaction)
				tr.internal_active_queries.prune_all (Current)
			else
				internal_transaction.repository.internal_active_queries.prune_all (Current)
			end

		ensure
			has_error: has_error
			closed: is_closed
			after: is_after
		end

feature {NONE} -- Initialization

	make
			-- Create a query for all objects of type `OBJECT_TYPE' (without filtering criteria).
		do
			object_initialization_depth := -1
			create {PS_EMPTY_CRITERION} criterion
			is_subtype_included := True
			generic_type := {detachable OBJECT_TYPE}
			create result_cache.make (100)
			create {PS_ITERATION_CURSOR [RESULT_TYPE]} stable_cursor.make (Current)
			reset
		ensure
			not_executed: not is_executed
			query_result_after: is_after
			default_criterion: attached {PS_EMPTY_CRITERION} criterion
			subtypes_included_by_default: is_subtype_included
			non_root_included_by_default: not is_non_root_ignored
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
			subtypes_included_by_default: is_subtype_included
			non_root_included_by_default: not is_non_root_ignored
		end

invariant
	valid_initialization_depth: object_initialization_depth > 0 or object_initialization_depth = -1
	attached_transaction_when_executed: is_executed = attached transaction_impl
	attached_cursor_when_executed: is_executed = attached internal_cursor

	same_context: (is_executed and then attached transaction as tr) implies internal_transaction = tr.transaction

--	error_implies_after: has_error implies is_after
end
