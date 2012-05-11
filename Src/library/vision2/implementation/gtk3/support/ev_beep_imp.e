note
	description: "Eiffel Vision beep routines. Gtk implementation"
	legal: "See notice at end of class."
	keywords: "color, pixel, rgb, 8, 16, 24"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: 86769 $"


class
	EV_BEEP_IMP

inherit
	EV_BEEP_I

create
	make

feature {NONE} -- Initlization

	old_make (an_interface: EV_BEEP)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

	destroy
			-- Render `Current' unusable.
			-- No externals to deallocate, just set the flags.
		do
			set_is_destroyed (True)
		end

feature -- Commands

	asterisk
			-- Asterisk beep.
		do
			{GTK}.gdk_beep
		end

	exclamation
			-- Exclamation beep.
		do
			{GTK}.gdk_beep
		end

	hand
			-- Hand beep.
		do
			{GTK}.gdk_beep
		end

	question
			-- Question beep.
		do
			{GTK}.gdk_beep
		end

	ok
			-- Ok beep.
			-- System default beep.
		do
			{GTK}.gdk_beep
		end

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




end -- class EV_BEEP_IMP
