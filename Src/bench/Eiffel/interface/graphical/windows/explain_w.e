indexing

	description:	
		"Window describing an explanation";
	date: "$Date$";
	revision: "$Revision$"

class EXPLAIN_W 

inherit

	BAR_AND_TEXT
		redefine
			build_format_bar, build_text_windows,
			tool_name, hole, stone_type, 
			process_any, build_menus, hole_button
		end;
	BAR_AND_TEXT
		redefine
			build_format_bar, hole_button,build_text_windows,
			tool_name,  hole, stone_type, process_any, build_menus
		end;

creation

	make_shell

feature -- Properties

	stone_type: INTEGER is
			-- Accept any type stone
		do
			Result := Any_type
		end

feature -- Status setting

	process_any (s: like stone) is
			-- Set `s' to `stone'.
		do
			if s.is_valid then
				text_window.set_text (s.help_text);
				set_title (s.header);
				update_save_symbol
			end
		end;

feature -- Graphical Interface

	build_menus is
			-- Create the menus.
		do
			!! menu_bar.make (new_name, global_form);
			!! file_menu.make ("File", menu_bar);
			!! edit_menu.make ("Edit", menu_bar);
			!! preference_menu.make ("Preference", menu_bar);
			!! window_menu.make ("Windows", menu_bar);
			!! help_menu.make ("Help", menu_bar);
			menu_bar.set_help_button (help_menu.menu_button);
			fill_menus
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			showtext_cmd: SHOW_TEXT;
			showtext_button: EB_BUTTON
		do
			!! showtext_cmd.make (text_window);
			!! showtext_button.make (showtext_cmd, format_bar);
			!! showtext_frmt_holder.make_plain (showtext_cmd);
			showtext_frmt_holder.set_button (showtext_button);
			format_bar.attach_top (showtext_button, 0);
			format_bar.attach_left (showtext_button, 0);
		end;

	build_text_windows is
			-- Create `editable_text_window' different ways whether
			-- the tabulation mecanism is disable or not
		do
			if tabs_disabled then
				!SCROLLED_TEXT_WINDOW! text_window.make (new_name, Current)
			else
				!TABBED_TEXT_WINDOW! text_window.make (new_name, Current)
			end;
			set_mode_for_editing;
			set_tab_length_to_default
		end

feature -- Window Properties

	tool_name: STRING is
			-- Name of the tool represented by Current.
		do
			Result := l_Explain
		end;

feature {NONE} -- Attributes; Forms And Holes

	hole: EXPLAIN_CMD;
			-- Hole characterizing Current.

	hole_button: EXPLAIN_HOLE;
			-- Hole characterizing Current.

end -- class EXPLAIN_W
