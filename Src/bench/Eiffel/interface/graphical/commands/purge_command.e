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
			if last_warner /= Void and argument = last_warner then
				confirmer (project_tool.text_window).call (Current, 
					"Think again%NAre you really sure ?", "OK");
			elseif last_confirmer /= Void and argument = last_confirmer then
				system.purge
			elseif workbench.successfull then
				warner (project_tool.text_window).call (Current,
					"Compress system%NIt could take quite a long%NGo on ?");
			else
				warner (project_tool.text_window).custom_call (Void,
						"A compilation must complete%N%
						%successfully before compressing", Void, Void, "OK");
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
