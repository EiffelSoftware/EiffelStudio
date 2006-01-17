indexing

	description:	
		"Display the current execution status in the debug window."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class DEBUG_STATUS

inherit

	PIXMAP_COMMAND
		rename
			init as make
		end;
	SHARED_APPLICATION_EXECUTION

create

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
			if Project_tool.initialized then
				create st.make
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
					Debug_window.set_top_character_position (0)
					Debug_window.display
				end
			end
		end;

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

end -- class DEBUG_STATUS
