note
	description: "[
			Same as EV_HORIZONTAL_SPLIT_AREA, except that when double click it'll set it's proportion to 50%.
			A decorator.
																										]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HORIZONTAL_SPLIT_AREA

inherit
	SD_MIDDLE_CONTAINER
		undefine
			is_in_default_state,
			initialize,
			copy
		end

	EV_HORIZONTAL_SPLIT_AREA
		redefine
			initialize,
			set_split_position
		select
			implementation,
			may_contain
		end

feature {NONE} -- Implementation

	initialize
			-- Redefine
		local
			l_platform: PLATFORM
		do
			Precursor {EV_HORIZONTAL_SPLIT_AREA}
			create l_platform
			-- Because GTK have a bug when press on a split area.
			-- The bug is: It will always set split position when left button released.
			--             And it not care about whether if user is dragging the spliter.			
			-- So we disable "set split position to 0.5 when double presses" on GTK.
			if l_platform.is_windows then
				pointer_double_press_actions.force_extend (agent set_half)
			end

			pointer_button_release_actions.force_extend (agent update_proportion)
			resize_actions.force_extend (agent remember_top_resize_split_area (Current))
		end

	set_half
			-- Set splitter position to half.
		local
			l_half: INTEGER
		do
			-- We don't use `set_proportion (0.5)' because this feature calculation base on minimum and maximum splitter position.
			l_half := width // 2
			if l_half >= minimum_split_position and l_half <= maximum_split_position then
				set_split_position (l_half)
			end
		end

feature -- Command

	set_split_position (a_split_position: INTEGER_32)
			-- <Precursor>
		do
			Precursor {EV_HORIZONTAL_SPLIT_AREA} (a_split_position)
			update_proportion
		end

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






end
