indexing 
	description: "EiffelVision print dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_DIALOG_IMP

inherit
	EV_PRINT_DIALOG_I
	EV_STANDARD_DIALOG_IMP

creation
	make

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create a window with a parent.
		do
		end

feature -- Access

	from_page: INTEGER is
			-- Value for the starting page edit control
		do
		end

	to_page: INTEGER is
			-- Value for the ending page edit control
		do
		end

	copies: INTEGER is
			-- Number of copies for the Copies edit control
		do
		end

	maximum_range: INTEGER is
			-- Maximum value for the range of pages specified
			-- in the From and To page edit controls.
			-- 1 by default.
		do
		end

feature -- Status report

	all_pages_selected: BOOLEAN is
			-- Is the "All pages" radio button selected?
		do
		end

	page_numbers_selected: BOOLEAN is
			-- Is the "Page" radio button selected?
		do
		end

	selection_selected: BOOLEAN is
			-- Is the "Selection" radio button selected?
		do
		end

	print_to_file_checked: BOOLEAN is
			-- Is the "Print to file" check box checked?
		do
		end

	collate_checked: BOOLEAN is
			-- Is the "Collate" check box checked?
		do
		end

feature -- Status setting

	select_page_numbers is
			-- Select the "Page numbers" radio button.
			-- By default, the "All pages" button is selected.
		do
		end

	select_selection is
			-- Select the "Selection" radio button.
			-- By default, the "All pages" button is selected.
		do
		end

	check_print_to_file is
			-- Check the "Print to file" check box.
		do
		end

	check_collate is
			-- Check the "Collate" check box.
		do
		end

	disable_page_numbers is
			-- Disable the "Page numbers" radio button.
		do
		end

	disable_selection is
			-- Disable the "Selection" radio button.
		do
		end

	disable_print_to_file is
			-- Disable the "Print to file" check box.
		do
		end

	hide_print_to_file is
			-- Hide the "Print to file" check box.
		do
		end

feature -- Element change

	set_from_page (value: INTEGER) is
			-- Make `value' the new `from_page' number.
		do
		end

	set_to_page (value: INTEGER) is
			-- Make `value' the new `to_page' number.
		do
		end

	set_copies (value: INTEGER) is
			-- Make `value' the new `copies' number.
		do
		end

	set_maximum_range (value: INTEGER) is
			-- Make `value' the new maximum_range.
		do
		end

end -- class EV_PRINT_DIALOG_IMP

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
