note
	description: "Provides an abstraction to the actual database. %
				%This class only contains the read functions."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_READ_REPOSITORY_CONNECTOR

inherit
	PS_ABEL_EXPORT

feature {PS_ABEL_EXPORT} -- Access

	stored_types: READABLE_INDEXABLE [IMMUTABLE_STRING_8]
			-- The type string for all objects and collections stored in `Current'.
		deferred
			-- Note to implementors: It is highly recommended to cache the result, and
			-- refresh it during a `retrieve' operation (or not at all if the result
			-- is always stable).
		ensure
			no_none_type: across Result as cursor all cursor.item /~ "NONE" end
		end

	batch_retrieval_size: INTEGER
			-- The amount of objects to retrieve in a single batch.
			-- Set to `{PS_REPOSITORY}.Infinite_batch_size' to retrieve all objects.

feature {PS_ABEL_EXPORT} -- Status report

	is_object_type_supported (type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current connector handle objects of type `type'?
		do
			Result := not attached {TYPE [detachable SPECIAL [detachable ANY]]} type.type and not attached {TYPE [detachable TUPLE]} type.type
		end

	is_generic_collection_supported: BOOLEAN
			-- Are collections supported by this connector?
		deferred
		end

feature {PS_ABEL_EXPORT} -- Element change

	set_batch_retrieval_size (size: INTEGER)
			-- Set the batch retrieval size.
		require
			valid: size > 0 or size = -1
		do
			batch_retrieval_size := size
		ensure
			correct: size = batch_retrieval_size
		end

	set_transaction_isolation (settings: PS_TRANSACTION_SETTINGS)
			-- Set the transaction isolation level such that all values in `settings' are respected.
		deferred
		end

feature {PS_ABEL_EXPORT} -- Object retrieval

	frozen retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; is_root_only: BOOLEAN; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- Retrieves all objects from the database where the following conditions hold:
			--		1) The object is a (direct) instance of `type'.
			--		2) The object is visible within the current `transaction'.
			--		3) The `criteria' are satisfied for this object (optional).
			--		4) If `is_root_only', then the retrieved object is a garbage collection root (optional).
			-- All attributes defined in `attributes' are guaranteed to be present. Additional attributes may be included.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch,
			-- the attribute value during retrieval will be an empty string and its class name `NONE'.
		require
			supported: is_object_type_supported (type)
			attributes_exist: across attributes as attr all attr.item = {PS_BACKEND_OBJECT}.value_type_item or else type.attributes.has (attr.item) end
			transaction_active: transaction.is_active
		local
			real_cursor: ITERATION_CURSOR [PS_BACKEND_OBJECT]
			wrapper: PS_CURSOR_WRAPPER
			args: TUPLE [type: PS_TYPE_METADATA; criteria: PS_CRITERION; attr: PS_IMMUTABLE_STRUCTURE [STRING]]
		do
				-- Execute plugins to adapt the query parameters.
			across
				plugins as cursor
			from
				args := [type, criteria, attributes]
			loop
				args := cursor.item.before_retrieve (args, transaction)
			end

				-- Retrieve result from actual implementation.
			real_cursor := internal_retrieve (args.type, args.criteria, is_root_only, args.attr, transaction)

				-- Wrap the cursor
			create wrapper.make (Current, real_cursor, args.type, args.attr, transaction)
			Result := wrapper

				-- Execute plugins for the first item after retrieval.
			if not Result.after and not plugins.is_empty then
				apply_plugins (Result.item, transaction)
			end
		ensure
			metadata_set: not Result.after implies Result.item.type.is_equal (type)
			attributes_present: not Result.after implies attributes.for_all (agent (Result.item).has_attribute)
			consistent: not Result.after implies Result.item.is_consistent
			transaction_unchanged: transaction.is_active
		end

	frozen specific_retrieve (primary_keys: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
			-- For each position `i' in the two lists, retrieve the object where the following conditions hold:
			--		1) The object is a (direct) instance of `types [i]'.
			--		2) The object is visible within the current `transaction'.
			--		3) The object has the unique primary key `primary_keys [i]'.
			-- All of the object's attributes stored in the database will be present in the result.
			-- If an attribute defined in `types [i].attributes' was `Void' during an insert, or it doesn't
			-- exist in the database because of a version mismatch, the attribute value during retrieval
			-- will be an empty string and its class name `NONE'.
			-- Note: A primary key only has to be unique among the set of objects with type `types [i]'.
			-- Note: The result does not have to be ordered, and items deleted in the database are not present in the result.
		require
			transaction_active: transaction.is_active
			not_empty: not primary_keys.is_empty
			supported: across types as cursor all is_object_type_supported (cursor.item) end
			same_count: primary_keys.count = types.count
		do
				-- Retrieve the results.
			Result := internal_specific_retrieve (primary_keys, types, transaction)

				-- Apply the plugins for each item in the result.
			if not plugins.is_empty then
				across
					Result as cursor
				loop
					apply_plugins (cursor.item, transaction)
				end
			end
		ensure
			type_and_primary_correct: across Result as res_cursor all (across 1 |..| primary_keys.count as arg_cursor some res_cursor.item.primary_key = primary_keys [arg_cursor.item] and res_cursor.item.type = types [arg_cursor.item] end) end
			attributes_present: across Result as cursor all cursor.item.type.attributes.for_all (agent (cursor.item).has_attribute) end
			consistent: across Result as res_cursor all res_cursor.item.is_consistent end
			transaction_unchanged: transaction.is_active
		end

