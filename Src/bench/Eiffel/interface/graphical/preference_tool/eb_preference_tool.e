indexing
	
	description:
		"Specific preference tool for EBench.";
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


creation
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
			{PREFERENCE_TOOL} Precursor
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

end -- class EB_PREFERENCE_TOOL
