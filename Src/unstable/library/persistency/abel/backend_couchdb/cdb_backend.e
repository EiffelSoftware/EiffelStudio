note
	description: "Stores objects as json documents in a CouchDB"
	author: "Pascal Roos"
	date: "$Date$"
	revision: "$Revision$"

class
	CDB_BACKEND

inherit

	PS_BACKEND

create
	make, make_with_host_and_port

feature {PS_ABEL_EXPORT} -- Status report

	is_generic_collection_supported: BOOLEAN = False
			-- Can the current backend support collections in general,
			-- i.e. is there a default strategy?

feature {PS_ABEL_EXPORT} -- Object retrieval operations

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- Retrieves all objects of class `type' (direct instance - not inherited from) that match the criteria in `criteria' within transaction `transaction'.
			-- If `attributes' is not empty, it will only retrieve the attributes listed there.
			-- If an attribute was `Void' during an insert, or it doesn't exist in the database because of a version mismatch, the attribute value during retrieval will be an empty string and its class name `NONE'.
			-- If `type' has a generic parameter, the retrieve function will return objects of all generic instances of the generating class.
			-- You can find out about the actual generic parameter by comparing the class name associated to a foreign key value.
		require else
			True
		local
--			temp_list: LINKED_LIST [PS_RETRIEVED_OBJECT]
			result_list: LINKED_LIST [PS_BACKEND_OBJECT]
			highest_id, curr_id: INTEGER
			curr_obj: detachable PS_BACKEND_OBJECT
		do
			create result_list.make
--			create temp_list.make
			highest_id := key_set [type.base_class.name]
--			highest_id := max_key + 1
			from
				curr_id := 1
			until
				curr_id > highest_id
			loop
				curr_obj := internal_retrieve_by_primary (type, curr_id, attributes, transaction)
				if attached curr_obj then
--					curr_obj := temp_list.first
--					if criteria.can_handle_object (curr_obj) then
--						if criteria.is_satisfied_by (curr_obj) then
							result_list.extend (curr_obj)
--						end
--					end
				end
				curr_id := curr_id + 1
			end
			Result := result_list.new_cursor
		end

	internal_retrieve_by_primary (type: PS_TYPE_METADATA; key: INTEGER; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): detachable PS_BACKEND_OBJECT
		local
			list: LINKED_LIST[INTEGER]
			res: LIST[PS_BACKEND_OBJECT]
		do
			create list.make
			list.extend (key)
			res := internal_retrieve_from_keys (type, list, transaction)
			if not res.is_empty then
				Result := res.first
			end
		end

	internal_retrieve_from_keys (type: PS_TYPE_METADATA; primary_keys: LIST [INTEGER]; transaction: PS_INTERNAL_TRANSACTION): LINKED_LIST [PS_BACKEND_OBJECT]
			-- Retrieve all objects of type `type' and with primary key in `primary_keys'.
		local
			all_items: ITERATION_CURSOR [PS_BACKEND_OBJECT]
			output: STRING
			result_list: LINKED_LIST [PS_PAIR [STRING, STRING]]
			current_obj: PS_BACKEND_OBJECT
			err_in_get: BOOLEAN
		do
			create Result.make
			create current_obj.make (0, type)
			err_in_get := false
			across
				primary_keys as id
			loop
				output := curl.get_document (type.base_class.name.as_lower, id.item.out)
				result_list := make_object (type, output, id.item.out)
				across
					result_list as attr
				loop
					if attr.item.first.is_equal ("error") then
						err_in_get := true
					elseif not err_in_get then
						if attr.item.first.is_equal ("_id") then
							if attr.item.second.is_integer then
								create current_obj.make (attr.item.second.to_integer, type)
							else
								create current_obj.make (0, type)
							end
						elseif not attr.item.first.starts_with ("_") then
							if attr.item.first.starts_with ("ps_") then
								current_obj.add_attribute (attr.item.first, attr.item.second, "BOOLEAN")
							else
								current_obj.add_attribute (attr.item.first, attr.item.second, type.attribute_type (attr.item.first).base_class.name)
							end
						end
					end
				end
				across
					type.attributes as attr
				loop
					if not current_obj.has_attribute (attr.item) then
						current_obj.add_attribute (attr.item, "", "NONE")
					end
				end
				if not err_in_get then
					Result.extend (current_obj)
				else
					err_in_get := false
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Primary key generation

	generate_all_object_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST[PS_BACKEND_OBJECT], PS_TYPE_METADATA]
			-- For each type `type_key' in `order', generate `order[type_key]' new objects in the database.
		local
			part: LINKED_LIST [PS_BACKEND_OBJECT]
		do
			across
				order as cursor
			from
				create Result.make (order.count)
			loop
				across
					1 |..| cursor.item as idx
				from
					create part.make
					Result.extend (part, cursor.key)
				loop
					part.extend (create {PS_BACKEND_OBJECT}.make_fresh (new_key (cursor.key.base_class.name).first, cursor.key))
				end
			end
		end

	generate_collection_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST[PS_BACKEND_COLLECTION], PS_TYPE_METADATA]
			-- For each type `type_key' in the hash table `order', generate `order[type_key]' new collections in the database.
		do
			check not_implemented: False end
			create Result.make (10)
		end

