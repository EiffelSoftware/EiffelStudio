-- Execution unit for a replicated feature

class REP_EXECUTION_UNIT 

inherit

	EXECUTION_UNIT
		redefine
			server_has
		end;

creation

	make
		
feature 

	server_has: BOOLEAN is
		do
			Result := Rep_feat_server.has (body_id);			
		end;

end
