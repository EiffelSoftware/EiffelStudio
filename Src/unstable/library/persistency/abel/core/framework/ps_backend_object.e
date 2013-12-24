note
	description: "[
		Represents an object in the database.
		The attribute values are all stored as strings, no matter if they are an actual value or just a foreign key.
		Every attribute value is attached to the class name of its generating class as well.
		A NULL value in the database is represented as an empty string, and the class name of a NULL value is `NONE'.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_BACKEND_OBJECT

inherit

	PS_BACKEND_ENTITY
		redefine
			make, is_equal, out
		end

create {PS_ABEL_EXPORT}
	make, make_fresh

feature {PS_ABEL_EXPORT} -- Access

	attributes: ARRAYED_LIST [STRING]
			-- The attributes of the object that have been loaded.
		do
			create Result.make_from_array (attr_values.current_keys)
		end

	attribute_value (attribute_name: STRING): TUPLE [value: STRING; attribute_class_name: IMMUTABLE_STRING_8]
			-- The value of the attribute `attribute_name'.
			-- The first item in the result is the value, and the second item is the class name of the generating class of the first item.
		require
			attribute_present: has_attribute (attribute_name) and then has_value_for_attribute (attribute_name)
		do
			check from_precondition: attached attr_values [attribute_name] as val and attached attr_types [attribute_name] as type then
				Result := [val, type]
			end
		end

	value_lookup (attribute_name: STRING): detachable STRING
			-- The value of the attribute `attribute_name', if present.
		do
			Result := attr_values [attribute_name]
		ensure
			attached_if_present: has_attribute (attribute_name) implies attached Result
		end

	type_lookup (attribute_name: STRING): IMMUTABLE_STRING_8
			-- The value of the attribute `attribute_name', if present.
		require
			has_attribute: has_attribute (attribute_name)
		do
			check attached attr_types [attribute_name] as type then
				Result := type
			end
		end


feature {PS_ABEL_EXPORT} -- Status report

	has_attribute (attribute_name: STRING): BOOLEAN
			-- Does the `Current' retrieved object have an attribute with name `attribute_name'?
		do
			Result := attr_values.has (attribute_name)
		end

	has_value_for_attribute (attribute_name: STRING): BOOLEAN
			-- Does the `Current' retrieved object have a value to the attribute with name `attribute_name'?
		require
			has_attribute (attribute_name)
		do
			Result := attr_values.has (attribute_name)
		end

	is_empty: BOOLEAN
			-- Is the current object empty (save for a primary key)?
		do
			Result := attr_values.is_empty
		ensure
			correct: Result = attributes.is_empty and Result = attr_values.is_empty
		end

	is_complete: BOOLEAN
			-- Does `Current' have all attributes to build the object?
		do
			Result := (attr_values.count = 1 and attached value_lookup (value_type_item))
			 or else metadata.attributes.for_all (agent has_attribute)
		end

	is_consistent: BOOLEAN
			-- Does the static type match the retrieved runtime type for all attributes in `Current'?
		local
			reflection: INTERNAL
			attr_type: INTEGER
		do
			across
				attr_types as cursor
			from
				create reflection
				Result := True
			loop
				-- Ignore additional attributes (e.g. from plugins)
				if metadata.attributes.has (cursor.key) then

					attr_type := reflection.dynamic_type_from_string (cursor.item)

					-- For expanded types, or when an object was attached, the runtime type must conform to the declared type
					Result := Result and (attr_type >= 0 implies
						reflection.type_conforms_to (attr_type, metadata.attribute_type (cursor.key).type.type_id))

					-- If a reference was Void during write, the runtime type was stored as NONE and the value is 0
					Result := Result and (attr_type = reflection.none_type implies
						not metadata.attribute_type (cursor.key).type.is_attached -- Type can be detachable
						and attached attr_values [cursor.key] as val and then val.is_empty) -- Value is an empty string
				end
			end
		end


feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := attr_values.count = other.attr_values.count and  is_subset_of (other)
		end

	is_subset_of (other: detachable like Current): BOOLEAN
			-- Does `Current' have the same primary key and metadata and a subset of the attributes in `other'?
		do
			if attached other then
				Result := primary_key.is_equal (other.primary_key) and metadata.is_equal (other.metadata) and then
					across attr_values as cursor all other.has_attribute (cursor.key) and then is_equal_tuple (other.attribute_value (cursor.key), attribute_value (cursor.key)) end
			else
				Result := False
			end
		end

