--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"Each code represent a kind of cursor."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR_CODE

obsolete
	"Don't use it. Use EV_DEFAULT_PIXMAPS instead"

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature -- Initialization

	default_create is
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

	sizens: INTEGER is
			-- Double-pointed arrow pointing north and south
		do
			Result := implementation.sizens
		end

	sizewe: INTEGER is
			-- Double-pointed arrow pointing west and east
		do
			Result := implementation.sizewe
		end

	uparrow: INTEGER is
			-- Vertical arrow
		do
			Result := implementation.uparrow
		end

	wait: INTEGER is
			-- Hourglass
		do
			Result := implementation.wait
		end

feature -- Implementation

	implementation: EV_CURSOR_CODE_IMP
			-- Platform dependent access

end -- class EV_CURSOR_CODE

--!-----------------------------------------------------------------------------
--! EiffelVision Library: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/06/07 17:28:06  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.4.4.3  2000/05/04 17:41:08  brendel
--| Moved obsolete clause.
--|
--| Revision 1.4.4.2  2000/05/04 04:16:09  pichery
--| This class is now Obsolete and marked as it.
--|
--| Revision 1.4.4.1  2000/05/03 19:10:00  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/03/15 22:48:35  king
--| Removed make procedure, now using default_create
--|
--| Revision 1.6  2000/02/22 18:39:48  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:48  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.3  2000/01/28 22:24:21  oconnor
--| released
--|
--| Revision 1.4.6.2  2000/01/27 19:30:44  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:30:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
