indexing
	description: "Window describing an explanation"
	date: "$Date$"
	revision: "$Revision$"

class EXPLAIN_W 

inherit
	BAR_AND_TEXT
		rename
			Explain_resources as resources
		redefine
			build_format_bar,
			tool_name, hole, stone_type, 
			process_any, build_menus,
			build_toolbar_menu,
			close, set_title, help_index, icon_id
		end

creation
	make

feature -- Properties

	stone_type: INTEGER is
			-- Accept any type stone
		do
			Result := Any_type
		end

	help_index: INTEGER is 5

	icon_id: INTEGER is
			-- Icon id of Current window (only for windows)
		do
			Result := Interface_names.i_Explain_id
		end

feature -- Status setting

	set_title (s: STRING) is
			-- Set `title' to `s'.
		do
			if is_a_shell then
				eb_shell.set_title (s)
				Project_tool.change_explain_entry (Current)
			end
		end

	process_any (s: like stone) is
			-- Set `s' to `stone'.
		local
			l: LINKED_LIST [STRING]
		do
			if s.is_valid then
				text_window.clear_window
				l := s.help_text
				from
					l.start
				until
					l.after
				loop
					text_window.put_string (l.item)
					text_window.new_line
					l.forth
				end
				text_window.display
				set_title (s.header)
				update_save_symbol
			end
		end

feature -- Graphical Interface

	build_menus is
			-- Create the menus.
		do
			!! menu_bar.make (new_name, global_form)
			!! file_menu.make (Interface_names.m_File, menu_bar)
			!! edit_menu.make (Interface_names.m_Edit, menu_bar)
			!! special_menu.make (Interface_names.m_Special, menu_bar)
			!! window_menu.make (Interface_names.m_Windows, menu_bar)
			build_help_menu
			fill_menus
		end

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			showtext_cmd: SHOW_HTML_TEXT
			showtext_button: FORMAT_BUTTON
		do
			!! showtext_cmd.make (Current)
			!! showtext_button.make (showtext_cmd, format_bar)
			!! showtext_frmt_holder.make_plain (showtext_cmd)
			showtext_frmt_holder.set_button (showtext_button)
			format_bar.attach_top (showtext_button, 0)
			format_bar.attach_left (showtext_button, 0)

			if resources.format_bar.actual_value = False then
				format_bar.remove
			end

			if resources.command_bar.actual_value = False then
				edit_bar.remove
			end
		end

	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
			toolbar_t: TOGGLE_B
		do
			!! toolbar_t.make (edit_bar.identifier, special_menu)
			edit_bar.init_toggle (toolbar_t)
			!! toolbar_t.make (format_bar.identifier, special_menu)
			format_bar.init_toggle (toolbar_t)
		end

	close is
			-- Close Current
		do
			Project_tool.remove_explain_entry (Current)
			hide
			reset
		end

feature -- Window Properties

	tool_name: STRING is
			-- Name of the tool represented by Current.
		do
			Result := Interface_names.t_Empty_explain
		end

feature {NONE} -- Attributes Forms And Holes

	hole: EXPLAIN_HOLE
			-- Hole characterizing Current.

end -- class EXPLAIN_W
