indexing 
	description: "EiffelVision print dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_DIALOG

inherit
	EV_STANDARD_DIALOG
		redefine
			implementation
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create a window with a parent.
		do
			!EV_PRINT_DIALOG_IMP! implementation.make (par)
		end

feature -- Access

	from_page: INTEGER is
			-- Value for the starting page edit control
		require
			exist: not destroyed
		do
			Result := implementation.from_page
		ensure
			positive_result: Result >= 0
		end

	to_page: INTEGER is
			-- Value for the ending page edit control
		require
			exist: not destroyed
		do
			Result := implementation.to_page
		ensure
			positive_result: Result >= 0
		end

	copies: INTEGER is
			-- Number of copies for the Copies edit control
		require
			exist: not destroyed
		do
			Result := implementation.copies
		ensure
			positive_result: Result >= 0
		end

	maximum_range: INTEGER is
			-- Maximum value for the range of pages specified
			-- in the From and To page edit controls.
			-- 1 by default.
		require
			exist: not destroyed
		do
			Result := implementation.maximum_range
		ensure
			positive_result: Result >= 0
		end

feature -- Status report

	all_pages_selected: BOOLEAN is
			-- Is the "All pages" radio button selected?
		require
			exists: not destroyed
		do
			Result := implementation.all_pages_selected
		end

	page_numbers_selected: BOOLEAN is
			-- Is the "Page" radio button selected?
		require
			exists: not destroyed
		do
			Result := implementation.page_numbers_selected
		end

	selection_selected: BOOLEAN is
			-- Is the "Selection" radio button selected?
		require
			exists: not destroyed
		do
			Result := implementation.selection_selected
		end

	print_to_file_checked: BOOLEAN is
			-- Is the "Print to file" check box checked?
		require
			exists: not destroyed
		do
			Result := implementation.print_to_file_checked
		end

	collate_checked: BOOLEAN is
			-- Is the "Collate" check box checked?
		require
			exists: not destroyed
		do
			Result := implementation.collate_checked
		end

feature -- Status setting

	select_page_numbers is
			-- Select the "Page numbers" radio button.
			-- By default, the "All pages" button is selected.
		require
			exists: not destroyed
		do
			implementation.select_page_numbers
		end

	select_selection is
			-- Select the "Selection" radio button.
			-- By default, the "All pages" button is selected.
		require
			exists: not destroyed
		do
			implementation.select_selection
		end

	check_print_to_file is
			-- Check the "Print to file" check box.
		require
			exists: not destroyed
		do
			implementation.check_print_to_file
		ensure
			print_to_file_checked: print_to_file_checked
		end

	check_collate is
			-- Check the "Collate" check box.
		require
			exists: not destroyed
		do
			implementation.check_collate
		ensure
			collate_checked: collate_checked
		end

	disable_page_numbers is
			-- Disable the "Page numbers" radio button.
		require
			exists: not destroyed
		do
			implementation.disable_page_numbers
		end

	disable_selection is
			-- Disable the "Selection" radio button.
		require
			exists: not destroyed
		do
			implementation.disable_selection
		end

	disable_print_to_file is
			-- Disable the "Print to file" check box.
		require
			exists: not destroyed
		do
			implementation.disable_print_to_file
		end

	hide_print_to_file is
			-- Hide the "Print to file" check box.
		require
			exists: not destroyed
		do
			implementation.hide_print_to_file
		end

feature -- Element change

	set_from_page (value: INTEGER) is
			-- Make `value' the new `from_page' number.
		require
			exists: not destroyed
			positive_value: value >= 0
		do
			implementation.set_from_page (value)
		ensure
			from_page_set: from_page = value
		end

	set_to_page (value: INTEGER) is
			-- Make `value' the new `to_page' number.
		require
			exists: not destroyed
			positive_value: value >= 0
		do
			implementation.set_to_page (value)
		ensure
			to_page_set: to_page = value
		end

	set_copies (value: INTEGER) is
			-- Make `value' the new `copies' number.
		require
			exists: not destroyed
			positive_value: value >= 0
		do
			implementation.set_copies (value)
		ensure
			copies_set: copies = value
		end

	set_maximum_range (value: INTEGER) is
			-- Make `value' the new maximum_range.
		require
			exist: not destroyed
			positive_value: value >= 0
		do
			implementation.set_maximum_range (value)
		ensure
			maximum_range_set: maximum_range = value
		end

feature {NONE} -- Implementation

	implementation: EV_PRINT_DIALOG_I

end -- class EV_PRINT_DIALOG

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
