indexing
	description: "Singleton which has all sizes used in Smart Docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SIZES

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		local
			l_env: EV_ENVIRONMENT
		do
			create internal_shared
			update_tool_bar_font_sizes
			update_addtional_sizes
			create l_env
			l_env.application.theme_changed_actions.extend (agent update_all)
		end

feature {NONE} -- Implementation

	update_all is
			-- Update all sizes.
		do
			update_tool_bar_font_sizes
			update_addtional_sizes
			update_widgets_sizes
			update_all_docking_managers
		end

	update_tool_bar_font_sizes is
			-- Update `Tool_bar_font_cell' and related singletons.
		local
			l_color: SD_SYSTEM_COLOR
			l_platform: PLATFORM
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

			l_notebook_tab_height := l_tool_bar_font.height * 3 // 2
			create l_platform
			if l_platform.is_windows then
				l_notebook_tab_height := l_notebook_tab_height + 2
			end
			notebook_tab_height_cell.put (l_notebook_tab_height)

			l_notebook_tab_maximum_size :=  l_tool_bar_font.width * 35
			notebook_tab_maximum_size_cell.put (l_notebook_tab_maximum_size)

			l_title_bar_height := l_tool_bar_font.height * 3 // 2 + 2
			title_bar_height_cell.put (l_title_bar_height)

			l_title_bar_text_start_y := (l_title_bar_height / 2 - l_tool_bar_font.height / 2).rounded
			title_bar_text_start_y_cell.put (l_title_bar_text_start_y)

			l_tool_bar_border_width := (l_tool_bar_font.height / 2).floor
			if l_platform.is_windows then
				l_tool_bar_border_width := l_tool_bar_border_width + 1
			end
			tool_bar_border_width_cell.put (l_tool_bar_border_width)

			l_tool_bar_size := l_tool_bar_font.height + 2 * l_tool_bar_border_width
			tool_bar_size_cell.put (l_tool_bar_size)
		end

	update_addtional_sizes is
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

	update_widgets_sizes is
			-- Update existing widgets sizes just after font changed
		local
			l_mem: MEMORY
			l_internal: INTERNAL
			l_type_id: INTEGER
			l_widgets: SPECIAL [ANY]
			l_tool_bar, l_tool_bar_2: SD_TOOL_BAR
			l_tool_bar_zone, l_tool_bar_zone_2: SD_TOOL_BAR_ZONE
			l_title, l_title_2: SD_TITLE_BAR
			l_notebook, l_notebook_2: SD_NOTEBOOK
			l_notebook_upper, l_notebook_upper_2: SD_NOTEBOOK_UPPER
			l_auto_hide_panel, l_auto_hide_panel_2: SD_AUTO_HIDE_PANEL
			l_i: INTEGER
		do
			create l_internal
			create l_mem

			from
				l_type_id := l_internal.dynamic_type_from_string ("SD_TOOL_BAR")
				check exists: l_type_id /= -1 end
				l_tool_bar ?= l_internal.new_instance_of (l_type_id)
				check not_void: l_tool_bar /= Void end
				l_widgets := l_mem.objects_instance_of (l_tool_bar)
			until
				l_i >= l_widgets.count
			loop
				l_tool_bar_2 ?= l_widgets.item (l_i)
				check not_void: l_tool_bar_2 /= Void end
				if l_tool_bar_2 /= l_tool_bar then
					l_tool_bar_2.need_calculate_size
					l_tool_bar_2.update_size
				end

				l_i := l_i + 1
			end

			from
				l_type_id := l_internal.dynamic_type_from_string ("SD_TOOL_BAR_ZONE")
				check exists: l_type_id /= -1 end
				l_tool_bar_zone ?= l_internal.new_instance_of (l_type_id)
				check not_void: l_tool_bar_zone /= Void end
				l_widgets := l_mem.objects_instance_of (l_tool_bar_zone)
				l_i := 0
			until
				l_i >= l_widgets.count
			loop
				l_tool_bar_zone_2 ?= l_widgets.item (l_i)
				check not_void: l_tool_bar_zone_2 /= Void end
				if l_tool_bar_zone_2 /= l_tool_bar_zone then
					l_tool_bar_zone_2.update_drag_area
				end

				l_i := l_i + 1
			end

			from
				l_type_id := l_internal.dynamic_type_from_string ("SD_TITLE_BAR")
				check exists: l_type_id /= -1 end
				l_title ?= l_internal.new_instance_of (l_type_id)
				check not_void: l_title /= Void end
				l_widgets := l_mem.objects_instance_of (l_title)
				l_i := 0
			until
				l_i >= l_widgets.count
			loop
				l_title_2 ?= l_widgets.item (l_i)
				check not_void: l_title_2 /= Void end
				if l_title_2 /= l_title then
					l_title_2.update_size_and_font
				end

				l_i := l_i + 1
			end

			from
				l_type_id := l_internal.dynamic_type_from_string ("SD_NOTEBOOK")
				check exists: l_type_id /= -1 end
				l_notebook ?= l_internal.new_instance_of (l_type_id)
				check not_void: l_notebook /= Void end
				l_widgets := l_mem.objects_instance_of (l_notebook)
				l_i := 0
			until
				l_i >= l_widgets.count
			loop
				l_notebook_2 ?= l_widgets.item (l_i)
				check not_void: l_notebook_2 /= Void end
				if l_notebook_2 /= l_notebook then
					l_notebook_2.update_size_and_font
				end

				l_i := l_i + 1
			end

			from
				l_type_id := l_internal.dynamic_type_from_string ("SD_NOTEBOOK_UPPER")
				check exists: l_type_id /= -1 end
				l_notebook_upper ?= l_internal.new_instance_of (l_type_id)
				check not_void: l_notebook_upper /= Void end
				l_widgets := l_mem.objects_instance_of (l_notebook_upper)
				l_i := 0
			until
				l_i >= l_widgets.count
			loop
				l_notebook_upper_2 ?= l_widgets.item (l_i)
				check not_void: l_notebook_upper_2 /= Void end
				if l_notebook_upper_2 /= l_notebook_upper then
					l_notebook_upper_2.update_size_and_font
				end

				l_i := l_i + 1
			end

			from
				l_type_id := l_internal.dynamic_type_from_string ("SD_AUTO_HIDE_PANEL")
				check exists: l_type_id /= -1 end
				l_auto_hide_panel ?= l_internal.new_instance_of (l_type_id)
				check not_void: l_auto_hide_panel /= Void end
				l_widgets := l_mem.objects_instance_of (l_auto_hide_panel)
				l_i := 0
			until
				l_i >= l_widgets.count
			loop
				l_auto_hide_panel_2 ?= l_widgets.item (l_i)
				check not_void: l_auto_hide_panel_2 /= Void end
				if l_auto_hide_panel_2 /= l_auto_hide_panel then
					l_auto_hide_panel_2.update_size
					l_auto_hide_panel_2.tab_stubs.do_all (agent (a_tab_stub: SD_TAB_STUB)
																														require
																															not_void: a_tab_stub /= Void
																														do
																															a_tab_stub.set_text (a_tab_stub.text)
																														end
																														)
				end

				l_i := l_i + 1
			end
		end

	update_all_docking_managers is
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

	Tool_bar_font_cell: CELL [EV_FONT] is
			-- Tool bar font singleton cell.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	Notebook_tab_height_cell: CELL [INTEGER] is
			-- Notebook tab height singleton cell.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	Notebook_tab_maximum_size_cell: CELL [INTEGER] is
			-- Notebook tab maximum size singleton cell.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	Title_bar_height_cell: CELL [INTEGER] is
			-- Title bar height singleton cell.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	Title_bar_text_start_y_cell: CELL [INTEGER] is
			-- Title bar text start y singleton cell.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	Tool_bar_border_width_cell: CELL [INTEGER] is
			-- Tool bar border width singleton cell.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	Tool_bar_size_cell: CELL [INTEGER] is
			-- Title bar size singleton cell.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

feature -- Additional singleton slots.

	Auto_hide_panel_size_cell: CELL [INTEGER] is
			-- Auto hide panel size singleton cell.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	Zone_minimum_width_cell: CELL [INTEGER] is
			-- Zone minimum width singleton cell.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	Zone_minimum_height_cell: CELL [INTEGER] is
			-- Zone minimum height singleton cell.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

invariant

		internal_shared_not_void: internal_shared /= Void

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
