indexing

	description:
		"Command to show or hide the `ROUTINE_W' %
		%portion of the debugger.";
	date: "$Date$";
	revision: "$Revision$"

class DISPLAY_ROUTINE_PORTION

inherit
	DISPLAY_DEBUGGER_PORTION

creation
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

end -- class DISPLAY_ROUTINE_PORTION
