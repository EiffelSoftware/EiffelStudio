indexing
	description: 
		"Eiffel Vision tooltipable. GTK+ implementation."
	status: "See notice at end of class"
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TOOLTIPABLE_IMP
	
inherit
	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

feature -- Initialization

	tooltip: STRING
			-- Tooltip that has been set.

feature -- Element change

	set_tooltip (a_text: STRING) is
			-- Set `tooltip' to `a_text'.
		local
			tempstr: ANY
		do
			tooltip := clone (a_text)
			tempstr := tooltip.to_c
			C.gtk_tooltips_set_tip (
				app_implementation.tooltips,
				c_object,
				$tempstr,
				NULL
			)
		end

	remove_tooltip is
			-- Set `tooltip' to `Void'.
	    do
			tooltip := Void
			C.gtk_tooltips_set_tip (
				app_implementation.tooltips,
				c_object,
				NULL,
				NULL
			)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE

end -- EV_TOOLTIPABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

