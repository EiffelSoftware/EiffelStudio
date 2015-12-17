note
	description: "[
		Performs queries, insertions, updates and deletions on a repository.
		The repository needed by the creation feature can be obtained by using class REPOSITORY_FACTORY.

		Errors are reported in the `Current.last_error' field and an exception is raised if an error occurs, 
		so you don't have to manually check on errors every time you call a feature in `Current'.
		
		If you use explicit transaction management (the *_within_transaction features),
		a transaction conflict exception will be caught and the transaction will be aborted automatically, without raising another exception.
		You can then continue to use the transaction, but operations on an aborted transaction have no effect on the repository,
		and a future commit call on the transaction is doomed to fail.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_EXECUTOR

inherit
	PS_ABEL_EXPORT

	REFACTORING_HELPER

create
	make

feature {PS_ABEL_EXPORT} --Access

	repository: PS_REPOSITORY
			-- The data repository on which `Current' operates.

feature {PS_ABEL_EXPORT} -- Status Report

	is_persistent (an_object: ANY): BOOLEAN
			-- Is there a database entry for `an_object'?
		do
			Result := repository.is_identified (an_object, new_transaction)
		end

	is_persistent_within_transaction (an_object: ANY; a_transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Is there a database entry for `an_object' within `a_transaction'?
		do
			Result := repository.is_identified (an_object, a_transaction)
		end

	can_handle (object: ANY): BOOLEAN
			-- Can the executor with the current repository handle the object `object'?
		do
			Result := repository.can_handle (object)
		end

feature {PS_ABEL_EXPORT} -- Data retrieval

	execute_query (query: PS_OBJECT_QUERY [ANY])
			-- Execute `query' and store the result in `query.result_cursor'.
		do
			execute_within_implicit_transaction (agent execute_query_within_transaction (query, ?), True)
		ensure
			query_executed: query.is_executed
			retrieved_item_persistent: not query.result_cursor.after implies is_persistent_within_transaction (query.result_cursor.item, new_transaction)
			can_handle_retrieved_item: not query.result_cursor.after implies can_handle (query.result_cursor.item)
		end

	execute_tuple_query (tuple_query: PS_TUPLE_QUERY [ANY])
			-- Execute `tuple_query' and store the result in `query.result_cursor'.
		do
			execute_within_implicit_transaction (agent execute_tuple_query_within_transaction (tuple_query, ?), True)
		ensure
			query_executed: tuple_query.is_executed
		end

	--execute_reload (object: ANY)
				-- Reload  `object'.
	--		require
	--			already_loaded: is_persistent (object, new_transaction)
	--		do
	--			fixme ("TODO: see reload_within_transaction")
	--		ensure
	--			still_persistent: is_persistent (object, new_transaction)
	--		end

feature {PS_ABEL_EXPORT} -- Data manipulation

	execute_insert (an_object: ANY)
			-- Insert `an_object' into the repository.
		require
			can_handle_object: can_handle (an_object)
		do
			if not is_persistent_within_transaction (an_object, new_transaction) then
				execute_within_implicit_transaction (agent execute_insert_within_transaction(an_object, ?), False)
			end
		ensure
			object_persistent: is_persistent_within_transaction (an_object, new_transaction)
		end

	execute_update (an_object: ANY)
			-- Write changes of `an_object' to the repository.
		require
			object_persistent: is_persistent_within_transaction (an_object, new_transaction)
			can_handle_object: can_handle (an_object)
		do
			execute_within_implicit_transaction (agent execute_update_within_transaction(an_object, ?), False)
		ensure
			object_persistent: is_persistent_within_transaction (an_object, new_transaction)
		end

	execute_delete (an_object: ANY)
			-- Delete `an_object' from the repository.
		require
			object_persistent: is_persistent_within_transaction (an_object, new_transaction)
			can_handle_object: can_handle (an_object)
		do
			execute_within_implicit_transaction (agent execute_delete_within_transaction(an_object, ?), False)
		ensure
			not_persistent_anymore: not is_persistent_within_transaction (an_object, new_transaction)
		end

	execute_deletion_query (deletion_query: PS_OBJECT_QUERY [ANY])
			-- Delete all objects that match the criteria defined in `deletion_query'.
		do
			execute_within_implicit_transaction (agent execute_deletion_query_within_transaction (deletion_query, ?), False)
		end

feature {PS_ABEL_EXPORT} -- Transaction-based data retrieval and querying

	execute_query_within_transaction (a_query: PS_OBJECT_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Execute `a_query' within the transaction `transaction'.
			-- In case of a conflict between transactions, it will abort `transaction' and return normally with an empty result.
			-- In every other case of errors it will abort `transaction' and raise an exception.
		require
			same_repository: transaction.repository = Current.repository
		do
			if a_query.is_executed then
				a_query.reset
			end
			handle_error_on_action (agent repository.internal_execute_query (a_query, transaction), transaction)
			if not a_query.is_executed then
				a_query.register_as_executed (transaction)
			end
		ensure
			query_executed: a_query.is_executed
			transaction_set: a_query.transaction = transaction
			result_is_persistent: not a_query.result_cursor.after implies is_persistent_within_transaction (a_query.result_cursor.item, transaction)
			can_handle_retrieved_item: not a_query.result_cursor.after implies can_handle (a_query.result_cursor.item)
			aborted_implies_after: transaction.has_error implies a_query.result_cursor.after
			only_transaction_conflicts_return_normally: transaction.has_error implies attached {PS_TRANSACTION_ABORTED_ERROR} transaction.error
		end


	--execute_reload_within_transaction (object:ANY; transaction: PS_TRANSACTION)
			-- Reload `object' within transaction `transaction'
			-- In case of a conflict between transactions, it will abort `transaction' and return normally.
			-- In every other case of errors it will abort `transaction' and raise an exception.
		--		require
		--			already_loaded: is_persistent (object, transaction)
		--		do
		--			fixme ("TODO: The function is dangerous: In case of an abort because of transaction conflicts, the state of `object' is undefined, and the callee only realizes that when transaction commits.")
		--		ensure
		--			still_persistent: is_persistent (object, transaction)
		--		end

	execute_insert_within_transaction (an_object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Insert `an_object' within the transaction `transaction' into the repository.
			-- In case of a conflict between transactions, it will abort `transaction' and return normally.
			-- In every other case of errors it will abort `transaction' and raise an exception.
		require
			same_repository: transaction.repository = Current.repository
			can_handle_object: can_handle (an_object)
		do
			if not is_persistent_within_transaction (an_object, transaction)
			then
				handle_error_on_action (agent repository.insert(an_object, transaction), transaction)
			end
		ensure
			success_implies_persistent: not transaction.has_error implies is_persistent_within_transaction (an_object, transaction)
			failure_implies_not_persistent: transaction.has_error implies not is_persistent_within_transaction (an_object, transaction)
			only_transaction_conflicts_return_normally: transaction.has_error implies attached {PS_TRANSACTION_ABORTED_ERROR} transaction.error
		end

	execute_update_within_transaction (an_object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Write back changes of `an_object' into the repository, within the transaction `transaction'.
			-- In case of a conflict between transactions, it will abort `transaction' and return normally.
			-- In every other case of errors it will abort `transaction' and raise an exception.
		require
			same_repository: transaction.repository = Current.repository
			object_persistent: is_persistent_within_transaction (an_object, transaction)
			can_handle_object: can_handle (an_object)
		do
			handle_error_on_action (agent repository.update(an_object, transaction), transaction)
		ensure
			only_transaction_conflicts_return_normally: transaction.has_error implies attached {PS_TRANSACTION_ABORTED_ERROR} transaction.error
		end

	execute_delete_within_transaction (an_object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete `an_object' within the transaction `transaction' from the repository.
			-- In case of a conflict between transactions, it will abort `transaction' and return normally.
			-- In every other case of errors it will abort `transaction' and raise an exception.
		require
			same_repository: transaction.repository = Current.repository
			object_persistent: is_persistent_within_transaction (an_object, transaction)
			can_handle_object: can_handle (an_object)
		do
			handle_error_on_action (agent repository.delete (an_object, transaction), transaction)
		ensure
			success_implies_not_persistent: not transaction.has_error implies not is_persistent_within_transaction (an_object, transaction)
			failure_implies_still_persistent: transaction.has_error implies is_persistent_within_transaction (an_object, transaction)
			only_transaction_conflicts_return_normally: transaction.has_error implies attached {PS_TRANSACTION_ABORTED_ERROR} transaction.error
		end

	execute_deletion_query_within_transaction (a_query: PS_OBJECT_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete, within the transaction `transaction', all objects that match the criteria defined in `a_query'
			-- In case of a conflict between transactions, it will abort `transaction' and return normally.
			-- In every other case of errors it will abort `transaction' and raise an exception.
		require
			same_repository: transaction.repository = Current.repository
		do
			if a_query.is_executed then
				a_query.reset
			end
			handle_error_on_action (agent repository.delete_query (a_query, transaction), transaction)
		ensure
			query_executed: a_query.is_executed
			transaction_set: a_query.transaction = transaction
			result_is_empty: a_query.result_cursor.after
			only_transaction_conflicts_return_normally: transaction.has_error implies attached {PS_TRANSACTION_ABORTED_ERROR} transaction.error
		end

feature {PS_ABEL_EXPORT} -- Transaction factory function

	new_transaction: PS_INTERNAL_TRANSACTION
			-- Create a new transaction for `Current.repository'..
		do
			create Result.make (repository)
		end

feature {PS_ABEL_EXPORT} --Error handling

	has_error: BOOLEAN
			-- Did the last operation have an error?
		do
			Result := not attached {PS_NO_ERROR} last_error
		end

	last_error: PS_ERROR
			-- The last encountered error.

feature {NONE} -- Implementation

	default_retries: INTEGER = 2
			-- The default retries for implicit transaction handling, if there is a transaction conflict.

	execute_within_implicit_transaction (action: PROCEDURE [PS_INTERNAL_TRANSACTION]; readonly: BOOLEAN)
			-- This function will execute `action' with implicit transaction handling
			-- It will retry `action' `Current.default_retries' times if there's a transaction conflict,
			-- and then raise a `PS_TRANSACTION_ABORTED_ERROR' error.
--		local
--			retries: INTEGER
--			transaction: PS_TRANSACTION
--			success: BOOLEAN
--		do
--			from
--				retries := 1
--				success := False
--			until
--				retries > default_retries or success
--			loop
--				if readonly then
--					create transaction.make_readonly (repository)
--					action.call ([transaction])
--				else
--					transaction := new_transaction
--					action.call ([transaction])
--					transaction.commit
--				end
--				if not transaction.has_error then
--					success := True
--				end
--				retries := retries + 1
--			end
--			if not success then
--				fixme ("Should we create a more specific error for such a case?")
--				create {PS_TRANSACTION_ABORTED_ERROR} last_error
--				last_error.raise
--			end
--		end
		local
			retries: INTEGER
			transaction: detachable PS_INTERNAL_TRANSACTION
		do
			if readonly then
				create transaction.make_readonly (repository)
				action.call ([transaction])
			else
				create transaction.make (repository)
				action.call ([transaction])
				transaction.commit
			end
		rescue
			if
				retries < Default_retries
				and then attached transaction as t
				and then attached {PS_TRANSACTION_ABORTED_ERROR} t.error
			then
				retries := retries + 1
				retry
			end
		end


	handle_error_on_action (action: PROCEDURE; transaction: PS_INTERNAL_TRANSACTION)
			-- This function will try the repository operation `action' and catch any error.
			-- In case of a conflict between transactions, it will abort `transaction' and return normally.
			-- In every other case of errors it will abort `transaction' and raise an exception.
		local
			retried: BOOLEAN
		do
				-- Please note that this function accepts transactions that already have an error, especially (but not exclusively) in case of a retry
			last_error := transaction.error
			if not transaction.has_error then
				action.call ([]) -- This may cause an exception which will be handled by the rescue clause
			end
		ensure
			only_transaction_conflicts_return_normally: transaction.has_error implies attached {PS_TRANSACTION_ABORTED_ERROR} transaction.error
		rescue
			last_error := transaction.error
			if not retried then
				retried := True
				if transaction.has_error and then attached {PS_TRANSACTION_ABORTED_ERROR} transaction.error then
					retry -- The retry will "catch" transaction conflicts
				else
					-- Any other error will propagate upwards
				end
			end
		end

	execute_tuple_query_within_transaction (query: PS_TUPLE_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Execute tuple query `query'. Exported to `NONE' because you can only have tuple queries with readonly transactions and implicit transaction management.
		require
			readonly_transaction: transaction.is_readonly
		do
			if query.is_executed then
				query.reset
			end
			handle_error_on_action (agent repository.internal_execute_tuple_query (query, transaction), transaction)
		ensure
			query_executed: query.is_executed
			transaction_set: query.transaction = transaction
			aborted_implies_after: transaction.has_error implies query.result_cursor.after
			only_transaction_conflicts_return_normally: transaction.has_error implies attached {PS_TRANSACTION_ABORTED_ERROR} transaction.error
		end

feature {NONE} -- Initialization

	make (a_repository: PS_REPOSITORY)
			-- Initialization for `Current'.
		do
			repository := a_repository
			create {PS_NO_ERROR} last_error
		ensure
			repository_set: repository = a_repository
		end

end
