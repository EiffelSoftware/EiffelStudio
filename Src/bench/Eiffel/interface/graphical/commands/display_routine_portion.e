indexing

	description:
		"Command to show or hide the `ROUTINE_W' %
		%portion of the debugger."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class DISPLAY_ROUTINE_PORTION

inherit
	DISPLAY_DEBUGGER_PORTION

create
	make

feature -- Properties

	name: STRING is
			-- Short name for Current
		do
			if is_shown then
				Result := Interface_names.f_Hide_feature
			else
				Result := Interface_names.f_Show_feature
			end
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			if is_shown then
				Result := Interface_names.m_Hide_feature
			else
				Result := Interface_names.m_Show_feature
			end
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	symbol: PIXMAP is
			-- Symbol to represent Current on a button
		do
			if is_shown then
				Result := Pixmaps.bm_Hide_routine
			else
				Result := Pixmaps.bm_Show_routine
			end
		end;

feature -- Execution

	hide is
			-- Hide Current.
		do
			is_shown := False;
			Project_tool.hide_feature_portion;
			update_visual_aspects
		end;

	show is
			-- Show Current
		do
			is_shown := True;
			Project_tool.show_feature_portion;
			update_visual_aspects
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

end -- class DISPLAY_ROUTINE_PORTION
