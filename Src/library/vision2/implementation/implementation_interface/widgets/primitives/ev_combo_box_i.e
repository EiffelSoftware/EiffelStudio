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
		export
			{NONE} position, set_position, select_region
			{NONE} cut_selection, copy_selection, paste
			{NONE} selection_start, selection_end
			{NONE} has_selection, delete_selection
			{NONE} select_all, deselect_all
		end

	EV_LIST_I
		export
			{NONE} set_multiple_selection, is_multiple_selection
			{NONE} selected_items
			{NONE} add_double_click_selection_command, remove_double_click_selection_commands
		undefine
			set_default_colors,
			set_default_options
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

feature -- Measurement

	extended_height: INTEGER is
			-- height of the combo-box when the children are
			-- visible.
		require
			exists: not destroyed
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

	set_selection (start_position, end_position: INTEGER) is
			-- Set the selection between `start_position'
			-- and `end_position'.
		do
			check
				Inapplicable: False
			end
		end

	select_all is
			-- Select all the text.
		do
			check
				Inapplicable: False
			end
		end

	deselect_all is
			-- Unselect the current selection.
		do
			check
				Inapplicable: False
			end
		end

	delete_selection is
			-- Delete the current selection.
		do
			check
				Inapplicable: False
			end
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		do
			check
				Inapplicable: False
			end
		end

	selection_start: INTEGER is
			-- Index of the first character selected
		do
			check
				Inapplicable: False
			end
		end

	selection_end: INTEGER is
			-- Index of the last character selected
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

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			check
				Inapplicable: False
			end
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selectd_region' is empty, it does
			-- nothing.
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
