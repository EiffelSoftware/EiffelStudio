indexing

	description:	
		"Ancestor of all tools in the workbench, providing %
					%dragging capabilities (transport)";
	date: "$Date$";
	revision: "$Revision$"

deferred class TOOL_W 

inherit

	NAMER;
	SHARED_TABS;
	SHARED_PIXMAPS;
	WINDOWS;
	INTERFACE_W;
	HOLE
		rename
			target as text_window
		export
			{ANY} receive
		end

feature -- Window Properties

	history: STONE_HISTORY;
			-- History list for Current.

	last_format: FORMATTER;
			-- Last format used.

	stone: STONE;
			-- Stone in tool

	stone_type: INTEGER is
			-- Stone type
		do
		end;

	text_window: TEXT_WINDOW;
			-- Text window attached to Current

	tool_name: STRING is 
			-- Name of the tool
		do
		end;

	realized: BOOLEAN is
			-- Is Current realized?
		deferred
		end;

	shown: BOOLEAN is
			-- Is Current shown on the screen?
		deferred
		end;

	title: STRING is
			-- The title of the window.
		deferred
		end;

	hole: EB_BUTTON_HOLE is
			-- Hole associated with Current.
			-- Void by default
		do
		end;

	save_cmd_holder: COMMAND_HOLDER is
			-- The command to save the contents of Current.
		do
		end;

	reset_stone is
			-- Reset the stone to Void.
		do
			stone := Void
		ensure
			stone = Void
		end;

feature -- Window Implementation

	display is
			-- Display tool.
		do
			if realized then
				if not shown then
					show
				else
					raise
				end
			else
				realize
			end
		end;

	realize is
			-- Realize Current.
		deferred
		end;

	show is
			-- Show Current on the screen.
		deferred
		end;

	raise is
			-- Raise Current to the top.
		deferred
		end;

	destroy is
			-- Destroy the window.
		deferred
		end;

	hide is
			-- Hide Current from the screen.
		deferred
		end

	close_windows is
			-- Close the related windows.
			-- Used for popping down.
		deferred
		end;

feature -- Window settings

	set_default_position is
			-- Set the position to its default.
		deferred
		end;

	set_default_size is
			-- Set the size to its default.
		deferred
		end;

	set_icon_name (s: STRING) is
			-- Set `s' to the name shown just below the icon.
		deferred
		end;

	set_default_format is
			-- Default format of windows.
		do
			-- Do nothing
		end;

	set_title (s: STRING) is
			-- Set `title' to `s'.
		deferred
		end;

feature {TEXT_WINDOW} -- Status setting

	set_stone (s: like stone) is
		require
			valid_stone_type: s /= Void implies s.stone_type = stone_type
		do
			stone := s;
			if s = Void then
				set_icon_name (tool_name);
			else
				set_icon_name (s.icon_name);
				if hole /= Void then
					hole.set_full_symbol
				end;
			end
		ensure
			set: s = stone
		end;

	set_last_format (f: like last_format) is
			-- Assign `f' to `last_format'.
		require
			format_exists: f /= Void
		do
			if last_format /= f then
				if not history.islast then
					history.extend (stone)
				end;
				if last_format /= Void then
					last_format.darken (False)
				end;
				last_format := f;
				last_format.darken (True)
			end
		ensure
			last_format = f
		end;

feature -- Update

	update_save_symbol is
			-- Update the save symbol in tool.
		do
			if save_cmd_holder /= Void then
				if text_window.changed then
					save_cmd_holder.associated_button.darken (true)
				else
					save_cmd_holder.associated_button.darken (false)
				end
			end
		end;

	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			synchronise_stone
		end;

	synchronise_stone is
			-- Synchronize the root stone of the window
			-- and the history's stones.
		local
			old_do_format: BOOLEAN
		do
			history.extend (stone);
			history.synchronize;
			if
				stone /= Void and then
				stone.synchronized_stone /= Void
			then
					-- The root stone is still valid.
				old_do_format := last_format.do_format;
				last_format.set_do_format (true);
				last_format.execute (history.item);
				last_format.set_do_format (old_do_format)
			else
					-- The root stone is not valid anymore.
				history.forth;
				check 
					history.after 
				end;
				set_default_format;
				text_window.set_cursor_position (0);
				text_window.clean;
				text_window.clear;
				text_window.display;
				text_window.set_changed (False);
				update_save_symbol;
				set_title (tool_name);
				if hole /= Void then
					hole.set_empty_symbol
				end;
			end
		end;

feature -- Pick and Throw Implementation

	reset is
			-- Reset the window contents.
		do
			set_title (tool_name);
			set_default_format;
			set_default_size;
			text_window.clear_window;
			close_windows;
			if hole /= Void then
				hole.set_empty_symbol
			end;
		end;

	unregister_holes is
			-- Unregister holes.
		do
			unregister;
		ensure
			current_unregistered: not registered
		end;

feature {NONE} -- Implementation

	raise_grabbed_popup is
			-- Raise popup windows with exclusive grab set.
		do
			if 
				last_warner /= Void and then 
				last_warner.is_popped_up and then
				last_warner.is_exclusive_grab 
			then
				last_warner.raise
			elseif 
				last_confirmer /= Void and then 
				last_confirmer.is_popped_up 
			then
				last_confirmer.raise
			elseif
				name_chooser.is_popped_up
			then
				name_chooser.raise
			else
				window_manager.class_win_mgr.raise_shell_popup
			end
		end;

invariant

	non_void_history: history /= Void

end -- class TOOL_W
