note
	description: "EiffelVision check button, gtk implementation."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		redefine
			interface
		end

	EV_TOGGLE_BUTTON_IMP
		undefine
			default_alignment
		redefine
			old_make,
			set_text,
			interface,
			make,
			new_gtk_button
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create a gtk check button.
		do
			assign_interface (an_interface)
		end

	new_gtk_button: POINTER
		do
			Result := {EV_GTK_EXTERNALS}.gtk_check_button_new
		end

	make
			-- Initialize 'Current'
		do
			Precursor {EV_TOGGLE_BUTTON_IMP}
			align_text_left
		end

feature -- Element change

	set_text (txt: STRING_GENERAL)
			-- Set current button text to `txt'.
			-- Redefined because we want the text to be left-aligned.
		do
			Precursor {EV_TOGGLE_BUTTON_IMP} (txt)

				-- We left-align and vertical_center-position the text
			{EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 0.0, 0.5)

			if gtk_pixmap /= NULL then
				{EV_GTK_EXTERNALS}.gtk_misc_set_alignment (pixmap_box, 0.0, 0.5)
			end
		end

feature {EV_ANY_I}

	interface: detachable EV_CHECK_BUTTON note option: stable attribute end;

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




end -- class EV_CHECK_BUTTON_IMP





