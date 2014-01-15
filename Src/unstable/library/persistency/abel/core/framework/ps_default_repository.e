note
	description: "A default repository that does the object-relational mapping, %
				% but relies on a PS_REPOSITORY_CONNECTOR for the stoage mechanism."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_DEFAULT_REPOSITORY

inherit
	PS_REPOSITORY

create
	make_from_factory

feature -- Access.

	batch_retrieval_size: INTEGER
			-- <Precursor>
		do
			Result := connector.batch_retrieval_size
		end

feature -- Element change

	set_batch_retrieval_size (size: INTEGER)
			-- <Precursor>
		do
			connector.set_batch_retrieval_size (size)
		end

feature -- Disposal

	collect_garbage
			-- <Precursor>
		local
			roots: PS_QUERY [ANY]
			non_roots: PS_QUERY [ANY]

			root_manager: PS_READ_MANAGER
			non_root_manager: PS_READ_MANAGER

			garbage_key: INTEGER
			garbage_type: PS_TYPE_METADATA

			collection_delete: ARRAYED_LIST [PS_BACKEND_COLLECTION]
			object_delete: ARRAYED_LIST [PS_BACKEND_OBJECT]
			delete_transaction: PS_INTERNAL_TRANSACTION

		do
			create collection_delete.make (0)
			create object_delete.make (0)

			create roots.make
			roots.set_is_non_root_ignored (True)
			internal_execute_query (roots, new_internal_transaction (True))
				-- Load everything.
			across roots as c loop end

			check attached {PS_QUERY_CURSOR} roots.internal_cursor as c then
				root_manager := c.read_manager
			end

			create non_roots.make
			internal_execute_query (non_roots, new_internal_transaction (True))
				-- Load everything.
			across non_roots as c loop end

			check attached {PS_QUERY_CURSOR} non_roots.internal_cursor as c then
				non_root_manager := c.read_manager
			end

			across
				non_root_manager.get_cache as type_cursor
			loop
				across
					type_cursor.item as primary_cursor
				loop
					if root_manager.cache_lookup (primary_cursor.key, type_cursor.key) = 0 then
							-- Found some garbage.
						garbage_key := primary_cursor.key
						garbage_type := type_cursor.key

						across
							all_handlers as cursor
						loop
							if cursor.item.can_handle_type (garbage_type) then
								if cursor.item.is_mapping_to_collection then
									collection_delete.extend (create {PS_BACKEND_COLLECTION}.make (garbage_key, garbage_type))
								else
									object_delete.extend (create {PS_BACKEND_OBJECT}.make (garbage_key, garbage_type))
								end
							end
						end
					end
				end
			end

			roots.close
			non_roots.close

			delete_transaction := new_internal_transaction (False)
			if not collection_delete.is_empty then
				connector.delete_collections (collection_delete, delete_transaction)
			end

			if not object_delete.is_empty then
				connector.delete (object_delete, delete_transaction)
			end
			connector.commit (delete_transaction)
		end


	close
			-- <Precursor>
		do
			connector.close
		end

