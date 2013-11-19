note
	description: "Summary description for {PS_DEFAULT_REPOSITORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_DEFAULT_REPOSITORY

inherit
	PS_REPOSITORY
		redefine is_root, direct_update end

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

	internal_execute_query (query: PS_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Execute `query' within `transaction'.
		do
			id_manager.register_transaction (transaction)
			if attached {PS_QUERY [ANY]} query as obj_query then
				retriever.setup_query (obj_query, transaction)
			end
		rescue
			query.reset
			default_transactional_rescue (transaction)
		end

	next_entry (query: PS_QUERY [ANY])
			-- Retrieves the next object. Stores item directly into result_set.
			-- In case of an error it is written into the transaction connected to the query.
		do
			id_manager.register_transaction (query.transaction)
			if attached {PS_QUERY [ANY]} query as obj_query then
				retriever.next_entry (obj_query)
			end
		rescue
			query.reset
			default_transactional_rescue (query.transaction)
		end

	internal_execute_tuple_query (tuple_query: PS_TUPLE_QUERY [ANY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Execute the tuple query `tuple_query' within the readonly transaction `transaction'.
		local
			exception: PS_INTERNAL_ERROR
		do
			id_manager.register_transaction (transaction)
			retriever.setup_tuple_query (tuple_query, transaction)
		rescue
			tuple_query.reset
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
			tuple_query.reset
			default_transactional_rescue (tuple_query.transaction)
		end

feature {PS_ABEL_EXPORT} -- Modification

	insert (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Insert `object' within `transaction' into `Current'.
		do
			id_manager.register_transaction (transaction)
			disassembler.execute_disassembly (object, (create {PS_WRITE_OPERATION}).insert, agent id_manager.is_identified(?, transaction))

			do_write (disassembler.object_graph, transaction)
		rescue
			default_transactional_rescue (transaction)
		end

	update (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Update `object' within `transaction'.
		do
			id_manager.register_transaction (transaction)
			disassembler.execute_disassembly (object, (create {PS_WRITE_OPERATION}).update, agent id_manager.is_identified(?, transaction))

			do_write (disassembler.object_graph, transaction)
		rescue
			default_transactional_rescue (transaction)
		end

	direct_update (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Update `object' only and none of its referenced objects.
		do
			default_object_graph.set_update_depth (1)
			update (object, transaction)
			default_object_graph.set_update_depth (-1)
		end

	delete (object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete `object' within `transaction' from `Current'.
		do
			id_manager.register_transaction (transaction)
			disassembler.execute_disassembly (object, (create {PS_WRITE_OPERATION}).delete, agent id_manager.is_identified(?, transaction))

			do_delete (disassembler.object_graph, transaction)
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
			handlers: LINKED_LIST[PS_COLLECTION_HANDLER_OLD[detachable ANY]]
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
		do
			fixme ("TODO: implement a query")
			Result := True
		end

	is_root (object: ANY; transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Is `object' a garbage collection root?
		do
			Result := True
		end

feature {NONE} -- Initialization

	make (a_backend: PS_READ_WRITE_BACKEND)
			-- Initialize `Current'.
		do
			backend := a_backend
			create transaction_isolation_level
			create transaction_isolation
			set_transaction_isolation_level (transaction_isolation_level.repeatable_read)
			create default_object_graph.make
			create id_manager.make
			create disassembler.make (id_manager.metadata_manager, default_object_graph)
			create retriever.make (backend, id_manager, Current)
			create collection_handlers.make
			create mapper.make

			retry_count := default_retry_count
		end

feature -- Initialization

	add_collection_handler (handler: PS_COLLECTION_HANDLER_OLD [detachable ANY])
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

	backend: PS_READ_WRITE_BACKEND
			-- A BACKEND implementation

	retriever: PS_RETRIEVAL_MANAGER
			-- A retrieval manager to build objects.

	collection_handlers: LINKED_LIST[PS_COLLECTION_HANDLER_OLD [detachable ANY]]
			-- The collection handlers registered with `Current'


	do_delete (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_INTERNAL_TRANSACTION)
		local
			entity: PS_BACKEND_ENTITY
			objects_to_delete: LINKED_LIST[PS_BACKEND_ENTITY]
			collections_to_delete: LINKED_LIST[PS_BACKEND_ENTITY]
		do
			across object_graph.new_smart_cursor as cursor
			from
				identify_all (object_graph, transaction)
				create objects_to_delete.make
				create collections_to_delete.make
			loop
				check cursor.item.write_operation = cursor.item.write_operation.delete end

				if attached {PS_SINGLE_OBJECT_PART} cursor.item as obj then
					create entity.make ( mapper.quick_translate (cursor.item.object_identifier, transaction), cursor.item.metadata)
					objects_to_delete.extend (entity)
					mapper.remove_primary_key (mapper.quick_translate (cursor.item.object_identifier, transaction), cursor.item.metadata, transaction)
					id_manager.delete_identification (obj.represented_object, transaction)
				elseif attached {PS_OBJECT_COLLECTION_PART} cursor.item as coll then
					create entity.make (mapper.quick_translate (coll.object_identifier, transaction), coll.metadata)
					collections_to_delete.extend (entity)
					mapper.remove_primary_key (mapper.quick_translate (coll.object_identifier, transaction), coll.metadata, transaction)
					id_manager.delete_identification (coll.represented_object, transaction)
				else
					check relations_not_implemented: False end
				end
			end


			if not objects_to_delete.is_empty then
				backend.delete (objects_to_delete, transaction)
			end
			if not collections_to_delete.is_empty then
				backend.delete_collections (collections_to_delete, transaction)
			end
		end

	do_write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_INTERNAL_TRANSACTION)
		local
			table: HASH_TABLE[INTEGER, PS_TYPE_METADATA]
			collection_table: HASH_TABLE[INTEGER, PS_TYPE_METADATA]
			primaries: HASH_TABLE[LIST[PS_BACKEND_OBJECT], PS_TYPE_METADATA]
			collection_primaries: HASH_TABLE[LIST[PS_BACKEND_COLLECTION], PS_TYPE_METADATA]

			objects_to_write: LINKED_LIST[PS_BACKEND_OBJECT]
			collections_to_write: LINKED_LIST[PS_BACKEND_COLLECTION]
		do

			identify_all (object_graph, transaction)
			create table.make (10)
			create collection_table.make (10)

			-- Collect all insert operations
			across object_graph.new_smart_cursor as cursor
			loop
				if cursor.item.write_operation = cursor.item.write_operation.insert then
					if cursor.item.is_collection then
						collection_table.force (collection_table[cursor.item.metadata] + 1, cursor.item.metadata)
					else
						table.force (table[cursor.item.metadata] + 1, cursor.item.metadata)
					end
				end
			end

			-- Get new primary keys for collections and objects in one single call
			if not table.is_empty then
				primaries := backend.generate_all_object_primaries (table, transaction)
			else
				create primaries.make (0)
			end

			if not collection_table.is_empty then
				collection_primaries := backend.generate_collection_primaries (collection_table, transaction)
			else
				create collection_primaries.make (0)
			end

			-- Prepare the cursors
			across primaries as p loop p.item.start end
			across collection_primaries as p loop p.item.start end

			-- Update the primary key mapping table
			across object_graph.new_smart_cursor as cursor
			loop
				if cursor.item.write_operation = cursor.item.write_operation.insert then

					if cursor.item.is_collection then
						check attached collection_primaries[cursor.item.metadata] as primary_cursor then
							mapper.add_entry (cursor.item.object_wrapper, primary_cursor.item.primary_key, transaction)
							primary_cursor.remove
						end
					else
						check attached primaries[cursor.item.metadata] as primary_cursor then
							mapper.add_entry (cursor.item.object_wrapper, primary_cursor.item.primary_key, transaction)
							primary_cursor.remove
						end
					end
				end
			end

			-- Prepare the retrieved objects serving as insert/update commands
			across object_graph.new_smart_cursor as cursor
			from
				create objects_to_write.make
				create collections_to_write.make
			loop
				check cursor.item.write_operation /= cursor.item.write_operation.delete end
				if attached {PS_SINGLE_OBJECT_PART} cursor.item as obj then
					objects_to_write.extend (to_retrieved(obj, transaction))
				elseif attached {PS_OBJECT_COLLECTION_PART} cursor.item as coll then
					collections_to_write.extend (to_retrieved_collection(coll, transaction))
				else
					check relations_not_implemented: False end
				end
			end

			-- Send the actual commands to the backend
			if not objects_to_write.is_empty then
				backend.write (objects_to_write, transaction)
			end
			if not collections_to_write.is_empty then
				backend.write_collections (collections_to_write, transaction)
			end
		end


	fill_retrieved (object: PS_SINGLE_OBJECT_PART; retrieved: PS_BACKEND_OBJECT; transaction: PS_INTERNAL_TRANSACTION)
		local
			attr: PS_PAIR[STRING, STRING]
			id: INTEGER
		do
--			retrieved.set_operation (object.write_operation)
			across
				object.attributes as cursor
			loop
				if attached {PS_COMPLEX_PART} object.attribute_value (cursor.item) as complex_attribute then
					id := mapper.quick_translate (complex_attribute.object_identifier, transaction)
				end
				attr := object.attribute_value (cursor.item).as_attribute (id)
				retrieved.add_attribute (cursor.item, attr.first, attr.second)
			end

			if object.write_operation = object.write_operation.insert then
				across object.metadata.attributes as cursor
				loop
					if not retrieved.has_attribute(cursor.item) then
						retrieved.add_attribute (cursor.item, "", "NONE")
					end
				end
			end
		end


	to_retrieved (object: PS_SINGLE_OBJECT_PART; transaction: PS_INTERNAL_TRANSACTION): PS_BACKEND_OBJECT

		do
			if object.write_operation = object.write_operation.insert then
				create Result.make_fresh (mapper.quick_translate (object.object_identifier, transaction), object.metadata)
			else
				create Result.make (mapper.quick_translate (object.object_identifier, transaction), object.metadata)
			end
			fill_retrieved (object, Result, transaction)
		end


	to_retrieved_collection (coll: PS_OBJECT_COLLECTION_PART; transaction: PS_INTERNAL_TRANSACTION): PS_BACKEND_COLLECTION
		local
			item: PS_PAIR[STRING, STRING]
			id: INTEGER
		do
			across
				coll.values as cursor
			from
				if coll.write_operation = coll.write_operation.insert then
					create Result.make_fresh (mapper.quick_translate (coll.object_identifier, transaction), coll.metadata)
				else
					create Result.make (mapper.quick_translate (coll.object_identifier, transaction), coll.metadata)
				end
--				Result.set_operation (coll.write_operation)
			loop
				if attached {PS_COMPLEX_PART} cursor.item as complex_item then
					id := mapper.quick_translate (complex_item.object_identifier, transaction)
				end
				item := cursor.item.as_attribute (id)
				Result.collection_items.extend (item)
			end

			across
				coll.additional_information as cursor
			loop
				Result.add_information (cursor.key, cursor.item)
			end
		end


	mapper: PS_KEY_POID_TABLE
end
