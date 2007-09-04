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
			l_widgets: SPECIAL [ANY]
			l_tool_bar: SD_TOOL_BAR
			l_i: INTEGER
		do
			from
				create l_mem
				create l_tool_bar.make
				l_widgets := l_mem.objects_instance_of (l_tool_bar)
			until
				l_i >= l_widgets.count
			loop
				l_tool_bar ?= l_widgets.item (l_i)
				check not_void: l_tool_bar /= Void end
				l_i := l_i + 1
			end
		end

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
