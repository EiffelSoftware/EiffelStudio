indexing
	description:
		"Abstraction for objects that can change color."
	status: "See notice at end of class"
	keywords: "color, colored, colorable, colorizable, colorize"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_COLORIZABLE

inherit
	EV_ANY
		undefine
			create_action_sequences
		redefine
			implementation
		end
	
feature -- Access

	foreground_color: EV_COLOR is
			-- Color of foreground features like text.
		do
			Result := implementation.foreground_color
		ensure
			bridge_ok: Result.is_equal (implementation.foreground_color)
		end

	background_color: EV_COLOR is
			-- Color displayed behind foreground features.
		do
			Result := implementation.background_color
		ensure
			bridge_ok: Result.is_equal (implementation.background_color)
		end

feature -- Element change

	set_foreground_color (a_color: like foreground_color) is
			-- Assign `a_color' to `foreground_color'.
		require
			a_color_not_void: a_color /= Void
		do
			implementation.set_foreground_color (a_color)
		ensure
			foreground_color_assigned: foreground_color.is_equal (a_color)
		end

	set_background_color (a_color: like background_color) is
			-- Assign `a_color' to `foreground_color'.
		require
			a_color_not_void: a_color /= Void
		do
			implementation.set_background_color (a_color)
		ensure
			background_color_assigned: background_color.is_equal (a_color)
		end

feature -- Status setting

	set_default_colors is
			-- Set foreground and background color to their default values.
		do
			implementation.set_default_colors
		end	

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_COLORIZABLE_I
			-- Responsible for interaction with the native graphics toolkit.

invariant

	background_color_not_void: is_useable implies background_color /= Void
	foreground_color_not_void: is_useable implies foreground_color /= Void

end -- class EV_COLORIZABLE

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
--| Revision 1.1.2.1  2000/05/12 17:51:22  king
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
