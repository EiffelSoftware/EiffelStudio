--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision Combo-box. Implementation interface"
	status: "See notice at end of class"
	names: widget
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COMBO_BOX_I

inherit
	EV_TEXT_FIELD_I
		redefine
			interface
		end

	EV_LIST_I
		export
			{NONE} enable_multiple_selection, multiple_selection_enabled
			{NONE} selected_items
		undefine
			set_default_colors
		redefine
			interface
		end

feature -- Access

	extended_height: INTEGER is
			-- height of the combo-box when the children are
			-- visible.
		require
		deferred
		end

feature -- Status Report

	multiple_selection_enabled: BOOLEAN is
			-- Combo box does not allow multiple selection
		do
			Result := False
		end

feature -- Status setting

	disable_multiple_selection is
			-- Do nothing, combo box is always single selection
		do
			check
				Inapplicable: True
			end
		end

feature -- Element change

	set_extended_height (value: INTEGER) is
			-- Make `value' the new extended-height of the box.
		require
			valid_value: value >= 0
		deferred
		end

feature {NONE} -- Inapplicable

	enable_multiple_selection is
			-- Not allowed for a combo box
		do
			check
				Inapplicable: False
			end
		end

--	make_with_text (txt: STRING) is
--			-- Create a text area with `par' as
--			-- parent and `txt' as text.
--		do
--			check
--				Inapplicable: False
--			end
--		end

feature {EV_COMBO_BOX_I} -- Implementation

	interface: EV_COMBO_BOX

end -- class EV_COMBO_BOX_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.23  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.22.6.6  2000/01/27 19:30:03  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.22.6.5  2000/01/15 00:53:44  oconnor
--| renamed is_multiple_selection -> multiple_selection_enabled, set_multiple_selection -> enable_multiple_selection & set_single_selection -> disable_multiple_selection
--|
--| Revision 1.22.6.4  1999/12/09 03:15:06  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.22.6.3  1999/12/03 07:46:36  oconnor
--| removed  set_default_options
--|
--| Revision 1.22.6.2  1999/11/30 22:47:14  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.22.6.1  1999/11/24 17:30:11  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.22.2.3  1999/11/04 23:10:44  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.22.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
