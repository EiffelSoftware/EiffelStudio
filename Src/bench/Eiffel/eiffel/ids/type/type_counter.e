-- System level static type counter.

class TYPE_COUNTER

inherit

	COMPILER_COUNTER
		redefine
			next_id, current_subcounter
		end

creation

	make

feature -- Initialization

	new_subcounter (compilation_id: INTEGER): TYPE_SUBCOUNTER is
			-- New static type id counter associated with `compilation_id'
		do
			if Compilation_modes.is_precompiling then
				!P_TYPE_SUBCOUNTER! Result.make (compilation_id)
			elseif Compilation_modes.is_extending then
				!DLE_TYPE_SUBCOUNTER! Result.make
			else
				!TYPE_SUBCOUNTER! Result.make
			end
		end

feature -- Access

	next_id: TYPE_ID is
			-- Next static type id
		do
			Result := current_subcounter.next_id
		end

feature {NONE} -- Implementation

	current_subcounter: TYPE_SUBCOUNTER;
			-- Current static type id subcounter

end -- class TYPE_COUNTER
