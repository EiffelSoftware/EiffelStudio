-- Counter associated with a DC-set.

deferred class DLE_COMPILER_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER

feature -- Access

	next_id: DLE_COMPILER_ID is
			-- Next id
		deferred
		end

end -- class DLE_COMPILER_SUBCOUNTER
