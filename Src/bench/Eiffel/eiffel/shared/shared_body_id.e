-- Constants for body ids of invariant and initialization routine

class SHARED_BODY_ID

inherit
	SHARED_WORKBENCH
	
feature {NONE}

	Invariant_body_id: BODY_ID is
		once
			Result := System.body_id_counter.invariant_body_id
		end

	Initialization_body_id: BODY_ID is
		once
			Result := System.body_id_counter.initialization_body_id
		end

	Dispose_body_id: BODY_ID is
		once
			Result := System.body_id_counter.dispose_body_id
		end

end -- class SHARED_BODY_ID
