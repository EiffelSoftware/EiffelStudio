indexing
	description:
		"Enumeration class for text alignment. Default is left."
	status: "See notice at end of class"
	keywords: "text, aligment"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_ALIGNMENT

create
	default_create,
	make_with_left_alignment,
	make_with_center_alignment,
	make_with_right_alignment

feature {NONE} -- Initialization

	make_with_left_alignment is
		do
			set_left_alignment
		end

	make_with_center_alignment is
		do
			set_center_alignment
		end

	make_with_right_alignment is
		do
			set_right_alignment
		end

feature -- Status setting

	set_left_alignment is
			-- Set the horizontal alignment to "left"
		do
			alignment_code := left_alignment
		ensure
			is_left_aligned: is_left_aligned
		end

	set_center_alignment is
			-- Set the horizontal alignment to "center"
		do
			alignment_code := center_alignment
		ensure
			is_center_aligned: is_center_aligned
		end

	set_right_alignment is
			-- Set the horizontal alignment to "right"
		do
			alignment_code := right_alignment
		ensure
			is_right_aligned: is_right_aligned
		end

feature -- Status report

	is_left_aligned: BOOLEAN is
		do
			Result := alignment_code = left_alignment
		end

	is_center_aligned: BOOLEAN is
		do
			Result := alignment_code = center_alignment
		end

	is_right_aligned: BOOLEAN is
		do
			Result := alignment_code = right_alignment
		end

feature {EV_ANY_I} -- Implementation

	alignment_code: INTEGER
		-- Used internally to represent one of the three alignment states.

	left_alignment: INTEGER is 0 -- Default
	center_alignment: INTEGER is 1
	right_alignment: INTEGER is 2

invariant
	alignment_code_within_range: 
		alignment_code >= left_alignment and 
		alignment_code <= right_alignment

end -- class EV_TEXT_ALIGNMENT

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------
