note
	description: "A default repository that does the object-relational mapping, but relies on a PS_BACKEND for the stoage mechanism."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_DEFAULT_REPOSITORY

inherit
	PS_REPOSITORY

	REFACTORING_HELPER

create
	make_from_factory


feature -- Access.

	batch_retrieval_size: INTEGER
			-- Define the number of objects to be retrieved in one batch for query operations.
			-- Set to `infinite_batch_size' to retrieve all objects at once (and disable lazy loading).
		do
			Result := backend.batch_retrieval_size
		end

feature -- Element change

	set_batch_retrieval_size (size: INTEGER)
			-- Set `batch_retrieval_size' to `size'.
		do
			backend.set_batch_retrieval_size (size)
		end

feature -- Disposal

	close
			-- Close the current repository.
		do
			backend.close
		end

feature {PS_ABEL_EXPORT} -- Object query

	internal_execute_query (query: PS_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Execute `query' within `transaction'.
		local
			type: PS_TYPE_METADATA
		do
			type := type_factory.create_metadata_from_type (query.generic_type)
			initialize_query (query, transaction, type.attributes)
		end

	internal_execute_tuple_query (tuple_query: PS_TUPLE_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Execute the tuple query `tuple_query' within the readonly transaction `transaction'.
		local
			collector: PS_CRITERION_ATTRIBUTE_COLLECTOR
			trash: INTEGER
		do
			create collector.make
			trash := collector.visit (tuple_query.criterion)
			collector.attributes.compare_objects
			across
				tuple_query.projection as proj
			loop
				if not collector.attributes.has (proj.item) then
					collector.attributes.extend (proj.item)
				end
			end

			initialize_query (tuple_query, transaction, collector.attributes)
		end

feature {PS_ABEL_EXPORT} -- Modification

	write (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Insert `object' within `transaction' into `Current'.
		local
			retried: BOOLEAN
		do
			if not retried then
				write_manager.write (object, transaction)
			end
		rescue
			abort (transaction)
			retried := True
			if transaction.is_retry_allowed then
				retry
			end
		end

	direct_update (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Update `object' only and none of its referenced objects.
		local
			retried: BOOLEAN
		do
			if not retried then
				write_manager.direct_update (object, transaction)
			end
		rescue
			abort (transaction)
			retried := True
			if transaction.is_retry_allowed then
				retry
			end
		end

	set_root_status (object: ANY; value: BOOLEAN; transaction: PS_INTERNAL_TRANSACTION)
			-- Set the root status of `object' to `value'.
		local
			retried: BOOLEAN
		do
			if not retried then
				write_manager.update_root (object, value, transaction)
			end
		rescue
			abort (transaction)
			retried := True
			if transaction.is_retry_allowed then
				retry
			end
		end

feature {PS_ABEL_EXPORT} -- Transaction handling

	commit_transaction (transaction: PS_INTERNAL_TRANSACTION)
			-- Explicitly commit the transaction.
		local
			retried: BOOLEAN
		do
			if not retried then
				backend.commit (transaction) -- can fail and raise an exception
				transaction.declare_as_successful
			end
		rescue
			abort (transaction)
			retried := True
			if transaction.is_retry_allowed then
				retry
			end
		end

	rollback_transaction (transaction: PS_INTERNAL_TRANSACTION)
			-- Rollback the transaction.

		do
			backend.rollback (transaction)
			transaction.declare_as_aborted
		end

feature {PS_ABEL_EXPORT} -- Testing

	wipe_out
			-- Wipe out all data.
		local
			batch_size: INTEGER
		do
			batch_size := batch_retrieval_size
			backend.wipe_out

			create type_factory.make
			create write_manager.make (type_factory, backend)

			all_handlers.do_all (agent {PS_HANDLER}.set_write_manager (write_manager))
			all_handlers.do_all (agent write_manager.add_handler)

			set_batch_retrieval_size (batch_size)
		end

feature {PS_ABEL_EXPORT} -- Status Report

	can_handle (object: ANY): BOOLEAN
			-- Can `Current' handle the object `object'?
		local
			local_transaction: PS_INTERNAL_TRANSACTION
		do
			local_transaction := new_internal_transaction (True)
			Result := write_manager.can_handle (object, local_transaction)
		end

feature {NONE} -- Initialization

	make_from_factory (
			a_backend: PS_REPOSITORY_CONNECTOR;
			a_type_factory: PS_METADATA_FACTORY;
			a_write_manager: PS_WRITE_MANAGER;
			handler_list: LINKED_LIST [PS_HANDLER];
			transaction_settings: PS_TRANSACTION_SETTINGS
			)
			-- Initialization for `Current'
		do
			backend := a_backend
			type_factory := a_type_factory
			write_manager := a_write_manager
			all_handlers := handler_list
			transaction_isolation := transaction_settings

			retry_count := default_retry_count
			set_batch_retrieval_size (infinite_batch_size)

			create internal_active_queries.make (1)
			create internal_active_transactions.make (1)
		end

feature {PS_ABEL_EXPORT} -- Implementation

	backend: PS_REPOSITORY_CONNECTOR
			-- A BACKEND implementation

	write_manager: PS_WRITE_MANAGER
			-- The write manager.

	all_handlers: LINKED_LIST [PS_HANDLER]
			-- All object handlers known to `Current'

	type_factory: PS_METADATA_FACTORY
			-- A type factory.


feature {NONE} -- Implementation

	initialize_query (query: PS_ABSTRACT_QUERY [ANY, ANY]; transaction: PS_INTERNAL_TRANSACTION; filter: READABLE_INDEXABLE [STRING])
			-- Set up the internal query cursor and retrieve the first result.
		local
			new_read_manager: PS_READ_MANAGER
			query_cursor: PS_QUERY_CURSOR
		do
			create new_read_manager.make (type_factory, backend, transaction)
			all_handlers.do_all (agent new_read_manager.add_handler)

			create query_cursor.make (query, filter, new_read_manager)

			query.prepare_execution (transaction, query_cursor)
			query.retrieve_next
		end

	abort (transaction: PS_INTERNAL_TRANSACTION)
			-- Execute `operation' and do error handling if necessary.
		local
			to_prune: detachable PS_TRANSACTION
		do
			if transaction.is_active then
				backend.rollback (transaction)
				transaction.declare_as_aborted
			end

			if not transaction.has_error then
				transaction.set_default_error
			end

			internal_active_transactions.remove (transaction)
		end

feature {NONE} -- Obsolete

		-- The two functions are just here to prevent bit-rot in case we need them again.


	delete (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete `object' within `transaction' from `Current'.
		require
			transaction_repository_correct: transaction.repository = Current
			active_transaction: transaction.is_active
			can_handle_object: can_handle (object)
			object_known: is_identified (object, transaction)
		local
			id: NATURAL_64
			primary: INTEGER
			type: PS_TYPE_METADATA
			to_delete: LINKED_LIST [PS_BACKEND_ENTITY]
			found: BOOLEAN
		do
			id := transaction.identifier_table.search (object)
			primary := transaction.primary_key_table [id]

			type := type_factory.create_metadata_from_object (object)

			create to_delete.make
			to_delete.extend (create {PS_BACKEND_OBJECT}.make (primary, type))

			across
				all_handlers as h_cursor
			until
				found
			loop
				if h_cursor.item.can_handle_type (type) then
					found := True
					if h_cursor.item.is_mapping_to_collection then
						backend.delete_collections (to_delete, transaction)
					else
						backend.delete (to_delete, transaction)
					end
				end
			end

			fixme ("Make sure other mappings to the same primary key are removed as well.")
			transaction.primary_key_table.remove (id)
			transaction.identifier_table.remove (id)
		ensure
			transaction_still_alive: transaction.is_active
			no_error: not transaction.has_error
			object_not_known: not is_identified (object, transaction)
		rescue
--			default_transactional_rescue (transaction)
		end

	delete_query (query: PS_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete all objects that match the criteria in `query' from `Current' within `transaction'.
		require
			not_executed: not query.is_executed
			transaction_repository_correct: transaction.repository = Current
			--active_transaction: query.transaction.is_active
			active_transaction: transaction.is_active
		do
			internal_execute_query (query, transaction)
			across
				query as cursor
			loop
				delete (cursor.item, transaction)
			end
		ensure
			transaction_still_alive: transaction.is_active
			no_error: not transaction.has_error
			query_executed: query.is_executed
			no_result: query.is_after
		end

end

