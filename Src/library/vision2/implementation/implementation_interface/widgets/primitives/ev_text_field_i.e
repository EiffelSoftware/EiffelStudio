indexing
	description: 
		"Eiffel Vision text field. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_FIELD_I
	
inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface
		end
	
	EV_FONTABLE_I	
		redefine
			interface
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES_I

feature -- Status report

	capacity: INTEGER is
			-- Maximum number of characters field can hold.
		deferred
		end

feature -- Status setting

	set_capacity (a_capacity: INTEGER) is
			-- Assign `a_capacity' to `capacity'.
		require
			a_capacity_not_negative: a_capacity >= 0
		deferred
		end

	hide_border is
			-- Hide the border of `Current'.
		do
			-- Redefined in EV_TEXT_FIELD_IMP as it is not needed by all EV_TEXT_FIELD_I descendents.
		end

feature {EV_TEXT_FIELD_I} -- Implementation

	interface: EV_TEXT_FIELD
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	capacity_not_negative: capacity >= 0

end --class EV_TEXT_FIELD_I

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

