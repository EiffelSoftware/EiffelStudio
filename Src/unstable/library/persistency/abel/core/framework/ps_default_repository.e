note
	description: "A default repository that does the object-relational mapping, but relies on a PS_BACKEND for the stoage mechanism."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_DEFAULT_REPOSITORY

inherit
	PS_REPOSITORY
		redefine
			set_root_status
		end

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
		do
			id_manager.register_transaction (transaction)
			initialize_query (query, transaction)
			check attached query.read_manager as rm then
				rm.execute (query, transaction, query.object_initialization_depth)
			end
--			attach (read_manager_cache[query.backend_identifier]).execute (query, transaction, query.object_initialization_depth)
		rescue
--			query.reset
			query.close
			default_transactional_rescue (transaction)
		end

	next_entry (query: PS_QUERY [ANY])
			-- Retrieves the next object. Stores item directly into result_set.
			-- In case of an error it is written into the transaction connected to the query.
		do
			id_manager.register_transaction (query.internal_transaction)
			check attached query.read_manager as rm then
				rm.next_entry (query)
			end

			--attach (read_manager_cache[query.backend_identifier]).next_entry (query)
		rescue
			fixme ("What to do in such a case (i.e. exception during lazy loading)?")
--			query.reset
			query.close
			default_transactional_rescue (query.internal_transaction)
		end

	internal_execute_tuple_query (tuple_query: PS_TUPLE_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Execute the tuple query `tuple_query' within the readonly transaction `transaction'.
		local
			exception: PS_INTERNAL_ERROR
		do
			id_manager.register_transaction (transaction)
			initialize_query (tuple_query, transaction)
			check attached tuple_query.read_manager as rm then
				rm.execute_tuple (tuple_query, transaction, tuple_query.object_initialization_depth)
			end

--			attach (read_manager_cache[tuple_query.backend_identifier]).execute_tuple (tuple_query, transaction, tuple_query.object_initialization_depth)
		rescue
			tuple_query.reset
			default_transactional_rescue (transaction)
		end

	next_tuple_entry (tuple_query: PS_TUPLE_QUERY [ANY])
			-- Retrieves the next tuple and stores it in `query.result_cursor'.
		local
			exception: PS_INTERNAL_ERROR
		do
			id_manager.register_transaction (tuple_query.internal_transaction)
--			attach (read_manager_cache[tuple_query.backend_identifier]).next_tuple_entry (tuple_query)

			check attached tuple_query.read_manager as rm then
				rm.next_tuple_entry (tuple_query)
			end
		rescue
			fixme ("What to do in such a case (i.e. exception during lazy loading)?")
			tuple_query.reset
			default_transactional_rescue (tuple_query.internal_transaction)
		end

feature {PS_ABEL_EXPORT} -- Modification

	insert (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Insert `object' within `transaction' into `Current'.
		do
			id_manager.register_transaction (transaction)
			write_manager.write (object, transaction)
		rescue
			default_transactional_rescue (transaction)
		end

	update (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Update `object' within `transaction'.
		do
			id_manager.register_transaction (transaction)
			write_manager.write (object, transaction)
		rescue
			default_transactional_rescue (transaction)
		end

	direct_update (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Update `object' only and none of its referenced objects.
		do
			id_manager.register_transaction (transaction)
			write_manager.direct_update (object, transaction)
		end

	delete (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete `object' within `transaction' from `Current'.
		local
			id: PS_OBJECT_IDENTIFIER_WRAPPER
			primary: INTEGER
			to_delete: LINKED_LIST[PS_BACKEND_ENTITY]
			found: BOOLEAN
		do
			id_manager.register_transaction (transaction)

			id := id_manager.identifier_wrapper (object, transaction)
			primary := mapper.quick_translate (id.object_identifier, transaction)

			create to_delete.make
			to_delete.extend (create {PS_BACKEND_OBJECT}.make (primary, id.metadata))

			across
				all_handlers as h_cursor
			until
				found
			loop
				if h_cursor.item.can_handle_type (id.metadata) then
					found := True
					if h_cursor.item.is_mapping_to_collection then
						backend.delete_collections (to_delete, transaction)
					else
						backend.delete (to_delete, transaction)
					end
				end
			end
			mapper.remove_primary_key (primary, id.metadata, transaction)
			id_manager.delete_identification (object, transaction)
		rescue
			default_transactional_rescue (transaction)
		end

	set_root_status (object: ANY; value: BOOLEAN; transaction: PS_INTERNAL_TRANSACTION)
			-- Set the root status of `object' to `value'.
		do
			write_manager.update_root (object, value, transaction)
		end

feature {PS_ABEL_EXPORT} -- Transaction handling

	commit_transaction (transaction: PS_INTERNAL_TRANSACTION)
			-- Explicitly commit the transaction.
		do
			if id_manager.can_commit (transaction) then
				backend.commit (transaction) -- can fail and raise an exception
				id_manager.commit (transaction)
				transaction.declare_as_successful
			else
				rollback_transaction (transaction, False)
			end
		rescue
			default_transactional_rescue (transaction)
		end

	rollback_transaction (transaction: PS_INTERNAL_TRANSACTION; manual_rollback: BOOLEAN)
			-- Rollback the transaction.
		do
			backend.rollback (transaction)
			id_manager.rollback (transaction)
			transaction.declare_as_aborted
		end

feature {PS_ABEL_EXPORT} -- Testing

	clean_db_for_testing
			-- Wipe out all data.
		local
			batch_size: INTEGER
		do
			batch_size := batch_retrieval_size
			backend.wipe_out

			create id_manager.make
			create mapper.make
--			create read_manager_cache.make (100)

			create write_manager.make (id_manager.metadata_manager, id_manager, mapper, backend)

			all_handlers.do_all (agent {PS_HANDLER}.set_write_manager (write_manager))
			all_handlers.do_all (agent write_manager.add_handler)

			set_batch_retrieval_size (batch_size)
		end

feature {PS_ABEL_EXPORT} -- Status Report

	can_handle (object: ANY): BOOLEAN
			-- Can `Current' handle the object `object'?
		do
			fixme ("TODO: implement a query")
			Result := True
		end

feature {NONE} -- Initialization

	make_from_factory (
			a_backend: PS_BACKEND;
			an_id_manager: PS_OBJECT_IDENTIFICATION_MANAGER;
			a_mapper: PS_KEY_POID_TABLE;
			a_write_manager: PS_WRITE_MANAGER;
			handler_list: LINKED_LIST [PS_HANDLER];
			transaction_settings: PS_TRANSACTION_SETTINGS
			)
		do
			backend := a_backend
			id_manager := an_id_manager
			mapper := a_mapper
			write_manager := a_write_manager
			all_handlers := handler_list
			transaction_isolation := transaction_settings

--			create read_manager_cache.make (100)
			create transaction_isolation_level
			set_transaction_isolation_level (transaction_isolation_level.repeatable_read)

			retry_count := default_retry_count
			set_batch_retrieval_size (infinite_batch_size)
		end

feature {PS_ABEL_EXPORT} -- Implementation

	backend: PS_BACKEND
			-- A BACKEND implementation

	mapper: PS_KEY_POID_TABLE
			-- An ABEL identifier -> primary key mapper.

	write_manager: PS_WRITE_MANAGER
			-- The write manager.

--	read_manager_cache: HASH_TABLE[PS_READ_MANAGER, INTEGER]
--			-- The read managers, as associated to queries.


	all_handlers: LINKED_LIST[PS_HANDLER]
			-- All object handlers known to `Current'


feature {NONE} -- Implementation


	initialize_query (query: PS_ABSTRACT_QUERY[ANY, ANY]; transaction: PS_INTERNAL_TRANSACTION)
		local
			new_read_manager: PS_READ_MANAGER
		do
--			query.set_identifier (new_query_identifier)
			create new_read_manager.make (id_manager.metadata_manager, id_manager, mapper, backend)
			all_handlers.do_all (agent new_read_manager.add_handler)
--			read_manager_cache.extend (new_read_manager, query.backend_identifier)
			query.prepare_execution (transaction, new_read_manager)
		end


--	new_query_identifier: INTEGER
--			-- Get a new identifier for a query.
--		do
--			Result := next_query_identifier
--			next_query_identifier := next_query_identifier + 1
--		end

--	next_query_identifier: INTEGER
--			-- The next identifier number

end

