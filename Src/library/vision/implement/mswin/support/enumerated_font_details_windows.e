indexing	
	description: "This class represents a font that has been enumerated";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ENUMERATED_FONT_DETAILS_WINDOWS

creation
	make

feature -- Initialization

	make (font_name, font_style: STRING) is
			-- Create the enumertaed font details
		do
			name := font_name
			style := font_style	
			!! sizes.make
		end

feature -- Access

	name: STRING
			-- Name of font

	sizes: LINKED_LIST [WEL_LOG_FONT]
			-- Sizes for `style'

	style: STRING
			-- Style of font

	truetype_log_font: WEL_LOG_FONT
			-- Log font for truetyp fonts

feature -- Status setting

	add (font_size: WEL_LOG_FONT) is
			-- Add another font of the same style for size `font_size'
		do
			sizes.extend (font_size)
		end	

	fill_sizes (sizes_list: WEL_SINGLE_SELECTION_LIST_BOX) is
			-- Fill `sizes_list' with the sizes
		local
			i: INTEGER
		do
			sizes_list.reset_content
			if sizes.count /= 0 then
				from
					sizes.start
				until
					sizes.after
				loop
					sizes_list.add_string (sizes.item.height.out)
					sizes.forth
				end
			else
				from
					i := scaleable_sizes.lower
				until
					i > scaleable_sizes.upper
				loop
					sizes_list.add_string (scaleable_sizes.item (i).out)
					i := i + 1
				end	
			end
		end

	find_log_font (size: STRING): WEL_LOG_FONT is
			-- Find the log font for `size'
		local
			c: CURSOR
		do
			if sizes.is_empty then
				!! Result.make (size.to_integer * 2, name)
				Result.set_not_underlined
				Result.set_not_strike_out
				Result.set_orientation (0)
				if style.substring_index ("Bold", 1) > 0 then
					Result.set_weight (700)
				else
					Result.set_weight (400)
				end
				if style.substring_index ("Italic", 1) > 0 then
					Result.set_italic
				else
					Result.set_not_italic
				end
				Result.set_escapement (0)
			else
				from
					c := sizes.cursor
					sizes.start
				until
					Result /= Void or sizes.after
				loop
					if sizes.item.height.out.is_equal (size) then
						Result := sizes.item
					end
					sizes.forth
				end
				sizes.go_to (c)
			end
		end

	set_truetype_log_font (lf: WEL_LOG_FONT) is
		do
			truetype_log_font := lf
		end

	scaleable_sizes: ARRAY [INTEGER] is
			-- Standard sizes for fonts that are scaleable.
		once
			!! Result.make (1, 16)
			Result.put (8, 1)
			Result.put (9, 2)
			Result.put (10, 3)
			Result.put (11, 4)
			Result.put (12, 5)
			Result.put (14, 6)
			Result.put (16, 7)
			Result.put (18, 8)
			Result.put (20, 9)
			Result.put (22, 10)
			Result.put (24, 11)
			Result.put (26, 12)
			Result.put (28, 13)
			Result.put (36, 14)
			Result.put (48, 15)
			Result.put (72, 16)
		end

invariant
	truetype_no_sizes: truetype_log_font /= Void implies sizes.is_empty

end -- class ENUMERATED_FONT_DETAILS_WINDOWS
 



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

