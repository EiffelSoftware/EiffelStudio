note
	description: "Summary description for {PS_NEW_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_NEW_BACKEND

inherit
	PS_EIFFELSTORE_EXPORT

feature {PS_EIFFELSTORE_EXPORT}

	frozen write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_TRANSACTION)
		do
			-- execute plugins before write
			-- (maybe) identify objects
			internal_write (object_graph, transaction)
			-- execute plugins after write
		end

	frozen retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
			-- Retrieves all objects of class `type' (direct instance - not inherited from) that match the criteria in `criteria' within transaction `transaction'.
			-- If `attributes' is not empty, it will only retrieve the attributes listed there.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch, the attribute value during retrieval will be an empty string and its class name `NONE'.
			-- If `type' has a generic parameter, the retrieve function will return objects of all generic instances of the generating class.
			-- You can find out about the actual generic parameter by comparing the class name associated to a foreign key value.
		require
--			most_general_type: across type.supertypes as supertype all not (supertype.item.is_equal (type) and type.is_subtype_of (supertype.item)) end
--			all_attributes_exist: to_implement_assertion ("The requirement is too strong - e.g. ESCHER requires attributes that are theoretically not part of the object itself. across attributes as attr all type.attributes.has (attr.item) end")
		do
			-- execute plugins before retrieve
			Result := internal_retrieve (type, criteria, attributes, transaction)
			-- execute plugins after retrieve
		ensure
--			attributes_loaded: not Result.after implies are_attributes_loaded (type, attributes, Result.item)
--			class_metadata_set: not Result.after implies Result.item.class_metadata.is_equal (type.base_class)
		end

	retrieve_from_single_key (type: PS_TYPE_METADATA; primary_key: INTEGER; transaction: PS_TRANSACTION): LINKED_LIST [PS_RETRIEVED_OBJECT]
			-- Retrieve the object of type `type' and key `primary_key'. Wrapper of the `retrieve_from_keys' in case you only need one object.
		require
--			keys_exist: to_implement_assertion ("Some way to ensure that no arbitrary primary keys are getting queried")
		local
			keys: LINKED_LIST [INTEGER]
		do
			create keys.make
			keys.extend (primary_key)
			Result := Current.retrieve_from_keys (type, keys, transaction)
		ensure
--			objects_loaded: to_implement_assertion ("This doesn't work: (primary_keys.count = Result.count), as some objects might have been deleted.")
--			all_metadata_set: across Result as res all res.item.class_metadata.name = type.base_class.name end
		end


	frozen retrieve_from_keys (type: PS_TYPE_METADATA; primary_keys: LIST [INTEGER]; transaction: PS_TRANSACTION): LINKED_LIST [PS_RETRIEVED_OBJECT]
			-- Retrieve all objects of type `type' and with primary key in `primary_keys'.
		require
--			keys_exist: to_implement_assertion ("Some way to ensure that no arbitrary primary keys are getting queried")
		do
			-- execute plugins before retrieve
			Result := internal_retrieve_from_keys (type, primary_keys, transaction)
			-- execute plugins after retrieve
		ensure
--			objects_loaded: to_implement_assertion ("This doesn't work: (primary_keys.count = Result.count), as some objects might have been deleted.")
--			all_metadata_set: across Result as res all res.item.class_metadata.name = type.base_class.name end
		end


	default_collection_backend: PS_COLLECTION_BACKEND
		deferred
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

feature {PS_EIFFELSTORE_EXPORT} -- Mapping

	key_mapper: PS_KEY_POID_TABLE
			-- Maps POIDs to primary keys as used by this backend.
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- Testing

	wipe_out
			-- Wipe out everything and initialize new.
		deferred
		end


feature {PS_NEW_BACKEND}


	internal_write (object_graph: PS_OBJECT_GRAPH_ROOT; transaction: PS_TRANSACTION)
		deferred
		end


	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_RETRIEVED_OBJECT]
			-- Retrieves all objects of class `type' (direct instance - not inherited from) that match the criteria in `criteria' within transaction `transaction'.
			-- If `attributes' is not empty, it will only retrieve the attributes listed there.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch, the attribute value during retrieval will be an empty string and its class name `NONE'.
			-- If `type' has a generic parameter, the retrieve function will return objects of all generic instances of the generating class.
			-- You can find out about the actual generic parameter by comparing the class name associated to a foreign key value.
		require
--			most_general_type: across type.supertypes as supertype all not (supertype.item.is_equal (type) and type.is_subtype_of (supertype.item)) end
--			all_attributes_exist: to_implement_assertion ("The requirement is too strong - e.g. ESCHER requires attributes that are theoretically not part of the object itself. across attributes as attr all type.attributes.has (attr.item) end")
		deferred
			-- To have lazy loading support, you need to have a special ITERATION_CURSOR and a function next in this class to load the next item of this customized cursor
		ensure
--			attributes_loaded: not Result.after implies are_attributes_loaded (type, attributes, Result.item)
--			class_metadata_set: not Result.after implies Result.item.class_metadata.is_equal (type.base_class)
		end

	internal_retrieve_from_keys (type: PS_TYPE_METADATA; primary_keys: LIST [INTEGER]; transaction: PS_TRANSACTION): LINKED_LIST [PS_RETRIEVED_OBJECT]
			-- Retrieve all objects of type `type' and with primary key in `primary_keys'.
		require
--			keys_exist: to_implement_assertion ("Some way to ensure that no arbitrary primary keys are getting queried")
		deferred
		ensure
--			objects_loaded: to_implement_assertion ("This doesn't work: (primary_keys.count = Result.count), as some objects might have been deleted.")
--			all_metadata_set: across Result as res all res.item.class_metadata.name = type.base_class.name end
		end


end
