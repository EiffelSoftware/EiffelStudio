-- Temporary ice command

class ICE 

inherit
 
	SHARED_WORKBENCH;
	ICONED_COMMAND
 
creation

	make
 
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do 
			init (c, a_text_window)
		end; 
 
	
feature {NONE}

	work (argument: ANY) is
			-- Useless 
		do
		end;
 
feature 

	symbol: PIXMAP is
			-- Empty symbol
		do
			!!Result.make;
			Result.read_from_file (bm_default)
		end;

	
feature {NONE}

	command_name: STRING is do Result := "" end
  
end
