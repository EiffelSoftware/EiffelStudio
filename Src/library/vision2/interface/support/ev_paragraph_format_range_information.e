indexing
	description: "[
		Objects that provide information for a range of lines in an EV_RICH_TEXT.
		Depending on the query applied to `Current', the values of all attributes are used in different
		fashions, sometimes to indicate which fields of an EV_PARAGRAPH_FORMAT are valid, or have a particular
		property. The applicable features in EV_RICH_TEXT which use `Current' provide full descriptions.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
	
inherit
	ANY
		export
			{NONE} default_create
		end

create
	make_with_values
	
feature -- Creation

	make_with_values (an_alignment, a_left_margin, a_right_margin, a_top_spacing, a_bottom_spacing: BOOLEAN) is
			-- Create `Current' and apply all values to corresponding attributes.
		do
			alignment := an_alignment
			left_margin := a_left_margin
			right_margin := a_right_margin
			top_spacing := a_top_spacing
			bottom_spacing := a_bottom_spacing
		end

feature -- Access
	
	alignment: BOOLEAN
		-- Is alignment of paragraph applicable?
		
	left_margin: BOOLEAN
		-- Is left margin of paragraph applicable?
		
	right_margin: BOOLEAN
		-- Is right margin of paragraph applicable?
		
	top_spacing: BOOLEAN
		-- Is top spacing of paragraph applicable?
		
	bottom_spacing: BOOLEAN
		-- Is bottom spacing of paragraph applicable?

end -- class EV_PARAGRAPH_FORMAT_RANGE_INFORMATION

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
