-- Supermelted real body ids.

class DEBUG_BODY_ID

inherit

	REAL_BODY_ID
		redefine
			counter
		end

creation

	make

feature {NONE} -- Implementation

	counter: DEBUG_BODY_ID_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := System.execution_table.counter.debug_subcounter
		end

end -- class DEBUG_BODY_ID
