indexing
	description:
		"Eiffel Vision Environment. Implementation interface.%N%
		%See ev_environment.e"
	status: "See notice at end of class"
	keywords: "environment, global, system"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ENVIRONMENT_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Status report

	platform: INTEGER is
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ENVIRONMENT
            -- Provides a common user interface to platform dependent
            -- functionality implemented by `Current'

feature -- Command

	destroy is
			-- Render current unuseable.
		do
			is_destroyed := True
			destroy_just_called := True
		end

end -- class EV_ENVIRONMENT_I

--!----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.5  2000/02/04 04:15:56  oconnor
--| release
--|
--| Revision 1.1.2.4  2000/01/27 19:29:54  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.3  1999/12/15 16:32:46  oconnor
--| formatting
--|
--| Revision 1.1.2.2  1999/12/15 05:22:21  oconnor
--| EV_ENVIRONMENT now inherits EV_ANY
--|
--| Revision 1.1.2.1  1999/12/09 22:48:08  brendel
--| New version of EV_ENVIRONMENT with feature `platform'. This feature is not
--| intended to be used by the way.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
