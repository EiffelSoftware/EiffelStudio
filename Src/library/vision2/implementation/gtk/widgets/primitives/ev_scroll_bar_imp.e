indexing
	description: "Eiffel Vision scrollbar. GTK+ implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCROLL_BAR_IMP

inherit
	EV_SCROLL_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface,
			set_leap,
			internal_set_upper
		end

feature -- Element change

	set_leap (a_leap: INTEGER) is
			-- Set `leap' to `a_leap'.
			-- We redefine it to keep the page size the same as leap.
		do
			if leap /= a_leap then
				{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_upper (adjustment, value_range.upper + a_leap)
				{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_page_increment (adjustment, a_leap)
				{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_page_size (adjustment, a_leap)
				{EV_GTK_EXTERNALS}.gtk_adjustment_changed (adjustment)
			end
		ensure then
			range_same: value_range.is_equal (old value_range)
		end

feature {NONE} -- Implementation

	internal_set_upper is
			-- Sets the upper value of the adjustment struct to take 'leap' in to account
		do
			{EV_GTK_EXTERNALS}.set_gtk_adjustment_struct_upper (
				adjustment,
				value_range.upper + leap
			)			
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SCROLL_BAR

end -- class EV_SCROLL_BAR_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

