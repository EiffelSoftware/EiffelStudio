indexing

	description:
		"Abstract notion of a command to show or %
		%hide a portion of the debugger.";
	date: "$Date$";
	revision: "$Revision$"

deferred class DISPLAY_DEBUGGER_PORTION

inherit 

	PIXMAP_COMMAND
		rename
			init as make
		end

feature -- Properties

	is_shown: BOOLEAN
			-- Is Current shown?

feature -- Execution

	work (argument: ANY) is
			-- Execute Current.
		do
			if is_shown then
				hide
			else
				show
			end
		end;

	hide is
			-- Hide Current.
		require
			is_shown: is_shown
		deferred
		end;

	show is
			-- Show Current.
		require
			not_is_shown: not is_shown
		deferred
		end;

feature {NONE} -- Implementation

	update_visual_aspects is
			-- Update the button and menu entry from `holder'.
		do
			holder.associated_button.set_symbol (symbol);
			holder.associated_menu_entry.set_text (name)
		end;

end -- class DISPLAY_DEBUGGER_PORTION
