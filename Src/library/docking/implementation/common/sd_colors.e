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
			-- Creation method
		do
			ev_application.theme_changed_actions.put_front (agent init_colors)
			ev_application.theme_changed_actions.put_right (agent update_all_tool_bars)
			init_colors

			create internal_shared
		end

	init_colors
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

			is_initialized := True

			create l_helper
			non_focused_color_lightness_cell.put (l_helper.color_with_lightness (default_background_color, {SD_SHARED}.Auto_hide_panel_lightness).twin)

			focused_color_cell.put (l_system_color.focused_selection_color)
			focused_title_text_color_cell.put (l_system_color.focused_title_text_color)
			active_border_color_cell.put (l_system_color.active_border_color)
			tab_text_color_cell.put (l_system_color.button_text_color)

			create l_text_box
			tool_tip_color_cell.put (l_text_box.background_color)
		ensure
			set: is_initialized = True
		end

feature -- Query

	non_focused_color: EV_COLOR
			-- Non focuse color. Used by SD_TITLE_BAR
		require
			initialized: is_initialized
		local
			l_result: detachable EV_COLOR
		do
			l_result := non_focused_color_cell.item
			check l_result /= Void end -- Implied by precondition `initialized'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	non_focused_title_color: EV_COLOR
			-- Non focused color of window title bar
		require
			initialized: is_initialized
		local
			l_result: detachable EV_COLOR
		do
			l_result := non_focused_title_color_cell.item
			check l_result /= Void end -- Implied by precondition `initialized'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	non_focused_title_text_color: EV_COLOR
			-- Title bar text color when non focused
		require
			initialized: is_initialized
		local
			l_result: detachable EV_COLOR
		do
			l_result := non_focused_title_text_color_cell.item
			check l_result /= Void end -- Implied by precondition `initialized'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	non_focused_color_lightness: EV_COLOR
			-- Lighter `non_focused_color'
		require
			initialized: is_initialized
		local
			l_result: detachable EV_COLOR
		do
			l_result := non_focused_color_lightness_cell.item
			check l_result /= Void end -- Implied by precondition `initialized'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	focused_color: EV_COLOR
			-- Focused color. Used by SD_TITLE_BAR...
		require
			initialized: is_initialized
		local
			l_result: detachable EV_COLOR
		do
			l_result := focused_color_cell.item
			check l_result /= Void end -- Implied by precondition `initialized'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	focused_title_text_color: EV_COLOR
			-- Focused title bar text color. Used bt SD_TITLE_BAR
		require
			initialized: is_initialized
		local
			l_result: detachable EV_COLOR
		do
			l_result := focused_title_text_color_cell.item
			check l_result /= Void end -- Implied by precondition `initialized'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	border_color: EV_COLOR
			-- Border color, used by SD_TAB_STUB, SD_NOTEBOOK_TAB...
		require
			initialized: is_initialized
		local
			l_result: detachable EV_COLOR
		do
			l_result := active_border_color_cell.item
			check l_result /= Void end -- Implied by precondition `initialized'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	tab_text_color: EV_COLOR
			-- Text color
		require
			initialized: is_initialized
		local
			l_result: detachable EV_COLOR
		do
			l_result := tab_text_color_cell.item
			check l_result /= Void end -- Implied by precondition `initialized'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	tool_tip_color: EV_COLOR
			-- Tooltip color which is used by SD_NOTEBOOK_HIDE_DIALOG
		require
			initialized: is_initialized
		local
			l_result: detachable EV_COLOR
		do
			l_result := tool_tip_color_cell.item
			check l_result /= Void end -- Implied by precondition `initialized'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	tool_bar_title_bar_color: EV_COLOR
			-- Tool bar tilte bar color when tool bar floating
		once
			create Result
			Result.set_rgb_with_8_bit (132, 130, 132)
		ensure
			not_void: Result /= Void
		end

	feedback_indicator_region_window_discard_color: EV_COLOR
			-- Feedback indicator window region discard color
		once
			create Result.make_with_rgb (1, 1, 1)
		end

	default_background_color: EV_COLOR
			-- Default background color
		require
			initialized: is_initialized
		local
			l_result: detachable EV_COLOR
		do
			l_result := default_background_color_cell.item
			check l_result /= Void end -- Implied by precondition `initialized'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

feature -- Contract support

	is_initialized: BOOLEAN
			-- If all singletons colors have beend set?

feature -- Implementation

	update_all_tool_bars
			-- Update all tool bars background color
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
				if attached {SD_TOOL_BAR} l_tool_bars.item (l_i) as l_tool_bar_2 then
					if not l_tool_bar_2.is_destroyed then
						l_tool_bar_2.set_background_color (internal_shared.default_background_color)
					end
				else
					check  not_possible: False end -- Implied by the design of {MEMORY}.objects_instance_of
				end
				l_i := l_i + 1
			end
		end

	non_focused_color_cell: CELL [detachable EV_COLOR]
			-- Singelton cell for `non_focus_color'
		once
			create Result.put (Void)
		end

	non_focused_title_color_cell: CELL [detachable EV_COLOR]
			-- Singleton cell for `non_focused_title_color'
		once
			create Result.put (Void)
		end

	non_focused_title_text_color_cell: CELL [detachable EV_COLOR]
			-- Singleton cell for `non_focused_title_text_color'
		once
			create Result.put (Void)
		end

	non_focused_color_lightness_cell: CELL [detachable EV_COLOR]
			-- Singleton cell for `non_focused_color_lightness'
		once
			create Result.put (Void)
		end

	focused_color_cell: CELL [detachable EV_COLOR]
			-- Singleton cell for `focused_color_cell'
		once
			create Result.put (Void)
		end

	focused_title_text_color_cell: CELL [detachable EV_COLOR]
			-- Singleton cell for `focused_title_text_color'
		once
			create Result.put (Void)
		end

	active_border_color_cell: CELL [detachable EV_COLOR]
			-- Singleton cell for `active_border_color'
		once
			create Result.put (Void)
		end

	tab_text_color_cell: CELL [detachable EV_COLOR]
			-- Singleton cell for `tab_text_color'
		once
			create Result.put (Void)
		end

	tool_tip_color_cell:CELL [detachable EV_COLOR]
			-- Singleton cell for `tool_tip_color'
		once
			create Result.put (Void)
		end

	default_background_color_cell: CELL [detachable EV_COLOR]
			-- Singletone cell for `default_background_color'
		once
			create Result.put (Void)
		end

	internal_shared: SD_SHARED
			-- All singletons

invariant
	not_void: internal_shared /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
