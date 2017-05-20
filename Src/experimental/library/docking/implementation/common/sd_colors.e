note
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

	make
			-- Initialize all colors and register agents for updates when a theme changes.
		do
			initialize_colors
			ev_application.theme_changed_actions.put_front (agent initialize_colors)
			ev_application.theme_changed_actions.put_right (agent update_all_tool_bars)
		end

	initialize_colors
			-- Initialize all colors.
		local
			l_system_color: SD_SYSTEM_COLOR
			l_helper: SD_COLOR_HELPER
		do
			create {SD_SYSTEM_COLOR_IMP} l_system_color.make
			non_focused_color := l_system_color.non_focused_selection_color
			non_focused_title_color := l_system_color.non_focused_selection_title_color
			non_focused_title_text_color := l_system_color.non_focused_title_text_color

			default_background_color := l_system_color.default_background_color

			create l_helper
			non_focused_color_lightness := l_helper.color_with_lightness (default_background_color, {SD_SHARED}.Auto_hide_panel_lightness).twin

			focused_color := l_system_color.focused_selection_color
			focused_title_text_color := l_system_color.focused_title_text_color
			border_color := l_system_color.active_border_color
			tab_text_color := l_system_color.button_text_color

			tool_tip_color := (create {EV_TEXT_FIELD}).background_color
		end

feature {SD_SHARED} -- Access

	non_focused_color: EV_COLOR
			-- Non focuse color. Used by {SD_TITLE_BAR}.

	non_focused_title_color: EV_COLOR
			-- Non focused color of window title bar.

	non_focused_title_text_color: EV_COLOR
			-- Title bar text color when non focused.

	non_focused_color_lightness: EV_COLOR
			-- Lighter `non_focused_color'.

	focused_color: EV_COLOR
			-- Focused color. Used by {SD_TITLE_BAR}.

	focused_title_text_color: EV_COLOR
			-- Focused title bar text color. Used by {SD_TITLE_BAR}.

	border_color: EV_COLOR
			-- Border color, used by {SD_TAB_STUB}, {SD_NOTEBOOK_TAB}.

	tab_text_color: EV_COLOR
			-- Text color.

	tool_tip_color: EV_COLOR
			-- Tooltip color which is used by {SD_NOTEBOOK_HIDE_DIALOG}.

	tool_bar_title_bar_color: EV_COLOR
			-- Tool bar tilte bar color when tool bar floating.
		once
			create Result
			Result.set_rgb_with_8_bit (132, 130, 132)
		ensure
			not_void: Result /= Void
		end

	feedback_indicator_region_window_discard_color: EV_COLOR
			-- Feedback indicator window region discard color.
		once
			create Result.make_with_rgb (1, 1, 1)
		end

	default_background_color: EV_COLOR
			-- Default background color.

feature {NONE} -- Implementation

	update_all_tool_bars
			-- Update all tool bars background color.
		local
			l_tool_bars: SPECIAL [ANY]
			i: INTEGER
		do
			from
				l_tool_bars := (create {MEMORY}).objects_instance_of (create {SD_TOOL_BAR}.make)
			until
				i >= l_tool_bars.count
			loop
				if attached {SD_TOOL_BAR} l_tool_bars [i] as l_tool_bar_2 then
					if not l_tool_bar_2.is_destroyed then
						l_tool_bar_2.set_background_color (default_background_color)
					end
				else
					check  not_possible: False end -- Implied by the design of {MEMORY}.objects_instance_of
				end
				i := i + 1
			end
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
