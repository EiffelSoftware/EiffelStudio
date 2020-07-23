note
	description: "Summary description for {PERSON_STRUCT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON_STRUCT

inherit

	MEMORY_STRUCTURE

create
	make,
	make_by_pointer


feature -- Access

	id: INTEGER_32
		do
			Result := c_id (item)
		end

	name: C_STRING
		do
			create Result.make ("Unknown")
			if c_name (item) /= default_pointer then
				create Result.make_by_pointer (c_name (item))
			end
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes).
		external
			"C inline use <c2eiffel.h>"
		alias
			"sizeof (struct person)"
		end

	c_id (a_item: POINTER): INTEGER_32
		external
			"C inline use <c2eiffel.h>"
		alias
			"((struct person*)$a_item)->id"
		end

	c_name (a_item: POINTER): POINTER
		external
			"C inline use <c2eiffel.h>"
		alias
			"((struct person*)$a_item)->name"
		end
end
