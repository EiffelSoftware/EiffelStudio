indexing
	description: "Description of a font";
	note: "On GTK, the fonts are defined only by their name.%
		% The name of the font looks as follow :%
		% -Adobe-Times-Medium-R-Normal--14-140-75-75-P-74-ISO8859-1.%
		% For more information, check the font-selection%
		% dialog of gtk."
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_FONT_IMP 

inherit
 	EV_FONT_I

	EV_GDK_FONT_EXTERNALS

creation
	make,
	make_by_name,
	make_by_system_name

feature {NONE} -- Initialization

 	make is
 			-- Create the default font.
		local
			a: ANY 
		do
			!! system_name.make_default
			a := full_name.to_c
			widget := gdk_font_load ($a)	
 		end

	make_by_name (str: STRING) is
			-- Create the font corresponding to the given name.
			-- The font is directly readed on a file.
		local
			a: ANY
		do
			!! system_name.make_by_name (str)
			a := full_name.to_c
			widget := gdk_font_load ($a)
		end

	make_by_system_name (str: STRING) is
			-- Create a font thanks to the system
			--name.
		local
			a: ANY
		do
			!! system_name.make_by_system_name (str)
			a := full_name.to_c
			widget := gdk_font_load ($a)
		end

feature -- Access

	name: STRING is
			-- Name of the font
		do
			Result := system_name.family
		end

	ascent: INTEGER is
			-- Ascent value in pixel of the font loaded.
		do
			Result := c_gdk_font_ascent (widget)
		end

	descent: INTEGER is
			-- Descent value in pixel of the font loaded.
		do
			Result := c_gdk_font_descent (widget)
		end

feature -- Measurement

	height: INTEGER is
			-- Height of the font
			-- In points.
		do
			Result := (system_name.point_size).to_integer
		end

	width: INTEGER is
			-- Average width of the current font
		do
			Result := (system_name.average_width).to_integer
		end

	maximum_width: INTEGER is
			-- Width of the widest character in the font
		do
			check
				not_yet_implemented: False
			end
		end
		
	string_width (str: STRING): INTEGER is
			-- Width in pixel of `str' in the current font.
		local
			a: ANY
		do
			a := str.to_c
			Result := gdk_string_width (widget, $a)
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font
			-- is designed`
		do
			Result := (system_name.resolution_x).to_integer
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font
			-- is designed
		do
			Result := (system_name.resolution_y).to_integer
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
			Result := widget = default_pointer
		end

	is_bold: BOOLEAN is
			-- Is the font bold?
		do
			Result := system_name.weight = "bold" or
				system_name.weight = "demibold"
		end

	is_italic: BOOLEAN is
			-- Is the font italic?
		do
			Result := system_name.slant = "I"
		end

	is_proportional: BOOLEAN is
			-- Is the font proportional?
		do
			Result := system_name.spacing = "P"
		end

 	is_standard: BOOLEAN is
 			-- Is the font standard and informations available (except for name) ?
 		do
 		end
 
	weight: STRING is
			-- Weight of font (Bold, Medium...)
		do
			Result := system_name.weight
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			widget := default_pointer		
		end

	set_bold (flag: BOOLEAN) is
			-- Set bold characters if `flag', unset otherwise.
		local
			old_weight: STRING
			a: ANY
		do
			old_weight := system_name.weight
			if flag then
				system_name.set_weight ("Bold")
			else
				system_name.set_weight ("Medium")
			end
			a := system_name.basic_name.to_c
			widget := gdk_font_load ($a)
			if widget = default_pointer then
				io.put_string ("The bold format is not availbale for this font.%N")
				system_name.set_weight (old_weight)
				a := full_name.to_c
				widget := gdk_font_load ($a)
			end
		end

	set_italic (flag: BOOLEAN) is
			-- Set italic characters if `flag', unset otherwise.
		local
			old_slant: STRING
			a: ANY
		do
			old_slant := system_name.slant
			if flag then
				system_name.set_slant ("I")
			else
				system_name.set_slant ("R")
			end
			a := system_name.basic_name.to_c
			widget := gdk_font_load ($a)
			if widget = default_pointer then
				io.put_string ("The italic format is not available for this font.%N")
				system_name.set_slant (old_slant)
				a := full_name.to_c
				widget := gdk_font_load ($a)
			end
		end

feature -- Element change

	set_name (str: STRING) is
			-- Make `str' the new name of the string.
		do
		end

	set_width (value: INTEGER) is
			-- Make `value' the new width.
		do
		end

	set_height (value: INTEGER) is
			-- Make `value' the new height.
		do
		end

	set_weight (value: INTEGER) is
			-- Make `str' the new weight.
		do
		end

feature -- Implementation

	widget: POINTER
		-- A pointer on a GdkFont

feature {NONE} -- Implementation

	system_name: EV_FONT_NAME_IMP
		-- System name of the font

	full_name: STRING is
			-- The full name of the string.
		do
			Result := system_name.system_name
		end
	
end -- class EV_FONT_IMP

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

