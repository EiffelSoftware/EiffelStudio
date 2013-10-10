note
	description: "Summary description for {PS_SIMPLE_IN_MEMORY_REPOSITORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SIMPLE_IN_MEMORY_REPOSITORY

inherit
	PS_REPOSITORY
		redefine
			default_create
		end

inherit {NONE}
	REFACTORING_HELPER
		undefine default_create end

create
	default_create

feature {PS_EIFFELSTORE_EXPORT} -- Object query

	execute_query (query: PS_OBJECT_QUERY [ANY]; transaction: PS_TRANSACTION)
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

	execute_tuple_query (tuple_query: PS_TUPLE_QUERY [ANY]; transaction: PS_TRANSACTION)
			-- Execute the tuple query `tuple_query' within the readonly transaction `transaction'.
		local
			exception: PS_INTERNAL_ERROR
		do
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
			id_manager.register_transaction (tuple_query.transaction)
			retriever.next_tuple_entry (tuple_query)
		rescue
			default_transactional_rescue (tuple_query.transaction)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Modification

	insert (object: ANY; transaction: PS_TRANSACTION)
			-- Insert `object' within `transaction' into `Current'.
		do
			id_manager.register_transaction (transaction)
			disassembler.execute_disassembly (object, (create {PS_WRITE_OPERATION}).insert, agent id_manager.is_identified(?, transaction))

			do_write (disassembler.object_graph, transaction)


		rescue
			default_transactional_rescue (transaction)
		end

	update (object: ANY; transaction: PS_TRANSACTION)
			-- Update `object' within `transaction'.
		do
			id_manager.register_transaction (transaction)
			disassembler.execute_disassembly (object, (create {PS_WRITE_OPERATION}).update, agent id_manager.is_identified(?, transaction))

			do_write (disassembler.object_graph, transaction)
		rescue
			default_transactional_rescue (transaction)
		end

	delete (object: ANY; transaction: PS_TRANSACTION)
			-- Delete `object' within `transaction' from `Current'.
		do
			id_manager.register_transaction (transaction)
			disassembler.execute_disassembly (object, (create {PS_WRITE_OPERATION}).delete, agent id_manager.is_identified(?, transaction))

			do_write (disassembler.object_graph, transaction)

			planner.set_object_graph (disassembler.object_graph)
			planner.generate_plan
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

feature {PS_EIFFELSTORE_EXPORT} -- Transaction handling

	commit_transaction (transaction: PS_TRANSACTION)
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

	rollback_transaction (transaction: PS_TRANSACTION; manual_rollback: BOOLEAN)
			-- Rollback the transaction.
		do
			backend.rollback (transaction)
			id_manager.rollback (transaction)
			transaction.declare_as_aborted
		end

feature {PS_EIFFELSTORE_EXPORT} -- Testing

	clean_db_for_testing
			-- Wipe out all data.
		local
			handlers: LINKED_LIST[PS_COLLECTION_HANDLER[ITERABLE [detachable ANY]]]
		do
			handlers:= collection_handlers
			backend.wipe_out
			make (backend)
			across handlers as handler_cursor loop
				add_collection_handler (handler_cursor.item)
			end
		end

feature {PS_EIFFELSTORE_EXPORT} -- Status Report

	can_handle (object: ANY): BOOLEAN
			-- Can `Current' handle the object `object'?
		local
			new_transaction: PS_TRANSACTION
			executor: PS_WRITE_EXECUTOR
		do
			fixme ("TODO: implement a similar query in new backend interface")
			if attached {PS_BACKEND_COMPATIBILITY} backend as b then
				create executor.make (b, id_manager)
				create new_transaction.make_readonly (Current)
				disassembler.execute_disassembly (object, (create {PS_WRITE_OPERATION}).insert, agent id_manager.is_identified(?, new_transaction))
				planner.set_object_graph (disassembler.object_graph)
				planner.generate_plan
				Result := executor.can_backend_handle_operations (planner.operation_plan)
			else
				Result := True
			end

		end

