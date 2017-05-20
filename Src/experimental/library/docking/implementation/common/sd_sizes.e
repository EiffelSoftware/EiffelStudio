note
	description: "Singleton which has all sizes used in Smart Docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SIZES

inherit
	SD_ACCESS

create
	make

feature {NONE} -- Initlization

	make
			-- Creation method.
		local
			l_env: EV_ENVIRONMENT
		do
			create internal_shared
			update_tool_bar_font_sizes
			update_addtional_sizes
			create l_env
			if attached l_env.application as l_app then
				l_app.theme_changed_actions.extend (agent update_all)
			end
		end

feature {NONE} -- Implementation

	update_all
			-- Update all sizes.
		do
			update_tool_bar_font_sizes
			update_addtional_sizes
			update_widgets_sizes
			update_all_docking_managers
		end

	update_tool_bar_font_sizes
			-- Update `Tool_bar_font_cell' and related singletons.
		local
			l_tool_bar_font: EV_FONT
			l_tool_bar_font_height: INTEGER
			l_title_bar_height: INTEGER
			l_tool_bar_border_width: INTEGER
		do
			l_tool_bar_font := (create {SD_SYSTEM_COLOR_IMP}.make).tool_bar_font
			tool_bar_font := l_tool_bar_font

			l_tool_bar_font_height := l_tool_bar_font.height
			notebook_tab_height := (l_tool_bar_font_height * 3 // 2) + 2

			notebook_tab_maximum_size := l_tool_bar_font.width * 35

			l_title_bar_height := l_tool_bar_font_height * 3 // 2 + 2
			title_bar_height := l_title_bar_height

			title_bar_text_start_y := (l_title_bar_height / 2 - (l_tool_bar_font_height + 1) / 2).rounded

			l_tool_bar_border_width := (l_tool_bar_font_height / 2).floor + 1
			tool_bar_border_width := l_tool_bar_border_width

			tool_bar_size := l_tool_bar_font_height + 2 * l_tool_bar_border_width
		end

	update_addtional_sizes
			-- The sizes should be updated after `update_tool_bar_font_sizes'.
		local
			l_auto_hide_panel_size: INTEGER
		do
			l_auto_hide_panel_size := notebook_tab_height
			if {PLATFORM}.is_windows then
				l_auto_hide_panel_size := l_auto_hide_panel_size + 2
			end
			auto_hide_panel_size := l_auto_hide_panel_size
			zone_minimum_width := title_bar_height * 5
			zone_minimum_height := title_bar_height + 1
		end

	update_widgets_sizes
			-- Update existing widgets sizes just after font changed
		local
			l_widgets: SD_WIDGETS_LISTS
		do
			l_widgets := internal_shared.widgets
			l_widgets.all_tool_bars.do_all (agent (a_item: SD_GENERIC_TOOL_BAR)
												do
													a_item.set_need_calculate_size (True)
													a_item.update_size
												end)

			l_widgets.all_tool_bar_zones.do_all (agent (a_item: SD_TOOL_BAR_ZONE)
													do
														a_item.update_drag_area
													end)


			l_widgets.all_title_bars.do_all (agent (a_item: SD_TITLE_BAR)
												do
													a_item.update_size_and_font
												end)

			l_widgets.all_notebooks.do_all (agent (a_item: SD_NOTEBOOK)
												do
													a_item.update_size_and_font
												end)

			l_widgets.all_auto_hide_panels.do_all (agent (a_item: SD_AUTO_HIDE_PANEL)
													do
														a_item.update_size
														a_item.tab_stubs.do_all (agent (a_tab_stub: SD_TAB_STUB)
															require
																not_void: a_tab_stub /= Void
															do
																a_tab_stub.set_text (a_tab_stub.text)
															end)
													end)
		end

	update_all_docking_managers
			-- Call `resize' on all docking managers.
		local
			l_list: ARRAYED_LIST [SD_DOCKING_MANAGER]
		do
			from
				l_list := internal_shared.docking_manager_list
				l_list.start
			until
				l_list.after
			loop
				l_list.item.command.resize (True)
				l_list.forth
			end
		end

	internal_shared: SD_SHARED
			-- All singletons.

feature {SD_SHARED} -- Slots realted to tool bar font.

	tool_bar_font: EV_FONT
			-- Tool bar font.

	notebook_tab_height: INTEGER
			-- Notebook tab height.

	notebook_tab_maximum_size: INTEGER
			-- Notebook tab maximum size.

	title_bar_height: INTEGER
			-- Title bar height.

	title_bar_text_start_y: INTEGER
			-- Title bar text start y.

	tool_bar_border_width: INTEGER
			-- Tool bar border width.

	tool_bar_size: INTEGER
			-- Title bar size.

feature {SD_SHARED} -- Additional slots.

	auto_hide_panel_size: INTEGER
			-- Auto hide panel size.

	zone_minimum_width: INTEGER
			-- Zone minimum width.

	zone_minimum_height: INTEGER
			-- Zone minimum height.

invariant

		internal_shared_not_void: internal_shared /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
