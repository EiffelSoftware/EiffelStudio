--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision cursor code, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR_CODE_IMP

inherit
	EV_C_ROUTINE_IMP

	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	busy: INTEGER is
			-- Standard arrow and small hourglass
		do
			Result := cwel_pointer_to_integer (Idc_appstarting)
		end

	standard: INTEGER is
			-- Standard arrow
		do
			Result := cwel_pointer_to_integer (Idc_arrow)
		end

	crosshair: INTEGER is
			-- Crosshair
		do
			Result := cwel_pointer_to_integer (Idc_cross)
		end

	help: INTEGER is
			-- Arrow and question mark
		do
			Result := cwel_pointer_to_integer (Idc_help)
		end

	ibeam: INTEGER is
			-- I-beam
		do
			Result := cwel_pointer_to_integer (Idc_ibeam)
		end

	no: INTEGER is
			-- Slashed_circle
		do
			Result := cwel_pointer_to_integer (Idc_no)
		end

	sizeall: INTEGER is
			-- Four-pointed arrow pointing north, south, east and west
		do
			Result := cwel_pointer_to_integer (Idc_sizeall)
		end

	sizenesw: INTEGER is
			-- Double-pointed arrow pointing northeast and southwest
		do
			Result := cwel_pointer_to_integer (Idc_sizenesw)
		end

	sizens: INTEGER is
			-- Double-pointed arrow pointing north and south
		do
			Result := cwel_pointer_to_integer (Idc_sizens)
		end

	sizenwse: INTEGER is
			-- Double-pointed arrow pointing west and east
		do
			Result := cwel_pointer_to_integer (Idc_sizenwse)
		end

	sizewe: INTEGER is
			-- Double-pointed arrow pointing west and east
		do
			Result := cwel_pointer_to_integer (Idc_sizewe)
		end

	uparrow: INTEGER is
			-- Vertical arrow
		do
			Result := cwel_pointer_to_integer (Idc_uparrow)
		end

	wait: INTEGER is
			-- Hourglass
		do
			Result := cwel_pointer_to_integer (Idc_wait)
		end

end -- class EV_CURSOR_CODE_IMP

--|----------------------------------------------------------------
--| EiffelVision Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.10.2  2000/01/27 19:30:10  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
