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
		do
			initialize_query (query, transaction)
			check attached query.read_manager as rm then
				rm.execute (query, transaction, query.object_initialization_depth)
			end
		rescue
			default_transactional_rescue (transaction)
			query.close
		end

	internal_execute_tuple_query (tuple_query: PS_TUPLE_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Execute the tuple query `tuple_query' within the readonly transaction `transaction'.
		do
			initialize_query (tuple_query, transaction)
			check attached tuple_query.read_manager as rm then
				rm.execute_tuple (tuple_query, transaction, tuple_query.object_initialization_depth)
			end
		rescue
			default_transactional_rescue (transaction)
			tuple_query.close
		end

feature {PS_ABEL_EXPORT} -- Modification

	write (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Insert `object' within `transaction' into `Current'.
		do
			write_manager.write (object, transaction)
		rescue
			default_transactional_rescue (transaction)
		end

	direct_update (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Update `object' only and none of its referenced objects.
		do
			write_manager.direct_update (object, transaction)
		rescue
			default_transactional_rescue (transaction)
		end

	set_root_status (object: ANY; value: BOOLEAN; transaction: PS_INTERNAL_TRANSACTION)
			-- Set the root status of `object' to `value'.
		do
			write_manager.update_root (object, value, transaction)
		rescue
			default_transactional_rescue (transaction)
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

	all_handlers: LINKED_LIST[PS_HANDLER]
			-- All object handlers known to `Current'


feature {NONE} -- Implementation


	initialize_query (query: PS_ABSTRACT_QUERY[ANY, ANY]; transaction: PS_INTERNAL_TRANSACTION)
		local
			new_read_manager: PS_READ_MANAGER
		do
			create new_read_manager.make (id_manager.metadata_manager, id_manager, mapper, backend)
			all_handlers.do_all (agent new_read_manager.add_handler)
			query.prepare_execution (transaction, new_read_manager)
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
			id: PS_OBJECT_IDENTIFIER_WRAPPER
			primary: INTEGER
			to_delete: LINKED_LIST[PS_BACKEND_ENTITY]
			found: BOOLEAN
		do
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
		ensure
			transaction_still_alive: transaction.is_active
			no_error: not transaction.has_error
			object_not_known: not is_identified (object, transaction)
			transaction_active_in_id_manager: id_manager.is_registered (transaction)
		rescue
			default_transactional_rescue (transaction)
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
			transaction_active_in_id_manager: id_manager.is_registered (transaction)
			query_executed: query.is_executed
			no_result: query.is_after
		end

end

