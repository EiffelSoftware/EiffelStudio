indexing
	description:
		"Enumeration class for text rich alignment       %
		% (left, center, right) for horizontal alignment %
		% (top, middle, bottom) for vertical alignment   "
	status: "See notice at end of class"
	keywords: "text, aligment, vertical, horizontal"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_RICH_ALIGNMENT

inherit
	EV_TEXT_ALIGNMENT

create
	default_create,
	make_with_left_alignment,
	make_with_center_alignment,
	make_with_right_alignment

feature -- Status setting

	set_top_alignment is
			-- Set the vertical alignment to "top"
		do
			vertical_alignment_code := top_alignment
		ensure
			is_top_aligned: is_top_aligned
		end

	set_middle_alignment is
			-- Set the vertical alignment to "top"
		do
			vertical_alignment_code := middle_alignment
		ensure
			is_middle_aligned: is_middle_aligned
		end

	set_bottom_alignment is
			-- Set the vertical alignment to "top"
		do
			vertical_alignment_code := bottom_alignment
		ensure
			is_bottom_aligned: is_bottom_aligned
		end

feature -- Status report

	is_top_aligned: BOOLEAN is
			-- Is the vertical alignment set to "top"?
		do
			Result := vertical_alignment_code = top_alignment
		end

	is_middle_aligned: BOOLEAN is
			-- Is the vertical alignment set to "middle"?
		do
			Result := vertical_alignment_code = middle_alignment
		end

	is_bottom_aligned: BOOLEAN is
			-- Is the vertical alignment set to "bottom"?
		do
			Result := vertical_alignment_code = bottom_alignment
		end

feature {EV_ANY_I} -- Implementation

	vertical_alignment_code: INTEGER
		-- Used internally to represent one of the three 
		-- vertical alignment states.

	top_alignment: INTEGER is 0 -- Default
	middle_alignment: INTEGER is 1
	bottom_alignment: INTEGER is 2

invariant
	vertical_alignment_code_within_range:  
		alignment_code >= top_alignment and 
		alignment_code <= bottom_alignment

end -- class EV_TEXT_RICH_ALIGNMENT

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
