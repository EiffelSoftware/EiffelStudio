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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

