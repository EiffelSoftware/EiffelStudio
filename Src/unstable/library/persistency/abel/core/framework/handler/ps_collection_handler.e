note
	description: "A handler which maps its objects to PS_BACKEND_COLLECTION."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_COLLECTION_HANDLER

inherit

	PS_HANDLER

feature {PS_ABEL_EXPORT} -- Status report

	is_mapping_to_object: BOOLEAN = False
			-- <Precursor>

	is_mapping_to_collection: BOOLEAN = True
			-- <Precursor>

	is_mapping_to_value_type: BOOLEAN = False
			-- <Precursor>

feature {PS_ABEL_EXPORT} -- Read functions

	retrieve (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- <Precursor>
		do
			read_manager.add_to_collection_batch_retrieve (object)
		end

feature {PS_ABEL_EXPORT} -- Write functions

	generate_primary_key (object: PS_OBJECT_WRITE_DATA)
			-- <Precursor>
		do
			if not object.is_persistent then
				write_manager.collection_primary_key_order [object.type] := write_manager.collection_primary_key_order [object.type] + 1
			end
		end

	generate_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- <Precursor>
		local
			new_command: PS_BACKEND_COLLECTION
		do
			if object.is_persistent then
				create new_command.make (write_manager.transaction.primary_key_table [object.identifier], object.type)
			else
				check attached write_manager.generated_collection_primary_keys [object.type] as generated_list then
					new_command := generated_list.item
					generated_list.forth
					write_manager.transaction.primary_key_table.extend (new_command.primary_key, object.identifier)
				end
			end

			object.set_backend_representation (new_command)
		end

	initialize_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- <Precursor>
		local
			collection: PS_BACKEND_COLLECTION
			iterable: READABLE_INDEXABLE [detachable ANY]

			item_type: TYPE [detachable ANY]
			item_value: STRING
			referenced_object: PS_OBJECT_WRITE_DATA

			k: INTEGER
			used_references: ARRAYED_LIST [BOOLEAN]
		do
			check attached {READABLE_INDEXABLE [detachable ANY]} object.reflector.object as iter then
				iterable := iter
			end

			across
				iterable as cursor
			from
				collection := object.backend_collection
				create used_references.make_filled (object.references.count)
			loop
				if attached cursor.item as item then
					item_type := item.generating_type

					if basic_expanded_types.has (item_type.type_id) then
							-- Basic types
						collection.extend (basic_attribute_value (item), item_type.name)
					else
							-- Reference and expanded
						from
							k := 1
						until
							k > object.references.count or (
								-- We need to keep track of used references because of expanded types...
							not used_references [k] and
							write_manager.item (object.references [k]).reflector.object = item)
						loop
							k := k + 1
						end

						if k > object.references.count then
							collection.extend ("", none_string)
						else
							referenced_object := write_manager.item (object.references [k])
							item_value := referenced_object.handler.as_string (referenced_object)
							collection.extend (item_value, referenced_object.type.name)
							used_references [k] := True
						end
					end
				else
					collection.extend ("", none_string)
				end
			end
		end

	write_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- <Precursor>
		do
			write_manager.collections_to_write.extend (object.backend_collection)
		end

end