feature {PS_ABEL_EXPORT} -- Object query

	internal_execute_query (query: PS_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		local
			type: PS_TYPE_METADATA
		do
			type := type_factory.create_metadata_from_type (query.generic_type)
			initialize_query (query, transaction, type.attributes)
		end

	internal_execute_tuple_query (tuple_query: PS_TUPLE_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
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
			-- <Precursor>
		local
			retried: BOOLEAN
		do
			if not retried then
				write_manager.write (object, transaction)
			end
		rescue
			retried := True
			abort (transaction)
			check has_error: transaction.has_error end
			if transaction.is_retry_allowed then
				retry
			end
		end

	direct_update (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		local
			retried: BOOLEAN
		do
			if not retried then
				write_manager.direct_update (object, transaction)
			end
		rescue
			retried := True
			abort (transaction)
			check has_error: transaction.has_error end
			if transaction.is_retry_allowed then
				retry
			end
		end

	set_root_status (object: ANY; value: BOOLEAN; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		local
			retried: BOOLEAN
		do
			if not retried then
				write_manager.update_root (object, value, transaction)
			end
		rescue
			retried := True
			abort (transaction)
			check has_error: transaction.has_error end
			if transaction.is_retry_allowed then
				retry
			end
		end

feature {PS_ABEL_EXPORT} -- Transaction handling

	commit_transaction (transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		local
			retried: BOOLEAN
		do
			if not retried then
					-- The next statement may fail and raise an exception.
					-- In that case, `transaction.has_error' is True.
				connector.commit (transaction)
				transaction.close
			end
		rescue
			retried := True
			abort (transaction)
			check has_error: transaction.has_error end
			if transaction.is_retry_allowed then
				retry
			end
		end

	rollback_transaction (transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		do
			connector.rollback (transaction)
			transaction.close
		end

feature {PS_ABEL_EXPORT} -- Testing

	wipe_out
			--<Precursor>
		local
			batch_size: INTEGER
		do
			batch_size := batch_retrieval_size
			connector.wipe_out

			create type_factory.make
			create write_manager.make (type_factory, connector)

			all_handlers.do_all (agent {PS_HANDLER}.set_write_manager (write_manager))
			all_handlers.do_all (agent write_manager.add_handler)

			set_batch_retrieval_size (batch_size)
		end

feature {PS_ABEL_EXPORT} -- Status Report

	can_handle (object: ANY): BOOLEAN
			-- <Precursor>
		local
			local_transaction: PS_INTERNAL_TRANSACTION
		do
			local_transaction := new_internal_transaction (True)
			Result := write_manager.can_handle (object, local_transaction)
		end

feature {NONE} -- Initialization

	make_from_factory (
			a_connector: PS_REPOSITORY_CONNECTOR;
			a_type_factory: PS_METADATA_FACTORY;
			a_write_manager: PS_WRITE_MANAGER;
			handler_list: LINKED_LIST [PS_HANDLER];
			transaction_settings: PS_TRANSACTION_SETTINGS
			)
			-- Initialization for `Current'.
		do
			initialize

			connector := a_connector
			type_factory := a_type_factory
			write_manager := a_write_manager
			all_handlers := handler_list
			transaction_isolation := transaction_settings

			retry_count := default_retry_count
			set_batch_retrieval_size (infinite_batch_size)
		end

feature {PS_ABEL_EXPORT} -- Implementation

	connector: PS_REPOSITORY_CONNECTOR
			-- A repository connector.

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
			create new_read_manager.make (type_factory, connector, transaction)
			all_handlers.do_all (agent new_read_manager.add_handler)

			create query_cursor.make (query, filter, new_read_manager)

			query.prepare_execution (transaction, query_cursor)
			query.retrieve_next
		end

	abort (transaction: PS_INTERNAL_TRANSACTION)
			-- Abort `transaction' and do some cleanup.
			-- May be called to resolve exceptions.
		local
			to_prune: detachable PS_TRANSACTION
		do
			if transaction.is_active then
				connector.rollback (transaction)
				transaction.close
			end

			if not transaction.has_error then
				transaction.set_default_error
			end

			internal_active_transactions.remove (transaction)
		ensure
			has_error: transaction.has_error
			not_present: not internal_active_transactions.has (transaction)
		end

feature {NONE} -- Obsolete: for future reference.

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
			to_delete: ARRAYED_LIST [PS_BACKEND_ENTITY]
			found: BOOLEAN
		do
			id := transaction.identifier_table.search (object)
			primary := transaction.primary_key_table [id]
			type := type_factory.create_metadata_from_object (object)

			create to_delete.make (1)
			to_delete.extend (create {PS_BACKEND_OBJECT}.make (primary, type))

			across
				all_handlers as h_cursor
			until
				found
			loop
				if h_cursor.item.can_handle_type (type) then
					found := True
					if h_cursor.item.is_mapping_to_collection then
						connector.delete_collections (to_delete, transaction)
					else
						connector.delete (to_delete, transaction)
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
		end

	delete_query (query: PS_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete all objects that match the criteria in `query' from `Current' within `transaction'.
		require
			not_executed: not query.is_executed
			transaction_repository_correct: transaction.repository = Current
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