feature {PS_ABEL_EXPORT} -- Object write operations

--	insert (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_INTERNAL_TRANSACTION)
--			-- Inserts `an_object' into the database.
--		local
--			db_name, doc, rev: STRING
--			err, prev: detachable STRING
--			prev_attr_list: LINKED_LIST [PS_PAIR [STRING, STRING]]
--			new_primary: PS_PAIR [INTEGER, STRING]
--		do
--			create prev_attr_list.make
--			new_primary := new_key (an_object.object_wrapper.metadata.base_class.name)
--			key_mapper.add_entry (an_object.object_wrapper, new_primary.first, a_transaction)
--			doc := make_json (an_object, new_primary.first.out, "", a_transaction)
--			db_name := an_object.object_wrapper.metadata.base_class.name.as_lower
--			err := curl.create_document (db_name, doc)
--			prev_attr_list := make_object (an_object.object_wrapper.metadata, err, "")
--			across
--				prev_attr_list as attr
--			loop
--				if attr.item.first.is_equal ("error") then
--					rev := get_rev (db_name, new_primary.first.out, an_object)
--					doc := make_json (an_object, new_primary.first.out, rev, a_transaction)
--					err := curl.update_document (db_name, new_primary.first.out, doc)
--				end
--			end
--		end

--	update (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_INTERNAL_TRANSACTION)
--			-- Updates `an_object' in the database.
--		local
--			primary: PS_PAIR [INTEGER, PS_TYPE_METADATA]
--			db_name, doc, rev: STRING
--			err: detachable STRING
--		do
--			primary := key_mapper.primary_key_of (an_object.object_wrapper, a_transaction)
--			db_name := an_object.object_wrapper.metadata.base_class.name.as_lower
--			rev := get_rev (db_name, primary.first.out, an_object)
--			doc := make_json (an_object, primary.first.out, rev, a_transaction)
--			err := curl.update_document (db_name, primary.first.out, doc)
--		end

--	delete (an_object: PS_SINGLE_OBJECT_PART; a_transaction: PS_INTERNAL_TRANSACTION)
--			-- Deletes `an_object' from the database.
--		local
--			primary: PS_PAIR [INTEGER, PS_TYPE_METADATA]
--			err, rev, db_name: STRING
--		do
--			primary := key_mapper.primary_key_of (an_object.object_wrapper, a_transaction)
--			db_name := an_object.object_wrapper.metadata.base_class.name.as_lower
--			rev := get_rev (db_name, primary.first.out, an_object)
--			err := curl.delete_document (db_name, primary.first.out, rev)
--			key_mapper.remove_primary_key (primary.first, an_object.object_wrapper.metadata, a_transaction)
--		end

	delete (objects: LIST[PS_BACKEND_ENTITY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete every item in `objects' from the database
		do
			check not_implemented: False end
		end

