indexing
	description: "Search report tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SEARCH_REPORT_TOOL_PANEL

inherit
	EB_CONSTANTS

	EB_TOOL
		rename
			widget as report_box
		redefine
			build_docking_content,
			build_mini_toolbar,
			mini_toolbar,
			internal_recycle,
			show
		end

create
	make

feature {NONE} -- Initialization

	build_interface is
			-- Create and return a box containing result grid.
		local
			frm: EV_FRAME
			report_toolbar: EV_TOOL_BAR
			hbox: EV_HORIZONTAL_BOX
			l_tool: ES_SEARCH_TOOL
		do
			create report_toolbar
			report_toolbar.disable_vertical_button_style
			create frm
				-- This is a small workaround for a bug on Windows, where a toolbar
				-- directly inserted within an EV_FRAME, overlaps the bottom of the frame.
				-- There is currently no easy fix for this so this code has been added temporarily
				-- as a work around. Julian.
			create hbox
			frm.extend (hbox)
			hbox.extend (report_toolbar)
			create summary_label.default_create
			hbox.extend (summary_label)
			hbox.disable_item_expand (summary_label)
			hbox.disable_item_expand (report_toolbar)

			create new_search_tool_bar
			hbox.extend (new_search_tool_bar)
			hbox.disable_item_expand (new_search_tool_bar)
			create new_search_button.make_with_text (interface_names.b_new_search)
			new_search_tool_bar.extend (new_search_button)
			new_search_tool_bar.disable_vertical_button_style
			new_search_tool_bar.hide

			create shortcut_tool_bar
			shortcut_tool_bar.disable_vertical_button_style
			hbox.extend (create {EV_CELL})
			hbox.extend (shortcut_tool_bar)
			hbox.disable_item_expand (shortcut_tool_bar)
			create expand_all_button.make_with_text (interface_names.b_expand_all)
			create collapse_all_button.make_with_text (interface_names.b_collapse_all)
			shortcut_tool_bar.extend (expand_all_button)
			shortcut_tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			shortcut_tool_bar.extend (collapse_all_button)

			l_tool ?= develop_window.shell_tools.tool ({ES_SEARCH_TOOL})
			create search_report_grid.make (l_tool)

			create report_box
			report_box.extend (frm)
			report_box.disable_item_expand (frm)

			create report

			report.extend (search_report_grid)
			report_box.extend (report)
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Redefine
		do
			create content.make_with_widget (report_box, title)
			content.close_request_actions.extend (agent close)
			content.set_long_title (title)
			content.set_short_title (title)
			if pixmap /= Void then
				content.set_pixmap (pixmap)
			end
			if pixel_buffer /= Void then
				content.set_pixel_buffer (pixel_buffer)
			end
			content.focus_in_actions.extend (agent show)
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER, ES_TOOL} -- Initialize

	build_mini_toolbar is
			-- Build mini tool bar.
		local
			l_cmd: ES_SHOW_TOOL_COMMAND
		do
			create mini_toolbar.make
			l_cmd := develop_window.commands.show_shell_tool_commands.item (develop_window.shell_tools.tool ({ES_SEARCH_TOOL}))
				-- Pixmap should be changed.
			l_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_search_icon)
			l_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_search_icon_buffer)
			mini_toolbar.extend (l_cmd.new_mini_sd_toolbar_item)
			mini_toolbar.compute_minimum_size

			content.set_mini_toolbar (mini_toolbar)
		ensure then
			mini_toolbar_exists: mini_toolbar /= Void
		end

feature -- Access

	search_report_grid: EB_SEARCH_REPORT_GRID
			-- Grid to contain search report

	search_tool: ES_MULTI_SEARCH_TOOL_PANEL
			-- Search tool
		do
			Result ?= develop_window.shell_tools.tool ({ES_SEARCH_TOOL})
		end

	report_box: EV_VERTICAL_BOX
			-- Widget

	mini_toolbar: SD_TOOL_BAR
			-- Mini tool bar

feature -- Command

	show is
			-- Show tool.
		do
			Precursor {EB_TOOL}
				-- We need to do this in shown_actions when it is available in docking library.
				-- Or the widget in a tool will not get focus at auto-hide mode.
			if search_report_grid /= Void then
				set_focus_if_possible (search_report_grid)
			end
		end

feature -- Element Change

	set_summary (a_string: STRING_GENERAL) is
			-- Set summary label text.
		require
			a_string_not_void: a_string /= Void
		do
			summary_label.set_text (a_string)
		end

	set_new_search_button_visible (a_visible: BOOLEAN) is
			-- Change new search button status.
		do
			if a_visible then
				new_search_tool_bar.show
			else
				new_search_tool_bar.hide
			end
		end

feature {ES_MULTI_SEARCH_TOOL_PANEL, EB_SEARCH_REPORT_GRID} -- Widgets

	summary_label : EV_LABEL
			-- Label to show search summary.

	shortcut_tool_bar: EV_TOOL_BAR
			-- Tool bar contains expand all button etc.

	new_search_tool_bar: EV_TOOL_BAR
			-- Tool bar contains new search button.

	new_search_button: EV_TOOL_BAR_BUTTON
			-- Button to force a new search.

	expand_all_button: EV_TOOL_BAR_BUTTON
			-- Button to expand all.

	collapse_all_button: EV_TOOL_BAR_BUTTON
			-- Button to collapse all.

	report : EV_FRAME
			-- Report container

feature {NONE} -- Recyclable

	internal_recycle is
			-- Recyclable
		do
			search_report_grid.wipe_out
			Precursor {EB_TOOL}
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
