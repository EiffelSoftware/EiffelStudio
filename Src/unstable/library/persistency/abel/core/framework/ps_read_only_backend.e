note
	description: "Summary description for {PS_READONLY_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_READ_ONLY_BACKEND

inherit
	PS_EIFFELSTORE_EXPORT

	REFACTORING_HELPER


feature {PS_EIFFELSTORE_EXPORT}-- Backend capabilities

	is_object_type_supported (type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle objects of type `type'?
		do
			-- The attached syntax is used here because the {TYPE}.is_conforming_to will always generate a catcall.
			Result := not attached {TYPE[detachable SPECIAL[detachable ANY]]} type.type and not attached {TYPE[detachable TUPLE]} type.type
--			Result := not type.type.is_conforming_to ({detachable SPECIAL[detachable ANY]})
--				and not type.type.is_conforming_to ({detachable TUPLE})
		end

	is_generic_collection_supported: BOOLEAN
			-- Can the current backend support collections in general,
			-- i.e. is there a default strategy?
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- Object retrieval


	frozen retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
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
			transaction_active: transaction.is_active
		local
			real_cursor: ITERATION_CURSOR[PS_BACKEND_OBJECT]
			wrapper: PS_CURSOR_WRAPPER
			args: TUPLE[type: PS_TYPE_METADATA; criteria: detachable PS_CRITERION; attr: PS_IMMUTABLE_STRUCTURE[STRING]]
		do
			-- execute plugins before retrieve
			across
				plug_in_list as cursor
			from
				args := [type, criteria, attributes]
			loop
				args := cursor.item.before_retrieve (args, transaction)
			end

			-- Due to the postcondition in PS_PLUGIN, this is safe:
			check attached args.criteria as final_criteria then

				-- Retrieve result from backend
				real_cursor := internal_retrieve (args.type, final_criteria, args.attr, transaction)

				-- Wrap the cursor
				create wrapper.make (Current, real_cursor, args.type, final_criteria, args.attr, transaction)
				Result := wrapper
			end

			-- execute plugins after retrieve
			if not Result.after then
				apply_plugins (Result.item, args.criteria, args.attr, transaction)
			end
		ensure
			metadata_set: not Result.after implies Result.item.metadata.is_equal (type)
			attributes_present: not Result.after implies attributes.for_all (agent (Result.item).has_attribute)
			consistent: not Result.after implies Result.item.is_consistent
			transaction_unchanged: transaction.is_active
		end

	frozen retrieve_by_primary (type: PS_TYPE_METADATA; primary_key: INTEGER; attributes: PS_IMMUTABLE_STRUCTURE[STRING] transaction: PS_TRANSACTION): detachable PS_BACKEND_OBJECT
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
			transaction_active: transaction.is_active
		local
			keys: LINKED_LIST [INTEGER]
			res: LIST[PS_BACKEND_OBJECT]
			args: TUPLE[type: PS_TYPE_METADATA; criteria: detachable PS_CRITERION; attr: PS_IMMUTABLE_STRUCTURE[STRING]]
		do
			-- execute plugins before retrieve
			across
				plug_in_list as cursor
			from
				args := [type, Void , attributes]
			loop
				args := cursor.item.before_retrieve (args, transaction)
			end

			-- Retrieve the result from the actual backend
			Result := internal_retrieve_by_primary (args.type, primary_key, args.attr, transaction)

			-- Apply plugins after retrieve, if necessary
			if attached Result then
				apply_plugins (Result, Void, args.attr, transaction)
			end
		ensure
			metadata_set: attached Result implies Result.metadata.is_equal (type)
			primary_key_correct: attached Result implies Result.primary_key = primary_key
			attributes_present: attached Result implies attributes.for_all (agent Result.has_attribute)
			consistent: attached Result implies Result.is_consistent
			transaction_unchanged: transaction.is_active
		end


feature {PS_EIFFELSTORE_EXPORT} -- Collection retrieval


	retrieve_all_collections (collection_type: PS_TYPE_METADATA; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		require
			collections_supported: is_generic_collection_supported
		deferred
		ensure
			metadata_set: not Result.after implies Result.item.metadata.is_equal (collection_type)
			consistent: not Result.after implies Result.item.is_consistent
		end

	retrieve_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_TRANSACTION): detachable PS_BACKEND_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		require
			collections_supported: is_generic_collection_supported
		deferred
		ensure
			metadata_set: attached Result implies Result.metadata.is_equal (collection_type)
			primary_key_correct: attached Result implies Result.primary_key = collection_primary_key
			consistent: attached Result implies Result.is_consistent
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

	add_plug_in (plug_in: PS_PLUGIN)
			-- Add `plugin' to the end of the current plugin list.
		do
			plug_in_list.extend (plug_in)
		end

feature {PS_CURSOR_WRAPPER}

	apply_plugins (item: PS_BACKEND_OBJECT; criterion: detachable PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_TRANSACTION)
		do
			across plug_in_list as cursor loop
				cursor.item.after_retrieve (item, criterion, attributes, transaction)
			end
		end

feature {PS_READ_ONLY_BACKEND} -- Implementation

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- See function `retrieve'.
			-- Use `internal_retrieve' for contracts and other calls within a backend.
		require
			supported: is_object_type_supported (type)
			no_agent_criteria: not criteria.has_agent_criterion
		deferred
		end

	internal_retrieve_by_primary (type: PS_TYPE_METADATA; key: INTEGER; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_TRANSACTION): detachable PS_BACKEND_OBJECT
			-- See function `retrieve_by_primary'.
			-- Use `internal_retrieve_by_primary' for contracts and other calls within a backend.
		require
			supported: is_object_type_supported (type)
		deferred
		end

end
