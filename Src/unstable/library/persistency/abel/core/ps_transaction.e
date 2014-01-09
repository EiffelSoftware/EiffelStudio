note
	description: "[
		Transaction context for read and write operations.

		Insert and update operation always treat the whole object
		graph, meaning the object given as an argument and all
		objects transitively reachable from it. Similarly, a query
		operation will always load the whole object graph from the
		database.
		
		Whenever an object in an object graph gets inserted or 
		retrieved from the database, ABEL will mark it as "persistent", 
		meaning the object has a counterpart in the database. 
		The persistent status is only valid within a transaction
		context and can be queried with feature `is_persistent'.
		
		The persistent mark allows ABEL to distinguish between
		an update and an insert operation. Update only works on
		persistent objects, whereas insert only works on
		non-persistent objects. 
		Note that this is only relevant for the root of an object 
		graph, and ABEL is able to handle object graphs with objects 
		of mixed export status. The distinction in the API is
		enforced mainly to avoid unpleasant surprises.
		
		ABEL introduces another object state: Root objects.
		The root state is used mainly for garbage collection, i.e.
		root objects and any objects transitively referenced by a 
		root object cannot be deleted. However, it can also be used
		as a filtering criterion for queries.
		By default the object given as an argument to the insert 
		function is a root object. It is possible to set the root
		status manually using `declare_root' or `declare_non_root'
		or change the defaults using `set_root_declaration_strategy'.
		
		
		In case of an error in the backend, the following conditions
		will hold:
		
			*) `has_error' is True.
			*) `last_error' is attached and contains a 
				PS_ERROR describing the error that occurred.
			*) The transaction is rolled back.
			
		The PS_ERROR class hierarchy has a visitor pattern which can
		be used for error handling.
		]"

	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TRANSACTION

inherit
	PS_ABEL_EXPORT

create {PS_REPOSITORY}
	make

feature {NONE} -- Initialization

	make (a_repository: like repository)
			-- Initialization for `Current'.
		local
			default_strategy: like root_declaration_strategy
		do
			repository := a_repository
			create internal_active_queries.make (0)
			transaction := repository.new_internal_transaction (False)
			repository.internal_active_transactions.extend (Current, transaction)
		ensure
			default_strategy: root_declaration_strategy.is_argument_of_insert
			active: is_active
			repository_set: repository = a_repository
			empty_queries: active_queries.is_empty
			no_error: not has_error
		end

feature -- Access

	repository: PS_REPOSITORY
			-- The data repository.

	root_declaration_strategy: PS_ROOT_OBJECT_STRATEGY
			-- The default behaviour for root declaration on write functions.
		do
			Result := transaction.root_declaration_strategy
		end

	active_queries: CONTAINER [PS_ABSTRACT_QUERY [ANY, ANY]]
			-- The currently active queries.
		do
			Result := internal_active_queries
		end

	last_error: detachable PS_ERROR
			-- The last encountered error.
		do
			Result := transaction.error
		end

feature -- Status report

	is_supported (object: ANY): BOOLEAN
			-- Can the current repository handle `object'?
		do
			Result := repository.can_handle (object)
		end

	is_active: BOOLEAN
			-- Is the current transaction active?
		do
			Result := transaction.is_active
		end

	is_persistent (object: ANY): BOOLEAN
			-- Is `object' stored in the database?
		require
			active: is_active
			supported: is_supported (object)
			no_error: not has_error
		do
			Result := repository.is_identified (object, transaction)
		end

	is_expanded (type: TYPE [detachable ANY]): BOOLEAN
			-- Is `type' expanded?
		do
			Result := repository.is_expanded (type)
		ensure
			correct: type.is_expanded implies Result
		end

	is_root (object: ANY): BOOLEAN
			-- Is `object' a root object?
		require
			active: is_active
			supported: is_supported (object)
			persistent: is_persistent (object)
			no_error: not has_error
		do
			Result := repository.is_root (object, transaction)
		end

	has_error: BOOLEAN
			-- Did the last operation produce an error?
		do
			Result := attached last_error
		end

