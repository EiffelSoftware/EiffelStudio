indexing

	description:	
		"Command for Case Storage";
	date: "$Date$";
	revision: "$Revision$"

class CASE_STORAGE 

inherit

	PIXMAP_COMMAND
		rename
			init as make
		end;

creation

	make
	
feature -- Properties

	control_click: ANY is
			-- No confirmation required, used in work
		once
			!!Result
		end;

feature {NONE} -- Attributes

	symbol: PIXMAP is 
			-- Symbol on the button.
		once 
			Result := bm_Case_storage 
		end;
 
	name: STRING is
			-- Internal command name.
		do
			Result := l_Case_storage
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Execute the command.
		local
			format_storage: E_STORE_CASE_INFO;
			mp: MOUSE_PTR
		do
			if 
				argument = control_click or
				(last_confirmer /= Void and argument = last_confirmer)
			then
				!! mp.set_watch_cursor;
				!! format_storage.make_with_window (Error_window);
				format_storage.execute;
				mp.restore
			else
				confirmer (popup_parent).call (Current,
					"This command requires exploring the entire%N%
					%system and may take a long time...",
					"Continue")
			end
		end;
	
end -- class CASE_STORAGE
