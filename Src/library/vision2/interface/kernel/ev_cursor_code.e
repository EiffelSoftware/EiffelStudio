indexing
	description:
		"Each code represent a kind of cursor."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR_CODE

creation
	make

feature -- Initialization

	make is
			-- Create the object
		do
			create {EV_CURSOR_CODE_IMP} implementation
		end

feature -- Access

	busy: INTEGER is
			-- Standard arrow and small hourglass
		do
			Result := implementation.busy
		end

	standard: INTEGER is
			-- Standard arrow
		do
			Result := implementation.standard
		end

	crosshair: INTEGER is
			-- Crosshair
		do
			Result := implementation.crosshair
		end

	help: INTEGER is
			-- Arrow and question mark
		do
			Result := implementation.help
		end

	ibeam: INTEGER is
			-- I-beam
		do
			Result := implementation.ibeam
		end

	no: INTEGER is
			-- Slashed_circle
		do
			Result := implementation.no
		end

	sizeall: INTEGER is
			-- Four-pointed arrow pointing north, south, east and west
		do
			Result := implementation.sizeall
		end

	sizenesw: INTEGER is
			-- Double-pointed arrow pointing northeast and southwest
		do
			Result := implementation.sizenesw
		end

	sizens: INTEGER is
			-- Double-pointed arrow pointing north and south
		do
			Result := implementation.sizens
		end

	sizenwse: INTEGER is
			-- Double-pointed arrow pointing west and east
		do
			Result := implementation.sizenwse
		end

	sizewe: INTEGER is
			-- Double-pointed arrow pointing west and east
		do
			Result := implementation.sizewe
		end

	uparrow: INTEGER is
			-- Vertical arrow
		do
			Result := implementation.sizewe
		end

	wait: INTEGER is
			-- Hourglass
		do
			Result := implementation.wait
		end

feature -- Implementation

	implementation: EV_CURSOR_CODE_I
			-- Platform dependent access

end -- class EV_CURSOR_CODE

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
