-- Predefined routine ids.

class SHARED_ROUT_ID

inherit

	SHARED_WORKBENCH

feature {NONE}

	Invariant_rout_id: ROUTINE_ID is
		once
			Result := System.routine_id_counter.invariant_rout_id
		end;

	Initialization_rout_id: ROUTINE_ID is
		once
			Result := System.routine_id_counter.initialization_rout_id
		end;

	Dle_make_rout_id: ROUTINE_ID is
		once
			Result := System.routine_id_counter.dle_make_rout_id
		end;

	Dispose_rout_id: ROUTINE_ID is
		once
			Result := System.routine_id_counter.dispose_rout_id
		end;

end -- class SHARED_ROUT_ID
