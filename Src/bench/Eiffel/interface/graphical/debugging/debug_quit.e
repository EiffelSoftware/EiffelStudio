class DEBUG_QUIT 

inherit

	ICONED_COMMAND;
	IPC_SHARED

creation

	make

feature 

	make (c: COMPOSITE; a_text_window: ROUTINE_TEXT) is
		do
			init (c, a_text_window);
			!!request.make (Rqst_quit)
		end;
	
feature {NONE}

	work (argument: ANY) is
			-- Continue execution.
		do
			request.send
		end;

	
feature 

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Debug_quit) 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Debug_quit end;

	request: EWB_REQUEST;

end