feature {PS_ABEL_EXPORT} -- Element change

	add_attribute (attribute_name: STRING; value: STRING; class_name_of_value: IMMUTABLE_STRING_8)
			-- Add the attribute `attribute_name' with value tuple <`value', `class_name_of_value'>.
		require
				--	attribute_exists: class_metadata.attributes.has (attribute_name)
			class_name_not_empty: not class_name_of_value.is_empty
			none_means_void_value: class_name_of_value.is_equal ("NONE") implies value.is_empty
--		local
--			pair: TUPLE [STRING, IMMUTABLE_STRING_8]
		do
--			pair := [value, class_name_of_value]

--			if values.has (attribute_name) then
--				values.force (pair, attribute_name)

--				attr_values.force (value, attribute_name)
--				attr_types.force (class_name_of_value, attribute_name)
--			else
--				values.extend (pair, attribute_name)
----				attributes.extend (attribute_name)
--			end


			attr_values.force (value, attribute_name)
			attr_types.force (class_name_of_value, attribute_name)

		ensure
			value_inserted: attribute_value (attribute_name).value.is_equal (value)
			class_name_inserted: attribute_value (attribute_name).attribute_class_name.is_equal (class_name_of_value)
		end

	remove_attribute (attribute_name: STRING)
			-- Remove the attribute `attribute_name'.
		require
			attribute_present: has_attribute (attribute_name)
		do
--			values.remove (attribute_name)
--			attributes.prune_all (attribute_name)


			attr_values.remove (attribute_name)
			attr_types.remove (attribute_name)
		ensure
			attribute_removed: not has_attribute (attribute_name)
		end

	filter_attributes (attributes_to_keep: HASH_TABLE [BOOLEAN, STRING])
			-- Remove all attributes except the ones listed in `attributes_to_keep'.
		do
			across
				attributes as cursor
			loop
				if not attributes_to_keep.has (cursor.item) then
--					values.remove (cursor.item)
					attr_values.remove (cursor.item)
					attr_types.remove (cursor.item)
				end
			end


--			from
--				attributes.start
--			until
--				attributes.after
--			loop
--				if attributes_to_keep.has (attributes.item) then
--					attributes.forth
--				else
--					values.remove (attributes.item)
--					attributes.remove
--				end
--			variant
--					-- In each iteration, either count or index decreases.
--				attributes.count - attributes.index + 1
--			end
		end

feature -- Debugging output

	out: STRING
			-- Printable version of `Current'
		do
			Result := "PS_RETRIEVED_OBJECT:%N"
			Result.append ("%Tprimary key: " + primary_key.out + "%N")
			Result.append ("%Ttype: " + metadata.type.name + "%N")
			Result.append ("%Tattributes:%N")
			across
				attr_types as cursor
			loop
				Result.append ("%T%T")
				Result.append (cursor.key + ": ")
				Result.append (cursor.item + " = ")
				Result.append (attribute_value (cursor.key).value)
				Result.append ("%N")
			end
		end

feature {NONE} -- Initialization

	make (key: INTEGER; type: PS_TYPE_METADATA)
			-- Initialization for `Current'.
		do
			precursor (key, type)
--			create values.make (type.attribute_count + 1) -- Additional space for plugins.
--			create attributes.make (class_data.attribute_count + 1)
--			attributes.compare_objects

			create attr_values.make (type.attribute_count + 1)
			create attr_types.make (type.attribute_count + 1)
		ensure then
			attributes_empty: attributes.is_empty
		end

feature {NONE} -- Implementation

	is_equal_tuple (a, b: TUPLE [first: STRING; second:IMMUTABLE_STRING_8]): BOOLEAN
		do
			Result := a.first.is_equal (b.first) and a.second.is_equal (b.second)
		end

feature {PS_BACKEND_OBJECT} -- Implementation

--	values: HASH_TABLE [TUPLE [value: STRING; type: IMMUTABLE_STRING_8], STRING]
			-- Maps attribute names to the corresponding value and runtime types.

	attr_values: HASH_TABLE [STRING, STRING]
			-- Maps attribute names to their value.

	attr_types: HASH_TABLE [IMMUTABLE_STRING_8, STRING]
			-- Maps attribute names to their runtime type.

feature {PS_ABEL_EXPORT} -- Constants

	value_type_item: STRING = "ps_value_item"
			-- The fake attribute for value type objects.



invariant
	has_value_for_all_attributes: across attributes as attribute_cursor all has_attribute (attribute_cursor.item) end

end
