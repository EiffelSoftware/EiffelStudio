note
	description:
		"Eiffel Vision sensitive. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

feature -- Status report

	is_sensitive: BOOLEAN
			-- Is the object sensitive to user input.
		do
			-- Shift to put bit in least significant place then take mod 2
			if not is_destroyed then
				Result := {GTK}.gtk_widget_is_sensitive (c_object)
			end
		end

feature -- Status setting

	enable_sensitive
			-- Allow the object to be sensitive to user input.
		do
			{GTK}.gtk_widget_set_sensitive (c_object, True)
			if {GTK}.gtk_is_event_box (c_object) then
					-- Restore visible window for event box.
				{GTK2}.gtk_event_box_set_visible_window (c_object, True)
			end
		end

	disable_sensitive
			-- Set the object to ignore all user input.
		do
			{GTK}.gtk_widget_set_sensitive (c_object, False)
			if {GTK}.gtk_is_event_box (c_object) then
					-- We hide the event box Window so that it cannot be seen disabled.
				{GTK2}.gtk_event_box_set_visible_window (c_object, False)
			end
		end

feature {EV_ANY_I} -- Implementation

	c_object: POINTER
		deferred
		end

	has_parent: BOOLEAN
			-- Is `Current' parented?
		do
			Result := parent /= Void
		end

	parent: detachable EV_ANY
		deferred
		end

	parent_is_sensitive: BOOLEAN
			-- Is `parent' sensitive?
		local
			sensitive_parent: detachable EV_SENSITIVE
		do
			sensitive_parent ?= parent
			if sensitive_parent /= Void then
				Result := sensitive_parent.is_sensitive
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_SENSITIVE note option: stable attribute end;
			-- Interface object for implementation

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- EV_SENSITIVE_IMP











