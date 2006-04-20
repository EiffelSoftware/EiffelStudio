indexing

	description:	
		"Command to print a text window"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class PRINT_COMMAND 

inherit

	TOOL_COMMAND
		rename
			init as make
		end

create
	make

feature -- Access

	print_window: PRINT_DIALOG;	
			-- Print dialog

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Print
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Print
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

feature -- Execution

	work (argument: ANY) is
			-- Popup the print dialog.
		do
			if Project_tool.initialized then
				if print_window = Void then
					create print_window;
				end;
				print_window.popup (Current)
			end
		end;

feature -- Close window

	close_print_window is
			-- Close the print window.
		do
			if print_window /= Void then
				print_window.close
			end
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class PRINT_COMMAND
