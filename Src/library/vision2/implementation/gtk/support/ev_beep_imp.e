indexing
	description: "Eiffel Vision beep routines. Gtk implementation"
	legal: "See notice at end of class."
	keywords: "color, pixel, rgb, 8, 16, 24"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	EV_BEEP_IMP

inherit
	EV_BEEP_I

create
	make

feature {NONE} -- Initlization

	make (an_interface: EV_BEEP) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

	destroy is
			-- Render `Current' unusable.
			-- No externals to deallocate, just set the flags.
		do
			set_is_destroyed (True)
		end

feature -- Commands

	asterisk is
			-- Asterisk beep.
		do
			{EV_GTK_EXTERNALS}.gdk_beep
		end

	exclamation is
			-- Exclamation beep.
		do
			{EV_GTK_EXTERNALS}.gdk_beep
		end

	hand is
			-- Hand beep.
		do
			{EV_GTK_EXTERNALS}.gdk_beep
		end

	question is
			-- Question beep.
		do
			{EV_GTK_EXTERNALS}.gdk_beep
		end

	ok is
			-- Ok beep.
			-- System default beep.
		do
			{EV_GTK_EXTERNALS}.gdk_beep
		end

indexing
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
