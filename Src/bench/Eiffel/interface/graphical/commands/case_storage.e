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
			Result := Pixmaps.bm_Case_storage 
		end;
 
	name: STRING is
			-- Internal command name.
		do
			Result := Interface_names.f_Case_storage
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Case_storage
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Execute the command.
		local
			format_storage: E_STORE_CASE_INFO;
			mp: MOUSE_PTR
		do
			!! mp.set_watch_cursor;
			!! format_storage.make_with_window (Error_window);
			format_storage.execute;
			mp.restore
		end;
	
end -- class CASE_STORAGE
