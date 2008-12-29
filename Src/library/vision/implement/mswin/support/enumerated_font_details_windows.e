note	
	description: "This class represents a font that has been enumerated"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ENUMERATED_FONT_DETAILS_WINDOWS

create
	make

feature -- Initialization

	make (font_name, font_style: STRING)
			-- Create the enumertaed font details
		do
			name := font_name
			style := font_style	
			create sizes.make
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

	add (font_size: WEL_LOG_FONT)
			-- Add another font of the same style for size `font_size'
		do
			sizes.extend (font_size)
		end	

	fill_sizes (sizes_list: WEL_SINGLE_SELECTION_LIST_BOX)
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

	find_log_font (size: STRING): WEL_LOG_FONT
			-- Find the log font for `size'
		local
			c: CURSOR
		do
			if sizes.is_empty then
				create Result.make (size.to_integer * 2, name)
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

	set_truetype_log_font (lf: WEL_LOG_FONT)
		do
			truetype_log_font := lf
		end

	scaleable_sizes: ARRAY [INTEGER]
			-- Standard sizes for fonts that are scaleable.
		once
			create Result.make (1, 16)
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




end -- class ENUMERATED_FONT_DETAILS_WINDOWS

