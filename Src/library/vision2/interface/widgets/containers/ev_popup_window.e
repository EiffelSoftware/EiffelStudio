indexing
	description:
		"[
			A window which does not appear in the task bar and is, by default, borderless.
			Useful for simulation of graphical elements such as tooltips and in-place editing.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POPUP_WINDOW

inherit
	EV_WINDOW
		redefine
			implementation,
			create_implementation,
			user_can_resize_default_state,
			is_border_enabled_default_state
		end
				
feature {NONE} -- Contract support
			
	user_can_resize_default_state: BOOLEAN is
			-- Is the default state of `Current' `user_can_resize'?
		do
			Result := False
		end
		
	is_border_enabled_default_state: BOOLEAN is
			-- Is the default state of `Current' `is_border_enabled'?
		do
			Result := False
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_POPUP_WINDOW_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_POPUP_WINDOW_IMP} implementation.make (Current)
		end

end

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
