indexing 
	description: "EiffelVision color selection dialog %
		%implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COLOR_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

feature -- Access

	color: EV_COLOR is
			-- Currently selected color.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Element change

	set_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `color'.
		require
			a_color_not_void: a_color /= Void
		deferred
		end

end -- class EV_COLOR_DIALOG_I

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

