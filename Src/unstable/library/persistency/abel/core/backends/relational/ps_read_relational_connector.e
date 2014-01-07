note
	description: "A repository connector for a relational database with an existing layout."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_READ_RELATIONAL_CONNECTOR

inherit
	PS_RDBMS_CONNECTOR

create
	make

feature {PS_ABEL_EXPORT} -- Access

	stored_types: ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- The type string for all objects and collections stored in `Current'.
		do
			-- Note to implementors: It is highly recommended to cache the result, and
			-- refresh it during a `retrieve' operation (or not at all if the result
			-- is always stable).
			fixme ("to implement")
			create Result.make (0)
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_generic_collection_supported: BOOLEAN = False
			-- Are collections supported by this connector?

feature {PS_ABEL_EXPORT} -- Collection retrieval

	collection_retrieve (type: PS_TYPE_METADATA; is_root: BOOLEAN; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_COLLECTION]
			-- <Precursor>
		do
			check not_supported: False end
			Result := (create {LINKED_LIST [PS_BACKEND_COLLECTION]}.make).new_cursor
		end

	specific_collection_retrieve (primary_keys: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_COLLECTION]
			-- <Precursor>
		do
			check not_supported: False end
			Result := create {LINKED_LIST [PS_BACKEND_COLLECTION]}.make
		end


feature {PS_READ_REPOSITORY_CONNECTOR} -- Implementation

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; is_root_only: BOOLEAN; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- <Precursor>
		local
			connection: PS_SQL_CONNECTION
			res_list: ARRAYED_LIST [PS_BACKEND_OBJECT]
			object: PS_BACKEND_OBJECT
		do

			connection := get_connection (transaction)
			connection.execute_sql ("SELECT * FROM " + type.name.as_lower)

			across
				connection as cursor
			from
				create res_list.make (1)
			loop
				across
					type.attributes as attribute_cursor
				from

					fixme ("Find out about the primary key.")
					bogus_primary := bogus_primary + 1

					create object.make (bogus_primary, type)
					
					res_list.extend (object)
				loop
					fixme ("What to do about the runtime type?")
					object.add_attribute (
							-- Attribute name.
						attribute_cursor.item,
							-- Attribute value.
						cursor.item.at (attribute_cursor.item),
							-- Runtime type.
						type.attribute_type (attribute_cursor.item).name)

				end
			end
			Result := res_list.new_cursor
		end

	internal_specific_retrieve (primaries: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
			-- <Precursor>
		do
			fixme ("to implement")
			Result := create {LINKED_LIST [PS_BACKEND_OBJECT]}.make
		end

feature {NONE} -- Initialization

	make (a_database: like database)
			-- Initialization for `Current'.
		do
			initialize (a_database)
		end

	bogus_primary: INTEGER

end
