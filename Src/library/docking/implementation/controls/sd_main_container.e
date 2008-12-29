note
	description: "Container that contained by SD_TOOL_BAR_CONTAINER. And it contain a EV_FIXED."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MAIN_CONTAINER

inherit
	SD_MAIN_CONTAINER_IMP
		rename
			set_background_color as set_background_color_vision2
		end


feature {NONE} -- Initialization

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_helper: SD_COLOR_HELPER
		do
			create internal_shared
			create l_helper

			set_background_color (internal_shared.non_focused_color_lightness)
		end

feature -- Command

	set_background_color (a_color: EV_COLOR)
			-- Set background color of gap areas.
		require
			not_void: a_color /= Void
		do
			left_top.set_background_color (a_color)
			right_top.set_background_color (a_color)
			left_bottom.set_background_color (a_color)
			right_bottom.set_background_color (a_color)

			gap_area_top.set_background_color (a_color)
			gap_area_bottom.set_background_color (a_color)
			gap_area_left.set_background_color (a_color)
			gap_area_right.set_background_color (a_color)
		end

	set_gap (a_direction: INTEGER; a_show: BOOLEAN)
			-- Show gap at `a_direction'?
		require
			a_direction_valid: (create {SD_ENUMERATION}).is_direction_valid (a_direction)
		do
			inspect
				a_direction
			when {SD_ENUMERATION}.top then
				if a_show then
					gap_area_top.set_minimum_height (internal_shared.auto_hide_panel_gap_size)
				else
					gap_area_top.set_minimum_height (0)
				end
			when {SD_ENUMERATION}.bottom then
				if a_show then
					gap_area_bottom.set_minimum_height (internal_shared.auto_hide_panel_gap_size)
				else
					gap_area_bottom.set_minimum_height (0)
				end
			when {SD_ENUMERATION}.left then
				if a_show then
					gap_area_left.set_minimum_width (internal_shared.auto_hide_panel_gap_size)
					left_top.set_minimum_width (auto_hide_bar_width)
					left_bottom.set_minimum_width (auto_hide_bar_width)
				else
					gap_area_left.set_minimum_width (0)
					left_top.set_minimum_width (0)
					left_bottom.set_minimum_width (0)
				end
			when {SD_ENUMERATION}.right then
				if a_show then
					gap_area_right.set_minimum_width (internal_shared.auto_hide_panel_gap_size)
					right_top.set_minimum_width (auto_hide_bar_width)
					right_bottom.set_minimum_width (auto_hide_bar_width)
				else
					gap_area_right.set_minimum_width (0)
					right_top.set_minimum_width (0)
					right_bottom.set_minimum_width (0)
				end
			end
		end

feature {NONE} -- Implementation

	internal_shared: SD_SHARED;
			-- All singletons.

note
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






end -- class SD_MAIN_CONTAINER

