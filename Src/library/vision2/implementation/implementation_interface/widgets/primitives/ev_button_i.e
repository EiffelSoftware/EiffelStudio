indexing
	description:
		"Eiffel Vision button. Implementation interface."
	status: "See notice at end of class"
	keywords: "press, push, label, pixmap"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_BUTTON_I 

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_TEXT_ALIGNABLE_I
		redefine
			interface
		end

	EV_PIXMAPABLE_I
		redefine
			interface
		end

	EV_BUTTON_ACTION_SEQUENCES_I

feature -- Access

	is_default_push_button: BOOLEAN is
			-- Is this button currently a default push button 
			-- for a particular container?
		deferred
		end

feature -- Status Setting

	enable_default_push_button is
			-- Set the style of the button corresponding
			-- to the default push button.
		deferred
		ensure
			is_default_push_button: is_default_push_button
		end

	disable_default_push_button is
			-- Remove the style of the button corresponding
			-- to the default push button.
		deferred
		ensure
			is_not_default_push_button: not is_default_push_button
		end

	enable_can_default is
			-- Allow the style of the button to be changed to the
			-- default push button if tabbed to by the user
			-- (GTK implementation needed only)
		require
			is_not_default_push_button: not is_default_push_button
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_BUTTON
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_BUTTON_I

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

