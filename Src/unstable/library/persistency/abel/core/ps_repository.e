note
	description: "[
		Represents a repository containing persistent objects.
		
		A repository can be used to execute read-only queries or create
		a new transaction context for read-write operations.
		
		It is possible to change some of the default settings
		for performance tuning, such as the transaction isolation level
		or the batch size for lazy loading during query execution.
		
		The repository class provides a common interface for all ABEL
		backends. However, the creation process cannot be abstracted.
		To hide the (often quite complicated) creation process each
		backend should ship its own factory class for its repository
		implementation.
		]"
	author: "Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_REPOSITORY

inherit
	PS_ABEL_EXPORT

feature -- Access

	transaction_isolation: PS_TRANSACTION_SETTINGS
			-- The isolation settings for transactions in `Current'.

	batch_retrieval_size: INTEGER
			-- Define the number of objects to be retrieved in one batch for query operations.
			-- Set to `infinite_batch_size' to retrieve all objects at once (and disable lazy loading).

	retry_count: INTEGER
			-- The default retries for implicit transaction handling, if there is a transaction conflict.

feature -- Element change

	set_batch_retrieval_size (size: INTEGER)
			-- Set `batch_retrieval_size' to `size'.
		require
			valid: size > 0 or size = infinite_batch_size
		do
			batch_retrieval_size := size
		ensure
			correct: batch_retrieval_size = size
		end

	set_retry_count (count: INTEGER)
			-- Set `retry_count' to `count'
		require
			positive: count >= 0
		do
			retry_count := count
		ensure
			correct: retry_count = count
		end

feature -- Query execution

	execute_query (query: PS_QUERY [ANY])
			-- Execute `query' and store the results in `query.result_cursor'.
			-- Note that the query is executed in an hidden, implicit transaction context
			-- and that the result cannot be used for any subsequent write operations.
		local
			attempts: INTEGER
			transaction: detachable PS_INTERNAL_TRANSACTION
		do
			create transaction.make_readonly (Current)
			internal_execute_query (query, transaction)
		rescue
			if
				attempts <= retry_count
				and then attached transaction as t
				and then attached {PS_TRANSACTION_ABORTED_ERROR} t.error
			then
				attempts := attempts + 1
				retry
			end
		end

	execute_tuple_query (query: PS_TUPLE_QUERY [ANY])
			-- Execute `query' and store the results in `query.result_cursor'.
			-- Note that the query is executed in an hidden, implicit transaction context
			-- and that the result cannot be used for any subsequent write operations.
		local
			attempts: INTEGER
			transaction: detachable PS_INTERNAL_TRANSACTION
		do
			create transaction.make_readonly (Current)
			internal_execute_tuple_query (query, transaction)
		rescue
			if
				attempts <= retry_count
				and then attached transaction as t
				and then attached {PS_TRANSACTION_ABORTED_ERROR} t.error
			then
				attempts := attempts + 1
				retry
			end
		end

feature -- Transactional access

	new_transaction: PS_TRANSACTION
			-- Create a new transaction.
		do
			create Result.make (Current)
		end

feature -- Disposal

	close
			-- Close the current repository.
		do

		end


feature {NONE} -- Obsolete

	transaction_isolation_level: PS_TRANSACTION_ISOLATION_LEVEL
			-- Transaction isolation level.

	set_transaction_isolation_level (a_level: PS_TRANSACTION_ISOLATION_LEVEL)
			-- Set the isolation level for transactions.
		require
			supported: to_implement_assertion ("Supported transaction isolation levels")
		do
			transaction_isolation_level := a_level
		ensure
			transaction_isolation_level = a_level
		end

	global_object_pool: BOOLEAN
			-- Does `Current' maintain a global pool of object identifiers?
		do
			Result := id_manager.is_global_pool
		end

	set_global_pool (val: BOOLEAN)
			-- Set `global_object_pool' to `val'.
		do
			id_manager.set_is_global_pool (val)
		end

feature {PS_ABEL_EXPORT} -- Object query

