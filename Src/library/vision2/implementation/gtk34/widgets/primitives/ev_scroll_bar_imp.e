note
	description: "Eiffel Vision scrollbar. GTK+ implementation."
	legal: "See notice at end of class."
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

	set_leap (a_leap: INTEGER)
			-- Set `leap' to `a_leap'.
			-- We redefine it to keep the page size the same as leap.
		do
			if leap /= a_leap then
				{GTK}.gtk_adjustment_set_upper (adjustment, value_range.upper + a_leap)
				{GTK}.gtk_adjustment_set_page_increment (adjustment, a_leap)
				{GTK}.gtk_adjustment_set_page_size (adjustment, a_leap)
			end
		ensure then
			range_same: value_range.is_equal (old value_range)
		end

feature {NONE} -- Implementation

	internal_set_upper
			-- Sets the upper value of the adjustment struct to take 'leap' in to account
		do
			{GTK}.gtk_adjustment_set_upper (
				adjustment,
				value_range.upper + leap
			)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_SCROLL_BAR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_SCROLL_BAR_IMP
