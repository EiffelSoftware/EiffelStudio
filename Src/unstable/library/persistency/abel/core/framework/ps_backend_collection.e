note
	description: "Represents a collection in the database."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_BACKEND_COLLECTION

inherit

	PS_BACKEND_ENTITY

	READABLE_INDEXABLE [STRING]
		rename
			upper as count
		undefine
			is_equal
		end


create {PS_ABEL_EXPORT}
	make, make_fresh

feature {PS_ABEL_EXPORT} -- Access

	count: INTEGER
			-- The number of items in `Current'.
		do
			Result := item_store.count
		ensure then
			correct: Result = item_store.count and Result = type_store.count
		end

	item alias "[]" (i: INTEGER): STRING
			--  <Precursor>
		do
			Result := item_store [i]
		ensure then
			correct: Result = item_store [i]
		end

	item_type (i: INTEGER): IMMUTABLE_STRING_8
			-- Runtime type of entry at position `i'.
		do
			Result := type_store [i]
		ensure
			correct: Result = type_store [i]
		end

	meta_information: HASH_TABLE [STRING, STRING]
			-- A key-value store for meta-information about a collection, such as its capacity.

	lower: INTEGER = 1
			-- <Precursor>

feature {PS_ABEL_EXPORT} -- Status report

	valid_index (i: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := 1 <= i and i <= count
		end

	is_empty: BOOLEAN
			-- Is the current collection empty (save for a primary key)?
		do
			Result := item_store.is_empty and meta_information.is_empty
		end

	is_consistent: BOOLEAN
			-- Does the static type match the retrieved runtime type for all collection items in `Current'?
		local
			collection_item_type: INTEGER
			runtime_type: INTEGER
			reflection: INTERNAL
		do
			Result := True
			if not attached {TYPE [detachable TUPLE]} type.type then
				across
					type_store as cursor
				from
					create reflection
					collection_item_type := type.actual_generic_parameter (1).type.type_id
				loop
					runtime_type := reflection.dynamic_type_from_string (cursor.item)

					if runtime_type >= 0 then
						-- Check if runtime type conforms to collection type
						Result := Result and reflection.type_conforms_to (runtime_type, collection_item_type)
					else
						-- Item was Void during insert
						Result := Result
							and runtime_type = reflection.none_type -- Runtime type set to "NONE"
							and not reflection.is_attached_type (collection_item_type) -- Collection type allowed to be detachable
							and item (cursor.target_index).is_empty -- Value is an empty string
					end
				end
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := count = other.count and meta_information.count = other.meta_information.count
			Result := Result and then is_subset_of (other)
		end

	is_subset_of (other: PS_BACKEND_COLLECTION): BOOLEAN
			-- Does `Current' have the same primary key and metadata and a subset of the items and information in `other'?
		local
			i: INTEGER
		do
			if Current = other then
				Result := True
			else
				Result := primary_key = other.primary_key and type ~ other.type and then
					across
						meta_information as cursor
					all
						other.meta_information.has (cursor.key)
						and then other.meta_information [cursor.key] ~ cursor.item
					end

				Result := Result and count <= other.count

				from
					i := 1
				until
					i > count or not Result
				loop
					Result := Result and item (i) ~ other.item (i)
						and item_type (i) ~ other.item_type (i)
					i := i + 1
				variant
					count + 1 - i
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Element change

	extend (value: STRING; runtime_type: IMMUTABLE_STRING_8)
			-- Add `value' with type `runtime_type' to `Current'.
		require
			class_name_not_empty: not runtime_type.is_empty
			void_value_means_none_type: value.is_empty implies runtime_type ~ "NONE"
		do
			item_store.extend (value)
			type_store.extend (runtime_type)
		ensure
			count_increased: count = old count + 1
			item_inserted: item (count)  = value
			class_name_inserted: item_type (count) = runtime_type
		end

	force_i_th (value: STRING; runtime_type: IMMUTABLE_STRING_8; position: INTEGER)
			-- Insert `value' with type `runtime_type' at `position'.
			-- Extend the list with Void items if necessary.
		require
			runtime_type_set: not runtime_type.is_empty
			none_means_void: runtime_type ~ "NONE" implies value.is_empty
			position_positive: position > 0
		local
			none_string: IMMUTABLE_STRING_8
		do

			from
				create none_string.make_from_string ("NONE")
			until
				count >= position
			loop
				extend ("", none_string)
			variant
				position + 1 - count
			end

			put_i_th (value, runtime_type, position)
		ensure
			count_big_enough: count >= position
			item_inserted: item (position) = value
			type_inserted: item_type (position) = runtime_type
		end

	put_i_th (value: STRING; runtime_type: IMMUTABLE_STRING_8; position: INTEGER)
			-- Insert `value' with type `runtime_type' at `position'.
		require
			runtime_type_set: not runtime_type.is_empty
			none_means_void: runtime_type ~ "NONE" implies value.is_empty
			valid_position: valid_index (position)
		do
			item_store [position] := value
			type_store [position] := runtime_type
		ensure
			count_unchanged: count = old count
			item_inserted: item (position) = value
			type_inserted: item_type (position) = runtime_type
		end

feature {NONE} -- Implementation

	default_capacity: INTEGER = 25
			-- The default capacity

	item_store: ARRAYED_LIST [STRING]
			-- The storage array for items.

	type_store: ARRAYED_LIST [IMMUTABLE_STRING_8]
			-- The storage array for types.

	check_void_types: BOOLEAN
			-- Check that all items with `NONE' type have an empty string.
		do
			Result :=
				across
					type_store as c
				all
					c.item ~ "NONE" implies item (c.target_index).is_empty
				end
		end

feature {NONE} -- Initialization

	make (key: INTEGER; a_type: PS_TYPE_METADATA)
			-- <Precursor>
		do
			primary_key := key
			type := a_type
			create meta_information.make (1)
			create item_store.make (default_capacity)
			create type_store.make (default_capacity)
		ensure then
			additional_info_empty: meta_information.is_empty
			items_empty: item_store.is_empty and type_store.is_empty
		end

invariant
	all_void_values_have_none_type: check_void_types
	same_count: item_store.count = type_store.count
end
