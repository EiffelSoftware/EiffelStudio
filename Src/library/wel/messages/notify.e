indexing
	description: "Information about message Wm_notify which informs the %
		%parent window of a control that an event has occured in the %
		%control or that the control requires some kind of information."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NOTIFY_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

creation
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
			!! Result.make_by_pointer (cwel_integer_to_pointer (l_param))
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwel_integer_to_pointer (i: INTEGER): POINTER is
			-- Converts an integer `i' to a pointer
		external
			"C [macro <wel.h>]"
		end

end -- class WEL_NOTIFY_MESSAGE

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
