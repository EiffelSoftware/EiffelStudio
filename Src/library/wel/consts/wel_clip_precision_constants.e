indexing
	description: "Clipping precision (CLIP) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CLIP_PRECISION_CONSTANTS

feature -- Access

	Clip_default_precis: INTEGER is 0

	Clip_character_precis: INTEGER is 1

	Clip_stroke_precis: INTEGER is 2

	Clip_mask: INTEGER is 15

	Clip_lh_angles: INTEGER is 16
			-- Declared in Windows as CLIP_LH_ANGLES

	Clip_tt_always: INTEGER is 32
			-- Declared in Windows as CLIP_TT_ALWAYS

	Clip_embedded: INTEGER is 128
			-- Declared in Windows as CLIP_EMBEDDED

end -- class WEL_CLIP_PRECISION_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

