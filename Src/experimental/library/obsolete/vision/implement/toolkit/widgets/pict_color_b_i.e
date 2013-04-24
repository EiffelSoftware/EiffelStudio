note

	description: "Button represented with a pixmap"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	PICT_COLOR_B_I 

inherit

	BUTTON_I

feature -- Access

	pixmap: PIXMAP
			-- Pixmap used
		deferred
		ensure
			valid_result: Result.is_valid
		end;

	is_pressed: BOOLEAN
			-- Is the pict color button pressed?
		deferred
		end

feature -- Element change

	set_pixmap (a_pixmap: PIXMAP)
			-- Draw `a_pixmap' into the picture_button.
		require
			a_pixmap_exists: a_pixmap /= Void
			a_pixmap_valid: a_pixmap.is_valid
		deferred
		ensure
			pixmap = a_pixmap
		end;

	set_pressed (b: like is_pressed)
			-- Set `is_pressed' to `b'.
		deferred
		ensure
			set: b = is_pressed
		end;

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




end -- class PICT_COLOR_B

