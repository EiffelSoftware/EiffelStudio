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
			make
		end

	PS_EIFFELSTORE_EXPORT

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

invariant
	has_value_for_all_attributes: across attributes as attribute_cursor all has_attribute (attribute_cursor.item) end
	void_references_have_NONE_type: across values as val all val.item.first.is_empty implies val.item.second.is_equal ("NONE") end

end
