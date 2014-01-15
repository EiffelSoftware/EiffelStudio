note
	description: "[
		An abstract repository with a common interface to 
		read and manipulate persistent objects.
		
		To create a new repository, use the PS_*_REPOSITORY_FACTORY 
		shipped with each ABEL backend.
		
		A repository can be used to execute read-only queries or create
		a new transaction for read-write operations.
		
		It is possible to change some of the default settings
		for performance tuning, such as the transaction isolation level
		or the batch size for lazy loading during query execution.
		]"
	author: "Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_REPOSITORY

inherit
	PS_ABEL_EXPORT

feature -- Constants

	Default_retry_count: INTEGER = 1
			-- The default number of retries for implicit transactions.

	Infinite_batch_size: INTEGER = -1
			-- The special value for an infinite batch size, i.e. to disable lazy loading.

feature -- Access

	transaction_isolation: PS_TRANSACTION_SETTINGS
			-- The isolation settings for transactions in `Current'.

	batch_retrieval_size: INTEGER
			-- Define the number of objects to be retrieved in one batch for query operations.
			-- Set to `infinite_batch_size' to retrieve all objects at once (and disable lazy loading).
		deferred
		end

	retry_count: INTEGER
			-- The default retries for implicit transaction handling, if there is a transaction conflict.

	active_queries: CONTAINER [PS_ABSTRACT_QUERY [ANY, ANY]]
			-- The currently active queries (which are not executed within a transaction).
		do
			Result := internal_active_queries
		end

	active_transactions: CONTAINER [PS_TRANSACTION]
			-- The currently active transactions.
		do
			Result := internal_active_transactions
		end

feature -- Element change

	set_batch_retrieval_size (size: INTEGER)
			-- Set `batch_retrieval_size' to `size'.
		require
			valid: size > 0 or size = infinite_batch_size
		deferred
		ensure
			correct: batch_retrieval_size = size
		end

	set_retry_count (count: INTEGER)
			-- Set `retry_count' to `count'.
		require
			positive: count >= 0
		do
			retry_count := count
		ensure
			correct: retry_count = count
		end

feature -- Query execution

	execute_query (query: PS_QUERY [ANY])
			-- Execute `query' against the database.
			-- The result can be fetched by calling `query.new_cursor' afterwards.
			-- Note that the query is executed in an hidden, implicit transaction context
			-- and that the result cannot be used for any subsequent update operation.
		require
			not_active: not active_queries.has (query)
			not_executed: not query.is_executed
			not_closed: not query.is_closed
		local
			attempts: INTEGER
			transaction: detachable PS_INTERNAL_TRANSACTION
		do
			from
				attempts := 0
			until
					-- Try several times in case of a transaction conflict.
				attempts > retry_count or
				(attempts > 0 and then
				not attached {PS_TRANSACTION_ABORTED_ERROR} query.last_error)
			loop
				query.reset
				transaction := new_internal_transaction (True)
				internal_active_queries.extend (query)
				internal_execute_query (query, transaction)
				attempts := attempts + 1
			variant
				retry_count - attempts + 2
			end
		ensure
			active: query.has_error xor active_queries.has (query)
			executed: query.is_executed
			not_closed: query.has_error xor not query.is_closed
		end

	execute_tuple_query (query: PS_TUPLE_QUERY [ANY])
			-- Execute `query' against the database.
			-- The result can be fetched by calling `query.new_cursor' afterwards.
			-- Note that the query is executed in an hidden, implicit transaction context
			-- and that the result cannot be used for any subsequent write operations.
		require
			not_active: not active_queries.has (query)
			not_executed: not query.is_executed
			not_closed: not query.is_closed
		local
			attempts: INTEGER
			transaction: detachable PS_INTERNAL_TRANSACTION
		do
			from
				attempts := 0
			until
					-- Try several times in case of a transaction conflict.
				attempts > retry_count or
				(attempts > 0 and then
				not attached {PS_TRANSACTION_ABORTED_ERROR} query.last_error)
			loop
				query.reset
				transaction := new_internal_transaction (True)
				internal_active_queries.extend (query)
				internal_execute_tuple_query (query, transaction)
				attempts := attempts + 1
			variant
				retry_count - attempts + 2
			end
		ensure
			active: query.has_error xor active_queries.has (query)
			executed: query.is_executed
			not_closed: query.has_error xor not query.is_closed
		end

feature -- Transactional access

	new_transaction: PS_TRANSACTION
			-- Create a new transaction.
		do
			create Result.make (Current)
		end

feature -- Disposal

	collect_garbage
			-- Perform a garbage collection cycle.
		require
			no_queries: active_queries.is_empty
			no_transactions: active_transactions.is_empty
		deferred
		end

	close
			-- Close the current repository.
		deferred
		end

