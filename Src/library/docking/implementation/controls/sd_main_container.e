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

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do

				-- Create all widgets
			create l_ev_horizontal_box_1
			create left_top
			create top_bar
			create right_top
			create l_ev_horizontal_box_2
			create left_bar
			create center_area
			create right_bar
			create l_ev_horizontal_box_3
			create left_bottom
			create bottom_bar
			create right_bottom

			create {EV_HORIZONTAL_BOX} gap_area_top
			create {EV_HORIZONTAL_BOX} gap_area_bottom
			create {EV_HORIZONTAL_BOX} gap_area_left
			create {EV_HORIZONTAL_BOX} gap_area_right

				-- Build_widget_structure
			create gap_area_holder
			create internal_shared

			default_create

			custom_initialize

			debug ("ev_identifier")
				set_identifier_name ("SD:main")
				left_top.set_identifier_name ("SD:main:left_top")
				top_bar.set_identifier_name ("SD:main:top_bar")
				right_top.set_identifier_name ("SD:main:right_top")
				left_bar.set_identifier_name ("SD:main:left_bar")
				center_area.set_identifier_name ("SD:main:center_area")
				right_bar.set_identifier_name ("SD:main:right_bar")
				left_bottom.set_identifier_name ("SD:main:left_bottom")
				bottom_bar.set_identifier_name ("SD:main:bottom_bar")
				right_bottom.set_identifier_name ("SD:main:right_bottom")

				gap_area_top.set_identifier_name ("SD:gap:area_top")
				gap_area_bottom.set_identifier_name ("SD:gap:area_bottom")
				gap_area_left.set_identifier_name ("SD:gap:area_left")
				gap_area_right.set_identifier_name ("SD:gap:area_right")
			end
		end

	user_initialization
			-- Called by `initialize'
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			create internal_shared
			set_background_color (internal_shared.non_focused_color_lightness)
		end

feature -- Command

	set_background_color (a_color: EV_COLOR)
			-- Set background color of gap areas
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
			-- All singletons

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"






end -- class SD_MAIN_CONTAINER

