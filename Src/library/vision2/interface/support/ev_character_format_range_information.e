indexing
	description: "[
		Objects that provide information for a range of characters in an EV_RICH_TEXT.
		Depending on the query applied to `Current', the values of all attributes are used in different
		fashions, sometimes to indicate which fields of an EV_CHARACTER_FORMAT are valid, or have a particular
		property. The applicable features in EV_RICH_TEXT which use `Current' provide full descriptions.
			]"
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
	
feature -- Creation

	make_with_values (family, weight, shape, height, a_color, a_background_color, striked_out, underlined: BOOLEAN) is
			-- Create `Current' and apply all values to corresponding attributes.
		do
			font_family := family
			font_weight := weight
			font_shape := shape
			font_height := height
			color := a_color
			background_color := a_background_color
			effects_striked_out := striked_out
			effects_underlined := underlined
		end

feature -- Access
	
	Font_family: BOOLEAN
		-- Is family of font applicable?
	
	Font_weight: BOOLEAN
		-- Is weight of font applicable?
	
	Font_shape: BOOLEAN
		-- Is shape of font applicable?
	
	Font_height: BOOLEAN
		-- Is height of font applicable?
		
	color: BOOLEAN
		-- Is color of font applicable?
		
	background_color: BOOLEAN
		-- Is background color of font applicable?
	
	effects_striked_out: BOOLEAN
		-- Is striked out effect of font applicable?
	
	effects_underlined: BOOLEAN
		-- Is underlined effect of font applicable?

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

