indexing

	description:	
		"Display the current execution status in the debug window.";
	date: "$Date$";
	revision: "$Revision$"

class DEBUG_STATUS

inherit

	PIXMAP_COMMAND
		rename
			init as make
		end;
	SHARED_APPLICATION_EXECUTION

creation

	make

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := Pixmaps.bm_Debug_status
		end

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Debug_status
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Debug_status
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Display the status of the application, or "Not running" if
			-- the application is not running.
		local
			st: STRUCTURED_TEXT
			st_syst: STRUCTURED_TEXT
		do
			!! st.make
			if Application.is_running then
				Application.status.display_status (st)
				Debug_window.clear_window
				Debug_window.process_text (st)
				Debug_window.set_top_character_position (0)
				Debug_window.display
			else
				st.add_string ("System not launched")
				st.add_new_line
				st_syst := project_tool.structured_system_info 
				if st_syst /= Void then
					st.append (st_syst)
				end
				Debug_window.clear_window
				Debug_window.process_text (st)
				Debug_window.display
			end
		end;

end -- class DEBUG_STATUS
