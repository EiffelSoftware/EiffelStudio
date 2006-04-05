indexing
	
	description:
		"Specific preference tool for EBench."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class EB_PREFERENCE_TOOL

inherit
	PREFERENCE_TOOL
		redefine
			display 
		end

	EB_CONSTANTS

	WINDOWS

	WINDOW_ATTRIBUTES

	SYSTEM_CONSTANTS


create
	make

feature -- Output

	display is
		local
			new_x, new_y: INTEGER;
			s: SCREEN;
			already_realized: BOOLEAN
		do
			already_realized := realized;
			if not General_resources.default_window_position.actual_value then
				s := screen;
				new_x := s.x;
				new_y := s.y;
				if new_x + width > s.width then
					new_x := s.width - width
				end;
				if new_x < 0 then
					new_x := 0
				end;
				if new_y + height > s.height then
					new_y := s.height - height
				end;
				if new_y < 0 then
					new_y := 0
				end;
			   	set_x_y (new_x, new_y)
			end;
			Precursor {PREFERENCE_TOOL}
			if not already_realized then
				set_title (Interface_names.t_Preference_tool);
				set_icon_name (Interface_names.t_Preference_tool);
				tooltip_realize
			end
		end;

feature {NONE} -- Initialization

	initialize_window is
			-- EBench specific initialization of the top shell.
		do
			set_title (Interface_names.n_X_resource_name);
				-- FIXME ** Need to add accelerators
			set_composite_attributes (Current);	
		end;

feature {NONE} -- Constants

	t_Tool_name: STRING is
		once
			if Platform_constants.is_windows then
					-- For windows we need the id for the Icon
				Result := Interface_names.i_Class_id.out
			else
					-- For unix we need this for the X resource file
				Result := Interface_names.n_X_resource_name
			end;
		end;

	m_File: STRING is
		once
			Result := Interface_names.m_File
		end;

	m_Category: STRING is
		once
			Result := Interface_names.m_Category
		end;

	m_Help: STRING is
		   -- Menu names
		once
			Result := Interface_names.f_Help
		end;

	b_Ok: STRING is
		once
			Result := Interface_names.b_Ok
		end;

	m_Ok: STRING is
		once
			Result := Interface_names.m_Ok
		end;

	b_Apply: STRING is
		once
			Result := Interface_names.b_Apply
		end;

	m_Apply: STRING is
		once
			Result := Interface_names.m_Apply
		end;

	b_Exit: STRING is
			-- Buttons names
		once
			Result := Interface_names.b_Exit
		end;

	f_Exit: STRING is
		once
			Result := Interface_names.f_Exit
		end;

	m_Exit: STRING is
		once
			Result := Interface_names.m_Exit
		end;

	m_Save: STRING is
		once
			Result := Interface_names.m_Save
		end;

	a_Save: STRING is
		once
			Result := Interface_names.a_Save
		end;

	m_Validate: STRING is
		once
			Result := Interface_names.m_Validate
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

end -- class EB_PREFERENCE_TOOL
