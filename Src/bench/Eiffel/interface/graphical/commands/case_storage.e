indexing

	description:	
		"Command for Case Storage"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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
			create Result
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
				create mp.set_watch_cursor;
				format_storage.execute;
				mp.restore
			end
		end;

feature {NONE} -- Implementation

	format_storage: E_STORE_CASE_INFO is
			-- Storage info
		once
			create Result.make (Error_window, Project_tool.progress_dialog);
		end
	
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

end -- class CASE_STORAGE
