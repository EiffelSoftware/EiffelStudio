indexing
	description:
		"Enumeration class for text alignment"
	status: "See notice at end of class"
	keywords: "text, aligment"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_ALIGNMENT

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_left_alignment,
	make_with_center_alignment,
	make_with_right_aligment

feature {NONE} -- Initialization

	default_create is
		do
			set_left_alignment
		end

	make_with_left_alignment is
		do
			set_left_alignment
		end

	make_with_center_alignment is
		do
			set_center_aligment
		end

	make_with_right_alignment is
		do
			set_right_alignment
		end

feature -- Status setting

	set_left_alignment is
		do
			alignment_code := 1
		ensure
			is_left_aligned: is_left_aligned
		end

	set_center_alignment is
		do
			alignment_code := 2
		ensure
			is_center_aligned: is_center_aligned
		end

	set_right_alignment is
		do
			alignment_code := 3
		ensure
			is_right_aligned: is_right_aligned
		end

feature -- Status report

	is_left_aligned: BOOLEAN
		do
			Result := alignment_code = 1
		end

	is_center_aligned: BOOLEAN
		do
			Result := alignment_code = 2
		end

	is_right_aligned: BOOLEAN
		do
			Result := alignment_code = 3
		end

feature {NONE} -- Implementation

	alignment_code: INTEGER
		-- Used to represent one of the three alignment states.

invariant
	alignment_code_within_range:  alignment_code >= 1 and alignment_code <= 3

feature -- Implementation

end -- class EV_TEXT_ALIGNMENT

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
