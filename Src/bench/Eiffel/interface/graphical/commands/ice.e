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
			-- for now, purge system
			-- lengthy confirmation needed
		do
			if argument = warner then
				confirmer.set_window (text_window);
				confirmer.call (Current, "Think again%NAre you really sure ?");
			elseif argument = confirmer then
				system.purge
			elseif workbench.successfull then
					warner.set_window (text_window);
					warner.call (Current,"Purge system%NIt could take quite a long%N%
									%Go on ?");
			else
				warner.set_window (text_window);
				warner.custom_call (void ,"A compilation must complete%
						%succesfully before purge", void, void, "OK");
			end;
		end;
 
feature 

	symbol: PIXMAP is
			-- Empty symbol
		do
			Result := bm_default
		end;

	
feature {NONE}

	command_name: STRING is do Result := "Purge system" end
  
end
