indexing
	description: "Information about message Wm_notify which informs the %
		%parent window of a control that an event has occurred in the %
		%control or that the control requires some kind of information."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NOTIFY_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

create
	make

feature -- Access

	id: INTEGER is
			-- Identifier of the control sending the message
		do
			Result := w_param
		end

	nmhdr: WEL_NMHDR is
			-- Information about the notification
		do
			create Result.make_by_pointer (cwel_integer_to_pointer (l_param))
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwel_integer_to_pointer (i: INTEGER): POINTER is
			-- Converts an integer `i' to a pointer
		external
			"C [macro <wel.h>] (int): EIF_POINTER"
		end

end -- class WEL_NOTIFY_MESSAGE

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

