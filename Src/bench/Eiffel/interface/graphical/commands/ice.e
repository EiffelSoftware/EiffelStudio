indexing

	description:	
		"Temporary ice command.";
	date: "$Date$";
	revision: "$Revision$"

class ICE 

inherit
 
	ICONED_COMMAND
 
creation

	make
 
	
feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
			-- Initialize the command.
		do 
			init (c, a_text_window)
		end; 
 
feature  -- Properties

	symbol: PIXMAP is
			-- Empty symbol
		do
			Result := bm_default
		end;
	
feature {NONE} -- Implementation

	work (argument: ANY) is
			-- for now, purge system
			-- lengthy confirmation needed
		do
			if last_warner /= Void and argument = last_warner then
				confirmer (text_window).call (Current, 
					"Think again%NAre you really sure ?");
			elseif last_confirmer /= Void and argument = last_confirmer then
				system.purge
			elseif workbench.successfull then
					warner (text_window).call (Current,
						"Purge system%NIt could take quite a long%NGo on ?");
			else
				warner (text_window).custom_call (void ,
						"A compilation must complete%
						%successfully before purge", void, void, "OK");
			end;
		end;

feature {NONE} -- Attrbitues

	command_name: STRING is
			-- Name of the command.
		do
			Result := "Purge system"
		end
  
end -- class ICE
