indexing
	description: 
		"GET_SIZE_COMMAND, sets the size of widget.%
		% Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	GET_SIZE_COMMAND

inherit
	EV_COMMAND

feature -- Command execution

	execute (arg: EV_ARGUMENT3[EV_WIDGET, EV_TEXT_FIELD, EV_TEXT_FIELD]; data: EV_EVENT_DATA) is
		do
			arg.second.set_text (arg.first.width.out)
			arg.third.set_text (arg.first.height.out)
		end

end -- class GET_SIZE_COMMAND

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