feature {NONE} -- Initialization

	make (a_backend: PS_READ_WRITE_BACKEND)
			-- Initialize `Current'.
		do
			backend := a_backend
			create transaction_isolation_level
			set_transaction_isolation_level (transaction_isolation_level.repeatable_read)
			create default_object_graph.make
			create id_manager.make
			create planner.make
			create disassembler.make (id_manager.metadata_manager, default_object_graph)
--			create executor.make (backend, id_manager)
			create retriever.make (backend, id_manager, Current)
			create collection_handlers.make
			create mapper.make
		end

feature -- Initialization

	add_collection_handler (handler: PS_COLLECTION_HANDLER [ITERABLE [detachable ANY]])
			-- Add a handler for a specific type of collections.
		do
			retriever.add_handler (handler)
			disassembler.add_handler (handler)
			collection_handlers.extend (handler)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Implementation

	identify_all (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_TRANSACTION)
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

	disassembler: PS_OBJECT_GRAPH_BUILDER
			-- An object graph builder to create explicit object graphs.

	planner: PS_WRITE_PLANNER
			-- A write planner to generate an operation plan from an object graph.

--	executor: PS_WRITE_EXECUTOR
			-- An executor to execute operations in an operation plan

	backend: PS_READ_WRITE_BACKEND
			-- A BACKEND implementation

	retriever: PS_RETRIEVAL_MANAGER
			-- A retrieval manager to build objects.

	collection_handlers: LINKED_LIST[PS_COLLECTION_HANDLER [ITERABLE [detachable ANY]]]
			-- The collection handlers registered with `Current'


	do_write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_TRANSACTION)
		local
			table: HASH_TABLE[INTEGER, PS_TYPE_METADATA]
			primaries: HASH_TABLE[INDEXABLE_ITERATION_CURSOR[INTEGER], PS_TYPE_METADATA]
			objects_to_write: LINKED_LIST[TUPLE[PS_RETRIEVED_OBJECT, PS_WRITE_OPERATION]]
			objects_to_delete: LINKED_LIST[TUPLE[type: PS_TYPE_METADATA; primary: INTEGER]]
		do

			identify_all (object_graph, transaction)
			create table.make (10)

			across object_graph.new_smart_cursor as cursor
			loop
				if cursor.item.write_operation = cursor.item.write_operation.insert then
					table.force (table[cursor.item.metadata] + 1, cursor.item.metadata)
				end
			end

			primaries := backend.genereta_all_object_primaries (table)

			across object_graph.new_smart_cursor as cursor
			loop
				if cursor.item.write_operation = cursor.item.write_operation.insert then
					check attached primaries[cursor.item.metadata] as primary_cursor then
						mapper.add_entry (cursor.item.object_wrapper, primary_cursor.item, transaction)
						primary_cursor.forth
					end
				end
			end


			across object_graph.new_smart_cursor as cursor
			from
				create objects_to_write.make
				create objects_to_delete.make
			loop
				if attached {PS_SINGLE_OBJECT_PART} cursor.item as obj then
					if cursor.item.write_operation /= cursor.item.write_operation.delete then
						objects_to_write.extend ([to_retrieved(obj, transaction), cursor.item.write_operation])
					else
						objects_to_delete.extend ([cursor.item.metadata, mapper.quick_translate (cursor.item.object_identifier, transaction)])
						mapper.remove_primary_key (mapper.quick_translate (cursor.item.object_identifier, transaction), cursor.item.metadata, transaction)
					end
				else
					check not_implemented: False end
				end
			end
			backend.write (objects_to_write)
			backend.delete (objects_to_delete)

		end


	to_retrieved (object: PS_SINGLE_OBJECT_PART; transaction: PS_TRANSACTION): PS_RETRIEVED_OBJECT
		local
			attr: PS_PAIR[STRING, STRING]
			id: INTEGER
		do
			across object.attributes as cursor
			from
				create Result.make (mapper.quick_translate (object.object_identifier, transaction), object.metadata)
			loop
				if attached {PS_COMPLEX_PART} object.attribute_value (cursor.item) then
					id := mapper.quick_translate (object.attribute_value (cursor.item).object_identifier, transaction)
				end
				attr := object.attribute_value (cursor.item).as_attribute (id)
				Result.add_attribute (cursor.item, attr.first, attr.second)
			end


		end


	mapper: PS_KEY_POID_TABLE


	default_create
			-- Initialization for `Current'.
		local
			simple_in_memory_backend: PS_EVEN_SIMPLER_IN_MEMORY_BACKEND
			special_handler: PS_SPECIAL_COLLECTION_HANDLER
		do
			create simple_in_memory_backend.wipe_out
			make (simple_in_memory_backend)
			create special_handler.make
			add_collection_handler (special_handler)
		end

end
