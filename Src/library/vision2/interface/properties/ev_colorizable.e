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
		redefine
			implementation
		end
	
feature -- Access

	foreground_color: EV_COLOR is
			-- Color of foreground features like text.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.foreground_color
		ensure
			bridge_ok: Result.is_equal (implementation.foreground_color)
		end

	background_color: EV_COLOR is
			-- Color displayed behind foreground features.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.background_color
		ensure
			bridge_ok: Result.is_equal (implementation.background_color)
		end

feature -- Element change

	set_foreground_color (a_color: like foreground_color) is
			-- Assign `a_color' to `foreground_color'.
		require
			not_destroyed: not is_destroyed
			a_color_not_void: a_color /= Void
		do
			implementation.set_foreground_color (a_color)
		ensure
			foreground_color_assigned: foreground_color.is_equal (a_color)
		end

	set_background_color (a_color: like background_color) is
			-- Assign `a_color' to `foreground_color'.
		require
			not_destroyed: not is_destroyed
			a_color_not_void: a_color /= Void
		do
			implementation.set_background_color (a_color)
		ensure
			background_color_assigned: background_color.is_equal (a_color)
		end

feature -- Status setting

	set_default_colors is
			-- Set foreground and background color to their default values.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_default_colors
		end	

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_COLORIZABLE_I
			-- Responsible for interaction with native graphics toolkit.

invariant

	background_color_not_void: is_usable implies background_color /= Void
	foreground_color_not_void: is_usable implies foreground_color /= Void

end -- class EV_COLORIZABLE

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

