-- Constants for body_indexes of invariant and initialization routine

class SHARED_BODY_ID

inherit
	SHARED_WORKBENCH
	
feature {NONE}

	Invariant_body_index: INTEGER is
		once
			Result := System.body_index_counter.invariant_body_index
		end

	Initialization_body_index: INTEGER is
		once
			Result := System.body_index_counter.initialization_body_index
		end

end -- class SHARED_BODY_ID
