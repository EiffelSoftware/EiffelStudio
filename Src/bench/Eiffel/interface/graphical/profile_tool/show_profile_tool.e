indexing

	description:
		"Command to show the profile tool."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_PROFILE_TOOL

inherit

	EB_CONSTANTS;
	ISE_COMMAND;
	WINDOWS

feature {NONE} -- Execution

	work (arg: ANY) is
		local
			mp: MOUSE_PTR;
			p_tool: like profile_tool
		do
			if Project_tool.initialized then
				create mp.set_watch_cursor;
				if profile_tool = Void then
					create p_tool.make (Current);
					profile_tool_cell.put (p_tool);
				end;	
				profile_tool.display;
				mp.restore
			end
		end

feature -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Profile_tool
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Profile_tool
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

feature {PROFILE_TOOL} -- Implementation

	done_profiling is
			-- The profile has been closed.
		do
			profile_tool.hide;
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

end -- class SHOW_PROFILE_TOOL
