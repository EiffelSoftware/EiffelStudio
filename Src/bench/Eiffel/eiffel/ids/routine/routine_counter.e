-- System level routine id counter.

class ROUTINE_COUNTER

inherit
	COMPILER_COUNTER
		rename
			next_id as next_rout_id
		export
			{NONE} current_count, set_value, set_precompiled_offset,
			is_precompiled
		redefine
			make
		end

creation
	make

feature -- Initialization

	make is
			-- Create a new routine id counter.
		do
			create attribute_ids.make (1, Chunk)
			Precursor {COMPILER_COUNTER}
			invariant_rout_id := next_rout_id
			initialization_rout_id := next_rout_id
			dispose_rout_id := next_rout_id
		end

feature -- Access

	is_attribute (rout_id: INTEGER): BOOLEAN is
		do
			Result := rout_id <= attribute_ids.upper
			if Result then 
				Result := attribute_ids.item (rout_id)
			end
		end

	next_attr_id: INTEGER is
			-- Next attribute id
		do
			count := count + 1
			Result := count
			attribute_ids.force (True, Result)
		ensure
			id_not_void: Result /= 0
		end

	invariant_rout_id: INTEGER
	initialization_rout_id: INTEGER
	dispose_rout_id: INTEGER
            -- Predefined routine ids

feature {NONE} -- Implementation

	attribute_ids: ARRAY [BOOLEAN]
			-- Let us know which entries are attributes.

	Chunk: INTEGER is 500
			-- Size of an array chunk at beginning.

end -- class ROUTINE_COUNTER
