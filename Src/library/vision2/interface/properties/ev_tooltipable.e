indexing
	description:
		"Abstraction for objects that have a tooltip property."
	status: "See notice at end of class"
	keywords: "tooltip, popup, hint"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_TOOLTIPABLE

inherit
	EV_ANY
		redefine
			implementation,
			is_in_default_state
		end
	
feature -- Access

	tooltip: STRING is
			-- Tooltip displayed on `Current'.
			-- If `Result' is empty then no tooltip displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tooltip
		ensure
			bridge_ok: equal (Result, implementation.tooltip)
			not_void: Result /= Void
			cloned: Result /= implementation.tooltip
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		require
			not_destroyed: not is_destroyed
			tooltip: a_tooltip /= Void
		do
			implementation.set_tooltip (a_tooltip)
		ensure
			tooltip_assigned: a_tooltip.is_equal (tooltip)
			cloned: tooltip /= a_tooltip
		end

	remove_tooltip is
			-- Make `tooltip' empty.
		require
			not_destroyed: not is_destroyed
		do
			set_tooltip ("")
		ensure
			tooltip_removed: tooltip.is_empty
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ANY} and tooltip.is_empty
		end

feature {EV_TOOLTIPABLE_I} -- Implementation
	
	implementation: EV_TOOLTIPABLE_I
			-- Responsible for interaction with native graphics toolkit.

end -- class EV_TOOLTIPABLE

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

