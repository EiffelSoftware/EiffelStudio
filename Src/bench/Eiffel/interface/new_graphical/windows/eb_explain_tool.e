indexing
	description: "Explain Tool. This class is not maintained%
		%anymore. the Help tool will replace it."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPLAIN_TOOL

obsolete 
	"To be replaced by the help tool"

inherit
	EB_TEXT_TOOL
		rename
			toolbar as explain_toolbar
--			Any_type as stone_type
		redefine
			default_name
-- hole, 
--			process_any, build_menus,
--			build_toolbar_menu,
		end

	EB_EXPLAIN_TOOL_DATA

creation
	make

feature -- Status setting

	process_any (s: like stone) is
			-- Set `s' to `stone'.
		local
			l: LINKED_LIST [STRING]
		do
			if s.is_valid then
				text_area.clear_window
				l := s.help_text
				from
					l.start
				until
					l.after
				loop
					text_area.put_string (l.item)
					text_area.new_line
					l.forth
				end
				text_area.display
				set_title (s.header)
			end
		end

feature -- Graphical Interface

--	create_toolbar (a_parent: EV_CONTAINER) is
--			-- Create a toolbar_parent with parent `a_parent'.
--		local
--			sep: THREE_D_SEPARATOR
--		do
--			create toolbar_parent.make (new_name, a_parent)
--			create sep.make (Interface_names.t_Empty, toolbar_parent)
--			toolbar_parent.set_column_layout
--			toolbar_parent.set_free_size	
--			toolbar_parent.set_margin_height (0)
--			toolbar_parent.set_spacing (1)
--			create explain_toolbar.make (Interface_names.n_Tool_bar_name, toolbar_parent)
--			if not Platform_constants.is_windows then
--				create sep.make (Interface_names.t_Empty, toolbar_parent)
--			else
--				explain_toolbar.set_height (22)
--			end
--		end

	build_menus is
			-- Create the menus.
		do
--			create menu_bar.make (new_name, global_form)
--			create file_menu.make (Interface_names.m_File, menu_bar)
--			create edit_menu.make (Interface_names.m_Edit, menu_bar)
--			create special_menu.make (Interface_names.m_Special, menu_bar)
--			create window_menu.make (Interface_names.m_Windows, menu_bar)
--			build_help_menu
--			fill_menus
		end

	build_toolbar (a_toolbar: EV_BOX) is
			-- Build formatting buttons in `format_bar'.
		local
--			showtext_cmd: SHOW_HTML_TEXT;
		do
--			create showtext_cmd.make (Current)
--			create showtext_frmt_holder.make_plain (showtext_cmd)
--
--			if resources.command_bar.actual_value = False then
--				explain_toolbar.remove
--			end
		end

	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
--			toolbar_t: TOGGLE_B
		do
--			create toolbar_t.make (explain_toolbar.identifier, special_menu)
--			explain_toolbar.init_toggle (toolbar_t)
		end

feature -- Window Properties

	default_name: STRING is
			-- Name of the tool represented by Current.
		do
			Result := Interface_names.t_Empty_explain
		end

feature {NONE} -- Attributes Forms And Holes

--	hole: EXPLAIN_HOLE
			-- Hole characterizing Current.

init_formatters is do end
close_windows is do end
update is do end
register is do end
unregister is do end
end -- class EB_EXPLAIN_TOOL
