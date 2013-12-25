note
	description: "Provides an abstraction to the actual database. This class only contains the read functions."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_READ_ONLY_BACKEND

inherit
	PS_ABEL_EXPORT

	REFACTORING_HELPER

feature {PS_ABEL_EXPORT} -- Access

	stored_types: LIST [READABLE_STRING_GENERAL]
			-- The type string for all objects and collections stored in `Current'.
		deferred
			-- Note to implementors: It is highly recommended to cache the result, and
			-- refresh it during a `retrieve' operation (or not at all if the result
			-- is always stable).
		ensure
			no_none_type: across Result as cursor all not cursor.item.is_equal ("NONE") end
		end

	batch_retrieval_size: INTEGER
			-- The amount of objects to retrieve in a single batch.
			-- Set to -1 to retrieve all objects.

feature {PS_ABEL_EXPORT} -- Backend capabilities

	is_object_type_supported (type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle objects of type `type'?
		do
			Result := not attached {TYPE [detachable SPECIAL [detachable ANY]]} type.type and not attached {TYPE [detachable TUPLE]} type.type
		end

	is_generic_collection_supported: BOOLEAN
			-- Can the current backend support collections in general,
			-- i.e. is there a default strategy?
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


	frozen retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- Retrieves all objects from the database where the following conditions hold:
			--		1) The object is a (direct) instance of `type'
			--		2) The object is visible within the current `transaction' (e.g. not deleted previously)
			--		3) The `criteria' are satisfied for this object (this point is optional however).
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
				-- Execute plugins to adapt the query parameters
			across
				plugins as cursor
			from
				args := [type, criteria, attributes]
			loop
				args := cursor.item.before_retrieve (args, transaction)
			end

				-- Retrieve result from backend
			real_cursor := internal_retrieve (args.type, args.criteria, args.attr, transaction)

				-- Wrap the cursor
			create wrapper.make (Current, real_cursor, args.type, args.attr, transaction)
			Result := wrapper

				-- Execute plugins for the first item after retrieval.
			if not Result.after and not plugins.is_empty then
				apply_plugins (Result.item, transaction)
			end
		ensure
			metadata_set: not Result.after implies Result.item.metadata.is_equal (type)
			attributes_present: not Result.after implies attributes.for_all (agent (Result.item).has_attribute)
			consistent: not Result.after implies Result.item.is_consistent
			transaction_unchanged: transaction.is_active
		end

--	frozen specific_retrieve (order: LIST [TUPLE [type: PS_TYPE_METADATA; primary_key: INTEGER]]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
	frozen specific_retrieve (primaries: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
			-- For each tuple in the list, retrieve the object where the following conditions hold:
			--		1) The object is a (direct) instance of `type'
			--		2) The object is visible within the current `transaction' (e.g. not deleted previously)
			--		3) The object has the unique primary key `primary_key'.
			-- All of the object's attributes stored in the database will be present in the result.
			-- If an attribute defined in `type.attributes' was `Void' during an insert, or it doesn't
			-- exist in the database because of a version mismatch, the attribute value during retrieval
			-- will be an empty string and its class name `NONE'.
			-- Note: A primary key only has to be unique among the set of objects with type `type'.
			-- Note: The result does not have to be ordered, and items deleted in the database are not present in the result.
		require
--			not_empty: not order.is_empty
--			supported: across order as cursor all is_object_type_supported (cursor.item.type) end
			transaction_active: transaction.is_active

			not_empty: not primaries.is_empty
			supported: across types as cursor all is_object_type_supported (cursor.item) end
			same_count: primaries.count = types.count
		do
				-- Retrieve the results.
--			Result := internal_specific_retrieve (order, transaction)
			Result := internal_specific_retrieve (primaries, types, transaction)

				-- Apply the plugins for each item in the result.
			if not plugins.is_empty then
				across
					Result as cursor
				loop
					apply_plugins (cursor.item, transaction)
				end
			end
		ensure
