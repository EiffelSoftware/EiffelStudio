indexing
	description:
		"Abstraction for objects that may ignore user input."
	status: "See notice at end of class"
	keywords: "sensitive, sensitivity, input"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_SENSITIVE

inherit
	EV_ANY
		undefine
			create_action_sequences
		redefine
			implementation
		end
	
feature -- Status report

	is_sensitive: BOOLEAN is
			-- Is object sensitive to user input.
		do
			Result := implementation.is_sensitive
		ensure
			bridge_ok: Result = implementation.is_sensitive
		end

feature -- Status setting

	enable_sensitive is
			-- Make object sensitive to user input.
		do
			implementation.enable_sensitive
		ensure
			is_sensitive: is_sensitive
		end

	disable_sensitive is
			-- Make object non-sensitive to user input.
		do
			implementation.disable_sensitive
		ensure
			is_unsensitive: not is_sensitive
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_SENSITIVE_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_SENSITIVE

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
--| Revision 1.2  2000/06/07 17:28:07  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.1.2.1  2000/05/11 19:27:30  king
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
