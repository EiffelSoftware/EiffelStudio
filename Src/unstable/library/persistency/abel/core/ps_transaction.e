note
	description: "[
		Represents a transaction context for read and write operations.

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
		
		
		In case of an error in the backend, ABEL will do some cleanup
		and raise an exception. Clients can expect the following 
		conditions to hold:
		
			*) `has_error' is True.
			*) `last_error' is attached and contains a 
				PS_ERROR describing the error that occurred.
			*) The transaction is rolled back.
			*) The exception propagates to the client.
			
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
			-- Initialization for `Current'
		do
			repository := a_repository
			last_error := Void
			create internal_active_queries.make
			create root_declaration_strategy.make_argument_of_insert
			create transaction.make (repository)
			repository.id_manager.register_transaction (attach (transaction))
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

	active_queries: CONTAINER [PS_ABSTRACT_QUERY [ANY, ANY]]
			-- The currently active queries.
		do
			Result := internal_active_queries
		end

	last_error: detachable PS_ERROR
			-- The last encountered error.

feature -- Status report

	is_supported (object: ANY): BOOLEAN
			-- Can the current repository handle `object'?
		do
			Result := repository.can_handle (object)
		end

	is_active: BOOLEAN
			-- Is the current transaction active?
		do
			Result := attached transaction as t and then t.is_active
		end

	is_persistent (object: ANY): BOOLEAN
			-- Is `object' stored in the database?
		require
			in_transaction: is_active
			supported: is_supported (object)
			no_error: not has_error
		do
			Result := repository.is_identified (object, attach(transaction))
		end

	is_root (object: ANY): BOOLEAN
			-- Is `object' a root object?
		require
			in_transaction: is_active
			supported: is_supported (object)
			persistent: is_persistent (object)
			no_error: not has_error
		do
			Result := repository.is_root (object, attach (transaction))
		end

	has_error: BOOLEAN
			-- Did the last operation produce an error?
		do
			Result := attached last_error and not attached {PS_NO_ERROR} last_error
		end

feature -- Element change

	set_root_declaration_strategy (a_strategy: like root_declaration_strategy)
			-- Set the new root declaration strategy
		do
			fixme ("Implement this setting in the backend")
			-- root_declaration_strategy := a_strategy
		ensure
			correct: root_declaration_strategy = a_strategy
		end

feature -- Data retrieval

	execute_query (query: PS_QUERY [ANY])
			-- Execute `query' and store the result in `query.result_cursor'.
		require
			in_transaction: is_active
			no_error: not has_error
		do
			repository.internal_execute_query (query, attach(transaction))
			internal_active_queries.extend (query)
			query.set_transaction_context (Current)
		ensure
			active: active_queries.has (query)
			executed: query.is_executed
			in_transaction: is_active
		rescue
			set_error
		end

	execute_tuple_query (query: PS_TUPLE_QUERY [ANY])
			-- Execute `query' and store the result in `query.result_cursor'.
		require
			in_transaction: is_active
			no_error: not has_error
		do
			repository.internal_execute_tuple_query (query, attach(transaction))
			internal_active_queries.extend (query)
			query.set_transaction_context (Current)
		ensure
			active: active_queries.has (query)
			executed: query.is_executed
			in_transaction: is_active
		rescue
			set_error
		end

feature -- Data modification

	insert (object: ANY)
			-- Insert `object' and all transitively referenced objects into the repository.
		require
			in_transaction: is_active
			no_error: not has_error
			supported: is_supported (object)
			not_persistent: not is_persistent (object)
		do
			repository.insert (object, attach(transaction))
		ensure
			in_transaction: is_active
			persistent: is_persistent (object)
			root_set: root_declaration_strategy > root_declaration_strategy.new_preserve implies is_root (object)
		rescue
			set_error
		end

	update (object: ANY)
			-- Update `object' and all transitively referenced objects in the repository.
		require
			in_transaction: is_active
			no_error: not has_error
			supported: is_supported (object)
			persistent: is_persistent (object)
		do
			repository.update (object, attach(transaction))
		ensure
			in_transaction: is_active
			persistent: is_persistent (object)
			root_set: root_declaration_strategy > root_declaration_strategy.new_argument_of_insert implies is_root (object)
		rescue
			set_error
		end

	direct_update (object: ANY)
			-- Update `object' only, do not follow references.
		require
			in_transaction: is_active
			no_error: not has_error
			supported: is_supported (object)
			persistent: is_persistent (object)
			valid_direct_update: to_implement_assertion ("check that all referenced objects are persistent")
		do
			repository.direct_update (object, attach(transaction))
		ensure
			in_transaction: is_active
			persistent: is_persistent (object)
			root_set: root_declaration_strategy > root_declaration_strategy.new_argument_of_insert implies is_root (object)
		rescue
			set_error
		end

feature -- Root status modification

	mark_root (object: ANY)
			-- Mark `object' as a root object.
			-- Do not change the status of any referenced object.
		require
			in_transaction: is_active
			no_error: not has_error
			supported: is_supported (object)
			persistent: is_persistent (object)
			not_root: not is_root (object)
		do
			repository.set_root_status (object, True, attach (transaction))
		ensure
			in_transaction: is_active
			persistent: is_persistent (object)
			root: is_root (object)
		rescue
			set_error
		end

	unmark_root (object: ANY)
			-- Remove the root status from `object'.
			-- Do not change the status of any referenced object.
		require
			in_transaction: is_active
			no_error: not has_error
			supported: is_supported (object)
			persistent: is_persistent (object)
			not_root: is_root (object)
		do
			repository.set_root_status (object, False, attach (transaction))
		ensure
			in_transaction: is_active
			persistent: is_persistent (object)
			root: not is_root (object)
		rescue
			set_error
		end


feature -- Transaction operations

	commit
			-- Commit the active transaction.
			-- If the transaction fails, `has_error' is True and an exception is raised.
		require
			is_active: is_active
			no_active_queries: active_queries.is_empty
			no_error: not has_error
		do
			repository.commit_transaction (attach (transaction))
			transaction := Void
		ensure
			not_active: not is_active
		rescue
			set_error
		end

	rollback
			-- Rollback the active transaction.
		require
			is_active: is_active
			no_active_queries: active_queries.is_empty
			no_error: not has_error
		do
			repository.rollback_transaction (attach (transaction), True)
			transaction := Void
		ensure
			not_active: not is_active
		rescue
			set_error
		end

	prepare
			-- Prepare `Current' to be reused as a new transaction.
		require
			not_active: not is_active
		do
			-- create {PS_NO_ERROR} last_error
			last_error := Void
			create transaction.make (repository)
			repository.id_manager.register_transaction (attach (transaction))
		ensure
			active: is_active
			no_error: not has_error
		end

feature {PS_ABEL_EXPORT} -- Implementation

	internal_active_queries: LINKED_LIST [PS_ABSTRACT_QUERY [ANY, ANY]]
			-- The internal storage for `active_queries'.

feature {NONE} -- Implementation


	transaction: detachable PS_INTERNAL_TRANSACTION
			-- The currently active transaction.

	set_error
			-- Set the `last_error' field.
		do
			if attached transaction as tr and then not attached {PS_NO_ERROR} tr.error then
				last_error := tr.error
			end
		end
end
