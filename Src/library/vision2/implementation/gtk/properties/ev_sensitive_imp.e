indexing
	description: 
		"Eiffel Vision sensitive. GTK+ implementation."
	status: "See notice at end of class"
	keywords: "sensitive"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_SENSITIVE_IMP
	
inherit
	EV_SENSITIVE_I
		redefine
			interface
		end

	EV_ANY_IMP
		undefine
			destroy
		redefine
			interface
		end

feature -- Status report

	is_sensitive: BOOLEAN is
			-- Is the object sensitive to user input.
		do
			-- Shift to put bit in least significant place then take mod 2
			if not is_destroyed then
				Result := (
					(feature {EV_GTK_EXTERNALS}.gtk_object_struct_flags (event_widget)
					// feature {EV_GTK_EXTERNALS}.gTK_SENSITIVE_ENUM) \\ 2
				) = 1				
			end
		end

feature -- Status setting

	enable_sensitive is
			-- Allow the object to be sensitive to user input.
		do
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_sensitive (event_widget, True)
--			if needs_event_box then
--				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_event_box_set_visible_window (c_object, True)
--			end
		end

	disable_sensitive is
			-- Set the object to ignore all user input.
		do
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_sensitive (event_widget, False)
--			if needs_event_box then
--				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_event_box_set_visible_window (c_object, False)
--			end
		end

feature {EV_ANY_I} -- Implementation

	event_widget: POINTER is
			-- 
		deferred
		end

	interface: EV_SENSITIVE

end -- EV_SENSITIVE_IMP

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

