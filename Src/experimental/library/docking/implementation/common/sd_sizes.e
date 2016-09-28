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
			l_color: SD_SYSTEM_COLOR
			l_tool_bar_font: EV_FONT
			l_notebook_tab_height: INTEGER
			l_notebook_tab_maximum_size: INTEGER
			l_title_bar_height: INTEGER
			l_title_bar_text_start_y: INTEGER
			l_tool_bar_border_width: INTEGER
			l_tool_bar_size: INTEGER
		do
			create {SD_SYSTEM_COLOR_IMP} l_color.make
			l_tool_bar_font := l_color.tool_bar_font
			Tool_bar_font_cell.put (l_tool_bar_font)

			l_notebook_tab_height := (l_tool_bar_font.height * 3 // 2) + 2

			notebook_tab_height_cell.put (l_notebook_tab_height)

			l_notebook_tab_maximum_size :=  l_tool_bar_font.width * 35
			notebook_tab_maximum_size_cell.put (l_notebook_tab_maximum_size)

			l_title_bar_height := l_tool_bar_font.height * 3 // 2 + 2
			title_bar_height_cell.put (l_title_bar_height)

			l_title_bar_text_start_y := (l_title_bar_height / 2 - (l_tool_bar_font.height + 1) / 2).rounded
			title_bar_text_start_y_cell.put (l_title_bar_text_start_y)

			l_tool_bar_border_width := (l_tool_bar_font.height / 2).floor + 1
			tool_bar_border_width_cell.put (l_tool_bar_border_width)

			l_tool_bar_size := l_tool_bar_font.height + 2 * l_tool_bar_border_width
			tool_bar_size_cell.put (l_tool_bar_size)
		end

	update_addtional_sizes
			-- The sizes should be updated after `update_tool_bar_font_sizes'.
		local
			l_platform: PLATFORM
			l_auto_hide_panel_size: INTEGER
			l_zone_minimum_width: INTEGER
			l_zone_minimum_height: INTEGER
		do
			l_auto_hide_panel_size := notebook_tab_height_cell.item
			create l_platform
			if l_platform.is_windows then
				l_auto_hide_panel_size := l_auto_hide_panel_size + 2
			end
			auto_hide_panel_size_cell.put (l_auto_hide_panel_size)

			l_zone_minimum_width := title_bar_height_cell.item * 5
			zone_minimum_width_cell.put (l_zone_minimum_width)

			l_zone_minimum_height := title_bar_height_cell.item + 1
			zone_minimum_height_cell.put (l_zone_minimum_height)
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

feature -- Singleton slots realted with tool bar font.

	Tool_bar_font_cell: CELL [EV_FONT]
			-- Tool bar font singleton cell.
		once
			create Result.put (create {EV_FONT})
		ensure
			not_void: Result /= Void
		end

	Notebook_tab_height_cell: CELL [INTEGER]
			-- Notebook tab height singleton cell.
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

	Notebook_tab_maximum_size_cell: CELL [INTEGER]
			-- Notebook tab maximum size singleton cell.
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

	Title_bar_height_cell: CELL [INTEGER]
			-- Title bar height singleton cell.
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

	Title_bar_text_start_y_cell: CELL [INTEGER]
			-- Title bar text start y singleton cell.
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

	Tool_bar_border_width_cell: CELL [INTEGER]
			-- Tool bar border width singleton cell.
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

	Tool_bar_size_cell: CELL [INTEGER]
			-- Title bar size singleton cell.
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

feature -- Additional singleton slots.

	Auto_hide_panel_size_cell: CELL [INTEGER]
			-- Auto hide panel size singleton cell.
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

	Zone_minimum_width_cell: CELL [INTEGER]
			-- Zone minimum width singleton cell.
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

	Zone_minimum_height_cell: CELL [INTEGER]
			-- Zone minimum height singleton cell.
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

invariant

		internal_shared_not_void: internal_shared /= Void

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
