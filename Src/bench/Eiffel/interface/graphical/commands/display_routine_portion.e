indexing

	description:
		"Command to show or hide the `ROUTINE_W' %
		%portion of the debugger.";
	date: "$Date$";
	revision: "$Revision$"

class DISPLAY_ROUTINE_PORTION

inherit
	DISPLAY_DEBUGGER_PORTION
		redefine
			update_visual_aspects
		end

creation
	make

feature -- Properties

	name: STRING is
			-- Short name for Current
		do
			if is_shown then
				Result := "Hide feature"
			else
				Result := "Show feature"
			end
		end;

	symbol: PIXMAP is
			-- Symbol to represent Current on a button
		do
			if is_shown then
				Result := bm_Hide_routine
			else
				Result := bm_Show_routine
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

feature {NONE} -- Implementation

	update_visual_aspects is
			-- Update the visual aspects.
		do
			holder.associated_button.set_pixmap (symbol);
			holder.associated_menu_entry.set_text (name)
		end;

end -- class DISPLAY_ROUTINE_PORTION
