note
	description: "Summary description for {PS_READONLY_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_READ_ONLY_BACKEND

inherit
	PS_EIFFELSTORE_EXPORT

inherit {NONE}
	REFACTORING_HELPER


feature {PS_EIFFELSTORE_EXPORT}-- Backend capabilities

	is_object_type_supported (type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle objects of type `type'?
		local
			reflection: INTERNAL
		do
			create reflection
			Result := not reflection.is_special_type (type.type.type_id)
		end

	is_generic_collection_supported: BOOLEAN
			-- Can the current backend support collections in general,
			-- i.e. is there a default strategy?
		deferred
		end

feature {PS_RETRIEVAL_MANAGER} -- Object retrieval


	frozen retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
			-- Retrieves all objects from the database where the following conditions hold:
			--		1) The object is a (direct) instance of `type'
			--		2) The object is visible within the current `transaction' (e.g. not deleted previously)
			--		3) The `criteria' are satisfied for this object (this point is optional however).
			-- All attributes defined in `attributes' are guaranteed to be present. Additional attributes may be included.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch,
			-- the attribute value during retrieval will be an empty string and its class name `NONE'.
		require
			supported: is_object_type_supported (type)
			attributes_exist: across attributes as attr all type.attributes.has (attr.item) end
			no_agent_criteria: to_implement_assertion ("Adapt upper layers for this precondition")--not criteria.has_agent_criterion
		local
			real_cursor: ITERATION_CURSOR[PS_RETRIEVED_OBJECT]
			wrapper: PS_CURSOR_WRAPPER
		do
			-- execute plugins before retrieve
			across plug_in_list as cursor
			loop
				cursor.item.before_retrieve (type, criteria, attributes, transaction)
			end

			-- Retrieve result from backend
			real_cursor := internal_retrieve (type, criteria, attributes, transaction)

			-- Wrap the cursor
			create wrapper.make (Current, real_cursor, type, criteria, attributes, transaction)
			Result := wrapper

			-- execute plugins after retrieve
			if not Result.after then
				apply_plugins (Result.item, transaction)
			end
		ensure
			metadata_set: not Result.after implies Result.item.metadata.is_equal (type)
			correct: not Result.after implies check_retrieved_object (Result.item, type, attributes, transaction)
		end

	frozen retrieve_by_primary (type: PS_TYPE_METADATA; primary_key: INTEGER; attributes: LIST[STRING] transaction: PS_TRANSACTION): detachable PS_RETRIEVED_OBJECT
			-- Retrieve the object where the following conditions hold:
			--		1) The object is a (direct) instance of `type'
			--		2) The object is visible within the current `transaction' (e.g. not deleted previously)
			--		3) The object has the unique primary key `primary_key'.
			-- All attributes defined in `attributes' are guaranteed to be present. Additional attributes may be included.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch,
			-- the attribute value during retrieval will be an empty string and its class name `NONE'.
			-- Note: A primary key only has to be unique among the set of objects with type `type'.
		require
			supported: is_object_type_supported (type)
			attributes_exist: across attributes as attr all type.attributes.has (attr.item) end
		local
			keys: LINKED_LIST [INTEGER]
			res: LIST[PS_RETRIEVED_OBJECT]
		do
			-- execute plugins before retrieve
			across plug_in_list as cursor
			loop
				cursor.item.before_retrieve (type, Void, attributes, transaction)
			end

			-- Retrieve the result from the actual backend
			Result := internal_retrieve_by_primary (type, primary_key, attributes, transaction)

			-- Apply plugins after retrieve, if necessary
			if attached Result then
				apply_plugins (Result, transaction)
			end
		ensure
			metadata_set: attached Result implies Result.metadata.is_equal (type)
			correct: attached Result implies check_retrieved_object (Result, type, attributes, transaction)
			primary_key_correct: attached Result implies Result.primary_key = primary_key
		end


feature {PS_RETRIEVAL_MANAGER} -- Collection retrieval


	retrieve_all_collections (collection_type: PS_TYPE_METADATA; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		require
			collections_supported: is_generic_collection_supported
		deferred
		ensure
			correct: not Result.after implies check_retrieved_collection (Result.item, collection_type, transaction)
		end

	retrieve_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_TRANSACTION): detachable PS_RETRIEVED_OBJECT_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		require
			collections_supported: is_generic_collection_supported
		deferred
		ensure
			correct: attached Result implies check_retrieved_collection (Result, collection_type, transaction)
			primary_key_set: attached Result implies Result.primary_key = collection_primary_key
		end

