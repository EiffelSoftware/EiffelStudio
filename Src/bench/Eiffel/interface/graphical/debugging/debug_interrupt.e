indexing

	description:	
		"Command to interrupt debugging."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create

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
					debug_window.put_new_line
					debug_window.put_string ("Interruption request")
					debug_window.put_new_line
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

	request: EWB_REQUEST;
			-- Request of some sort.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class DEBUG_QUIT
