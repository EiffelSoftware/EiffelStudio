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

	EV_LIST_I
		export
			{NONE} set_multiple_selection, is_multiple_selection
			{NONE} selected_items
		undefine
			set_default_colors,
			set_default_options
		end

feature -- Access

	extended_height: INTEGER is
			-- height of the combo-box when the children are
			-- visible.
		require
			exists: not destroyed
		deferred
		end

feature -- Status Report

	is_multiple_selection: BOOLEAN is
			-- Combo box does not allow multiple selection
		do
			Result := False
		end

feature -- Status setting

	set_single_selection is
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
			exists: not destroyed
			valid_value: value >= 0
		deferred
		end

feature {NONE} -- Inapplicable

	set_multiple_selection is
			-- Not allowed for a combo box
		do
			check
				Inapplicable: False
			end
		end

	make_with_text (txt: STRING) is
			-- Create a text area with `par' as
			-- parent and `txt' as text.
		do
			check
				Inapplicable: False
			end
		end

end -- class EV_COMBO_BOX_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------
