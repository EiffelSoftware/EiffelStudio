note
	description: "[
		Common ancestor for all repository strategies.
		Descendants, obtained from PS_REPOSITORY_FACTORY, implement support for different kinds of databases.
		The repository object receives QUERYs from an EXECUTOR object and returns ANY objects.
		
		Every feature with a PS_TRANSACTION as an argument will either
			- return normally, if no error occurred
			- raise an exception, if any kind of error has occured
			
		The actual error is returned in the PS_TRANSACTION.error field, and the transaction is automatically rolled back.
	]"
	author: "Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_REPOSITORY

inherit

	PS_EIFFELSTORE_EXPORT

feature -- Settings

	default_object_graph: PS_OBJECT_GRAPH_SETTINGS
			-- Default object graph settings.

	transaction_isolation_level: PS_TRANSACTION_ISOLATION_LEVEL
			-- Transaction isolation level.

	set_transaction_isolation_level (a_level: PS_TRANSACTION_ISOLATION_LEVEL)
			-- Set the isolation level for transactions.
		do
			transaction_isolation_level := a_level
		end

feature {PS_EIFFELSTORE_EXPORT} -- Object query

	execute_query (query: PS_OBJECT_QUERY [ANY]; transaction: PS_TRANSACTION)
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

	next_entry (query: PS_OBJECT_QUERY [ANY])
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

	execute_tuple_query (tuple_query: PS_TUPLE_QUERY [ANY]; transaction: PS_TRANSACTION)
			-- Execute the tuple query `tuple_query' within the readonly `transaction'.
		require
			readonly_transaction: transaction.is_readonly
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
			readonly_transaction: tuple_query.transaction.is_readonly
		deferred
		ensure
			transaction_still_alive: tuple_query.transaction.is_active
			no_error: not tuple_query.transaction.has_error
		end

feature {PS_EIFFELSTORE_EXPORT} -- Modification

	insert (object: ANY; transaction: PS_TRANSACTION)
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

	update (object: ANY; transaction: PS_TRANSACTION)
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

	delete (object: ANY; transaction: PS_TRANSACTION)
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

	delete_query (query: PS_OBJECT_QUERY [ANY]; transaction: PS_TRANSACTION)
			-- Delete all objects that match the criteria in `query' from `Current' within `transaction'.
		require
			not_executed: not query.is_executed
			transaction_repository_correct: transaction.repository = Current
			--active_transaction: query.transaction.is_active
			active_transaction: transaction.is_active
		do
			from
				execute_query (query, transaction)
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

feature {PS_EIFFELSTORE_EXPORT} -- Transaction handling

	commit_transaction (transaction: PS_TRANSACTION)
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

	rollback_transaction (transaction: PS_TRANSACTION; manual_rollback: BOOLEAN)
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

feature {PS_EIFFELSTORE_EXPORT} -- Status

	is_identified (an_object: ANY; a_transaction: PS_TRANSACTION): BOOLEAN
			-- Is `an_object' already identified and thus registered in this repository?
		do
			Result := id_manager.is_identified (an_object, a_transaction)
		end

	can_handle (object: ANY): BOOLEAN
			-- Can `Current' handle the object `object'?
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- Testing

	clean_db_for_testing
			-- Wipe out all data.
		deferred
		end

feature {NONE} -- Rescue

	default_transactional_rescue (transaction: PS_TRANSACTION)
			-- The default action if a routine has failed.
		do
			rollback_transaction (transaction, False)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Implementation

	id_manager: PS_OBJECT_IDENTIFICATION_MANAGER

end
