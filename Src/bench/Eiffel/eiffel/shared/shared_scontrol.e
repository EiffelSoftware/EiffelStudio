class SHARED_SCONTROL

inherit
	
	SHARED_WORKBENCH

feature

	Server_controler: SERVER_CONTROL is
			-- Server controller
		once
			Result := System.server_controler
		end;

end