feature {PS_ABEL_EXPORT} -- Internal: Status report

	can_handle (object: ANY): BOOLEAN
			-- Can `Current' handle the object `object'?
		deferred
		end

	is_identified (object: ANY; transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Is `an_object' already identified and thus registered in this repository?
		do
			Result := transaction.identifier_table.search (object) /= 0
		end

	is_expanded (type: TYPE [detachable ANY]): BOOLEAN
			-- Is `type' expanded?
		do
			Result := type.is_expanded
		ensure
			correct: type.is_expanded implies Result
		end

	is_root (object: ANY; transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Is `object' a garbage collection root?
		local
			id: NATURAL_64
		do
			id := transaction.identifier_table.search (object)
			if id /= 0 then
				Result := transaction.root_flags [id]
			end
		end

feature {PS_ABEL_EXPORT} -- Internal: Querying operations

	internal_execute_query (query: PS_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Executes `query' within `transaction'.
		require
			not_executed: not query.is_executed
			transaction_repository_correct: transaction.repository = Current
			active_transaction: transaction.is_active
			no_error: not transaction.has_error and not query.has_error
		deferred
		ensure
			executed: query.is_executed
			transaction_set: query.internal_transaction = transaction
			valid_transaction_status: transaction.has_error xor transaction.is_active
			after_if_error: transaction.has_error implies query.is_after
			can_handle_retrieved_object: not query.is_after implies can_handle (query.result_cache.last)
			not_after_means_known: (not query.is_after and not transaction.is_readonly) implies (is_expanded (query.generic_type) xor is_identified (query.result_cache.last, transaction))
		end

	internal_execute_tuple_query (tuple_query: PS_TUPLE_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Execute `tuple_query' within `transaction'.
		require
			not_executed: not tuple_query.is_executed
			transaction_repository_correct: transaction.repository = Current
			active_transaction: transaction.is_active
			no_error: not transaction.has_error and not tuple_query.has_error
		deferred
		ensure
			executed: tuple_query.is_executed
			transaction_set: tuple_query.internal_transaction = transaction
			valid_transaction_status: transaction.has_error xor transaction.is_active
			after_if_error: transaction.has_error implies tuple_query.is_after
		end

feature {PS_ABEL_EXPORT} -- Internal: Write operations

	write (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Write `object' to the database.
			-- Perform an update if object `is_identified', otherwise do an insert.
		require
			repository_correct: transaction.repository = Current
			active: transaction.is_active
			can_handle_object: can_handle (object)
			no_error: not transaction.has_error
		deferred
		ensure
			valid_transaction_status: transaction.is_active xor transaction.has_error
			object_known: not transaction.has_error implies  is_identified (object, transaction) xor is_expanded (object.generating_type)
		end

	direct_update (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Update `object', but none of its references.
		require
			repository_correct: transaction.repository = Current
			active: transaction.is_active
			can_handle_object: can_handle (object)
			no_error: not transaction.has_error
			not_expanded: not is_expanded (object.generating_type)
			object_known: is_identified (object, transaction)
		deferred
		ensure
			valid_transaction_status: transaction.is_active xor transaction.has_error
			object_known: not transaction.has_error implies is_identified (object, transaction)
		end

	set_root_status (object: ANY; value: BOOLEAN; transaction: PS_INTERNAL_TRANSACTION)
			-- Set the root status of `object' to `value'.
		require
			repository_correct: transaction.repository = Current
			active: transaction.is_active
			can_handle_object: can_handle (object)
			no_error: not transaction.has_error
			not_expanded: not is_expanded (object.generating_type)
			object_known: is_identified (object, transaction)
		deferred
		ensure
			valid_transaction_status: transaction.is_active xor transaction.has_error
			object_known: not transaction.has_error implies is_identified (object, transaction)
			root_set: not transaction.has_error implies is_root (object, transaction) = value
		end

feature {PS_ABEL_EXPORT} -- Internal: Transaction handling

	new_internal_transaction (readonly: BOOLEAN): PS_INTERNAL_TRANSACTION
			-- Create a new internal transaction.
		do
			max_transaction_id := max_transaction_id + 1
			if readonly then
				create Result.make_readonly (Current, max_transaction_id)
			else
				create Result.make (Current, create {PS_ROOT_OBJECT_STRATEGY}.make_argument_of_insert, max_transaction_id)
			end
		end

	commit_transaction (transaction: PS_INTERNAL_TRANSACTION)
			-- Commit `transaction'. If the commit fails, `transaction.has_error' is True.
		require
			repository_correct: transaction.repository = Current
			active: transaction.is_active
			no_error: not transaction.has_error
		deferred
		ensure
			dead: not transaction.is_active
		end

	rollback_transaction (transaction: PS_INTERNAL_TRANSACTION)
			-- Rollback `transaction'.
			-- This feature may be called when an exception happens to do some cleanup.
		require
			repository_correct: transaction.repository = Current
			active: transaction.is_active
		deferred
		ensure
			dead: not transaction.is_active
			error_unchanged: transaction.has_error = old (transaction.has_error)
		end

feature {PS_ABEL_EXPORT} -- Testing

	wipe_out
			-- Wipe out all data.
		deferred
		end

feature {PS_ABEL_EXPORT} -- Implementation

	internal_active_queries: ARRAYED_LIST [PS_ABSTRACT_QUERY [ANY, ANY]]
			-- A list of active queries.

	internal_active_transactions: HASH_TABLE [PS_TRANSACTION, PS_INTERNAL_TRANSACTION]
			-- A list of active transactions.

feature {NONE} -- Implementation

	max_transaction_id: INTEGER
			-- The maximum transaction id.

	initialize
			-- Initialize some data structures.
		do
			create internal_active_queries.make (1)
			create internal_active_transactions.make (1)
		end

invariant
	valid_batch_size: batch_retrieval_size > 0 or batch_retrieval_size = infinite_batch_size
	retry_count_positive: retry_count >= 0
	max_transaction_id_positive: max_transaction_id >= 0
end
