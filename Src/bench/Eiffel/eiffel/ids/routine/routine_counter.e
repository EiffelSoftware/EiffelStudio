-- System level routine id counter.

class ROUTINE_COUNTER

inherit

	COMPILER_COUNTER [ROUTINE_ID]
		rename
			make as old_make,
			next_id as next_rout_id
		redefine
			current_subcounter
		end;

	COMPILER_COUNTER [ROUTINE_ID]
		rename
			next_id as next_rout_id
		redefine
			make, current_subcounter
		select
			make
		end

creation

	make

feature -- Initialization

	make is
			-- Create a new routine id counter.
		do
			old_make;
			invariant_rout_id := current_subcounter.next_rout_id;
			initialization_rout_id := current_subcounter.next_rout_id;
			dle_make_rout_id := current_subcounter.next_rout_id;
			dispose_rout_id := current_subcounter.next_rout_id
		end

	new_subcounter (compilation_id: INTEGER): ROUTINE_SUBCOUNTER is
			-- New routine id counter associated with `compilation_id'
		do
			if Compilation_modes.is_precompiling then
				!P_ROUTINE_SUBCOUNTER! Result.make (compilation_id)
			elseif Compilation_modes.is_extending then
				!P_ROUTINE_SUBCOUNTER! Result.make (compilation_id)
			else
				!ROUTINE_SUBCOUNTER! Result.make
			end
		end

feature -- Access

	next_attr_id: ATTRIBUTE_ID is
			-- Next attribute id
		do
			Result := current_subcounter.next_attr_id
		ensure
			id_not_void: Result /= Void
		end

	invariant_rout_id: ROUTINE_ID;
	initialization_rout_id: ROUTINE_ID;
	dle_make_rout_id: ROUTINE_ID;
	dispose_rout_id: ROUTINE_ID;
            -- Predefined routine ids

feature {NONE} -- Implementation

	current_subcounter: ROUTINE_SUBCOUNTER;
			-- Current routine id subcounter

end -- class ROUTINE_COUNTER
