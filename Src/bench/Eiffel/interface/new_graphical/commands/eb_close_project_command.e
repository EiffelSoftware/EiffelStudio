indexing
	description: "Command to quit the Eiffel workbench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLOSE_PROJECT_CMD

inherit
	GRAPHICS
	PROJECT_CONTEXT
	SHARED_APPLICATION_EXECUTION
	PIXMAP_COMMAND
		rename
			init as make
		redefine
			license_checked
		end
	WARNER_CALLBACKS
		rename
			execute_warner_help as exit_anyway,
			execute_warner_ok as do_not_exit
		end

create
	make
	
feature -- Callbacks

	exit_anyway is
		local
			mp: MOUSE_PTR
		do
			if Application.is_running then
				Application.kill
			end
			discard_licenses

			if Project_tool.initialized then
				Project_tool.save_environment
			end
			exit
		end

	do_not_exit (argument: ANY) is
		do
			do_exit := false
		end

feature -- License managment
	
	license_checked: BOOLEAN is True
			-- Is the license checked.

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Quit 
		end
	
feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Quit project after saving.
		do
			if Project_tool.initialized then
				-- Project_file is not void
				if do_exit or else (last_confirmer /= Void and then argument = last_confirmer) then
					exit_anyway
				elseif
					window_manager.class_win_mgr.changed or else
					(is_system_tool_created and then system_tool.changed)
				then
					do_exit := True
					warner (popup_parent).custom_call (Current,
						"Some files have not been saved.",
						"Don't exit", "Exit anyway", Void)
				else
					confirmer (popup_parent).call (Current, 
						"Quit "+Interface_names.EiffelBench_name+"?", "Exit")
				end
			else
				if do_exit or else (last_confirmer /= Void and then argument = last_confirmer) then
					exit_anyway
				else
					confirmer (popup_parent).call (Current, 
						"Quit "+Interface_names.EiffelBench_name+"?", "Exit")
				end
			end
		end

feature {NONE} -- Attributes

	do_exit: BOOLEAN
			-- Should be called: `must_exit' OR comment has to change
			-- Do we really have to exit?

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Exit_project
		end
 
	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Exit_project
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

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

end -- class EB_CLOSE_PROJECT_CMD
