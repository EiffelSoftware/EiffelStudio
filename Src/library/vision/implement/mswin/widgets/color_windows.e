indexing
	description: "This class represents a MS_WINDOWS color";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	COLOR_WINDOWS

inherit
	COLOR_I

	WEL_COLOR_REF
		rename
			make as wel_color_ref_make,
			make_system as wel_make_system,
			set_red as wel_set_red,
			set_green as wel_set_green,
			set_blue as wel_set_blue,
			red as wel_red,
			green as wel_green,
			blue as wel_blue
		end

	COLOR_NAMES_WINDOWS

creation
	make,
	make_by_wel,
	make_system

feature -- Initialization

	make (a_color: COLOR) is
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

	red: INTEGER
			-- Red saturation level

	green: INTEGER
			-- Green saturation level

	blue: INTEGER
			-- Blue saturation level

	allocated_blue: INTEGER is
                        -- Allocated blue saturation level for `a_widget'
		do
			Result := blue
		end

	allocated_green: INTEGER is
                        -- Allocated green saturation level for `a_widget'
		do
			Result := green
		end

	allocated_red: INTEGER is
                        -- Allocated red saturation level for `a_widget'
		do
			Result := red
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
			-- Set redsaturation level to `green_value'.
		do
			red := r
			wel_set_red (r // 256)
			name := Void
		end

	set_green (g: INTEGER) is
			-- Set green saturation level to `green_value'.
		do
			green := g
			wel_set_green (g // 256)
			name := Void
		end

	set_blue (b: INTEGER) is
			-- Set blue saturation level to `green_value'.
		do
			blue := b
			wel_set_blue (b // 256)
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
					wel_set_red (255)
					wel_set_green (255)
					wel_set_blue (255)
				else
					wel_set_red (0)
					wel_set_green (0)
					wel_set_blue (0)
				end
				debug ("COLORS")
					print ("undefined color: ")
					print (a_name)
					print ("%N")
				end
			end
			!! allocated_brush.make_solid (Current)
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
			if allocated_brush = Void then
				!! allocated_brush.make_solid (Current)
			end
			Result := allocated_brush
		end

feature {NONE} -- Implementation

	allocated_brush: WEL_BRUSH
			-- Brush corresponding to the color

	has (color_name: STRING): BOOLEAN is
			-- Test if the color_name exists in the hash_table
		local
			s: STRING
		do
			s := clone (color_name)
			s.to_lower
			Result := names.has (s)
		end 

end -- class COLOR_WINDOWS
 
--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