feature -- Element change

	set_root_declaration_strategy (a_strategy: like root_declaration_strategy)
			-- Set the new root declaration strategy.
		do
			transaction.set_root_declaration_strategy (a_strategy)
		ensure
			correct: root_declaration_strategy = a_strategy
		end

feature -- Data retrieval

	execute_query (query: PS_QUERY [ANY])
			-- Execute `query' and store the result in `query.result_cursor'.
		require
			active: is_active
			no_error: not has_error
			not_active: not active_queries.has (query)
			not_executed: not query.is_executed
			not_closed: not query.is_closed
		do
			internal_active_queries.extend (query)
			query.set_transaction (Current)

				-- The next statement may fail. The exception will be catched
				-- in {PS_QUERY}.retrieve_next.
			repository.internal_execute_query (query, transaction)

			check correctly_aliased: query.has_error = has_error and query.has_error = not is_active end

			if query.has_error then
				internal_active_queries.prune_all (query)
				repository.internal_active_transactions.remove (transaction)
			end
		ensure
			executed: query.is_executed
			valid_status: has_error xor is_active
			registered: has_error xor active_queries.has (query)
			correct_cleanup: has_error implies not repository.active_transactions.has (Current)
		end

	execute_tuple_query (query: PS_TUPLE_QUERY [ANY])
			-- Execute `query' and store the result in `query.result_cursor'.
		require
			active: is_active
			no_error: not has_error
			not_active: not active_queries.has (query)
			not_executed: not query.is_executed
			not_closed: not query.is_closed
		local
			retried: BOOLEAN
		do
			internal_active_queries.extend (query)
			query.set_transaction (Current)

				-- The next statement may fail. The exception will be catched
				-- in {PS_TUPLE_QUERY}.retrieve_next.
			repository.internal_execute_tuple_query (query, transaction)

			check correctly_aliased: query.has_error = has_error and query.has_error = not is_active end

			if query.has_error then
				internal_active_queries.prune_all (query)
				repository.internal_active_transactions.remove (transaction)
			end
		ensure
			executed: query.is_executed
			valid_status: has_error xor is_active
			registered: has_error xor active_queries.has (query)
			correct_cleanup: has_error implies not repository.active_transactions.has (Current)
		end

