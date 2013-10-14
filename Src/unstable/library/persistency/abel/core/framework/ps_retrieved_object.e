note
	description: "[
		Represents a freshly retrieved object.
		The attribute values are all stored as strings, no matter if they are an actual value or just a foreign key.
		Every attribute value is attached to the class name of its generating class as well.
		A NULL value in the database is represented as an empty string, and the class name of a NULL value is `NONE'.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_RETRIEVED_OBJECT

inherit

	PS_BACKEND_ENTITY
		redefine
			make, is_equal
		end

create {PS_EIFFELSTORE_EXPORT}
	make, make_fresh

feature {PS_EIFFELSTORE_EXPORT} -- Access

--	primary_key: INTEGER
--			-- The retrieved object's primary key, as used in the database.

--	metadata: PS_TYPE_METADATA
--			-- The type of the current object

	class_metadata: PS_CLASS_METADATA
			-- Metadata information about the object.
		obsolete
			"use metadata.base_class"
		do
			Result := metadata.base_class
		end

	attributes: LINKED_LIST [STRING]
			-- The attributes of the object that have been loaded.

	attribute_value (attribute_name: STRING): TUPLE [value: STRING; attribute_class_name: STRING]
			-- The value of the attribute `attribute_name'.
			-- The first item in the result is the value, and the second item is the class name of the generating class of the first item.
		require
			attribute_present: has_attribute (attribute_name) and then has_value_for_attribute (attribute_name)
		do
			Result := attach (values [attribute_name])
		end

feature {PS_EIFFELSTORE_EXPORT} -- Status report

	has_attribute (attribute_name: STRING): BOOLEAN
			-- Does the `Current' retrieved object have an attribute with name `attribute_name'?
		do
			Result := attributes.has (attribute_name)
		end

	has_value_for_attribute (attribute_name: STRING): BOOLEAN
			-- Does the `Current' retrieved object have a value to the attribute with name `attribute_name'?
		require
			has_attribute (attribute_name)
		do
			Result := values.has (attribute_name)
		end

	is_empty: BOOLEAN
			-- Is the current object empty (save for a primary key)?
		do
			Result := attributes.is_empty
		ensure
			correct: Result = attributes.is_empty
		end

	is_complete: BOOLEAN
			-- Does `Current' have all attributes to build the object?
		do
			Result := metadata.attributes.for_all (agent has_attribute)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := attributes.count = other.attributes.count and  is_subset_of (other)
		end

	is_subset_of (other: detachable like Current): BOOLEAN
			-- Does `Current' have the same primary key and metadata and a subset of the attributes in `other'?
		do
			if attached other then
				Result := primary_key.is_equal (other.primary_key) and metadata.is_equal (other.metadata) and then
					across attributes as cursor all other.has_attribute (cursor.item) and then is_equal_tuple (other.attribute_value (cursor.item), attribute_value(cursor.item)) end
			else
				Result := False
			end
		end

feature {PS_EIFFELSTORE_EXPORT} -- Element change

	add_attribute (attribute_name: STRING; value: STRING; class_name_of_value: STRING)
			-- Add the attribute `attribute_name' with value tuple <`value', `class_name_of_value'>.
		require
				--	attribute_exists: class_metadata.attributes.has (attribute_name)
			class_name_not_empty: not class_name_of_value.is_empty
			void_value_means_none_type: value.is_empty implies class_name_of_value.is_equal ("NONE")
		local
			pair: PS_PAIR [STRING, STRING]
		do
			create pair.make (value, class_name_of_value)
			values.extend (pair, attribute_name)
			attributes.extend (attribute_name)
		ensure
			value_inserted: attribute_value (attribute_name).value.is_equal (value)
			class_name_inserted: attribute_value (attribute_name).attribute_class_name.is_equal (class_name_of_value)
		end

	remove_attribute (attribute_name: STRING)
			-- Remove the attribute `attribute_name'.
		require
			attribute_present: has_attribute (attribute_name)
		do
			values.remove (attribute_name)
			attributes.prune (attribute_name)
		ensure
			attribute_removed: not has_attribute (attribute_name)
		end

feature {NONE} -- Initialization

	values: HASH_TABLE [PS_PAIR [STRING, STRING], STRING]
			-- Maps attribute names to the corresponding value and runtime types.

	make (key: INTEGER; class_data: PS_TYPE_METADATA)
			-- Initialization for `Current'.
		do
			precursor(key, class_data)
--			primary_key := key
--			metadata := class_data
			create values.make (10)
			create attributes.make
			attributes.compare_objects
		ensure then
			attributes_empty: attributes.is_empty
		end

feature {NONE} -- Implementation

	is_equal_tuple (a, b: TUPLE[first: STRING; second:STRING]): BOOLEAN
		do
			Result := a.first.is_equal (b.first) and a.second.is_equal (b.second)
		end

invariant
	has_value_for_all_attributes: across attributes as attribute_cursor all has_attribute (attribute_cursor.item) end
	void_references_have_NONE_type: across values as val all val.item.first.is_empty implies val.item.second.is_equal ("NONE") end

end
