indexing
	description: 
		"Eiffel Vision tooltipable. Implementation interface."
	status: "See notice at end of class"
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_TOOLTIPABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Access

	tooltip: STRING is
			-- Tooltip displayed on `Current'.
		deferred
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		require
			a_tooltip_not_void: a_tooltip /= Void
		deferred
		end

	remove_tooltip is
			-- Make `tooltip' `Void'.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

end -- class EV_TOOLTIPABLE_I

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

