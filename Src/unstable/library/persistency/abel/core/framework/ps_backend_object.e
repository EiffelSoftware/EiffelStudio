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
			out
		end

create {PS_ABEL_EXPORT}
	make, make_fresh

feature {PS_ABEL_EXPORT} -- Access

	attributes: ARRAYED_LIST [STRING]
			-- The attributes present in `Current'.
		do
			create Result.make_from_array (attr_values.current_keys)
		end

	attribute_value (name: STRING): TUPLE [value: STRING; type: IMMUTABLE_STRING_8]
			-- The value of the attribute `name'.
			-- The first item in the result is the actual value, and the second item is its runtime type.
		require
			attribute_present: has_attribute (name)
		do
			check from_precondition: attached attr_values [name] as val and attached attr_types [name] as runtime_type then
				Result := [val, runtime_type]
			end
		end

	value_lookup (name: STRING): detachable STRING
			-- The value of the attribute `attribute_name', if present.
		do
			Result := attr_values [name]
		ensure
			attached_if_present: has_attribute (name) implies attached Result
		end

	type_lookup (name: STRING): IMMUTABLE_STRING_8
			-- The type of the attribute `attribute_name'.
		require
			has_attribute: has_attribute (name)
		do
			check attached attr_types [name] as runtime_type then
				Result := runtime_type
			end
		end

feature {PS_ABEL_EXPORT} -- Status report

	has_attribute (name: STRING): BOOLEAN
			-- Does `Current' have an attribute with name `attribute_name'?
		do
			Result := attr_values.has (name)
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
			 or else type.attributes.for_all (agent has_attribute)
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
				if type.attributes.has (cursor.key) then

					attr_type := reflection.dynamic_type_from_string (cursor.item)

						-- For expanded types, or when an object was attached, the runtime type must conform to the declared type
					Result := Result and (attr_type >= 0 implies
						reflection.type_conforms_to (attr_type, type.attribute_type (cursor.key).type.type_id))

						-- If a reference was Void during write, the runtime type was stored as NONE and the value is 0
					Result := Result and (attr_type = reflection.none_type implies
						not type.attribute_type (cursor.key).type.is_attached -- Type can be detachable
						and attached attr_values [cursor.key] as val and then val.is_empty) -- Value is an empty string
				end
			end
		end


feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := attr_values.count = other.attr_values.count and  is_subset_of (other)
		end

	is_subset_of (other: detachable like Current): BOOLEAN
			-- Does `Current' have the same primary key and metadata and a subset of the attributes in `other'?
		do
			if attached other then
				Result := primary_key.is_equal (other.primary_key) and type.is_equal (other.type) and then
					across
						attr_values as cursor
					all
						other.has_attribute (cursor.key) and then
						(other.value_lookup (cursor.key) ~ value_lookup (cursor.key)
						and other.type_lookup (cursor.key) ~ type_lookup (cursor.key))
					end
			else
				Result := False
			end
		end

feature {PS_ABEL_EXPORT} -- Element change

	add_attribute (name: STRING; value: STRING; runtime_type: IMMUTABLE_STRING_8)
			-- Add the attribute `name' with value `value' and runtime type `runtime_type'.
		require
			class_name_not_empty: not runtime_type.is_empty
			none_means_void_value: runtime_type.is_equal ("NONE") implies value.is_empty
		do
			attr_values.force (value, name)
			attr_types.force (runtime_type, name)
		ensure
			value_inserted: attribute_value (name).value.is_equal (value)
			class_name_inserted: attribute_value (name).type.is_equal (runtime_type)
		end

	remove_attribute (name: STRING)
			-- Remove the attribute `name'.
		require
			attribute_present: has_attribute (name)
		do
			attr_values.remove (name)
			attr_types.remove (name)
		ensure
			attribute_removed: not has_attribute (name)
		end

	filter_attributes (attributes_to_keep: HASH_TABLE [BOOLEAN, STRING])
			-- Remove all attributes except the ones listed in `attributes_to_keep'.
		do
			across
				attributes as cursor
			loop
				if not attributes_to_keep.has (cursor.item) then
					attr_values.remove (cursor.item)
					attr_types.remove (cursor.item)
				end
			end
		end

feature -- Debugging output

	out: STRING
			-- <Precursor>
		do
			Result := "PS_RETRIEVED_OBJECT:%N"
			Result.append ("%Tprimary key: " + primary_key.out + "%N")
			Result.append ("%Ttype: " + type.type.name + "%N")
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

	make (key: INTEGER; a_type: PS_TYPE_METADATA)
			-- <Precursor>
		do
			primary_key := key
			type := a_type
			create attr_values.make (a_type.attribute_count + 1)
			create attr_types.make (a_type.attribute_count + 1)
		ensure then
			attributes_empty: attributes.is_empty
		end

feature {PS_BACKEND_OBJECT} -- Implementation

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
