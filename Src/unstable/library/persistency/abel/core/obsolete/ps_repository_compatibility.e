note
	description: "[
	A repository that while holding objects in memory, decomposes them and stores them in a relational-like fashion.
	Use REPOSITORY_FACTORY to get an instance of this class associated with the specific database of interest.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_REPOSITORY_COMPATIBILITY

inherit

	PS_REPOSITORY

	REFACTORING_HELPER

create
	make

feature {PS_ABEL_EXPORT} -- Obsolete


	default_object_graph: PS_OBJECT_GRAPH_SETTINGS
			-- Default object graph settings.
		obsolete "Not supported any more"
		attribute
		end


feature {PS_ABEL_EXPORT} -- Object query

	internal_execute_query (query: PS_OBJECT_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Execute `query' within `transaction'.
		do
			id_manager.register_transaction (transaction)
			if attached {PS_OBJECT_QUERY [ANY]} query as obj_query then
				retriever.setup_query (obj_query, transaction)
			end
		rescue
			default_transactional_rescue (transaction)
		end

	next_entry (query: PS_OBJECT_QUERY [ANY])
			-- Retrieves the next object. Stores item directly into result_set.
			-- In case of an error it is written into the transaction connected to the query.
		do
			id_manager.register_transaction (query.transaction)
			if attached {PS_OBJECT_QUERY [ANY]} query as obj_query then
				retriever.next_entry (obj_query)
			end
		rescue
			default_transactional_rescue (query.transaction)
		end

	internal_execute_tuple_query (tuple_query: PS_TUPLE_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Execute the tuple query `tuple_query' within the readonly transaction `transaction'.
		local
			exception: PS_INTERNAL_ERROR
		do
--			fixme ("TODO")
--			create exception
--			exception.set_message ("Feature not yet implemented.")
--			transaction.set_error (exception)
--			exception.raise
			id_manager.register_transaction (transaction)
			retriever.setup_tuple_query (tuple_query, transaction)
		rescue
			default_transactional_rescue (transaction)
		end

	next_tuple_entry (tuple_query: PS_TUPLE_QUERY [ANY])
			-- Retrieves the next tuple and stores it in `query.result_cursor'.
		local
			exception: PS_INTERNAL_ERROR
		do
--			fixme ("TODO")
--			create exception
--			exception.set_message ("Feature not yet implemented.")
--			transaction.set_error (exception)
--			exception.raise
			id_manager.register_transaction (tuple_query.transaction)
			retriever.next_tuple_entry (tuple_query)
		rescue
			default_transactional_rescue (tuple_query.transaction)
		end

feature {PS_ABEL_EXPORT} -- Modification

	insert (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Insert `object' within `transaction' into `Current'.
		do
			id_manager.register_transaction (transaction)
			disassembler.execute_disassembly (object, (create {PS_WRITE_OPERATION}).insert, agent id_manager.is_identified(?, transaction))
			identify_all (disassembler.object_graph, transaction)
			backend.write (disassembler.object_graph, transaction)
--			planner.set_object_graph (disassembler.object_graph)
--			planner.generate_plan
--			executor.perform_operations (planner.operation_plan, transaction)
		rescue
			default_transactional_rescue (transaction)
		end

	update (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Update `object' within `transaction'.
		do
			id_manager.register_transaction (transaction)
			disassembler.execute_disassembly (object, (create {PS_WRITE_OPERATION}).update, agent id_manager.is_identified(?, transaction))
			identify_all (disassembler.object_graph, transaction)
			backend.write (disassembler.object_graph, transaction)
--			planner.set_object_graph (disassembler.object_graph)
--			planner.generate_plan
--			executor.perform_operations (planner.operation_plan, transaction)
		rescue
			default_transactional_rescue (transaction)
		end

	delete (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete `object' within `transaction' from `Current'.
		do
			id_manager.register_transaction (transaction)
			disassembler.execute_disassembly (object, (create {PS_WRITE_OPERATION}).delete, agent id_manager.is_identified(?, transaction))
			identify_all (disassembler.object_graph, transaction)
			backend.write (disassembler.object_graph, transaction)
			planner.set_object_graph (disassembler.object_graph)
			planner.generate_plan
--			executor.perform_operations (planner.operation_plan, transaction)
			across
				planner.operation_plan as op
			loop
				if attached {PS_COMPLEX_PART} op.item as complex and then complex.write_operation = complex.write_operation.delete then
					id_manager.delete_identification (complex.represented_object, transaction)
				end
			end
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
			handlers: LINKED_LIST[PS_COLLECTION_HANDLER_OLD[ITERABLE [detachable ANY]]]
		do
			handlers:= collection_handlers
			backend.wipe_out
			make (backend)
			across handlers as handler_cursor loop
				add_collection_handler (handler_cursor.item)
			end
		end

feature {PS_ABEL_EXPORT} -- Status Report

	can_handle (object: ANY): BOOLEAN
			-- Can `Current' handle the object `object'?
		local
			tx: PS_INTERNAL_TRANSACTION
			executor: PS_WRITE_EXECUTOR
		do
			fixme ("TODO: implement a similar query in new backend interface")
			if attached {PS_BACKEND_COMPATIBILITY} backend as b then
				create executor.make (b, id_manager)
				create tx.make_readonly (Current)
				disassembler.execute_disassembly (object, (create {PS_WRITE_OPERATION}).insert, agent id_manager.is_identified(?, tx))
				planner.set_object_graph (disassembler.object_graph)
				planner.generate_plan
				Result := executor.can_backend_handle_operations (planner.operation_plan)
			else
				Result := True
			end

		end

feature {NONE} -- Initialization

	make (a_backend: PS_BACKEND_COMPATIBILITY)
			-- Initialize `Current'.
		do
			backend := a_backend
			create transaction_isolation_level
			set_transaction_isolation_level (transaction_isolation_level.repeatable_read)
			create transaction_isolation
			create default_object_graph.make
			create id_manager.make
			create planner.make
			create disassembler.make (id_manager.metadata_manager, default_object_graph)
--			create executor.make (backend, id_manager)
			create retriever.make (backend, id_manager, Current)
			create collection_handlers.make

			retry_count := default_retry_count
		end

feature -- Initialization

	add_collection_handler (handler: PS_COLLECTION_HANDLER_OLD [ITERABLE [detachable ANY]])
			-- Add a handler for a specific type of collections.
		do
			retriever.add_handler (handler)
			disassembler.add_handler (handler)
			collection_handlers.extend (handler)
		end

feature {PS_ABEL_EXPORT} -- Implementation

	identify_all (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_INTERNAL_TRANSACTION)
			-- Add an identifier wrapper to all objects in the graph
		do
--			across object_graph as cursor
--			from cursor.ignore_no_operation
--			loop
--				if attached {PS_COMPLEX_PART} cursor.item as part and then not part.is_identified then
--					check part.write_operation /= part.write_operation.no_operation end
--					if not id_manager.is_identified (part.represented_object, transaction) then
--						id_manager.identify (part.represented_object, transaction)
--					end
--					part.set_object_wrapper (id_manager.identifier_wrapper (part.represented_object, transaction))
--				end
--			end
--			across id_manager.global_set.current_items as cursor loop print (cursor.item.at (2)) print (", ") end print ("%N")
			across object_graph as cursor
			loop
				if attached {PS_COMPLEX_PART} cursor.item as item and then not item.is_identified then
					if not id_manager.is_identified (item.represented_object, transaction) then
						id_manager.identify (item.represented_object, transaction)
					end
					item.set_object_wrapper (id_manager.identifier_wrapper (item.represented_object, transaction))
				end
			end
		end

	mapper: PS_KEY_POID_TABLE
		do
			Result := backend.key_mapper
		end

	disassembler: PS_OBJECT_GRAPH_BUILDER
			-- An object graph builder to create explicit object graphs.

	planner: PS_WRITE_PLANNER
			-- A write planner to generate an operation plan from an object graph.

--	executor: PS_WRITE_EXECUTOR
			-- An executor to execute operations in an operation plan

	backend: PS_BACKEND_COMPATIBILITY
			-- A BACKEND implementation

	retriever: PS_RETRIEVAL_MANAGER
			-- A retrieval manager to build objects.

	collection_handlers: LINKED_LIST[PS_COLLECTION_HANDLER_OLD [ITERABLE [detachable ANY]]]
			-- The collection handlers registered with `Current'
end
