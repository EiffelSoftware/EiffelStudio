indexing

	description: 
		""
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EDIT_OPERATIONS

inherit

	TOOL_COMMAND;
	SYSTEM_CONSTANTS

create
	make_paste, 
	make_copy, 
	make_cut

feature {NONE} -- Initialization

	make_paste (a_tool: like tool) is
			-- Initialize command for paste operation.
		do
			edit_type := paste_type;
			tool := a_tool
		end;	

	make_cut (a_tool: like tool) is
			-- Initialize command for cut operation.
		do
			edit_type := cut_type;
			tool := a_tool
		end;	

	make_copy (a_tool: like tool) is
			-- Initialize command for copy operation.
		do
			edit_type := copy_type;
			tool := a_tool
		end;	

	name: STRING is
			-- Name of editor operations
		do
			inspect
				edit_type
			when copy_type then
				Result := Interface_names.f_copy
			when cut_type then
				Result := Interface_names.f_cut
			when paste_type then
				Result := Interface_names.f_paste
			end
		end;

	menu_name: STRING is
			-- Name used in menu entry
		local
			is_win: BOOLEAN
		do
			is_win := Platform_constants.is_windows;
				-- Use the default accelerator
			if is_win then
				inspect
					edit_type
				when copy_type then
					Result := Interface_names.m_Windows_copy
				when cut_type then
					Result := Interface_names.m_Windows_cut
				when paste_type then
					Result := Interface_names.m_Windows_paste
				end
			else
				inspect
					edit_type
				when copy_type then
					Result := Interface_names.m_Unix_copy
				when cut_type then
					Result := Interface_names.m_Unix_cut
				when paste_type then
					Result := Interface_names.m_Unix_paste
				end
			end
		end;

	accelerator: STRING is
		do
		end

feature -- Execution

	work (argument: ANY) is
			-- Perform edit operations.
		do
			inspect
				edit_type
			when copy_type then
				text_window.copy_text
			when cut_type then
				text_window.cut_text
			when paste_type then
				text_window.paste_text
			end
		end;

feature {NONE} -- Implementation

	edit_type: INTEGER;

	copy_type, paste_type, cut_type: INTEGER is unique;

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

end -- class EDIT_OPERATIONS