feature -- Data modification

	insert (object: ANY)
			-- Insert `object' and all transitively referenced objects into the repository.
		require
			active: is_active
			no_error: not has_error
			supported: is_supported (object)
		local
			saved: detachable PS_ROOT_OBJECT_STRATEGY
		do
			if root_declaration_strategy.is_argument_of_insert and then is_persistent (object) then
				saved := root_declaration_strategy
				set_root_declaration_strategy (saved.new_argument_of_write)
			end

			repository.write (object, transaction)

			if attached saved then
				set_root_declaration_strategy (saved)
			end
		ensure
			valid_status: has_error xor is_active
			root_declaration_unchanged: root_declaration_strategy = old root_declaration_strategy
			persistent: not has_error implies is_persistent (object) xor is_expanded (object.generating_type)
			correct_cleanup: has_error implies not repository.active_transactions.has (Current)
			root_set: not has_error implies (is_expanded (object.generating_type) xor
				(root_declaration_strategy > root_declaration_strategy.new_preserve implies is_root (object)))
		end

	update (object: ANY)
			-- Update `object' and all transitively referenced objects in the repository.
		require
			active: is_active
			no_error: not has_error
			supported: is_supported (object)
			not_expanded: not is_expanded (object.generating_type)
			persistent: is_persistent (object)
		local
			retried: BOOLEAN
		do
			repository.write (object, transaction)
		ensure
			valid_status: has_error xor is_active
			persistent: not has_error implies is_persistent (object)
			correct_cleanup: has_error implies not repository.active_transactions.has (Current)
			root_set: not has_error implies
				(root_declaration_strategy > root_declaration_strategy.new_argument_of_insert
				implies is_root (object))
		end

	direct_update (object: ANY)
			-- Update `object' only, do not follow references.
		require
			active: is_active
			no_error: not has_error
			supported: is_supported (object)
			not_expanded: not is_expanded (object.generating_type)
			persistent: is_persistent (object)
			valid_direct_update: to_implement_assertion ("check that all referenced objects are persistent")
		local
			retried: BOOLEAN
		do
			if not retried then
				repository.direct_update (object, transaction)
			end
		ensure
			valid_status: has_error xor is_active
			persistent: not has_error implies is_persistent (object)
			correct_cleanup: has_error implies not repository.active_transactions.has (Current)
			root_set: not has_error implies
				(root_declaration_strategy > root_declaration_strategy.new_argument_of_insert
				implies is_root (object))
		end

feature -- Root status modification

	mark_root (object: ANY)
			-- Mark `object' as a root object.
			-- Do not change the status of any referenced object.
		require
			active: is_active
			no_error: not has_error
			supported: is_supported (object)
			not_expanded: not is_expanded (object.generating_type)
			persistent: is_persistent (object)
			not_root: not is_root (object)
		do
			repository.set_root_status (object, True, transaction)
		ensure
			valid_status: has_error xor is_active
			persistent: not has_error implies is_persistent (object)
			root: not has_error implies is_root (object)
			correct_cleanup: has_error implies not repository.active_transactions.has (Current)
		end

	unmark_root (object: ANY)
			-- Remove the root status from `object'.
			-- Do not change the status of any referenced object.
		require
			active: is_active
			no_error: not has_error
			supported: is_supported (object)
			not_expanded: not is_expanded (object.generating_type)
			persistent: is_persistent (object)
			root: is_root (object)
		do
			repository.set_root_status (object, False, transaction)
		ensure
			valid_status: has_error xor is_active
			persistent: not has_error implies is_persistent (object)
			not_root: not has_error implies not is_root (object)
			correct_cleanup: has_error implies not repository.active_transactions.has (Current)
		end


feature -- Transaction operations

	commit
			-- Commit the active transaction.
			-- If the transaction fails, `has_error' is True.
		require
			active: is_active
			no_active_queries: active_queries.is_empty
			no_error: not has_error
		do
			repository.commit_transaction (transaction)
			repository.internal_active_transactions.remove (transaction)
		ensure
			not_active: not is_active
			correct_cleanup: not repository.active_transactions.has (Current)
		end

	rollback
			-- Rollback the active transaction.
		require
			active: is_active
			no_active_queries: active_queries.is_empty
			no_error: not has_error
		do
			repository.rollback_transaction (transaction)
			repository.internal_active_transactions.remove (transaction)
		ensure
			not_active: not is_active
			correct_cleanup: not repository.active_transactions.has (Current)
		end

	prepare
			-- Prepare `Current' to be reused as a new transaction.
		require
			not_active: not is_active and not repository.active_transactions.has (Current)
		local
			l_transaction: like transaction
		do
			l_transaction := repository.new_internal_transaction (False)
			l_transaction.set_root_declaration_strategy (root_declaration_strategy)
			transaction := l_transaction
			repository.internal_active_transactions.extend (Current, transaction)
		ensure
			active: is_active
			no_active_queries: active_queries.is_empty
			no_error: not has_error
			root_declaration_unchanged: root_declaration_strategy = old root_declaration_strategy
		end

feature {PS_ABEL_EXPORT} -- Implementation

	internal_active_queries: ARRAYED_LIST [PS_ABSTRACT_QUERY [ANY, ANY]]
			-- The internal storage for `active_queries'.

	transaction: PS_INTERNAL_TRANSACTION
			-- The currently active transaction.

invariant
	not_active_when_error: has_error implies not is_active
	in_active_transaction_collection: is_active = repository.active_transactions.has (Current)

end
