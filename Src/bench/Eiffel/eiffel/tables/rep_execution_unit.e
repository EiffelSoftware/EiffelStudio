-- Execution unit for a replicated feature

class REP_EXECUTION_UNIT 

inherit

	EXECUTION_UNIT
		redefine
			has_replicated_body
		end;

creation

	make
		
feature 

	has_replicated_body: BOOLEAN is
		do
			Result := Rep_feat_server.has (body_id);			
		end;

end
