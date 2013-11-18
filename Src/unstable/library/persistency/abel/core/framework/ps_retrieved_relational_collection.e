note
	description: "Represents a freshly retrieved relational collection. See also the description in PS_RETRIEVED_COLLECTION."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_RETRIEVED_RELATIONAL_COLLECTION

inherit

	PS_RETRIEVED_COLLECTION

create
	make

feature -- Access

	owner_key: INTEGER
			-- The primary key of the reference owner of the retrieved relational collection.
			-- Note that a relational collection does not have a primary key in the database!

	owner_type: PS_CLASS_METADATA
			-- The class metadata of the reference owner of the retrieved relational collection.

	owner_attribute_name: STRING
			-- The attribute name of the reference that points to the current collection.

feature {NONE}

	make (o_key: INTEGER; o_type: PS_CLASS_METADATA; o_attr_name: STRING)
			-- Initialize `Current'.
		do
			owner_key := o_key
			owner_type := o_type
			owner_attribute_name := o_attr_name
			create collection_items.make
		ensure
			owner_key_set: owner_key = o_key
			owner_type_set: owner_type.is_equal (o_type)
			owner_attribute_name_set: owner_attribute_name.is_equal (o_attr_name)
			collection_items_empty: collection_items.is_empty
		end

invariant
		-- Void references cannot be stored in relational collections
	no_void_types: across collection_items as coll all not coll.item.first.is_empty end

end
