indexing
	description: "Information about message Wm_timer which is sent after %
		%each interval specified in the `set_timer' procedure used to %
		%install a timer."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TIMER_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

creation
	make

feature -- Access

	id: INTEGER is
			-- Timer id specified with `set_timer'.
		do
			Result := w_param
		end

end -- class WEL_TIMER_MESSAGE

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
