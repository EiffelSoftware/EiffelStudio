indexing
	description:
		"Eiffel Vision timeout. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TIMEOUT_IMP

inherit
	EV_TIMEOUT_I

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create timer.
		do
			base_make (an_interface)
		end

	initialize is
		do
			internal_timeout.add_timeout (Current)
			is_initialized := True
		end

feature -- Access

	interval: INTEGER
			-- Time between calls to `interface.actions' in milliseconds.

feature -- Status setting

	set_interval (an_interval: INTEGER) is
			-- Assign `an_interval' in milliseconds to `interval'.
		do
			if interval /= an_interval then
				interval := an_interval
				internal_timeout.change_interval (id, interval)
			end
		end

feature {EV_INTERNAL_TIMEOUT_IMP} -- Implementation

	id: INTEGER
			-- Id needed to destroy the current timeout.

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
			Result := not internal_timeout.timeouts.has (id)
		end

	destroy is
			-- Destroy actual object.
		do
			internal_timeout.remove_timeout (id)
		end

	set_id (value: INTEGER) is
			-- Make `value' the new id of the timeout.
		do
			id := value
		end

feature {NONE} -- Implementation

	internal_timeout: EV_INTERNAL_TIMEOUT_IMP is
			-- Window that launch the timeout commands.
		once
			create result.make_top ("EiffelVision timeout window")
		end

end -- class EV_TIMEOUT_IMP

--!----------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/03/06 23:11:11  brendel
--| Implemented new interface.
--|
--| Revision 1.7  2000/02/19 07:34:49  oconnor
--| removed old commandstuff
--|
--| Revision 1.6  2000/02/19 07:03:52  oconnor
--| removed command
--|
--| Revision 1.5  2000/02/19 06:34:12  oconnor
--| removed old command stuff
--|
--| Revision 1.4  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.3  2000/02/19 04:34:55  oconnor
--| removed command code, implemented deferred features
--|
--| Revision 1.2  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.1.10.3  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.1.10.2  2000/01/27 19:30:11  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.10.1  1999/11/24 17:30:18  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.6.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
