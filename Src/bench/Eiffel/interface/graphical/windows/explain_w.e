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
			process_any, build_menus,
			update_boolean_resource,
			update_integer_resource
		end;
	BAR_AND_TEXT
		redefine
			build_format_bar, build_text_windows,
			tool_name,  hole, stone_type, process_any, build_menus,
			update_boolean_resource,
			update_integer_resource
		end;
	EB_CONSTANTS

creation

	make_shell

feature -- Resource Update

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
		local
			er: like Explain_tool_resources
		do
			er := Explain_tool_resources
			if old_res = er.command_bar then
				if new_res.actual_value then
					edit_bar.add
				else
					edit_bar.remove
				end
			elseif old_res = er.format_bar then
				if new_res.actual_value then
					format_bar.add
				else
					format_bar.remove
				end
			end;
			old_res.update_with (new_res)
		end;

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
			-- Update `old_res' with the value of `new_res',
			-- if the value of `new_res' is applicable.
			-- Also update the interface.
		local
			er: like Explain_tool_resources
		do
			er := Explain_tool_resources;
			if new_res.actual_value > 0 then
				if old_res = er.tool_height then
					if old_res.actual_value /= new_res.actual_value then
						set_height (new_res.actual_value)
					end
				elseif old_res = er.tool_width then
					if old_res.actual_value /= new_res.actual_value then
						set_width (new_res.actual_value)
					end
				end;
				old_res.update_with (new_res)
			end
		end

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
			showtext_button: FORMAT_BUTTON
		do
			!! showtext_cmd.make (text_window);
			!! showtext_button.make (showtext_cmd, format_bar);
			!! showtext_frmt_holder.make_plain (showtext_cmd);
			showtext_frmt_holder.set_button (showtext_button);
			format_bar.attach_top (showtext_button, 0);
			format_bar.attach_left (showtext_button, 0);

			if Explain_tool_resources.format_bar.actual_value = False then
				format_bar.remove
			end;

			if Explain_tool_resources.command_bar.actual_value = False then
				edit_bar.remove
			end;
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

			set_mode_for_editing
		end

feature -- Window Properties

	tool_name: STRING is
			-- Name of the tool represented by Current.
		do
			Result := l_Explain
		end;

feature {NONE} -- Attributes; Forms And Holes

	hole: EXPLAIN_HOLE;
			-- Hole characterizing Current.

end -- class EXPLAIN_W
