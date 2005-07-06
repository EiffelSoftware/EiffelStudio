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
			destroy,
			needs_event_box
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
					({EV_GTK_EXTERNALS}.gtk_object_struct_flags (c_object)
					// {EV_GTK_EXTERNALS}.gTK_SENSITIVE_ENUM) \\ 2
				) = 1				
			end
		end

feature -- Status setting

	enable_sensitive is
			-- Allow the object to be sensitive to user input.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_set_sensitive (c_object, True)
			if needs_event_box then
					-- Restore visible window for event box.
				{EV_GTK_EXTERNALS}.gtk_event_box_set_visible_window (c_object, True)
			end
		end

	disable_sensitive is
			-- Set the object to ignore all user input.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_set_sensitive (c_object, False)
			if needs_event_box then
					-- We hide the event box Window so that it cannot be seen disabled.
				{EV_GTK_EXTERNALS}.gtk_event_box_set_visible_window (c_object, False)
			end
		end

feature {EV_ANY_I} -- Implementation

	has_parent: BOOLEAN is
			-- Is `Current' parented?
		do
			Result := parent /= Void
		end

	parent: EV_ANY is
		deferred
		end

	parent_is_sensitive: BOOLEAN is
			-- (export status {NONE})
		local
			sensitive_parent: EV_SENSITIVE
		do
			sensitive_parent ?= parent
			if sensitive_parent /= Void then
				Result := sensitive_parent.is_sensitive
			end
		end

	interface: EV_SENSITIVE
			-- Interface object for implementation

end -- EV_SENSITIVE_IMP

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

