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
		
		
		If an error happens in the backend, ABEL will do the following
		(not necessarily in this order):
			
			*) Translate the backend error to a corresponding PS_ERROR,
			*) set the `last_error' attribute,
			*) rollback the current transaction, 
			*) and raise an exception
			
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
		redefine
			default_rescue
		end

create
	make

feature {NONE} -- Initialization

	make (a_repository: like repository)
			-- Initialization for `Current'
		do
			repository := a_repository
			create {PS_NO_ERROR} last_error
			create internal_active_queries.make
			create root_declaration_strategy
			root_declaration_strategy := root_declaration_strategy.insert_argument_only
			create transaction.make (repository)
		ensure
			default_strategy: root_declaration_strategy = root_declaration_strategy.insert_argument_only
			active: is_transaction_active
			repository_set: repository = a_repository
			empty_queries: active_queries.is_empty
			no_error: not has_error
		end

feature -- Access

	repository: PS_REPOSITORY
			-- The data repository.

	root_declaration_strategy: PS_ROOT_OBJECT_STRATEGY
			-- The default behaviour for root declaration on write functions.

	active_queries: CONTAINER [PS_QUERY [ANY, ANY]]
			-- The currently active queries.
		do
			Result := internal_active_queries
		end

	last_error: detachable PS_ERROR
			-- The last encountered error.
--		require
--			error: has_error
--		attribute
--		end

feature -- Status report

	is_supported (object: ANY): BOOLEAN
			-- Can the current repository handle `object'?
		do
			Result := repository.can_handle (object)
		end

	is_transaction_active: BOOLEAN
			-- Is there an active transaction?
		do
			Result := attached transaction as t and then t.is_active
		end

	is_persistent (object: ANY): BOOLEAN
			-- Is `object' stored in the database?
		require
			in_transaction: is_transaction_active
			supported: is_supported (object)
			no_error: not has_error
		do
			Result := repository.is_identified (object, attach(transaction))
		end

	is_root (object: ANY): BOOLEAN
			-- Is `object' a root object?
		require
			in_transaction: is_transaction_active
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

	execute_query (query: PS_OBJECT_QUERY [ANY])
			-- Execute `query' and store the result in `query.result_cursor'.
		require
			in_transaction: is_transaction_active
			no_error: not has_error
		do
			repository.internal_execute_query (query, attach(transaction))
			internal_active_queries.extend (query)
			query.set_transaction_context (Current)
		ensure
			active: active_queries.has (query)
			executed: query.is_executed
			in_transaction: is_transaction_active
		end

	execute_tuple_query (query: PS_TUPLE_QUERY [ANY])
			-- Execute `query' and store the result in `query.result_cursor'.
		require
			in_transaction: is_transaction_active
			no_error: not has_error
		do
			repository.internal_execute_tuple_query (query, attach(transaction))
			internal_active_queries.extend (query)
			query.set_transaction_context (Current)
		ensure
			active: active_queries.has (query)
			executed: query.is_executed
			in_transaction: is_transaction_active
		end

feature -- Data modification

	insert (object: ANY)
			-- Insert `object' and all transitively referenced objects into the repository.
		require
			in_transaction: is_transaction_active
			no_error: not has_error
			supported: is_supported (object)
			not_persistent: not is_persistent (object)
		do
			repository.insert (object, attach(transaction))
		ensure
			in_transaction: is_transaction_active
			persistent: is_persistent (object)
			root_set: root_declaration_strategy > root_declaration_strategy.None implies is_root (object)
		end

	update (object: ANY)
			-- Update `object' and all transitively referenced objects in the repository.
		require
			in_transaction: is_transaction_active
			no_error: not has_error
			supported: is_supported (object)
			persistent: is_persistent (object)
		do
			repository.update (object, attach(transaction))
		ensure
			in_transaction: is_transaction_active
			persistent: is_persistent (object)
			root_set: root_declaration_strategy > root_declaration_strategy.insert_argument_only implies is_root (object)
		end

	direct_update (object: ANY)
			-- Update `object' only, do not follow references.
		require
			in_transaction: is_transaction_active
			no_error: not has_error
			supported: is_supported (object)
			persistent: is_persistent (object)
			valid_direct_update: to_implement_assertion ("check that all referenced objects are persistent")
		do
			repository.direct_update (object, attach(transaction))
		ensure
			in_transaction: is_transaction_active
			persistent: is_persistent (object)
			root_set: root_declaration_strategy > root_declaration_strategy.insert_argument_only implies is_root (object)
		end

feature -- Root status modification

	declare_root (object: ANY)
			-- Declare `object' as a root object.
			-- Do not change the status of any referenced object.
		require
			in_transaction: is_transaction_active
			no_error: not has_error
			supported: is_supported (object)
			persistent: is_persistent (object)
			not_root: not is_root (object)
		do
			repository.set_root_status (object, True, attach (transaction))
		ensure
			in_transaction: is_transaction_active
			persistent: is_persistent (object)
			root: is_root (object)
		end

	declare_non_root (object: ANY)
			-- Remove the root status from `object'.
			-- Do not change the status of any referenced object.
		require
			in_transaction: is_transaction_active
			no_error: not has_error
			supported: is_supported (object)
			persistent: is_persistent (object)
			not_root: is_root (object)
		do
			repository.set_root_status (object, False, attach (transaction))
		ensure
			in_transaction: is_transaction_active
			persistent: is_persistent (object)
			root: not is_root (object)
		end


feature -- Transaction operations

	commit
			-- Commit the active transaction.
			-- If the transaction fails, `has_error' is True and an exception is raised.
		require
			is_active: is_transaction_active
			no_active_queries: active_queries.is_empty
			no_error: not has_error
		do
			repository.commit_transaction (attach (transaction))
			transaction := Void
		ensure
			not_active: not is_transaction_active
		end

	rollback
			-- Rollback the active transaction.
		require
			is_active: is_transaction_active
			no_active_queries: active_queries.is_empty
			no_error: not has_error
		do
			repository.rollback_transaction (attach (transaction), True)
			transaction := Void
		ensure
			not_active: not is_transaction_active
		end

	start
			-- Start a new transaction.
		require
			not_active: not is_transaction_active
		do
			create {PS_NO_ERROR} last_error
			create transaction.make (repository)
		ensure
			active: is_transaction_active
			no_error: not has_error
		end

feature {PS_ABEL_EXPORT} -- Implementation

	internal_active_queries: LINKED_LIST [PS_QUERY [ANY, ANY]]
			-- The internal storage for `active_queries'.

feature {NONE} -- Implementation


	transaction: detachable PS_INTERNAL_TRANSACTION
			-- The currently active transaction.
--		require
--			is_active: is_transaction_active
--		attribute
--		end

	default_rescue
			-- Set the `last_error' field.
		do
			if attached transaction as tr then
				last_error := tr.error
			end
		end
end
