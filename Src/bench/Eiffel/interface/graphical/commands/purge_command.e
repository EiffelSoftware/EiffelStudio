-- Temporary ice command

class PURGE_COMMAND 

inherit
 
	SHARED_WORKBENCH;
	COMMAND_W
		redefine
			execute
		end;
	PUSH_B
		rename
			make as push_b_make
		end
 
creation

	make
 
	
feature 

	make (c: COMPOSITE) is
		do 
			push_b_make ("Compress", c);
			add_activate_action (Current, Void)
		end; 
 
	
feature {NONE}

	execute (argument: ANY) is
		do
			work (argument)
		end;

	work (argument: ANY) is
			-- for now, purge system
			-- lengthy confirmation needed
		do
			if argument = warner then
				confirmer.call (Current, "Think again%NAre you really sure ?", "OK");
			elseif argument = confirmer then
				system.purge
			elseif workbench.successfull then
					warner.call (Current,"Compress system%NIt could take quite a long%N%
									%Go on ?");
			else
				warner.custom_call (void ,"A compilation must complete%N%
						%succesfully before compressing", void, void, "OK");
			end;
		end;
 
feature 

	symbol: PIXMAP is
			-- Empty symbol
		do
			Result := bm_default
		end;

	
feature {NONE}

	command_name: STRING is do Result := "Compress" end
  
end
