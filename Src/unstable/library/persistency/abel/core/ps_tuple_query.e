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
			generate_tuple_type
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

feature {PS_ABEL_EXPORT} -- Implementation: Element change

	retrieve_next
			-- Retrieve the next item from the database and store it in `result_cache'.
		local
			reflector: INTERNAL
			i: INTEGER
		do
			check attached internal_cursor as my_cursor then
				my_cursor.forth

				if my_cursor.after then
					is_after := True
				else

					create reflector

					check attached {TUPLE} reflector.new_instance_of (tuple_type) as new_tuple then

						across
							projection as attr_cursor
						from
							i := 1
						loop
							new_tuple.put (reflector.field (field_indices [attr_cursor.item], my_cursor.item), i)
							i := i + 1
						end

						result_cache.extend (new_tuple)
					end
				end
			end
		rescue
			repository.rollback_transaction (internal_transaction, False)
			close
		end

feature {NONE} -- Initialization

	make
			-- Create a query for all objects of type G (no filtering criteria).
		local
			reflector: REFLECTOR
			field_count: INTEGER
		do
			create field_indices.make (0)
			create projection.make (0)

			Precursor

			create reflector
			field_count := reflector.field_count_of_type (generic_type.type_id)
			create field_indices.make (field_count)

			across
				1 |..| field_count as index
			loop
				field_indices.extend (index.item, reflector.field_name_of_type (index.item, generic_type.type_id))
			end

			set_projection (default_projection)
		end


	field_indices: HASH_TABLE [INTEGER, STRING]
			-- A quick lookup: field_name -> index, as used by reflection.

	tuple_type: INTEGER
			-- The dynamic type of the result tuples.


	generate_tuple_type
			-- Generate a tuple of correct type and size
		require
			 projection_not_empty: projection.count > 0
		local
			tuple_string: STRING
			index: INTEGER
			reflection: REFLECTOR
		do
			create reflection
			tuple_string := "detachable TUPLE ["

			from index := 1
			until index > projection.count
			loop

				-- NOTE: We cannot just take the runtime type of the attribute, since those types are (for whatever reason)
				-- always detachable. Instead the generated tuple needs to have the statically declared types as its generic
				-- attributes. This way object tests like
				--		check attached TUPLE [STRING, STING, detachable STRING] generated_tuple end
				--  will succeed for objects having those fields.

				tuple_string := tuple_string + reflection.type_name_of_type (reflection.field_static_type_of_type (field_indices [projection [index]], generic_type.type_id))
				index := index + 1

				if index <= projection.count then
					tuple_string := tuple_string + ", "
				end
			end

			tuple_string := tuple_string + "]"
			tuple_type := reflection.dynamic_type_from_string (tuple_string)
		end


end
