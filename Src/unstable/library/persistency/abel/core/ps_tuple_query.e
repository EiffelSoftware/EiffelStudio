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

	PS_QUERY [G, TUPLE]
		redefine
			make
		end

create
	make, make_with_criterion

feature -- Access: Retrieval Parameter

	projection: ARRAY [STRING]
			-- Data to be included for projection. Defaults to all fields of basic types and string types.
			-- The projection also defines the layout of the TUPLE results:
			-- The i-th item in a TUPLE corresponds to the i-th attribute in the projection.

feature -- Status report

	is_object_query: BOOLEAN = False
			-- Is `Current' an instance of PS_OBJECT_QUERY?

feature -- Element change

	set_projection (a_projection: ARRAY [STRING])
			-- Set `a_projection' to the current query.
		do
			projection := a_projection
		ensure
			projected_data_set: projection = a_projection
		end

feature -- Utilities

	default_projection: ARRAY [STRING]
			-- An array containing all the attribute names that are of a basic type.
		local
			reflection: INTERNAL
			instance: ANY
			field: detachable ANY
			i, j, num_fields: INTEGER
			field_type, string_type: INTEGER
		do
			create reflection
			instance := reflection.new_instance_of (reflection.generic_dynamic_type (Current, 1))
			num_fields := reflection.field_count (instance)
			create Result.make_filled (create {STRING}.make_empty, 1, num_fields)
			from
				i := 1
				j := 1
			until
				i > num_fields
			loop
				field := reflection.field (i, instance)
				if attached {NUMERIC} field or attached {BOOLEAN} field then
					Result.put (reflection.field_name (i, instance), j)
					j := j + 1
				else
					field_type := reflection.field_static_type_of_type (i, reflection.dynamic_type (instance))
					string_type := reflection.dynamic_type_from_string ("READABLE_STRING_GENERAL")
						--print (field_type.out + " " + string_type.out + "%N")
					if reflection.field_conforms_to (field_type, string_type) then
						Result.put (reflection.field_name (i, instance), j)
						j := j + 1
					end
				end
				i := i + 1
			end
			Result:= Result.subarray (1, j-1)
			Result.compare_objects
		end

	attribute_index (name: STRING): INTEGER
			-- Get the tuple index for the attribute with name `name'
		require
			 name_exists: projection.has (name)
		do
			from
				Result:= 1
			until
				Result > projection.count or name.is_equal (projection [Result])
			loop
				Result:= Result + 1
			end
		ensure
			positive: Result > 0
			in_range: Result <= projection.count
			correct: name.is_equal (projection [Result])
		end

feature {NONE} -- Initialization

	make
			-- Create a query for all objects of type G (no filtering criteria).
		do
			create projection.make_empty
			Precursor
			create projection.make_from_array (default_projection)
			projection.compare_objects
		ensure then
			projection_correctly_initialized: projection.is_deep_equal (old default_projection)
		end

end
