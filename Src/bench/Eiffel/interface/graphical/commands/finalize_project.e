-- Command to finalize the Eiffel

class FINALIZE_PROJECT 

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
			-- Finalize the project.
		do
--			System.pass4
		end;
	
feature 

	symbol: PIXMAP is 
		once 
			!!Result.make;
			Result.read_from_file (bm_Finalize)
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Finalize end
 
end
