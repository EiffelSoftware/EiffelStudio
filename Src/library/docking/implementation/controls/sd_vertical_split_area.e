note
	description: "[
			Same as EV_VERTICAL_SPLIT_AREA, except that when double click it'll set it's proportion to 50%.
			A decorator.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_VERTICAL_SPLIT_AREA

inherit
	SD_MIDDLE_CONTAINER
		undefine
			is_in_default_state,
			copy
		redefine
			initialize,
			implementation
		end

	EV_VERTICAL_SPLIT_AREA
		redefine
			initialize,
			set_split_position,
			implementation
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	initialize
			-- <Precursor>
		local
			l_platform: PLATFORM
		do
			Precursor {EV_VERTICAL_SPLIT_AREA}
			create l_platform
				-- Because GTK have a bug when press on a split area.
				-- The bug is: It will always set split position when left button released.
				--             And it not care about whether if user is dragging the spliter.
				-- So we disable "set split position to 0.5 when double presses" on GTK.
			if l_platform.is_windows then
				pointer_double_press_actions.extend
					(agent (a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32)
						do set_half end)
			end

			pointer_button_release_actions.extend
				(agent (a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32)
					do
						update_proportion
						if attached shared_environment.is_gtk3_implementation then
							set_proportion (proportion)
						end
					end)
			resize_actions.extend
				(agent (a_x, a_y, a_width, a_height: INTEGER_32)
					do remember_top_resize_split_area (Current) end)
			dpi_changed_actions.extend
				(agent (a_dpi: NATURAL_32; a_x, a_y, a_width, a_height: INTEGER_32)
					do remember_top_resize_split_area (Current) end)
		end

	set_half
			-- Set splitter position to half.
		local
			l_half: INTEGER
		do
			-- We don't use `set_proportion (0.5)' because this feature calculation base on minimum and maximum splitter position.
			l_half := height // 2
			if l_half >= minimum_split_position and l_half <= maximum_split_position then
				set_split_position (l_half)
			end
		end

feature -- Command

	set_split_position (a_split_position: INTEGER_32)
			-- <Precursor>
		do
			Precursor {EV_VERTICAL_SPLIT_AREA} (a_split_position)
			update_proportion
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_VERTICAL_SPLIT_AREA_I
			-- Responsible for interaction with native graphics toolkit.

invariant

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

end
