indexing
	description: "Search report tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SEARCH_REPORT_TOOL

inherit
	EB_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_search_tool: EB_MULTI_SEARCH_TOOL) is
			-- Initialization
		require
			a_search_tool_not_void: a_search_tool /= Void
		do
			search_tool := a_search_tool
			report_box := build_report_box
		ensure
			search_tool_not_void: search_tool /= Void
		end

	build_report_box : EV_VERTICAL_BOX is
			-- Create and return a box containing result grid.
		local
			frm: EV_FRAME
			report_toolbar: EV_TOOL_BAR
			hbox: EV_HORIZONTAL_BOX
		do
			create report_button.make_with_text (Interface_names.l_Search_report_hide)
			report_button.select_actions.extend (agent toggle_search_report)
			create report_toolbar
			report_toolbar.disable_vertical_button_style
			report_toolbar.extend (report_button)
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
			new_search_tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			new_search_tool_bar.hide

			create shortcut_tool_bar
			shortcut_tool_bar.disable_vertical_button_style
			hbox.extend (create {EV_CELL})
			hbox.extend (shortcut_tool_bar)
			hbox.disable_item_expand (shortcut_tool_bar)
			shortcut_tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			create expand_all_button.make_with_text (interface_names.b_expand_all)
			create collapse_all_button.make_with_text (interface_names.b_collapse_all)
			shortcut_tool_bar.extend (expand_all_button)
			shortcut_tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
			shortcut_tool_bar.extend (collapse_all_button)

			create search_report_grid.make (search_tool)

			create Result
			Result.extend (frm)
			Result.disable_item_expand (frm)

			create report

			report.extend (search_report_grid)
			Result.extend (report)
		end

feature -- Access

	search_report_grid: EB_SEARCH_REPORT_GRID
			-- Grid to contain search report

	search_tool: EB_MULTI_SEARCH_TOOL

	report_box: EV_VERTICAL_BOX
		-- Widget

feature -- Element Change

	set_summary (a_string: STRING) is
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

feature {EB_MULTI_SEARCH_TOOL, EB_SEARCH_REPORT_GRID} -- Widgets

	report_button : EV_TOOL_BAR_BUTTON
			-- Button to hide or show report.

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

feature {NONE} -- Implementation

	toggle_search_report is
			-- Hide report if it is shown, show it if it is hidden.
		do
			if report.is_show_requested then
				report.hide
				report_button.set_text (Interface_names.l_Search_report_show)
			else
				report.show
				report_button.set_text (Interface_names.l_Search_report_hide)
			end
		end

invariant
	invariant_clause: True -- Your invariant here

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
