note
	description: "[
		Represents a query for objects of type OBJECT_TYPE.
		The result is a TUPLE containing attributes of the object.
		
		Only the attributes listed in the projection array are loaded.
		The i-th item in a result TUPLE corresponds to the i-th attribute
		in the projection array.
		
		By default a projection contains only attributes of a basic or STRING type.
		It is possible to change the default using feature`set_projection'.
		Adding reference type attributes to the projection is possible.
		
		Note: If a predefined criterion is defined for an attribute which is not 
		part of the projection, the attribute will internally be retrieved as well.
		It will not be part of the result tuple however.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TUPLE_QUERY [G -> ANY]

inherit

	PS_ABSTRACT_QUERY [G, TUPLE]
		redefine
			make
		end

create
	make, make_with_criterion

feature -- Access: Retrieval Parameter

	projection: ARRAYED_LIST [STRING]
			-- Data to be included for projection. Defaults to all fields of basic types and string types.
			-- The projection also defines the layout of the TUPLE results:
			-- The i-th item in a TUPLE corresponds to the i-th attribute in the projection.

feature -- Status report

	is_tuple_query: BOOLEAN = True
			-- Is `Current' an instance of PS_TUPLE_QUERY?

feature -- Element change

	set_projection (a_projection: ARRAYED_LIST [STRING])
			-- Set `a_projection' to the current query.
		do
			projection := a_projection
		ensure
			projected_data_set: projection = a_projection
		end

feature -- Utilities

	default_projection: ARRAYED_LIST [STRING]
			-- An array containing all the attribute names that are of a basic type.
		local
			reflection: INTERNAL
			type: INTEGER
			field_type: INTEGER
			string_type: INTEGER
		do
			create reflection
			type := generic_type.type_id
			string_type := ({READABLE_STRING_GENERAL}).type_id

			create Result.make (10)
			Result.compare_objects

			across
				1 |..| reflection.field_count_of_type (type) as idx
			loop

				field_type := reflection.field_static_type_of_type (idx.item, type)

				if basic_types.has (field_type) or else reflection.type_conforms_to (field_type, string_type) then
					Result.extend (reflection.field_name_of_type (idx.item, type))
				end
			end
		end

--	attribute_index (name: STRING): INTEGER
--			-- Get the tuple index for the attribute with name `name'
--		require
--			 name_exists: projection.has (name)
--		do
--			Result := projection.index_of (name, 1)
--		ensure
--			positive: Result > 0
--			in_range: Result <= projection.count
--			correct: name.is_equal (projection [Result])
--		end

feature {NONE} -- Initialization

	make
			-- Create a query for all objects of type G (no filtering criteria).
		do
--			create projection.make (0)
			Precursor
			projection := default_projection
		end

	basic_types: HASH_TABLE [BOOLEAN, INTEGER]
			-- A quick lookup table for basic types.
		once
			create Result.make (20)

			Result.extend (True, ({INTEGER_8}).type_id)
			Result.extend (True, ({INTEGER_16}).type_id)
			Result.extend (True, ({INTEGER_32}).type_id)
			Result.extend (True, ({INTEGER_64}).type_id)

			Result.extend (True, ({NATURAL_8}).type_id)
			Result.extend (True, ({NATURAL_16}).type_id)
			Result.extend (True, ({NATURAL_32}).type_id)
			Result.extend (True, ({NATURAL_64}).type_id)


			Result.extend (True, ({REAL_32}).type_id)
			Result.extend (True, ({REAL_64}).type_id)

			Result.extend (True, ({CHARACTER_8}).type_id)
			Result.extend (True, ({CHARACTER_32}).type_id)

			Result.extend (True, ({BOOLEAN}).type_id)
			Result.extend (True, ({POINTER}).type_id)
		end
end