feature {PS_BACKEND} -- Implementation

	internal_write (objects: LIST[PS_BACKEND_OBJECT]; transaction: PS_INTERNAL_TRANSACTION)
			-- Write all `objects' to the database.
			-- Only write the attributes present in {PS_BACKEND_OBJECT}.attributes.
		local
			db_name, doc, rev: STRING
			err, prev: detachable STRING
			prev_attr_list: LINKED_LIST [PS_PAIR [STRING, STRING]]
			new_primary: PS_PAIR [INTEGER, STRING]
		do

			across
				objects as cursor
			loop
				doc := make_json_new (cursor.item, cursor.item.primary_key.out, "")
				db_name := cursor.item.metadata.base_class.name.twin
				db_name.to_lower
				err := curl.create_document (db_name, doc)
--				print (doc)
--				print (err)

				-- ??
				prev_attr_list := make_object (cursor.item.metadata, err, "")
				across
					prev_attr_list as attr
				loop
					if attr.item.first.is_equal ("error") then
						rev := get_rev_new (db_name, cursor.item.primary_key.out, cursor.item)
						doc := make_json_new (cursor.item, cursor.item.primary_key.out, rev)
						err := curl.update_document (db_name, cursor.item.primary_key.out, doc)
					end
				end

			end
		end

feature --json operations

	make_object (type: PS_TYPE_METADATA; json: STRING; key: STRING): LINKED_LIST [PS_PAIR [STRING, STRING]]
			--creates a list of (type,value) pairs of attributes from a json document
		local
			attribute_name, attribute_value: STRING
			b_attr, b_value, b_afterattr: BOOLEAN
			pair: PS_PAIR [STRING, STRING]
		do
			create Result.make
			b_afterattr := false
			b_attr := false
			b_value := false
			create attribute_name.make_empty
			create attribute_value.make_empty
			across
				json as curr_char
			loop
				if curr_char.item.is_equal ('%"') then
					if not b_attr and not b_value and not b_afterattr then
						b_attr := true
					elseif not b_attr and not b_value and b_afterattr then
						b_value := true
						b_afterattr := false
					elseif b_attr then
						b_attr := false
						b_afterattr := true
					elseif b_value then
						b_value := false
					end
				elseif curr_char.item.is_equal (',') or curr_char.item.is_equal ('%>') then --attribute done
					create pair.make (attribute_name, attribute_value)
					Result.extend (pair)
					attribute_name := ""
					attribute_value := ""
				else
					if b_attr then
						attribute_name.extend (curr_char.item)
					end
					if b_value then
						attribute_value.extend (curr_char.item)
					end
				end
			end
		end

--	make_json (object: PS_SINGLE_OBJECT_PART; id: STRING; rev: STRING; transaction: PS_INTERNAL_TRANSACTION): STRING
--			--creates a json document containing the attributes of object in the form:
--			--{"attribute1": "value1", "attribute2": "value2"}
--		local
--			referenced_part: PS_OBJECT_GRAPH_PART
--			value: STRING
--		do
--			create Result.make_empty
--			Result.append ("{ ")
--			if not id.is_empty then
--				Result.append ("%"_id%": %"" + id + "%", ")
--			end
--			if not rev.is_empty then
--				Result.append ("%"_rev%": %"" + rev + "%", ")
--			end
--			across
--				object.attributes as current_attribute
--			loop
--				Result.append ("%"" + current_attribute.item + "%": ")
--				referenced_part := object.attribute_value (current_attribute.item)
--				if referenced_part.is_basic_attribute then
--					value := referenced_part.basic_attribute_value
--				else
--					value := referenced_part.as_attribute (key_mapper.quick_translate (referenced_part.object_identifier, transaction)).value
--				end
--				Result.append ("%"" + value + "%"")
--				if not current_attribute.is_last then
--					Result.append (", ")
--				end
--			end
--			Result.append (" }")
--		end

	make_json_new (object: PS_BACKEND_OBJECT; id: STRING; rev: STRING): STRING
			--creates a json document containing the attributes of object in the form:
			--{"attribute1": "value1", "attribute2": "value2"}
		local
			value: STRING
		do
			create Result.make_empty
			Result.append ("{ ")
			if not id.is_empty then
				Result.append ("%"_id%": %"" + id + "%", ")
			end
			if not rev.is_empty then
				Result.append ("%"_rev%": %"" + rev + "%", ")
			end
			across
				object.attributes as current_attribute
			loop
				Result.append ("%"" + current_attribute.item + "%": ")

				value := object.attribute_value (current_attribute.item).value

				fixme ("Store the attribute type as well!")

				Result.append ("%"" + value + "%"")
				if not current_attribute.is_last then
					Result.append (", ")
				end
			end
			Result.append (" }")
		end

--	get_rev (db_name: STRING; id: STRING; an_object: PS_SINGLE_OBJECT_PART): STRING
--			--retrieves the rev value from the database
--		local
--			callback: STRING
--			attr_list: LINKED_LIST [PS_PAIR [STRING, STRING]]
--		do
--			create attr_list.make
--			callback := curl.get_document (db_name, id)
--			attr_list := make_object (an_object.object_wrapper.metadata, callback, id)
--			create Result.make_empty
--			across
--				attr_list as curr_attr
--			loop
--				if curr_attr.item.first.is_equal ("_rev") then
--					Result := curr_attr.item.second
--				end
--			end
--		end

	get_rev_new (db_name: STRING; id: STRING; object: PS_BACKEND_OBJECT): STRING
			--retrieves the rev value from the database
		local
			callback: STRING
			attr_list: LINKED_LIST [PS_PAIR [STRING, STRING]]
		do
			create attr_list.make
			callback := curl.get_document (db_name, id)
			attr_list := make_object (object.metadata, callback, id)
			create Result.make_empty
			across
				attr_list as curr_attr
			loop
				if curr_attr.item.first.is_equal ("_rev") then
					Result := curr_attr.item.second
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Object-oriented collection operations

	retrieve_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_INTERNAL_TRANSACTION): detachable PS_BACKEND_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		do
			check
				not_implemented: False
			end
		end

	retrieve_all_collections (collection_type: PS_TYPE_METADATA; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		do
			check
				not_implemented: False
			end
			Result := (create {LINKED_LIST [PS_BACKEND_COLLECTION]}.make).new_cursor
		end

	write_collections (collections: LIST[PS_BACKEND_COLLECTION]; transaction: PS_INTERNAL_TRANSACTION)
			-- Write every item in `collections' to the database
		do
			check
				not_implemented: False
			end
		end

	delete_collections (collections: LIST[PS_BACKEND_ENTITY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete every item in `collections' from the database
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

feature {PS_ABEL_EXPORT} -- Testing helpers

	wipe_out
			-- Wipe out everything and initialize new.
		local
			db_string: STRING
			databases: LIST [STRING]
			output: STRING
		do
				-- Returns a string of the form: ["_user", "person", "chain_head"].
			db_string := curl.list_databases

				-- Remove all user-defined databases (i.e. not prefixed by underline).
			databases := db_string.split ('"')
			across
				databases as cursor
			loop
				cursor.item.trim
				if not cursor.item.is_empty or else cursor.item.item (1).is_alpha then
					output := curl.destroy_database (cursor.item)
				end
			end
		end

feature -- database

	curl: CDB_DATABASE

feature {NONE} -- Initialization

	make
		do
			create curl.make
			create key_set.make (100)
			create plug_in_list.make
		end

	make_with_host_and_port (host: STRING; port: INTEGER)
		do
			create curl.make_with_host_and_port (host, port)
			create key_set.make (100)
			create plug_in_list.make
		end

end
