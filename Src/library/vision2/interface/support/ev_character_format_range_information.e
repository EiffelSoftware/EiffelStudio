indexing
	description: "[
		Objects that provide formatting information for a range of characters in an EV_RICH_TEXT.
		Information is a snapshot of the EV_RICH_TEXT at the time it was retrieved and does not
		remain consistent as the contents of the EV_RICH_TEXT are subsequently changed.
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_RANGE_INFORMATION
	
inherit
	ANY
		export
			{NONE} default_create
		end

create
	make_with_values
	
feature {EV_ANY_I} -- Creation

	make_with_values (lower_index, upper_index: INTEGER; family, weight, shape, height, color, striked_out, underlined: BOOLEAN) is
			-- Create `Current' and apply all values to corresponding attributes.
		do
			lower := lower_index
			upper := upper_index
			font_family_contiguous := family
			font_weight_contiguous := weight
			font_shape_contiguous := shape
			font_height_contiguous := height
			color_contiguous := color
			effects_striked_out_contiguous := striked_out
			effects_underlined_contiguous := underlined
		end

feature -- Access

	lower: INTEGER
		-- One based index of caret position signifying range start.
	
	upper: INTEGER
		-- One based index of caret position signifying range end.
	
	Font_family_contiguous: BOOLEAN
		-- Is family of font between `lower' and `upper' consistent?
	
	Font_weight_contiguous: BOOLEAN
		-- Is weight of font between `lower' and `upper' consistent?
	
	Font_shape_contiguous: BOOLEAN
		-- Is shape of font between `lower' and `upper' consistent?
	
	Font_height_contiguous: BOOLEAN
		-- Is height of font between `lower' and `upper' consistent?
		
	color_contiguous: BOOLEAN
		-- Is color applied to font between `lower' and `upper' consistent?
	
	effects_striked_out_contiguous: BOOLEAN
		-- Is striked out effect of font between `lower' and `upper' consistent?
	
	effects_underlined_contiguous: BOOLEAN
		-- Is underlined effect of font between `lower' and `upper' consistent?

end -- class EV_CHARACTER_FORMAT_INFORMATION

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

