indexing
	description: 
		"Eiffel Vision sensitive. Implementation interface."
	status: "See notice at end of class"
	keywords: "sensitive, input"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_SENSITIVE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Status report

	is_sensitive: BOOLEAN is
			-- Is the object sensitive to user input.
		deferred
		end

feature -- Status setting

	enable_sensitive is
			-- Make object sensitive to user input.
		deferred
		ensure
			is_sensitive: is_sensitive
		end

	disable_sensitive is
			-- Make object desensitive to user input.
		deferred
		ensure
			is_desensitive: not is_sensitive
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SENSITIVE
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

end -- class EV_SENSITIVE_I

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/06/07 17:27:45  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.1.2.1  2000/05/11 19:25:43  king
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
