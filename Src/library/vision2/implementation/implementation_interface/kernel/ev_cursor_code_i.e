indexing
	description:
		"EiffelVision cursor code, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CURSOR_CODE_I

feature -- Access


	busy: INTEGER is
			-- Standard arrow and small hourglass
		deferred
		end

	standard: INTEGER is
			-- Standard arrow
		deferred
		end

	crosshair: INTEGER is
			-- Crosshair
		deferred
		end

	help: INTEGER is
			-- Arrow and question mark
		deferred
		end

	ibeam: INTEGER is
			-- I-beam
		deferred
		end

	no: INTEGER is
			-- Slashed_circle
		deferred
		end

	sizeall: INTEGER is
			-- Four-pointed arrow pointing north, south, east and west
		deferred
		end

	sizenesw: INTEGER is
			-- double-pointed arrow pointing northeast and southwest
		deferred
		end

	sizens: INTEGER is
			-- Double-pointed arrow pointing north and south
		deferred
		end

	sizenwse: INTEGER is
			-- Double-pointed arrow pointing west and east
		deferred
		end

	sizewe: INTEGER is
			-- Double-pointed arrow pointing west and east
		deferred
		end

	uparrow: INTEGER is
			-- Vertical arrow
		deferred
		end

	wait: INTEGER is
			-- Hourglass
		deferred
		end

end -- class EV_CURSOR_CODE_I

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
