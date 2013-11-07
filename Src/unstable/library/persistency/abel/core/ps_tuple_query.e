note
	description: "[
		Represents a repository query that returns data tuples of objects.
		Please note that you cannot update or insert data tuples of objects into the repository.
		
		You can set a projection on the attributes you would like to have, to restrict the amount of data that is going to be retrieved.
		You'll get completely loaded objects as attributes if you include an attribute in your projection that is not of a basic type (strings and numbers).
		Objects of this type can be used directly to iterate through the query result.
		Example: across my_query as cur
				 loop 
					-- do something with cur.item 
				 end
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TUPLE_QUERY [G -> ANY]

inherit

	PS_QUERY [G]

	ITERABLE [TUPLE]

create
	make, make_with_criterion

feature -- Access

	new_cursor: ITERATION_CURSOR [TUPLE]
			-- Return a fresh cursor over the query result.
			-- | Note: The result is loaded lazily upon calling `{ITERATION_CURSOR}.forth'.
			-- | Note: The results are cached interanlly, thus it is possible to iterate over the result
			-- | many times without performance impact.
		do
			create {PS_ITERATION_CURSOR [TUPLE]} Result.make (Current)
		end

feature -- Status report

	is_object_query: BOOLEAN = False
			-- Is `Current' an instance of PS_OBJECT_QUERY?

feature -- Projections

	projection: ARRAY [STRING]
			-- Data to be included for projection. Defaults to all fields of basic types and string types.

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
				--reflection.dynamic_type_from_string (class_name))
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

	set_projection (a_projection: ARRAY [STRING])
			-- Set `a_projection' to the current query.
		do
			projection := a_projection
		ensure
			projected_data_set: projection = a_projection
		end

feature -- Utilities

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

--feature -- Cursor generation

--	new_cursor: PS_RESULT_CURSOR [TUPLE]
--			-- Return the result_cursor.
--		do
--			--TODO: according to class ITERABLE, this should return a fresh copy of the cursor.
--			Result := result_cursor
--		end

feature {NONE} -- Initialization

	make
			-- Create a query for all objects of type G (no filtering criteria).
		do
			create projection.make_empty
			initialize
			create projection.make_from_array (default_projection)
			projection.compare_objects
		ensure then
			projection_correctly_initialized: projection.is_deep_equal (old default_projection)
		end

	create_result_cursor
			-- Create a new result set.
		do
			create result_cursor.make
		end

feature {PS_EIFFELSTORE_EXPORT} -- Access

	result_cursor: PS_RESULT_CURSOR [TUPLE]
			-- Iteration cursor containing the result of the query.

end
