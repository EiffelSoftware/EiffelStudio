indexing

	description:
		"Command to show or hide the `OBJECT_W' %
		%portion of the debugger.";
	date: "$Date$";
	revision: "$Revision$"

class DISPLAY_OBJECT_PORTION

inherit
	DISPLAY_DEBUGGER_PORTION

creation
	make


feature -- Properties

	name: STRING is
			-- Short name for Current
		do
			if is_shown then
				Result := "Hide object"
			else
				Result := "Show object"
			end
		end;

	symbol: PIXMAP is
			-- Pixmap to represent Current on a button
		do
			if is_shown then
				Result := bm_Hide_object
			else
				Result := bm_Show_object
			end
		end;

feature -- Execution

	hide is
			-- Hide Current.
		do
			is_shown := False;
			Project_tool.hide_object_portion;
			update_visual_aspects;
		end;

	show is
			-- Show Current.
		do
			is_shown := True;
			Project_tool.show_object_portion;
			update_visual_aspects
		end;

end -- class DISPLAY_OBJECT_PORTION
