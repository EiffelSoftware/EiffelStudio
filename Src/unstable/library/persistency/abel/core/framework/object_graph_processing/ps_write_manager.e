note
	description: "This class processes object graphs and generates PS_BACKEND_OBJECTs to be written by the backend."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_WRITE_MANAGER

inherit
	PS_ABSTRACT_MANAGER [PS_OBJECT_WRITE_DATA]

create
	make

feature {NONE} -- Initialization

	make (a_metadata_factory: like type_factory; a_connector: like connector)
			-- Initialization for `Current'.
		do
			initialize (a_metadata_factory)
			connector := a_connector
			create traversal.make (create {ANY}, type_factory)

			-- NOTE: Be aware that object_storage is aliased!
			object_storage := traversal.traversed_objects

			create object_primary_key_order.make (small_size)
			create collection_primary_key_order.make (small_size)
			create generated_object_primary_keys.make (small_size)
			create generated_collection_primary_keys.make (small_size)
			create objects_to_write.make (small_size)
			create collections_to_write.make (small_size)
		end

	object_storage: ARRAYED_LIST [PS_OBJECT_WRITE_DATA]
			-- An internal storage for objects.

feature {PS_ABEL_EXPORT} -- Access

	count: INTEGER
			-- The number of objects known to this manager.
		do
			Result := object_storage.count
		ensure then
			correct: object_storage.count = Result
		end

	item (index: INTEGER): PS_OBJECT_WRITE_DATA
			-- Get the object with index `index'
		do
			Result := object_storage [index]
		ensure then
			object_correct: object_storage [index] = Result
			index_set: Result.index = index
		end


	transaction: PS_INTERNAL_TRANSACTION
			-- The transaction in which the current operation is running.
		do
			check attached internal_transaction as attached_transaction then
				Result := attached_transaction
			end
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_valid_index (index: INTEGER): BOOLEAN
			-- Is `index' a valid index?
		do
			Result := 1 <= index and index <= count
		end

feature {PS_ABEL_EXPORT} -- Accesss: Static

	connector: PS_REPOSITORY_CONNECTOR
			-- A repository connector for the write operations.

	traversal: PS_OBJECT_GRAPH_TRAVERSAL
			-- An object to traverse and generate an object graph.

feature {PS_ABEL_EXPORT} -- Access: Per Write


	object_primary_key_order: HASH_TABLE [INTEGER, PS_TYPE_METADATA]
			-- All primary keys for objects to be generated.

	collection_primary_key_order: HASH_TABLE [INTEGER, PS_TYPE_METADATA]
			-- All primary keys for collections to be generated.

	generated_object_primary_keys: HASH_TABLE [LIST [PS_BACKEND_OBJECT], PS_TYPE_METADATA]
			-- The generated object primary keys.

	generated_collection_primary_keys: HASH_TABLE [LIST [PS_BACKEND_COLLECTION], PS_TYPE_METADATA]
			-- The generated collection primary keys.

	objects_to_write: ARRAYED_LIST [PS_BACKEND_OBJECT]
			-- All objects to be written to the database.

	collections_to_write: ARRAYED_LIST [PS_BACKEND_COLLECTION]
			-- All collections to be written to the database.

feature {PS_ABEL_EXPORT} -- Write execution

	can_handle (root_object: ANY; a_transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Check if `Current' can handle `root_object'.
		local
			i: INTEGER
		do
			wipe_out
			internal_transaction := a_transaction
			traversal.set_root_object (root_object)
			traversal.traverse
			assign_handlers (1 |..| count)
			do_all (agent {PS_HANDLER}.set_is_persistent)

			from
				Result := True
				i := 1
			until
				i > count or not Result
			loop
				if item (i).is_ignored then

				elseif item (i).handler.is_mapping_to_object then
					Result := Result and connector.is_object_type_supported (item (i).type)
				elseif item (i).handler.is_mapping_to_collection then
					Result := Result and connector.is_generic_collection_supported

				end
				i := i + 1
			variant
				count + 1 - i
			end
		end

	write (root_object: ANY; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Insert or update `root_object' and all objects reachable from it.
		local
			object: PS_OBJECT_WRITE_DATA
		do
			wipe_out
			internal_transaction := a_transaction
			traversal.set_root_object (root_object)
			traversal.traverse
			-- The next step is not necessary due to aliasing
			-- object_storage := traversal.traversed_objects

			assign_handlers (1 |..| count)

			a_transaction.identifier_table.prepare

--			do_all (agent {PS_HANDLER}.set_is_persistent)
			across
				object_storage as cursor
			loop
				object := cursor.item
				if not object.is_ignored then
					object.handler.set_is_persistent (object)
				end
			end

--			do_all (agent {PS_HANDLER}.set_identifier)
			across
				object_storage as cursor
			loop
				object := cursor.item
				if not object.is_ignored then
					object.handler.set_identifier (object)
				end
			end

			a_transaction.identifier_table.release


--			do_all (agent {PS_HANDLER}.generate_primary_key)
			across
				object_storage as cursor
			loop
				object := cursor.item
				if not object.is_ignored then
					object.handler.generate_primary_key (object)
				end
			end


			if not object_primary_key_order.is_empty then
				generated_object_primary_keys := connector.generate_all_object_primaries (object_primary_key_order, transaction)
				across generated_object_primary_keys as cursor loop cursor.item.start end
			end

			if not collection_primary_key_order.is_empty then
				generated_collection_primary_keys := connector.generate_collection_primaries (collection_primary_key_order, transaction)
				across generated_collection_primary_keys as cursor2 loop cursor2.item.start end
			end

--			do_all (agent {PS_HANDLER}.generate_backend_representation)
			across
				object_storage as cursor
			loop
				object := cursor.item
				if not object.is_ignored then
					object.handler.generate_backend_representation (object)
				end
			end


--			do_all (agent {PS_HANDLER}.initialize_backend_representation)
			across
				object_storage as cursor
			loop
				object := cursor.item
				if not object.is_ignored then
					object.handler.initialize_backend_representation (object)
				end
			end

			set_root_flags (transaction.root_declaration_strategy)

			across
				1 |..| count as idx
			loop
				if attached item (idx.item).backend_representation as br then
					br.set_is_root (transaction.root_flags [item (idx.item).identifier])
				end
			end

--			do_all (agent {PS_HANDLER}.write_backend_representation)
			across
				object_storage as cursor
			loop
				object := cursor.item
				if not object.is_ignored then
					object.handler.write_backend_representation (object)
				end
			end


			if not objects_to_write.is_empty then
				connector.write (objects_to_write, transaction)
			end

			if not collections_to_write.is_empty then
				connector.write_collections (collections_to_write, transaction)
			end

			if attached connector.after_write_action as action then
				across
					object_storage as cursor
				loop
					object := cursor.item
					if not object.is_ignored then
						action (cursor.item)
					end
				end
			end
		end


	update_root (object: ANY; value: BOOLEAN; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Set the root status of `object' to `value'.
		local
			reflected_object: REFLECTED_REFERENCE_OBJECT
			type: PS_TYPE_METADATA
			object_data: PS_OBJECT_WRITE_DATA
		do
				-- Initialize the data structures first.
			wipe_out
			object_storage.wipe_out

			internal_transaction := a_transaction
			create reflected_object.make (object)
			type := traversal.factory.create_metadata_from_type_id (reflected_object.dynamic_type)

			create object_data.make_with_object (1, reflected_object, 0, type)
			object_storage.extend (object_data)

			check count_is_one: count = 1 end

			assign_handlers (1 |..| count)
			a_transaction.identifier_table.prepare
			do_all (agent {PS_HANDLER}.set_is_persistent)
			do_all (agent {PS_HANDLER}.set_identifier)
			a_transaction.identifier_table.release
			do_all (agent {PS_HANDLER}.generate_primary_key)

				-- No need to generate primary keys in a batch, as the object should be identified already.
			check object_persistent: object_primary_key_order.is_empty and collection_primary_key_order.is_empty end

			do_all (agent {PS_HANDLER}.generate_backend_representation)

				-- Do not initialize... we don't want to perform an actual update...

				-- Set the root status in the backend representation
			transaction.root_flags.force (value, item (1).identifier)
			check attached item (1).backend_representation as br then
				br.set_is_root (transaction.root_flags [item (1).identifier])
				br.set_is_update_delta (True)
			end

			do_all (agent {PS_HANDLER}.write_backend_representation)

			if not objects_to_write.is_empty then
				connector.write (objects_to_write, transaction)
			end

			if not collections_to_write.is_empty then
				connector.write_collections (collections_to_write, transaction)
			end

			if attached connector.after_write_action as action then
				across
					object_storage as cursor
				loop
					if not cursor.item.is_ignored then
						action (cursor.item)
					end
				end
			end
		end


	direct_update (root_object: ANY; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Insert or update `root_object' and all objects reachable from it.
		local
			i, k: INTEGER
		do
			wipe_out
			internal_transaction := a_transaction
			traversal.set_root_object (root_object)
			traversal.traverse

			from
				i := 1
			until
				i > count or else item (i).level > 1
			loop
				k := i
				i := i + 1
			end


			assign_handlers (1 |..| k)
			a_transaction.identifier_table.prepare
			do_all_in_set (agent {PS_HANDLER}.set_is_persistent, 1 |..| k)
			do_all_in_set (agent {PS_HANDLER}.set_identifier, 1 |..| k)
			a_transaction.identifier_table.release
			do_all_in_set (agent {PS_HANDLER}.generate_primary_key, 1 |..| k)

			check object_primary_key_order.is_empty and collection_primary_key_order.is_empty end

			do_all_in_set (agent {PS_HANDLER}.generate_backend_representation, 1 |..| k)
			do_all_in_set (agent {PS_HANDLER}.initialize_backend_representation, 1 |..| 1)

			if
				not transaction.root_declaration_strategy.is_preserve and
				(not item (1).is_persistent or transaction.root_declaration_strategy.is_argument_of_write)
			then
				transaction.root_flags.force (True, item (1).identifier)
			end

			check attached item (1).backend_representation as br then
				br.set_is_root (transaction.root_flags [item (1).identifier])
			end

			do_all_in_set (agent {PS_HANDLER}.write_backend_representation, 1 |..| 1)

			if not objects_to_write.is_empty then
				connector.write (objects_to_write, transaction)
			end

			if not collections_to_write.is_empty then
				connector.write_collections (collections_to_write, transaction)
			end

			if attached connector.after_write_action as action then
				across
					object_storage as cursor
				loop
					if not cursor.item.is_ignored then
						action (cursor.item)
					end
				end
			end
		end

	set_root_flags (strategy: PS_ROOT_OBJECT_STRATEGY)
		do
			if
				not transaction.root_declaration_strategy.is_preserve and
				(not item (1).is_persistent or transaction.root_declaration_strategy.is_argument_of_write)
			then
				transaction.root_flags.force (True, item (1).identifier)
			end

			if strategy.is_everything then
				across
					1 |..| count as idx
				loop
					transaction.root_flags.force (True, item (idx.item).identifier)
				end
			end

		end

feature {PS_ABEL_EXPORT} -- Support

	cascading_ignore (object: PS_OBJECT_DATA)
			-- Ignore `object' and all objects transitively referenced by it.
		local
			stack: LINKED_STACK [INTEGER]
			i: INTEGER
		do
			from
				create stack.make
				stack.extend (object.index)
			until
				stack.is_empty
			loop
				i := stack.item
				stack.remove

				item (i).ignore

				across
					item (i).references as ref_cursor
				loop

--					check
--						correct_referer: item (ref_cursor.item).referers.count > 0
--						and (item (ref_cursor.item).referers.count = 1
--							implies item (ref_cursor.item).referers.first = i)
--					end

					if item (ref_cursor.item).referer_count = 1 then
						stack.extend (item (ref_cursor.item).index)
					end
				end
			end
		end

feature {NONE} -- Implementation

	wipe_out
			-- Wipe out all data structures.
		do
			object_primary_key_order.wipe_out
			collection_primary_key_order.wipe_out
			generated_object_primary_keys.wipe_out
			generated_collection_primary_keys.wipe_out
			objects_to_write.wipe_out
			collections_to_write.wipe_out
		end

	internal_transaction: detachable like transaction
			-- The detachable attribute for `transaction'
end
