indexing
	description	: "Objects that process help requests according to a given help context."
	status		: "See notice at end of class."
	keywords	: "help"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EV_HELP_ENGINE

feature -- Basic Operations

	show (a_help_context: EV_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		require
			a_help_context_not_void: a_help_context /= Void
		deferred
		end
		
end -- class EV_HELP_ENGINE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
