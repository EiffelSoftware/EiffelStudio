indexing
	description:
		"EV_COLORIZABLE implementation interface."
	status: "See notice at end of class"
	keywords: "color, colored, colorable"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_COLORIZABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Access

	foreground_color: EV_COLOR is
			-- Color of foreground features like text.
		deferred
		end

	background_color: EV_COLOR is
			-- Color displayed behind foregournd features.
		deferred
		end

feature -- Element change

	set_foreground_color (a_color: like foreground_color) is
			-- Assign `a_color' to `foreground_color'.
		require
			a_color_not_void: a_color /= Void
		deferred
		ensure
			foreground_color_assigned: is_initialized implies interface.implementation.foreground_color.is_equal (a_color)
		end

	set_background_color (a_color: like background_color) is
			-- Assign `a_color' to `foreground_color'.
		require
			a_color_not_void: a_color /= Void
		deferred
		ensure
			background_color_assigned: is_initialized implies interface.implementation.background_color.is_equal (a_color)
		end

feature -- Status setting

	set_default_colors is
			-- Set foreground and background color to their default values.
		deferred
		end	

feature {EV_ANY_I} -- Implementation
	
	interface: EV_COLORIZABLE

end -- class EV_COLORIZABLE_I

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.3  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.6  2000/10/27 01:28:28  manus
--| `set_default_colors' is now obsolet, so that it can be defined in an efficient manner
--| by platform independent classes.
--|
--| Revision 1.1.2.5  2000/10/09 18:04:11  king
--| Altered postconds of *_color to prevent failure on object initialization
--|
--| Revision 1.1.2.4  2000/09/29 20:32:43  manus
--| Changed post-condition for consistency since `implementation' can change on the fly, we
--| always have to rely on the `interface' one.
--|
--| Revision 1.1.2.3  2000/07/25 17:52:55  king
--| Altered invalid color assignment postcond interface.implementation call
--|
--| Revision 1.1.2.2  2000/07/21 22:11:38  pichery
--| Changed postconditons to work with EV_PIXMAP multiple
--| implementation on windows.
--|
--| Revision 1.1.2.1  2000/05/12 17:51:52  king
--| Initial
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
