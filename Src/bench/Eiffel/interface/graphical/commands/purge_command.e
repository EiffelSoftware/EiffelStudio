indexing

	description:	
		"Temporary ice command.";
	date: "$Date$";
	revision: "$Revision$"

class PURGE_COMMAND 

inherit
 
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
 
	
feature -- Initialization

	make (c: COMPOSITE) is
			-- Initialize the command.
		do 
			push_b_make ("Compress", c);
			add_activate_action (Current, Void)
		end; 
 
feature -- Properties

	symbol: PIXMAP is
			-- Empty symbol
		do
			Result := Pixmaps.bm_default
		end;

feature {NONE} -- Execution

	execute (argument: ANY) is
			-- Execute the command.
		do
			work (argument)
		end;

	work (argument: ANY) is
			-- for now, purge system
			-- lengthy confirmation needed
		do
			if last_warner /= Void and argument = last_warner then
				confirmer (Project_tool).call (Current, 
					"Think again%NAre you really sure ?", "OK");
			elseif last_confirmer /= Void and argument = last_confirmer then
				system.purge
			elseif workbench.successfull then
				warner (popup_parent).call (Current,
					"Compress system%NIt could take quite a long%NGo on ?");
			else
				warner (popup_parent).custom_call (Void,
						"A compilation must complete%N%
						%successfully before compressing", Void, Void, "OK");
			end;
		end;

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := "Compress"
		end

end -- class PURGE_COMMAND
