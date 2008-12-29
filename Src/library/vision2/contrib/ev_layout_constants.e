note
	description	: "Constants for layout using Vision2"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LAYOUT_CONSTANTS

feature -- Access (button size constants)

	default_button_width: INTEGER
			-- Default width for buttons
		once
			Result := dialog_unit_to_pixels (75)
		end

	default_button_height: INTEGER
			-- Default height for buttons
		once
			Result := dialog_unit_to_pixels (23)
		end

feature -- Access (padding constants)

	default_padding_size: INTEGER
			-- Default size for padding
		once
			Result := dialog_unit_to_pixels (14)
		end

	small_padding_size: INTEGER
			-- Small size for padding
		once
			Result := dialog_unit_to_pixels (10)
		end

	tiny_padding_size: INTEGER
			-- Tiny size for padding
		once
			Result := dialog_unit_to_pixels (3)
		end

feature -- Access (border constants)

	large_border_size: INTEGER
			-- Default size for borders
		once
			Result := dialog_unit_to_pixels (10)
		end

	default_border_size: INTEGER
			-- Default size for borders
		once
			Result := dialog_unit_to_pixels (7)
		end

	small_border_size: INTEGER
			-- Small size for borders
		once
			Result := dialog_unit_to_pixels (5)
		end

feature -- Operation

	set_default_size_for_button (a_button: EV_BUTTON)
			-- Set the default size for `a_button'.
		do
			a_button.set_minimum_size (
				a_button.minimum_width.max (Default_button_width),
				a_button.minimum_height.max (Default_button_height))
		end

	set_default_width_for_button (a_button: EV_BUTTON)
			-- Set the default width for `a_button'.
		do
			a_button.set_minimum_width (
				a_button.minimum_width.max (Default_button_width))
		end

feature -- Conversion

	dialog_unit_to_pixels (a_size: INTEGER): INTEGER
			-- Convert `a_size' dialog units into pixels.
			-- Used to get the same look&feel under all platforms
		do
			if resolution = 96 then
				Result := a_size
			else
				Result := (a_size * resolution) // 96
			end
		end

feature {NONE} -- Implementation

	resolution: INTEGER
			-- Resolution for current display.
		once
			Result := (create {EV_SCREEN}).horizontal_resolution
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_LAYOUT_CONSTANTS

