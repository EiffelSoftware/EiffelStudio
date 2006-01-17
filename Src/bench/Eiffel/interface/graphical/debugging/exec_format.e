indexing

	description:	
		"Set execution format."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EXEC_FORMAT

inherit
	PIXMAP_COMMAND
		rename
			init as make
		redefine
			execute, tool
		end
	
	EXEC_MODES

	SHARED_APPLICATION_EXECUTION

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command.
		do
			if last_warner /= Void then
				last_warner.popdown
			end;
			work (Void);
		end;

feature -- Formatting

	work (argument: ANY) is
			-- Set the execution format to `stone'.
		do
			Application.set_execution_mode (execution_mode)
			tool.debug_run_hole_holder.associated_command.execute (Current)
		end;

feature -- Properties

	tool: PROJECT_W;
			-- Project tool

feature {NONE} -- Attributes

	execution_mode: INTEGER is
			-- Mode of execution.
		deferred
		end;

	display_info (s: STONE) is
			-- Useless here.
		do
			-- Do Nothing
		end;

	title_part: STRING is
			-- Part of the title of the window.
		do
			Result := ""
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

end -- class EXEC_FORMAT
