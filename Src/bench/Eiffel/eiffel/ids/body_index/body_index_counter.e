-- System level body index counter.

class BODY_INDEX_COUNTER

inherit
	COMPILER_COUNTER
		rename
			make as old_make
		end

creation
	make

feature -- Initialization

	make is
			-- Create a new body id counter.
		do
			old_make
			invariant_body_index := next_id
			initialization_body_index := next_id
			dispose_body_index := next_id
		end

feature -- Access

	invariant_body_index: INTEGER
	initialization_body_index: INTEGER
	dispose_body_index: INTEGER
            -- Predefined body indexes

end -- class BODY_INDEX_COUNTER
