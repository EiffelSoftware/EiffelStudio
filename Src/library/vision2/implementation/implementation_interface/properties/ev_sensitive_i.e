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

	user_is_sensitive: BOOLEAN is
			-- Is the object sensitive to user input.
		do
			if not has_parent or else parent_is_sensitive then
				Result := is_sensitive
			end
		end

feature -- Status setting

	user_enable_sensitive is
			-- Make object sensitive to user input.
		do
			internal_non_sensitive := False
			enable_sensitive
		ensure
			is_sensitive_if_parent_sensitive:
				(has_parent and then parent_is_sensitive) implies interface.implementation.is_sensitive
			is_sensitive_if_orphaned: not has_parent implies interface.implementation.is_sensitive
		end

	user_disable_sensitive is
			-- Make object desensitive to user input.
		do
			internal_non_sensitive := True
			disable_sensitive
		ensure
			is_desensitive: not user_is_sensitive
		end

feature {EV_ANY_I} -- Implementation

	enable_sensitive is
			-- Make object sensitive to user input.
		deferred
		end

	disable_sensitive is
			-- Make object desensitive to user input.
		deferred
		end

	parent_is_sensitive: BOOLEAN is
		deferred
		end

	has_parent: BOOLEAN is
		deferred
		end

	internal_non_sensitive: BOOLEAN
		-- Is `Current' not sensitive to input as seen purely
		-- from the interface?
		
	is_sensitive: BOOLEAN is
			-- Is the object sensitive to user input.
		deferred
		end

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
--| Revision 1.3  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.6  2000/08/15 21:47:58  king
--| Corrected user_is_sensitive
--|
--| Revision 1.1.2.5  2000/08/15 20:53:26  rogers
--| Added enable_sensitive and disable_sensitive as deferred.
--|
--| Revision 1.1.2.4  2000/08/15 20:18:15  rogers
--| renamed enable_Sensitive to user_enable_Sensitive and disable sensitive to
--| user_disable_sensitive. They now set internal_non_sensitive as required.
--|
--| Revision 1.1.2.3  2000/08/15 19:47:07  king
--| Implemented user_is_sensitive
--|
--| Revision 1.1.2.2  2000/06/15 03:24:34  pichery
--| Changed precondition with interface.implementation to
--| take into account EV_PIXMAP_IMP on Windows changing
--| its implementation.
--|
--| Revision 1.1.2.1  2000/05/11 19:25:43  king
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
