note
	description: "[
		Represents a freshly retrieved object-oriented collection.
		See also description of PS_RETRIEVED_COLLECTION.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_RETRIEVED_OBJECT_COLLECTION

inherit

	PS_BACKEND_ENTITY
		redefine
			make
		end

	PS_RETRIEVED_COLLECTION

create {PS_EIFFELSTORE_EXPORT}
	make

feature {PS_EIFFELSTORE_EXPORT} -- Access

--	primary_key: INTEGER
--			-- The retrieved collection's primary key, as used in the database.

--	metadata: PS_TYPE_METADATA
--			-- The type of the current collection.

	class_metadata: PS_CLASS_METADATA
			-- Some metadata information about the generating class of the collection.
		obsolete
			"use metadata.base_class"
		do
			Result := metadata.base_class
		end

	information_descriptions: LIST [STRING]
			-- Get all descriptions which have an information value.

	get_information (description: STRING): STRING
			-- Returns the additional information to the key `description'.
			-- (Background info: Information is generated during insert and needed during retrieval by a PS_COLLECTION_HANDLER. The backend just stores the <description, value> tuple.)
		require
			description_not_empty: not description.is_empty
			information_present: has_information (description)
		do
			Result := attach (additional_information_hash [description])
		end

feature {PS_EIFFELSTORE_EXPORT} -- Status report

	has_information (description: STRING): BOOLEAN
			-- Does the retrieved collection have a information value attached to the `description' key?
		require
			description_not_empty: not description.is_empty
		do
			Result := additional_information_hash.has (description)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Element change

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
			precursor (key, meta)
--			primary_key := key
--			metadata := meta
			create additional_information_hash.make (10)
			create {LINKED_LIST [STRING]} information_descriptions.make
			create collection_items.make
		ensure then
--			primary_key_set: primary_key = key
--			metadata_set: metadata.is_equal (meta)
			additional_info_empty: additional_information_hash.is_empty
			collection_items_empty: collection_items.is_empty
		end

invariant
	all_void_values_have_none_type: check_void_types
	all_descriptions_have_information: information_descriptions.count = additional_information_hash.count and then across information_descriptions as desc all has_information (desc.item) end

end
