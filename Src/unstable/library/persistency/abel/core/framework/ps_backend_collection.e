note
	description: "Represents a collection in the database."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_BACKEND_COLLECTION

inherit

	PS_BACKEND_ENTITY
		redefine
			make, is_equal
		end

create {PS_ABEL_EXPORT}
	make, make_fresh

feature {PS_ABEL_EXPORT} -- Access

	collection_items: LIST [PS_PAIR [STRING, IMMUTABLE_STRING_8]]
			-- All objects that are stored inside this collection.
			-- The first item in the PS_PAIR is the actual value of the item (foreign key or basic value), and the second item is the class name of the generating class of the first item.

	information_descriptions: LIST [STRING]
			-- Get all descriptions which have an information value.

	get_information (description: STRING): STRING
			-- Returns the additional information to the key `description'.
			-- (Background info: Information is generated during insert and needed during retrieval by a PS_COLLECTION_HANDLER. The backend just stores the <description, value> tuple.)
		require
			description_not_empty: not description.is_empty
			information_present: has_information (description)
		do
			check from_precondition: attached additional_information_hash [description] as res then
				Result := res
			end
		end

feature {PS_ABEL_EXPORT} -- Status report

	has_information (description: STRING): BOOLEAN
			-- Does the retrieved collection have a information value attached to the `description' key?
		require
			description_not_empty: not description.is_empty
		do
			Result := additional_information_hash.has (description)
		end

	is_empty: BOOLEAN
			-- Is the current collection empty (save for a primary key)?
		do
			Result := collection_items.is_empty and information_descriptions.is_empty
		end

	is_consistent: BOOLEAN
			-- Does the static type match the retrieved runtime type for all collection items in `Current'?
		local
			collection_item_type: INTEGER
			runtime_type: INTEGER
			reflection: INTERNAL
		do
			Result := True
			if not attached {TYPE [detachable TUPLE]} metadata.type then
				across
					collection_items as cursor
				from
					create reflection
					collection_item_type := metadata.actual_generic_parameter (1).type.type_id
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

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			if Current = other then
				Result := True
			else
				Result := primary_key.is_equal (other.primary_key) and metadata.is_equal (other.metadata)
				from
					collection_items.start
					other.collection_items.start
					Result := Result and collection_items.count = other.collection_items.count
					Result := Result and information_descriptions.count = other.information_descriptions.count and then
						across information_descriptions as cursor
						all
							other.has_information (cursor.item) and then
							other.get_information (cursor.item).is_equal (get_information (cursor.item))
						end
				until
					collection_items.after or not Result
				loop
					Result := Result and collection_items.item.first.is_equal (other.collection_items.item.first)
									 and collection_items.item.second.is_equal (other.collection_items.item.second)
					collection_items.forth
					other.collection_items.forth
				variant
					collection_items.count - collection_items.index + 1
				end
			end
		end

	is_subset_of (other: PS_BACKEND_COLLECTION): BOOLEAN
			-- Does `Current' have the same primary key and metadata and a subset of the items and information in `other'?
		local
			i: INTEGER
		do
			if Current = other then
				Result := True
			else
				Result := primary_key = other.primary_key and metadata ~ other.metadata and then
					across
						information_descriptions as cursor
					all
						other.has_information (cursor.item)
						and then other.get_information (cursor.item) ~ get_information (cursor.item)
					end

				Result := Result and collection_items.count <= other.collection_items.count

				from
					i := 1
				until
					i > collection_items.count or not Result
				loop
					Result := Result and collection_items [i].first ~ other.collection_items [i].first
						and collection_items [i].second ~ other.collection_items [i].second

					i := i + 1
				variant
					collection_items.count + 1 - i
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Element change

	add_item (item_value, class_name_of_item_value: STRING)
			-- Add the value `item_value' and its `class_name_of_item_value' to the end of the `collection_items' list.
		require
			class_name_not_empty: not class_name_of_item_value.is_empty
			void_value_means_none_type: item_value.is_empty implies class_name_of_item_value.is_equal ("NONE")
		do
			collection_items.extend (create {PS_PAIR [STRING, IMMUTABLE_STRING_8]}.make (item_value, class_name_of_item_value))
		ensure
			item_inserted: collection_items.last.first.is_equal (item_value)
			class_name_inserted: collection_items.last.second.is_equal (class_name_of_item_value)
		end

	put_item (value: STRING; runtime_type: IMMUTABLE_STRING_8; position: INTEGER)
			-- Add the tuple [`value', `runtime_type'] at position `position'.
			-- Fill the list with ["", "NONE"] tuples if necessary.
		require
			runtime_type_set: not runtime_type.is_empty
			none_means_void: runtime_type ~ "NONE" implies value.is_empty
			position_positive: position > 0
		do
			from
			until
				collection_items.count >= position
			loop
				collection_items.extend (["", create {IMMUTABLE_STRING_8}.make_from_string ("NONE")])
			end

			collection_items.put_i_th ([value, runtime_type], position)
		end

	add_information (description: STRING; value: STRING)
			-- Add the information `value' with its description `description' to the retrieved collection.
		require
			description_not_empty: not description.is_empty
			value_not_empty: not value.is_empty
		do
			information_descriptions.extend (description)
			additional_information_hash.extend (value, description)
		ensure
			information_set: get_information (description).is_equal (value)
		end

feature {NONE}

	additional_information_hash: HASH_TABLE [STRING, STRING]
			-- The internal store for additional information.

	make (key: INTEGER; meta: PS_TYPE_METADATA)
			-- Initialize `Current'
		do
			Precursor (key, meta)
			create additional_information_hash.make (2)
			create {ARRAYED_LIST [STRING]} information_descriptions.make (2)
			create {ARRAYED_LIST [PS_PAIR [STRING, IMMUTABLE_STRING_8]]} collection_items.make (25)
		ensure then
			additional_info_empty: additional_information_hash.is_empty
			collection_items_empty: collection_items.is_empty
		end

feature {NONE} -- Consistency checks

	check_void_types: BOOLEAN
			-- Check that all Void items have `NONE' as the generating class.
		do
			Result := across collection_items as item_cursor all item_cursor.item.first.is_empty implies item_cursor.item.second.is_equal ("NONE") end
		end

invariant
	all_void_values_have_none_type: check_void_types
	all_descriptions_have_information: information_descriptions.count = additional_information_hash.count and then across information_descriptions as desc all has_information (desc.item) end

end
