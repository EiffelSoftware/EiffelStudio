indexing
	description: "This class represents a MS_WINDOWS color";
	status: "See notice at end of class";
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

creation
	make,
	make_by_wel,
	make_system,
	make_for_screen

feature -- Initialization

	make (a_color: COLOR) is
			-- Make a color implementation
			-- for `a_color'.
		do
			wel_color_ref_make
		end

	make_for_screen (a_color: COLOR; a_screen: SCREEN) is
			-- Make a color implementation
			-- for `a_color'.
		do
			wel_color_ref_make
		end


	make_system (color_id: INTEGER) is
			-- Make a color according to `color_id'
		do
			wel_make_system (color_id)
		end

	make_by_wel (a_color_ref: WEL_COLOR_REF) is
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

	red: INTEGER is
		do
			Result := allocated_red
		end

	green: INTEGER is
		do
			Result := allocated_green
		end

	blue: INTEGER is
		do
			Result := allocated_blue
		end

	is_white_by_default: BOOLEAN
			-- Default color used in case of failure
			-- to allocate desire color

	name: STRING
			-- Name of desired color for current

	rgb: INTEGER is
			-- Return a RGB for Windows
		do
			Result := item
		end

feature -- Settings

	set_red (r: INTEGER) is
			-- Set red saturation level to `green_value'.
		do
			allocated_red := r
			wel_set_red (r // 256)
			name := Void
		end

	set_green (g: INTEGER) is
			-- Set green saturation level to `green_value'.
		do
			allocated_green := g
			wel_set_green (g // 256)
			name := Void
		end

	set_blue (b: INTEGER) is
			-- Set blue saturation level to `green_value'.
		do
			allocated_blue := b
			wel_set_blue (b // 256)
			name := Void
		end

	set_rgb (r, g, b: INTEGER) is
			-- Set red, green and blue saturation level respectivly to
			-- `red_value', `green_value' and `blue_value'.
		do
			allocated_red := r
			allocated_green := g
			allocated_blue := b
			wel_set_rgb (r // 256, g // 256, b // 256)
			name := Void
		end

	set_black_default is
			-- Set black color to be used by default if
			-- it is impossible to allocate desire color.
		do
			is_white_by_default := False
		ensure then
			not is_white_by_default
		end

	set_colorref (colorref_value: INTEGER) is
			-- Set the colorref 
		do
			item := colorref_value
		end

	set_name (a_name: STRING) is
                        -- Set color name to `a_name'.
		local
			rgb_tripple: RGB_TRIPLE
		do
			name := clone (a_name)
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

	set_white_default is
			-- Set white color to be used by default if
			-- it is impossible to allocate desire color.
		do
			is_white_by_default := True
		ensure then
			is_white_by_default
		end

	brush: WEL_BRUSH is
			-- Windows Brush corresponding to this color.
		do
			create Result.make_solid (Current)
		end

feature {NONE} -- Implementation

	has (color_name: STRING): BOOLEAN is
			-- Test if the color_name exists in the hash_table
		local
			s: STRING
		do
			s := clone (color_name)
			s.to_lower
			Result := names.has (s)
		end 

end -- class COLOR_IMP
 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