feature {PS_EIFFELSTORE_EXPORT} -- Transaction handling

	commit (a_transaction: PS_TRANSACTION)
			-- Tries to commit `a_transaction'. As with every other error, a failed commit will result in a new exception and the error will be placed inside `a_transaction'.
		deferred
		end

	rollback (a_transaction: PS_TRANSACTION)
			-- Aborts `a_transaction' and undoes all changes in the database.
		deferred
		end

	transaction_isolation_level: PS_TRANSACTION_ISOLATION_LEVEL
			-- The currently active transaction isolation level.
		deferred
		end

	set_transaction_isolation_level (a_level: PS_TRANSACTION_ISOLATION_LEVEL)
			-- Set the transaction isolation level `a_level' for all future transactions.
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- Plugins

	plug_in_list: LINKED_LIST[PS_PLUGIN]
			-- A collection of plugins providing additional functionality.
			-- The list is traversed front-to-back during retrieval operations,
			-- and back-to-front during write operations
		once ("OBJECT")
			fixme ("Move to creation procedure of all subclasses...")
			create Result.make
		end

	add_plug_in (plug_in: PS_PLUGIN)
			-- Add `plugin' to the end of the current plugin list.
		do
			plug_in_list.extend (plug_in)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Mapping

	add_mapping (object: PS_OBJECT_IDENTIFIER_WRAPPER; key: INTEGER; transaction: PS_TRANSACTION)
			-- Add a mapping from `object' to the database entry with primary key `key'
		deferred
			-- TODO: move the mapping task somewhere else, as it is no longer the responsibility of a backend.
		end


feature {PS_CURSOR_WRAPPER}

	apply_plugins (item: PS_RETRIEVED_OBJECT; transaction: PS_TRANSACTION)
		do
			across plug_in_list as cursor loop
				cursor.item.after_retrieve (item, transaction)
			end
		end

feature {PS_CURSOR_WRAPPER} -- Contracts

	check_retrieved_object (object: PS_RETRIEVED_OBJECT; type:PS_TYPE_METADATA;  attributes: LIST[STRING]; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if the retrieved object meets some conditions
		local
			reflection: INTERNAL
			attr_type: INTEGER
		do
			create reflection

			-- Check if the type is correct
			Result := object.metadata.is_equal (type)

			if Result then
				-- Check if all requested attributes are present
				Result := Result and attributes.for_all (agent object.has_attribute)

				-- For attributes actually present in an object, check if the runtime type makes sense.
				across attributes as cursor
				loop
					if type.attributes.has (cursor.item) then
						attr_type := reflection.dynamic_type_from_string (object.attribute_value (cursor.item).attribute_class_name)

						-- For expanded types, or when an object was attached, the runtime type must conform to the declared type
						Result := Result and (attr_type >= 0 implies
							reflection.type_conforms_to (attr_type, type.attribute_type (cursor.item).type.type_id))

						-- If a reference was Void during write, the runtime type was stored as NONE and the value is 0
						Result := Result and (attr_type = reflection.none_type implies
							not type.attribute_type (cursor.item).type.is_attached -- Type can be detachable
							and object.attribute_value (cursor.item).value.is_empty) -- Value is an empty string
					end
				end
			end
		end


	check_retrieved_collection (collection: PS_RETRIEVED_OBJECT_COLLECTION; type:PS_TYPE_METADATA; transaction:PS_TRANSACTION): BOOLEAN
			-- Check if the retrieved collection meets some conditions
		local
			collection_item_type: INTEGER
			runtime_type: INTEGER
			reflection: INTERNAL
		do
			-- Check if the type is correct
			Result := collection.metadata.is_equal(type)

			if Result then
				-- For all values, check if the runtime type makes sense
				across collection.collection_items as cursor
				from
					create reflection
					collection_item_type := type.actual_generic_parameter (1).type.type_id
				loop
					runtime_type := reflection.dynamic_type_from_string (cursor.item.second)

					if runtime_type >= 0 then
						-- Check if runtime type conforms to collection type
						Result := Result and reflection.type_conforms_to (runtime_type, collection_item_type)
					else
						-- Item was Void during insert
						Result := Result
							and runtime_type = reflection.none_type -- Runtime type set to "NONE"
							and not reflection.is_attached_type (collection_item_type) -- Collection type allowed to be detachable
							and cursor.item.first.is_empty -- Value is an empty string
					end
				end
			end
		end

feature {PS_READ_ONLY_BACKEND} -- Implementation

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
			-- See function `retrieve'.
			-- Use `internal_retrieve' for contracts and other calls within a backend.
		require
			supported: is_object_type_supported (type)
			no_agent_criteria: to_implement_assertion ("Adapt upper layers for this precondition")--not criteria.has_agent_criterion
		deferred
			-- To have lazy loading support, you need to have a special ITERATION_CURSOR and a function next in this class to load the next item of this customized cursor
		ensure
		end

	internal_retrieve_by_primary (type: PS_TYPE_METADATA; key: INTEGER; attributes: LIST [STRING]; transaction: PS_TRANSACTION): detachable PS_RETRIEVED_OBJECT
			-- See function `retrieve_by_primary'.
			-- Use `internal_retrieve_by_primary' for contracts and other calls within a backend.
		require
			supported: is_object_type_supported (type)
		deferred
		end

end
