indexing

	description:	
		"Display the current execution status in the debug window."
	date: "$Date$"
	revision: "$Revision$"

class EB_DEBUG_STATUS_CMD

inherit

	EB_TOOL_COMMAND

	SHARED_APPLICATION_EXECUTION

	NEW_EB_CONSTANTS

	EB_SHARED_INTERFACE_TOOLS

creation

	make

feature -- Properties

--	symbol: EV_PIXMAP is
--			-- Pixmap for the button.
--		once
--			Result := Pixmaps.bm_Debug_status
--		end

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

	execute (argument: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Display the status of the application, or "Not running" if
			-- the application is not running.
		local
			st: STRUCTURED_TEXT
			st_syst: STRUCTURED_TEXT
		do
			if Project_tool.initialized then
				create st.make
				if Application.is_running then
					Application.status.display_status (st)
					Debug_window.clear_window
					Debug_window.process_text (st)
--					Debug_window.set_top_character_position (0)
					Debug_window.display
				else
					st.add_string ("System not launched")
					st.add_new_line
					st_syst := debug_tool.structured_system_info 
					if st_syst /= Void then
						st.append (st_syst)
					end
					Debug_window.clear_window
					Debug_window.process_text (st)
--					Debug_window.set_top_character_position (0)
					Debug_window.display
				end
			end
		end

end -- class EB_DEBUG_STATUS_CMD
