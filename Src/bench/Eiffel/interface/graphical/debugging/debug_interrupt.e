indexing

	description:	
		"Command to interrupt debugging."
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_INTERRUPT 

inherit

	PIXMAP_COMMAND
	IPC_SHARED
	SHARED_APPLICATION_EXECUTION
	E_CMD
		rename execute as termination_processing
		end

creation

	make 

feature -- Initialization

	make (a_tool: TOOL_W) is
			-- Initialize the command.
		do
			init (a_tool)
		end

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Debug_interrupt 
		end
 
	termination_processing is
			-- Print the termination message to the debug_window
			-- and reset the object windows.
		do
			io.put_string("DEBUG_INTERRUPT: Error...%N")
		end

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Continue execution.
		local
			status: APPLICATION_STATUS
		do
			status := Application.status
			if status /= Void then
				if not status.is_stopped then
						-- Ask the application to interrupt ASAP.
					debug_window.clear_window
					debug_window.put_string ("System is running")
					debug_window.new_line
					debug_window.put_string ("Interruption request")
					debug_window.new_line
					debug_window.display
					Application.interrupt
				end
			end
		end

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Debug_interrupt
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Debug_interrupt
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Debug_interrupt
		end

	request: EWB_REQUEST
			-- Request of some sort.

end -- class DEBUG_QUIT