--		Note: Every feature with a PS_TRANSACTION as an argument will either
--			- return normally, if no error occurred
--			- raise an exception, if any kind of error has occured
--			
--		The actual error is returned in the PS_TRANSACTION.error field,
--		and the transaction is automatically rolled back.


	internal_execute_query (query: PS_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Executes the object query `query' within `transaction'.
		require
			not_executed: not query.is_executed
			transaction_repository_correct: transaction.repository = Current
			active_transaction: transaction.is_active
		deferred
		ensure
			executed: query.is_executed
			transaction_set: query.transaction = transaction
			transaction_still_alive: transaction.is_active
			no_error: not transaction.has_error
			can_handle_retrieved_object: not query.result_cursor.after implies can_handle (query.result_cursor.item)
			not_after_means_known: not query.result_cursor.after implies is_identified (query.result_cursor.item, transaction)
		end

	next_entry (query: PS_QUERY [ANY])
			-- Retrieves the next object and stores the result directly into `query.result_cursor'.
		require
			not_after: not query.result_cursor.after
			already_executed: query.is_executed
			active_transaction: query.transaction.is_active
			query_executed_by_me: query.transaction.repository = Current
		deferred
		ensure
			transaction_still_alive: query.transaction.is_active
			no_error: not query.transaction.has_error
			can_handle_retrieved_object: not query.result_cursor.after implies can_handle (query.result_cursor.item)
			not_after_means_known: not query.result_cursor.after implies is_identified (query.result_cursor.item, query.transaction)
		end

	internal_execute_tuple_query (tuple_query: PS_TUPLE_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Execute the tuple query `tuple_query' within the readonly `transaction'.
		require
--			readonly_transaction: transaction.is_readonly
			not_executed: not tuple_query.is_executed
			transaction_repository_correct: transaction.repository = Current
			active_transaction: transaction.is_active
		deferred
		ensure
			executed: tuple_query.is_executed
			transaction_set: tuple_query.transaction = transaction
			transaction_still_alive: transaction.is_active
			no_error: not transaction.has_error
		end

	next_tuple_entry (tuple_query: PS_TUPLE_QUERY [ANY])
			-- Retrieves the next tuple and stores it in `query.result_cursor'.
		require
			not_after: not tuple_query.result_cursor.after
			already_executed: tuple_query.is_executed
			active_transaction: tuple_query.transaction.is_active
			query_executed_by_me: tuple_query.transaction.repository = Current
--			readonly_transaction: tuple_query.transaction.is_readonly
		deferred
		ensure
			transaction_still_alive: tuple_query.transaction.is_active
			no_error: not tuple_query.transaction.has_error
		end

feature {PS_ABEL_EXPORT} -- Modification

	insert (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Insert `object' within `transaction' into `Current'.
		require
			transaction_repository_correct: transaction.repository = Current
			active_transaction: transaction.is_active
			can_handle_object: can_handle (object)
			not_known: not is_identified (object, transaction)
		deferred
		ensure
			transaction_still_alive: transaction.is_active
			no_error: not transaction.has_error
			transaction_active_in_id_manager: id_manager.is_registered (transaction)
			object_known: is_identified (object, transaction)
		end

	update (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Update `object' within `transaction'.
		require
			transaction_repository_correct: transaction.repository = Current
			active_transaction: transaction.is_active
			can_handle_object: can_handle (object)
			object_known: is_identified (object, transaction)
		deferred
		ensure
			transaction_still_alive: transaction.is_active
			no_error: not transaction.has_error
			transaction_active_in_id_manager: id_manager.is_registered (transaction)
			object_known: is_identified (object, transaction)
		end

	direct_update (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Update `object' only and none of its referenced objects.
		deferred
		end

	delete (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete `object' within `transaction' from `Current' within `transaction'.
		require
			transaction_repository_correct: transaction.repository = Current
			active_transaction: transaction.is_active
			can_handle_object: can_handle (object)
			object_known: is_identified (object, transaction)
		deferred
		ensure
			transaction_still_alive: transaction.is_active
			no_error: not transaction.has_error
			object_not_known: not is_identified (object, transaction)
			transaction_active_in_id_manager: id_manager.is_registered (transaction)
		end

	delete_query (query: PS_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete all objects that match the criteria in `query' from `Current' within `transaction'.
		require
			not_executed: not query.is_executed
			transaction_repository_correct: transaction.repository = Current
			--active_transaction: query.transaction.is_active
			active_transaction: transaction.is_active
		do
			from
				internal_execute_query (query, transaction)
			until
				query.result_cursor.after
			loop
				delete (query.result_cursor.item, transaction)
				query.result_cursor.forth
			end
		ensure
			transaction_still_alive: transaction.is_active
			no_error: not transaction.has_error
			transaction_active_in_id_manager: id_manager.is_registered (transaction)
			query_executed: query.is_executed
			no_result: query.result_cursor.after
		end

	set_root_status (object: ANY; value: BOOLEAN; transaction: PS_INTERNAL_TRANSACTION)
			-- Set the root status of `object' to `value'.
		do
		end

feature {PS_ABEL_EXPORT} -- Transaction handling

	commit_transaction (transaction: PS_INTERNAL_TRANSACTION)
			-- Commit `transaction'. It raises an exception if the commit fails.
		require
			transaction_alive: transaction.is_active
			no_error: not transaction.has_error
			repository_correct: transaction.repository = Current
				--			not_readonly: not transaction.is_readonly
		deferred
		ensure -- This will only hold of course if the commit has not failed...
			transaction_dead: not transaction.is_active
			successful_commit: transaction.is_successful_commit
			no_error: not transaction.has_error
			transaction_gone_in_id_manager: not id_manager.is_registered (transaction)
		end

	rollback_transaction (transaction: PS_INTERNAL_TRANSACTION; manual_rollback: BOOLEAN)
			-- Rollback `transaction'.
			-- This acts as a `default_rescue' clause, so the postcondition defines what happens in case of an error.
		require
			transaction_alive: transaction.is_active
			repository_correct: transaction.repository = Current
				--			not_readonly: not transaction.is_readonly
		deferred
		ensure
			transaction_dead: not transaction.is_active
			transaction_failed: not transaction.is_successful_commit
			transaction_gone_in_id_manager: not id_manager.is_registered (transaction)
			error_on_implicit_abort: not manual_rollback implies transaction.has_error
			exception_raised_on_implicit_abort: not manual_rollback implies transaction.error.is_caught
		end

feature {PS_ABEL_EXPORT} -- Status

	is_identified (an_object: ANY; a_transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Is `an_object' already identified and thus registered in this repository?
		do
			Result := id_manager.is_identified (an_object, a_transaction)
		end

	is_root (object: ANY; transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Is `object' a garbage collection root?
		do
			if id_manager.is_identified (object, transaction) then
				Result := transaction.root_flags [id_manager.identifier_wrapper (object, transaction).object_identifier]
			end
		end

	can_handle (object: ANY): BOOLEAN
			-- Can `Current' handle the object `object'?
		deferred
		end

feature {PS_ABEL_EXPORT} -- Testing

	clean_db_for_testing
			-- Wipe out all data.
		deferred
		end

feature {NONE} -- Rescue

	default_transactional_rescue (transaction: PS_INTERNAL_TRANSACTION)
			-- The default action if a routine has failed.
		do
			rollback_transaction (transaction, False)
		end

feature {PS_ABEL_EXPORT} -- Implementation

	id_manager: PS_OBJECT_IDENTIFICATION_MANAGER

	mapper: PS_KEY_POID_TABLE
		deferred
		end

feature -- Constants

	default_retry_count: INTEGER = 1
			-- The default number of retries for implicit transactions.

	infinite_batch_size: INTEGER = -1
			-- The special value for an infinite batch size (i.e. to effectively disable lazy loading).

invariant
--	valid_batch_size: batch_retrieval_size > 0 or batch_retrieval_size = infinite_batch_size

end
