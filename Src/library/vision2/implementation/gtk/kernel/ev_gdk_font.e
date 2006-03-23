indexing
	description: "Eiffel Vision GDK font. (for GTK implementation.) %N%
		%Objects that have a reference to a GdkFont, and the fully %N%
		%matched string that it is loaded from."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GDK_FONT

create
	make

feature {NONE} -- Initialization

	make (a_full_name: STRING_GENERAL) is
			-- Initialize.
		require
			a_full_name_not_void: a_full_name /= Void
		do
			full_name := a_full_name
			load
		end

feature {NONE} -- Implementation

	load is
			-- Load font specified in `full_name'.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := full_name
			c_object := {EV_GTK_EXTERNALS}.gdk_font_load (a_cs.item)
		end

	destroy is
			-- Unreference font.
		do
			{EV_GTK_EXTERNALS}.gdk_font_unref (c_object)
		end

feature -- Access

	full_name: STRING_32

	c_object: POINTER;

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




end -- class EV_GDK_FONT

