indexing
	description: "Window describing an explanation"
	date: "$Date$"
	revision: "$Revision$"

class EXPLAIN_W 

inherit
	BAR_AND_TEXT
		rename
			Explain_resources as resources,
			edit_bar as explain_toolbar,
			Any_type as stone_type
		redefine
			build_format_bar, create_toolbar,
			tool_name, hole, 
			process_any, build_menus,
			build_toolbar_menu,
			close, set_title, help_index, icon_id
		end

creation
	make

feature -- Properties

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

	create_toolbar (a_parent: COMPOSITE) is
			-- Create a toolbar_parent with parent `a_parent'.
		local
			sep: THREE_D_SEPARATOR
		do
			!! toolbar_parent.make (new_name, a_parent)
			!! sep.make (Interface_names.t_Empty, toolbar_parent)
			toolbar_parent.set_column_layout
			toolbar_parent.set_free_size	
			toolbar_parent.set_margin_height (0)
			toolbar_parent.set_spacing (1)
			!! explain_toolbar.make (Interface_names.n_Tool_bar_name, toolbar_parent)
			if not Platform_constants.is_windows then
				!! sep.make (Interface_names.t_Empty, toolbar_parent)
			else
				explain_toolbar.set_height (22)
			end
		end

	build_menus is
			-- Create the menus.
		do
			!! menu_bar.make (new_name, global_form)
			!! file_menu.make (Interface_names.m_File, menu_bar)
			!! edit_menu.make (Interface_names.m_Edit, menu_bar)
			!! special_menu.make (Interface_names.m_Special, menu_bar)
			!! window_menu.make (Interface_names.m_window, menu_bar)
			build_help_menu
			fill_menus
		end

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			showtext_cmd: SHOW_HTML_TEXT;
		do
			!! showtext_cmd.make (Current)
			!! showtext_frmt_holder.make_plain (showtext_cmd)

			if resources.command_bar.actual_value = False then
				explain_toolbar.remove
			end
		end

	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
			toolbar_t: TOGGLE_B
		do
			!! toolbar_t.make (explain_toolbar.identifier, special_menu)
			explain_toolbar.init_toggle (toolbar_t)
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
