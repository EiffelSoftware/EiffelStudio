-- System level body id counter.

class BODY_ID_COUNTER

inherit

	COMPILER_COUNTER
		rename
			make as old_make
		redefine
			next_id, current_subcounter
		end

creation

	make

feature -- Initialization

	make is
			-- Create a new body id counter.
		do
			old_make;
			invariant_body_id := current_subcounter.next_id;
			initialization_body_id := current_subcounter.next_id;
			dispose_body_id := current_subcounter.next_id
		end

	new_subcounter (compilation_id: INTEGER): BODY_ID_SUBCOUNTER is
			-- New body id counter associated with `compilation_id'
		do
			if Compilation_modes.is_precompiling then
				!P_BODY_ID_SUBCOUNTER! Result.make (compilation_id)
			else
				!BODY_ID_SUBCOUNTER! Result.make
			end
		end

feature -- Access

	next_id: BODY_ID is
			-- Next body id
		do
			Result := current_subcounter.next_id
		end

	invariant_body_id: BODY_ID;
	initialization_body_id: BODY_ID;
	dispose_body_id: BODY_ID;
            -- Predefined body ids

feature {NONE} -- Implementation

	current_subcounter: BODY_ID_SUBCOUNTER;
			-- Current body id subcounter

end -- class BODY_ID_COUNTER