feature {PS_ABEL_EXPORT} -- Collection retrieval

	collection_retrieve (type: PS_TYPE_METADATA; is_root: BOOLEAN; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_COLLECTION]
			-- Retrieves all collections from the database where the following conditions hold:
			--		1) The object is a (direct) instance of `type'.
			--		2) The object is visible within the current `transaction'.
			--		3) If `root_only' is true, then the retrieved collection is a garbage collection root (optional).
		require
			collections_supported: is_generic_collection_supported
			transaction_active: transaction.is_active
		deferred
		ensure
			metadata_set: not Result.after implies Result.item.type.is_equal (type)
			consistent: not Result.after implies Result.item.is_consistent
			transaction_unchanged: transaction.is_active
		end

	specific_collection_retrieve (primary_keys: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_COLLECTION]
			-- For each position `i' in the two lists, retrieve the collecvtion where
			-- the following conditions hold:
			--		1) The collection is a (direct) instance of `types [i]'.
			--		2) The collection is visible within the current `transaction'.
			--		3) The collection has the unique primary key `primary_keys [i]'.
			-- Note: The result does not have to be ordered, and items deleted in
			-- the database are not present in the result.
		require
			not_empty: not primary_keys.is_empty
			same_count: primary_keys.count = types.count
			collection_supported: is_generic_collection_supported
			transaction_active: transaction.is_active
		deferred
		ensure
			type_and_primary_correct: across Result as res_cursor all (across 1 |..| primary_keys.count as arg_cursor some res_cursor.item.primary_key = primary_keys [arg_cursor.item] and res_cursor.item.type = types [arg_cursor.item] end) end
			consistent: across Result as cursor all cursor.item.is_consistent end
			transaction_unchanged: transaction.is_active
		end

feature {PS_ABEL_EXPORT} -- Transaction handling

	commit (transaction: PS_INTERNAL_TRANSACTION)
			-- Commit `transaction'. In case of an error an exception is raised,
			-- and `transaction.error' contains an error description.
		require
			no_error: not transaction.has_error
			active: transaction.is_active
		deferred
		end

	rollback (transaction: PS_INTERNAL_TRANSACTION)
			-- Aborts `transaction' and undoes all changes in the database.
			-- This function may be invoked several times with the same transaction object.
		deferred
		end

	close
			-- Close the backend.
		deferred
		end

feature {PS_ABEL_EXPORT} -- Plugins

	plugins: ARRAYED_LIST [PS_PLUGIN]
			-- A collection of plugins providing additional functionality.
			-- The list is traversed front-to-back during retrieval operations,
			-- and back-to-front during write operations

	add_plugin (plugin: PS_PLUGIN)
			-- Add `plugin' to the end of the current plugin list.
		do
			plugins.extend (plugin)
		end

feature {PS_CURSOR_WRAPPER}

	apply_plugins (item: PS_BACKEND_OBJECT; transaction: PS_INTERNAL_TRANSACTION)
			-- Apply all plugins to `item'.
		do
			across
				plugins as cursor
			loop
				cursor.item.after_retrieve (item, transaction)
			end
		end

feature {PS_READ_REPOSITORY_CONNECTOR} -- Implementation

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; is_root_only: BOOLEAN; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- See function `retrieve'.
			-- Use `internal_retrieve' for contracts and other calls within a backend.
		require
			supported: is_object_type_supported (type)
			no_agent_criteria: not criteria.has_agent_criterion
		deferred
		end

	internal_specific_retrieve (primaries: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
			-- See function `specific_retrieve'.
			-- Use `internal_specific_retrieve' for contracts and other calls within a backend.
		require
			not_empty: not primaries.is_empty
			same_count: primaries.count = types.count
			supported: across types as cursor all is_object_type_supported (cursor.item) end
			transaction_active: transaction.is_active
		deferred
		end

invariant
	valid_batch_retrieval_size: batch_retrieval_size > 0 or batch_retrieval_size = {PS_REPOSITORY}.Infinite_batch_size
end
