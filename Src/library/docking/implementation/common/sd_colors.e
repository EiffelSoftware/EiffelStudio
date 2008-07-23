indexing
	description: "Responsible for maitain all colors used by docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_COLORS

inherit
	ANY

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation method
		do
			ev_application.theme_changed_actions.put_front (agent init_colors)
			ev_application.theme_changed_actions.put_right (agent update_all_tool_bars)
			init_colors

			create internal_shared
		end

	init_colors is
			-- Initialize all colors
		local
			l_system_color: SD_SYSTEM_COLOR
			l_helper: SD_COLOR_HELPER
			l_text_box: EV_TEXT_FIELD
		do
			create {SD_SYSTEM_COLOR_IMP} l_system_color.make
			non_focused_color_cell.put (l_system_color.non_focused_selection_color)
			non_focused_title_color_cell.put (l_system_color.non_focused_selection_title_color)
			non_focused_title_text_color_cell.put (l_system_color.non_focused_title_text_color)

			default_background_color_cell.put (l_system_color.default_background_color)
			create l_helper
			non_focused_color_lightness_cell.put (l_helper.color_with_lightness (default_background_color, {SD_SHARED}.Auto_hide_panel_lightness).twin)

			focused_color_cell.put (l_system_color.focused_selection_color)
			focused_title_text_color_cell.put (l_system_color.focused_title_text_color)
			active_border_color_cell.put (l_system_color.active_border_color)
			tab_text_color_cell.put (l_system_color.button_text_color)

			create l_text_box
			tool_tip_color_cell.put (l_text_box.background_color)
		end

feature -- Query

	non_focused_color: EV_COLOR is
			-- Non focuse color. Used by SD_TITLE_BAR.
		do
			Result := non_focused_color_cell.item
		end

	non_focused_title_color: EV_COLOR is
			-- Non focused color of window title bar.
		do
			Result := non_focused_title_color_cell.item
		end

	non_focused_title_text_color: EV_COLOR is
			-- Title bar text color when non focused.
		do
			Result := non_focused_title_text_color_cell.item
		end

	non_focused_color_lightness: EV_COLOR is
			-- Lighter `non_focused_color'.
		do
			Result := non_focused_color_lightness_cell.item
		end

	focused_color: EV_COLOR is
			-- Focused color. Used by SD_TITLE_BAR...
		do
			Result := focused_color_cell.item
		end

	focused_title_text_color: EV_COLOR is
			-- Focused title bar text color. Used bt SD_TITLE_BAR.
		do
			Result := focused_title_text_color_cell.item
		end

	border_color: EV_COLOR is
			-- Border color, used by SD_TAB_STUB, SD_NOTEBOOK_TAB...
		do
			Result := active_border_color_cell.item
		end

	tab_text_color: EV_COLOR is
			-- Text color
		do
			Result := tab_text_color_cell.item
		end

	tool_tip_color: EV_COLOR is
			-- Tooltip color which is used by SD_NOTEBOOK_HIDE_DIALOG.
		do
			Result := tool_tip_color_cell.item
		end

	tool_bar_title_bar_color: EV_COLOR is
			-- Tool bar tilte bar color when tool bar floating.
		once
			create Result
			Result.set_rgb (132 / 255, 130 / 255, 132 / 255)
		ensure
			not_void: Result /= Void
		end

	feedback_indicator_region_window_discard_color: EV_COLOR is
			-- Feedback indicator window region discard color.
		once
			create Result.make_with_rgb (1, 1, 1)
		end

	default_background_color: EV_COLOR is
			-- Default background color
		do
			Result := default_background_color_cell.item
		end

feature -- Implementation

	update_all_tool_bars is
			-- Update all tool bars background color.
		local
			l_mem: MEMORY
			l_tool_bar: SD_TOOL_BAR
			l_tool_bars: SPECIAL [ANY]
			l_i: INTEGER
		do
			create l_mem
			create l_tool_bar.make
			l_tool_bars := l_mem.objects_instance_of (l_tool_bar)

			from
			until
				l_i >= l_tool_bars.count
			loop
				l_tool_bar ?= l_tool_bars.item (l_i)
				check  not_void: l_tool_bar /= Void end
				if not l_tool_bar.is_destroyed then
					l_tool_bar.set_background_color (internal_shared.default_background_color)
				end
				l_i := l_i + 1
			end
		end

	non_focused_color_cell: CELL [EV_COLOR] is
			-- Singelton cell for `non_focus_color'
		once
			create Result
		end

	non_focused_title_color_cell: CELL [EV_COLOR] is
			-- Singleton cell for `non_focused_title_color'
		once
			create Result
		end

	non_focused_title_text_color_cell: CELL [EV_COLOR] is
			-- Singleton cell for `non_focused_title_text_color'
		once
			create Result
		end

	non_focused_color_lightness_cell: CELL [EV_COLOR] is
			-- Singleton cell for `non_focused_color_lightness'
		once
			create Result
		end

	focused_color_cell: CELL [EV_COLOR] is
			-- Singleton cell for `focused_color_cell'
		once
			create Result
		end

	focused_title_text_color_cell: CELL [EV_COLOR] is
			-- Singleton cell for `focused_title_text_color'
		once
			create Result
		end

	active_border_color_cell: CELL [EV_COLOR] is
			-- Singleton cell for `active_border_color'
		once
			create Result
		end

	tab_text_color_cell: CELL [EV_COLOR] is
			-- Singleton cell for `tab_text_color'
		once
			create Result
		end

	tool_tip_color_cell:CELL [EV_COLOR] is
			-- Singleton cell for `tool_tip_color'
		once
			create Result
		end

	default_background_color_cell: CELL [EV_COLOR] is
			-- Singletone cell for `default_background_color'
		once
			create Result
		end

	internal_shared: SD_SHARED
			-- All singletons

invariant
	not_void: internal_shared /= Void

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
