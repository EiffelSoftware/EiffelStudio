-- DC-set supermelted real body ids

class DLE_DEBUG_BODY_ID

inherit

	DLE_REAL_BODY_ID
		redefine
			counter
		end;

creation

	make

feature {NONE} -- Implementation
 
	counter: DLE_DEBUG_BODY_ID_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := System.execution_table.counter.dle_debug_subcounter
		end

end -- class DLE_DEBUG_BODY_ID
