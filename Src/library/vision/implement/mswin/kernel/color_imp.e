note
	description: "This class represents a MS_WINDOWS color"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	COLOR_IMP

inherit
	COLOR_I

	WEL_COLOR_REF
		rename
			make as wel_color_ref_make,
			make_system as wel_make_system,
			set_red as wel_set_red,
			set_green as wel_set_green,
			set_blue as wel_set_blue,
			set_rgb as wel_set_rgb,
			red as wel_red,
			green as wel_green,
			blue as wel_blue
		end

	COLOR_NAMES_WINDOWS

	WEL_COLOR_CONSTANTS

create
	make,
	make_by_wel,
	make_system,
	make_for_screen

feature -- Initialization

	make (a_color: COLOR)
			-- Make a color implementation
			-- for `a_color'.
		do
			wel_color_ref_make
		end

	make_for_screen (a_color: COLOR; a_screen: SCREEN)
			-- Make a color implementation
			-- for `a_color'.
		do
			wel_color_ref_make
		end


	make_system (color_id: INTEGER)
			-- Make a color according to `color_id'
		do
			wel_make_system (color_id)
		end

	make_by_wel (a_color_ref: WEL_COLOR_REF)
			-- Make a color implementation
			-- with information from `a_color_ref'.
		require
			a_color_ref_not_void: a_color_ref /= Void
		do
			wel_color_ref_make
			set_red (a_color_ref.red * 256)
			set_green (a_color_ref.green * 256)
			set_blue (a_color_ref.blue * 256)
		end

feature  -- Access

	allocated_red: INTEGER
			-- Red saturation level

	allocated_green: INTEGER
			-- Green saturation level

	allocated_blue: INTEGER
			-- Blue saturation level

	red: INTEGER
		do
			Result := allocated_red
		end

	green: INTEGER
		do
			Result := allocated_green
		end

	blue: INTEGER
		do
			Result := allocated_blue
		end

	is_white_by_default: BOOLEAN
			-- Default color used in case of failure
			-- to allocate desire color

	name: STRING
			-- Name of desired color for current

	rgb: INTEGER
			-- Return a RGB for Windows
		do
			Result := item
		end

feature -- Settings

	set_red (r: INTEGER)
			-- Set red saturation level to `green_value'.
		do
			allocated_red := r
			wel_set_red (r // 256)
			name := Void
		end

	set_green (g: INTEGER)
			-- Set green saturation level to `green_value'.
		do
			allocated_green := g
			wel_set_green (g // 256)
			name := Void
		end

	set_blue (b: INTEGER)
			-- Set blue saturation level to `green_value'.
		do
			allocated_blue := b
			wel_set_blue (b // 256)
			name := Void
		end

	set_rgb (r, g, b: INTEGER)
			-- Set red, green and blue saturation level respectivly to
			-- `red_value', `green_value' and `blue_value'.
		do
			allocated_red := r
			allocated_green := g
			allocated_blue := b
			wel_set_rgb (r // 256, g // 256, b // 256)
			name := Void
		end

	set_black_default
			-- Set black color to be used by default if
			-- it is impossible to allocate desire color.
		do
			is_white_by_default := False
		ensure then
			not is_white_by_default
		end

	set_colorref (colorref_value: INTEGER)
			-- Set the colorref
		do
			item := colorref_value
		end

	set_name (a_name: STRING)
                        -- Set color name to `a_name'.
		local
			rgb_tripple: RGB_TRIPLE
		do
			name := a_name.twin
			rgb_tripple := names @ (a_name)
			if rgb_tripple /= Void then
				wel_set_red (rgb_tripple.red)
				wel_set_green (rgb_tripple.green)
				wel_set_blue (rgb_tripple.blue)
			else
				if is_white_by_default then
					set_rgb (255 * 256, 255 * 256, 255 * 256)
				else
					set_rgb (0, 0, 0)
				end
				debug ("COLORS")
					print ("undefined color: ")
					print (a_name)
					print ("%N")
				end
			end
		end

	set_white_default
			-- Set white color to be used by default if
			-- it is impossible to allocate desire color.
		do
			is_white_by_default := True
		ensure then
			is_white_by_default
		end

	brush: WEL_BRUSH
			-- Windows Brush corresponding to this color.
		do
			create Result.make_solid (Current)
		end

feature {NONE} -- Implementation

	has (color_name: STRING): BOOLEAN
			-- Test if the color_name exists in the hash_table
		local
			s: STRING
		do
			s := color_name.as_lower
			Result := names.has (s)
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




end -- class COLOR_IMP

