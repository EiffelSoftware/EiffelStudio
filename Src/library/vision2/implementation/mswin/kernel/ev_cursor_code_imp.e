indexing
	description:
		"EiffelVision cursor code, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR_CODE_IMP

inherit
	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	busy: INTEGER is
			-- Standard arrow and small hourglass
		do
			Result := Idc_appstarting
		end

	standard: INTEGER is
			-- Standard arrow
		do
			Result := Idc_arrow
		end

	crosshair: INTEGER is
			-- Crosshair
		do
			Result := Idc_cross
		end

	help: INTEGER is
			-- Arrow and question mark
		do
			Result := Idc_help
		end

	ibeam: INTEGER is
			-- I-beam
		do
			Result := Idc_ibeam
		end

	no: INTEGER is
			-- Slashed_circle
		do
			Result := Idc_no
		end

	sizeall: INTEGER is
			-- Four-pointed arrow pointing north, south, east and west
		do
			Result := Idc_sizeall
		end

	sizenesw: INTEGER is
			-- Double-pointed arrow pointing northeast and southwest
		do
			Result := Idc_sizenesw
		end

	sizens: INTEGER is
			-- Double-pointed arrow pointing north and south
		do
			Result := Idc_sizens
		end

	sizenwse: INTEGER is
			-- Double-pointed arrow pointing west and east
		do
			Result := Idc_sizenwse
		end

	sizewe: INTEGER is
			-- Double-pointed arrow pointing west and east
		do
			Result := Idc_sizewe
		end

	uparrow: INTEGER is
			-- Vertical arrow
		do
			Result := Idc_uparrow
		end

	wait: INTEGER is
			-- Hourglass
		do
			Result := Idc_wait
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