--			type_and_primary_correct: across Result as res_cursor all (across order as arg_cursor some res_cursor.item.primary_key = arg_cursor.item.primary_key and res_cursor.item.metadata = arg_cursor.item.type end) end
			type_and_primary_correct: across Result as res_cursor all (across 1 |..| primaries.count as arg_cursor some res_cursor.item.primary_key = primaries [arg_cursor.item] and res_cursor.item.metadata = types [arg_cursor.item] end) end
			attributes_present: across Result as cursor all cursor.item.metadata.attributes.for_all (agent (cursor.item).has_attribute) end
			consistent: across Result as res_cursor all res_cursor.item.is_consistent end
			transaction_unchanged: transaction.is_active
		end

feature {PS_ABEL_EXPORT} -- Collection retrieval

	collection_retrieve (type: PS_TYPE_METADATA; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_COLLECTION]
			-- Retrieves all collections from the database where the following conditions hold:
			--		1) The object is a (direct) instance of `type'
			--		2) The object is visible within the current `transaction' (e.g. not deleted previously)
		require
			collections_supported: is_generic_collection_supported
			transaction_active: transaction.is_active
		deferred
		ensure
			metadata_set: not Result.after implies Result.item.metadata.is_equal (type)
			consistent: not Result.after implies Result.item.is_consistent
			transaction_unchanged: transaction.is_active
		end

	specific_collection_retrieve (order: LIST [TUPLE [type: PS_TYPE_METADATA; primary_key: INTEGER]]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_COLLECTION]
			-- For every item in `order', retrieve the object with the correct `type' and `primary_key'.
			-- Note: The result does not have to be ordered, and items deleted in the database are not present in the result.
		require
			collection_supported: is_generic_collection_supported
			not_empty: not order.is_empty
			transaction_active: transaction.is_active
		deferred
		ensure
			type_and_primary_correct: across Result as res_cursor all (across order as arg_cursor some res_cursor.item.primary_key = arg_cursor.item.primary_key and res_cursor.item.metadata = arg_cursor.item.type end) end
			consistent: across Result as cursor all cursor.item.is_consistent end
			transaction_unchanged: transaction.is_active
		end

feature {PS_ABEL_EXPORT} -- Transaction handling

	commit (a_transaction: PS_INTERNAL_TRANSACTION)
			-- Tries to commit `a_transaction'. As with every other error, a failed commit will result in a new exception and the error will be placed inside `a_transaction'.
		deferred
		end

	rollback (a_transaction: PS_INTERNAL_TRANSACTION)
			-- Aborts `a_transaction' and undoes all changes in the database.
		deferred
		end

	close
			-- Close the backend.
		do

		end

feature {PS_ABEL_EXPORT} -- Plugins

	plugins: LINKED_LIST [PS_PLUGIN]
			-- A collection of plugins providing additional functionality.
			-- The list is traversed front-to-back during retrieval operations,
			-- and back-to-front during write operations

	add_plugin (plug_in: PS_PLUGIN)
			-- Add `plugin' to the end of the current plugin list.
		do
			plugins.extend (plug_in)
		end

feature {PS_CURSOR_WRAPPER}

	apply_plugins (item: PS_BACKEND_OBJECT; transaction: PS_INTERNAL_TRANSACTION)
		do
			across plugins as cursor loop
				cursor.item.after_retrieve (item, transaction)
			end
		end

feature {PS_READ_ONLY_BACKEND} -- Implementation

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- See function `retrieve'.
			-- Use `internal_retrieve' for contracts and other calls within a backend.
		require
			supported: is_object_type_supported (type)
			no_agent_criteria: not criteria.has_agent_criterion
		deferred
		end

--	internal_specific_retrieve (order: LIST [TUPLE [type: PS_TYPE_METADATA; primary_key: INTEGER]]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
	internal_specific_retrieve (primaries: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
			-- See function `specific_retrieve'.
			-- Use `internal_specific_retrieve' for contracts and other calls within a backend.
		require
			not_empty: not primaries.is_empty
			same_count: primaries.count = types.count
			supported: across types as cursor all is_object_type_supported (cursor.item) end
		deferred
		end

invariant
	valid_batch_retrieval_size: batch_retrieval_size > 0 or batch_retrieval_size = {PS_REPOSITORY}.Infinite_batch_size

end
