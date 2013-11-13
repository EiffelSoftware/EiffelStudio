note
	description: "Stores objects as a collection of strings in main memory."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_IN_MEMORY_DATABASE

inherit

	PS_BACKEND_COMPATIBILITY
		redefine
			update_object_oriented_collection
		end

	PS_ABEL_EXPORT

create
	make

feature {PS_ABEL_EXPORT} -- Supported collection operations

	supports_object_collection: BOOLEAN = True
			-- Can the current backend handle relational collections?

	supports_relational_collection: BOOLEAN = False
			-- Can the current backend handle relational collections?

feature {PS_ABEL_EXPORT} -- Status report

	can_handle_relational_collection (owner_type, collection_item_type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle the relational collection between the two classes `owner_type' and `collection_type'?
		do
			Result := False
		end

	can_handle_object_oriented_collection (collection_type: PS_TYPE_METADATA): BOOLEAN
			-- Can the current backend handle an object-oriented collection of type `collection_type'?
		do
			Result := True
		end

feature {PS_ABEL_EXPORT} -- Object retrieval operations

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- Retrieves all objects of class `class_name' that match the criteria in `criteria' within transaction `transaction'.
			-- If `attributes' is not empty, it will only retrieve the attributes listed there.
		local
			keys: ARRAYED_LIST [INTEGER]
			attr: PS_IMMUTABLE_STRUCTURE [STRING]
		do
				-- Evaluate which objects to load
				-- (here: ignore criteria and just return everything from that class)
			if db.has (type.base_class.name) then
				create keys.make_from_array (attach (db [type.base_class.name]).current_keys)
			else
				create keys.make (0)
			end
				-- Evaluate which attributes to load
			if attributes.is_empty then
				attr := type.attributes
			else
				attr := attributes
			end
				-- Retrieve result and return cursor
			Result := load_objects (type, attr, keys).new_cursor
		end

	internal_retrieve_by_primary (type: PS_TYPE_METADATA; key: INTEGER; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): detachable PS_BACKEND_OBJECT
		local
			list: LINKED_LIST[INTEGER]
			res: LIST[PS_BACKEND_OBJECT]
		do
			create list.make
			list.extend (key)
--			res := internal_retrieve_from_keys (type, list, transaction)
			res := load_objects (type, attributes, list)
			if not res.is_empty then
				Result := res.first
			end
		end

--	internal_retrieve_from_keys (type: PS_TYPE_METADATA; primary_keys: LIST [INTEGER]; transaction: PS_TRANSACTION): LINKED_LIST [PS_RETRIEVED_OBJECT]
--			-- Retrieve all objects of type `type' and with primary key in `primary_keys'.
--		do
--				-- Retrieve all keys in primary_keys and with all attributes
--			Result := load_objects (type, create{LINKED_LIST[STRING]}.make, primary_keys)
--		end

feature {PS_ABEL_EXPORT} -- Object write operations

	insert (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Inserts `an_object' into the database.
		local
			new_primary: PS_PAIR [INTEGER, STRING]
		do
				-- Add a new entry in primary <--> POID mapping table
			new_primary := new_key (an_object.object_wrapper.metadata.base_class.name)
			key_mapper.add_entry (an_object.object_wrapper, new_primary.first, a_transaction)
				-- Create new object in DB with freshly created primary key and then write all attributes
			insert_empty_object (new_primary.first, new_primary.second)
			write_attributes (an_object, a_transaction)
		end

	update (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Updates `an_object' in the database.
		do
				-- write all attributes in `an_object'
			write_attributes (an_object, a_transaction)
		end

	delete (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Deletes `an_object' from the database.
		local
			primary: PS_PAIR [INTEGER, PS_TYPE_METADATA]
		do
				-- Remove the entry in the primary <--> POID mapping table
			primary := key_mapper.primary_key_of (an_object.object_wrapper, a_transaction)
			key_mapper.remove_primary_key (primary.first, an_object.object_wrapper.metadata, a_transaction)
				-- remove the complete object from DB
			attach (db [primary.second.base_class.name]).remove (primary.first)
		end

feature {PS_ABEL_EXPORT} -- Object-oriented collection operations

	retrieve_all_collections (collection_type: PS_TYPE_METADATA; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		local
			res_list: LINKED_LIST [PS_BACKEND_COLLECTION]
		do
			create res_list.make
			across
				collections.current_keys as key_cursor
			loop
				res_list.extend (retrieve_object_oriented_collection (collection_type, key_cursor.item, transaction))
			end
			Result := res_list.new_cursor
		end

	retrieve_object_oriented_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_INTERNAL_TRANSACTION): PS_BACKEND_COLLECTION
			-- Retrieves the object-oriented collection of type `object_type' and with primary key `object_primary_key'.
		local
			info: HASH_TABLE [STRING, STRING]
		do
			create Result.make (collection_primary_key, collection_type)
			across
				get_ordered_collection (collection_primary_key) as cursor
			loop
				Result.add_item (cursor.item.first, cursor.item.second)
			end
			info := attach (collection_info [collection_primary_key])
			across
				info.current_keys as key_cursor
			loop
				Result.add_information (key_cursor.item, attach (info [key_cursor.item]))
			end
		end

	insert_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Add all entries in `a_collection' to the database
		local
			id: INTEGER
			primary: INTEGER
			item_primary: INTEGER
			new_inserts: LINKED_LIST [STRING]
		do
			if not key_mapper.has_primary_key_of (a_collection.object_wrapper, a_transaction) then -- Collection not yet in database
					-- first set up everything
				primary := new_key (default_class_string_for_collections).first -- only key is interesting
				key_mapper.add_entry (a_collection.object_wrapper, primary, a_transaction)
				insert_empty_collection (primary)
					-- add additional information
				fixme ("test if a simple reference copy is safe enough in this case, or if a deep_clone is needed...")
				collection_info.force (a_collection.additional_information, primary)
			else
					-- we already have the collection and its additional information in the database, we just have to extend it
				primary := key_mapper.primary_key_of (a_collection.object_wrapper, a_transaction).first
			end
				-- Now add all collection values to the collection
			across
				a_collection.values as coll_item
			loop
				item_primary := key_mapper.quick_translate (coll_item.item.object_identifier, a_transaction)
				add_to_collection (primary, coll_item.item.as_attribute (item_primary), a_collection.index_of (coll_item.item))
			end
		end

	update_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Update `a_collection' in the database.
		local
			primary: INTEGER
		do
			primary := key_mapper.primary_key_of ( a_collection.object_wrapper, a_transaction).first
			attach (collections[primary]).wipe_out
			collection_info.force (a_collection.additional_information, primary)
			insert_object_oriented_collection (a_collection, a_transaction)
		end

	delete_object_oriented_collection (a_collection: PS_OBJECT_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Delete `a_collection' from the database.
		local
			key: INTEGER
		do
			key := key_mapper.primary_key_of (a_collection.object_wrapper, a_transaction).first
			collection_info.remove (key)
			collections.remove (key)
			key_mapper.remove_primary_key (key, a_collection.object_wrapper.metadata, a_transaction)
		end

feature {PS_ABEL_EXPORT} -- Relational collection operations

	retrieve_relational_collection (owner_type, collection_item_type: PS_TYPE_METADATA; owner_key: INTEGER; owner_attribute_name: STRING; transaction: PS_INTERNAL_TRANSACTION): PS_RETRIEVED_RELATIONAL_COLLECTION
			-- Retrieves the relational collection between class `owner_type' and `collection_item_type', where the owner has primary key `owner_key' and the attribute name of the collection inside the owner object is called `owner_attribute_name'.
		do
			check
				not_implemented: False
			end
			create Result.make (owner_key, owner_type.base_class, owner_attribute_name)
		end

	insert_relational_collection (a_collection: PS_RELATIONAL_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Add all entries in `a_collection' to the database.
		do
			check
				not_implemented: False
			end
		end

	delete_relational_collection (a_collection: PS_RELATIONAL_COLLECTION_PART; a_transaction: PS_INTERNAL_TRANSACTION)
			-- Delete `a_collection' from the database.
		do
			check
				not_implemented: False
			end
		end

feature {PS_ABEL_EXPORT} -- Transaction handling

	commit (a_transaction: PS_INTERNAL_TRANSACTION)
			-- Tries to commit `a_transaction'. As with every other error, a failed commit will result in a new exception and the error will be placed inside `a_transaction'.
		do
		end

	rollback (a_transaction: PS_INTERNAL_TRANSACTION)
			-- Aborts `a_transaction' and undoes all changes in the database.
		do
		end

	transaction_isolation_level: PS_TRANSACTION_ISOLATION_LEVEL
			-- The currently active transaction isolation level.
		do
			create Result
			Result := Result.read_uncommitted
		end

	set_transaction_isolation_level (a_level: PS_TRANSACTION_ISOLATION_LEVEL)
			-- Set the transaction isolation level `a_level' for all future transactions.
		do
		end

feature {PS_ABEL_EXPORT} -- Mapping

	key_mapper: PS_KEY_POID_TABLE
			-- Maps POIDs to primary keys as used by this backend.

feature {PS_ABEL_EXPORT} -- Testing

	wipe_out
			-- Wipe out everything and initialize new.
		do
			make
		end

feature {PS_ABEL_EXPORT} -- Miscellaneous

	string_representation: STRING
			-- The current DB content as a string.
		local
			class_names: ARRAY [STRING]
			objects: LIST [INTEGER]
			object_values: HASH_TABLE [STRING, STRING]
		do
			fixme ("TODO, still needed?")
			Result := ""
		end

feature {NONE} -- Implementation - Loading and storing objects

	load_objects (type: PS_TYPE_METADATA; arg_attributes: PS_IMMUTABLE_STRUCTURE [STRING]; keys: LIST [INTEGER]): LINKED_LIST [PS_BACKEND_OBJECT]
			-- Loads all objects of class `type' whose primary key is listed in `keys'.
			-- Only loads the attributes listed in `attributes',or all attributes if the list is empty.
		local
			current_obj: PS_BACKEND_OBJECT
			attr_val: PS_PAIR [STRING, STRING]
			attributes: LINKED_LIST[STRING]
		do
			create attributes.make
			arg_attributes.do_all (agent attributes.extend)
			create Result.make
			across
				keys as obj_primary
			loop
				if has_object (type.base_class.name, obj_primary.item) then
					create current_obj.make (obj_primary.item, type)

					if attributes.is_empty then
						attributes.fill (get_object_as_strings(type.base_class.name, obj_primary.item).current_keys)
						across type.attributes as cursor
						from attributes.compare_objects
						loop
							if not attributes.has (cursor.item) then
								attributes.extend (cursor.item)
							end
						end
					end

					across
						attributes as cursor
					loop
						if has_attribute (type.base_class.name, obj_primary.item, cursor.item) then
							attr_val := get_attribute (type.base_class.name, obj_primary.item, cursor.item)
						else
							create attr_val.make (Void_value, None_type)
						end
						current_obj.add_attribute (cursor.item, attr_val.first, attr_val.second)
							--		print ("loaded attribute: " + cursor.item + "%N%T value: " + attr_val.first + "%N%T type: " + attr_val.second + "%N%N")
					end
					Result.extend (current_obj)
				end
			end
		end

	write_attributes (an_object: PS_SINGLE_OBJECT_PART; transaction: PS_INTERNAL_TRANSACTION)
			-- Stores all attributes of `an_object' in the internal database, replacing any existing attribute with the same name if present.
		local
			attr_primary: INTEGER
			primary: PS_PAIR [INTEGER, PS_TYPE_METADATA]
		do
			primary := key_mapper.primary_key_of (an_object.object_wrapper, transaction)
			across
				an_object.attributes as attr_cursor
			loop
				attr_primary := key_mapper.quick_translate (an_object.attribute_value (attr_cursor.item).object_identifier, transaction)
					--				print (attr_cursor.item)
				add_or_replace_attribute (primary.second.base_class.name, primary.first, attr_cursor.item, an_object.attribute_value (attr_cursor.item).as_attribute (attr_primary))
			end
		end

feature {NONE} -- Implementation - Key generation

	key_set: HASH_TABLE [INTEGER, STRING]
			-- stores the maximum key for every class.

	new_key (class_name: STRING): PS_PAIR [INTEGER, STRING]
			-- creates a new, not yet used, primary key for objects of type `class_name'.
		local
			max: INTEGER
		do
			max := key_set [class_name]
			max := max + 1
			create Result.make (max, class_name)
			key_set.force (max, class_name)
		end

feature {NONE} -- Implementation - Database and DB access for objects

	db:
				-- The internal "database" that stores every object as a collection of strings.
			HASH_TABLE [ -- class_name to objects table
			HASH_TABLE [ -- primary key to object
			HASH_TABLE [PS_PAIR [STRING, STRING], STRING], -- attribute to value
 INTEGER], STRING]
			-- The internal "database" that stores every object as a collection of strings.

	insert_empty_object (key: INTEGER; class_name: STRING)
			-- Insert an empty object of type `class_name' with primary key `key'.
		local
			new_class: HASH_TABLE [HASH_TABLE [PS_PAIR [STRING, STRING], STRING], INTEGER]
			new_obj: HASH_TABLE [PS_PAIR [STRING, STRING], STRING]
		do
			if not db.has (class_name) then
				create new_class.make (default_objects_per_class_size)
				db.extend (new_class, class_name)
			else
				new_class := attach (db [class_name])
			end
			create new_obj.make (default_attribute_count)
			new_class.extend (new_obj, key)
		end

	get_object_as_strings (class_name: STRING; key: INTEGER): HASH_TABLE [PS_PAIR [STRING, STRING], STRING]
			-- Get the object of type `class_name' with key `key' in string representation.
		local
			intermediate: HASH_TABLE [HASH_TABLE [PS_PAIR [STRING, STRING], STRING], INTEGER]
		do
			intermediate := attach (db [class_name])
			Result := attach (intermediate [key])
		end

	has_object (class_name: STRING; key: INTEGER): BOOLEAN
		do
			Result := db.has (class_name) and then attach (db [class_name]).has (key)
		end

	has_attribute (class_name: STRING; key: INTEGER; attr_name: STRING): BOOLEAN
			-- Does the object of type `class_name' and with key `key' have an attribute with name `attr_name'?
		do
			Result := get_object_as_strings (class_name, key).has (attr_name)
		end

	add_or_replace_attribute (class_name: STRING; key: INTEGER; attr_name: STRING; value: PS_PAIR [STRING, STRING])
			-- Add or replace the value of `attr_name' in the object of type `class_name' and with primary key `key'.
		do
			get_object_as_strings (class_name, key).force (value, attr_name)
		end

	get_attribute (class_name: STRING; key: INTEGER; attr_name: STRING): PS_PAIR [STRING, STRING]
			-- Get the value of the attribute `attr_name' from the object of type `class_name' and with primary key `key'.
		do
			Result := attach (get_object_as_strings (class_name, key).item (attr_name))
		end

feature {NONE} -- Implementation - Database and DB access for Object-oriented Collections

	insert_empty_collection (key: INTEGER)
			-- Insert an empty object-oriented collection with pimary key `key'.
		local
			list: LINKED_LIST [PS_PAIR [STRING, PS_PAIR [STRING, INTEGER]]]
		do
			create list.make
			collections.extend (list, key)
			collection_info.extend (create {HASH_TABLE [STRING, STRING]}.make (10), key)
		end

	add_to_collection (key: INTEGER; value: PS_PAIR [STRING, STRING]; order: INTEGER)
			-- Add `value' to the collection with primary key `key'.
			-- Insert the object in the collection list such that (previous.order <= order < next.order).
		local
			collection: LINKED_LIST [PS_PAIR [STRING, PS_PAIR [STRING, INTEGER]]]
			new_item: PS_PAIR [STRING, PS_PAIR [STRING, INTEGER]]
			previous_order: INTEGER
		do
			create new_item.make (value.first, create {PS_PAIR [STRING, INTEGER]}.make (value.second, order))
			fixme ("BROKEN: doesn't work as intended...")
			from
				collection := attach (collections [key])
					--			if collection.is_empty then
				collection.extend (new_item)
					--collection.forth
					--			end
				collection.start
			until
				collection.after
			loop
				if (collection.isfirst or else previous_order <= order) and order < collection.item.second.second then
					collection.put_left (new_item)
						--					print ("added item")
				end
				collection.forth
			end
		end

	get_ordered_collection (key: INTEGER): LINKED_LIST [PS_PAIR [STRING, STRING]]
			-- Get all values of the collection with primary key `key' in the correct order.
		local
			collection: LINKED_LIST [PS_PAIR [STRING, PS_PAIR [STRING, INTEGER]]]
			coll_item: PS_PAIR [STRING, STRING]
		do
			create Result.make
			collection := attach (collections [key])
				--			print ("in get_ordered_collection")
			across
				collection as cursor
			loop
					-- The database should be ordered already
				create coll_item.make (cursor.item.first, cursor.item.second.first)
				Result.extend (coll_item)
			end
		end

	collections: HASH_TABLE [LINKED_LIST [PS_PAIR [STRING, PS_PAIR [STRING, INTEGER]]], INTEGER]
			-- Internal store of collection objects.

	collection_info: HASH_TABLE [HASH_TABLE [STRING, STRING], INTEGER]
			-- The capacity of individual SPECIAL objects.

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create collections.make (default_collection_db_capacity)
			create collection_info.make (default_collection_db_capacity)
			create key_mapper.make
			create key_set.make (default_class_size)
			create db.make (default_class_size)
			create plug_in_list.make
		end

	default_class_size: INTEGER = 20
			-- The default capacity for the amount of classes the DB can handle.

	default_objects_per_class_size: INTEGER = 50
			-- The default capacity for the amount of objects per class.

	default_attribute_count: INTEGER = 10
			-- The default capacity for attributes per object.

	default_class_string_for_collections: STRING = "COLLECTION"
			-- The default string for the key generator when dealing with collections.

	default_collection_db_capacity: INTEGER = 50
			-- The default capacity of the in-memory database for storing collection objects.

	Void_value: STRING = ""

	None_type: STRING = "NONE"
			-- The type used for an attribute that is Void.

end
