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
		redefine
			make
		end


feature

	make (a_tool: like tool) is
			-- Initialize a command with the `symbol' icon,
			-- `a_tool' is passed as argument to the activation action.
		do
			tool := a_tool
			is_shown := False
--			is_shown := True
		end

feature -- Properties

	is_shown: BOOLEAN
			-- Is Current shown?

	holder: EB_HOLDER;
			-- Holder

feature -- Element change

	set_holder (h: like holder) is
			-- Set `holder' to `h'.
		do
			holder := h
		end;

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
