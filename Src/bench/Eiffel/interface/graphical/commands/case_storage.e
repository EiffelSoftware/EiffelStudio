indexing

	description:	
		"Command for Case Storage";
	date: "$Date$";
	revision: "$Revision$"

class CASE_STORAGE 

inherit

	EB_CONSTANTS;
	ISE_COMMAND;
	WINDOWS
	SHARED_LICENSE

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
			mp: MOUSE_PTR
		do
			if project_tool.initialized then
				if license.demo_mode then
					license.get_license
				end
				!! mp.set_watch_cursor;
				format_storage.execute;
				mp.restore
			end
		end;

feature {NONE} -- Implementation

	format_storage: E_STORE_CASE_INFO is
			-- Storage info
		once
			!! Result.make (Error_window, Project_tool.progress_dialog);
		end
	
end -- class CASE_STORAGE
