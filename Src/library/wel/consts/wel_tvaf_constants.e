indexing
	description: "Tree view action flag (TVAF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVAF_CONSTANTS

feature -- Access

	Tvc_bykeyboard: INTEGER is 2
			-- Used for the `Tvn_selchanged' and `Tvn_selchanging'
			-- notification messages.
			-- Action done by a key stroke.
			--
			-- Declared in Windows as TVC_BYKEYBOARD

	Tvc_bymouse: INTEGER is 1
			-- Used for the `Tvn_selchanged' and `Tvn_selchanging'
			-- notification messages.
			-- Action done by a mouse click.
			--
			-- Declared in Windows as TVC_BYMOUSE

	Tvc_unknown: INTEGER is 0
			-- Used for the `Tvn_selchanged' or `Tvn_selchanging'
			-- notification messages.
			-- Action done by unknown.
			--
			-- Declared in Windows as TVC_UNKNOWN

	Tve_collapse: INTEGER is 1
			-- Used for the `Tvn_expand' or `Tvn_expanding'
			-- notification messages.
			-- Action done by collapsing the list.
			--
			-- Declared in Windows as TVE_COLLAPSE

	Tve_collapsereset: INTEGER is 32768
			-- Used for the `Tvn_expand' and `Tvn_expanding'
			-- notification messages.
			-- Action done by collapsing the list and removing
			-- the child items.
			--
			-- Declared in Windows as TVE_COLLAPSERESET

	Tve_expand: INTEGER is 2
			-- Used for the `Tvn_expand' and `Tvn_expanding'
			-- notification messages.
			-- Action done by expanding the list.
			--
			-- Declared in Windows as TVE_EXPAND

	Tve_toggle: INTEGER is 3
			-- Used for the `Tvn_expand' and `Tvn_expanding'
			-- notification messages.
			-- Action done by changing the list of the list 
			-- between collapse and expand.
			--
			-- Declared in Windows as TVE_TOGGLE

end -- class WEL_TVAF_CONSTANTS

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

