indexing
	description: "EiffelVision check button, gtk implementation.";
	status: "See notice at end of class";
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
			make,
			set_text,
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk check button.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_check_button_new)
		end
		
	initialize is
			-- Initialize 'Current'
		do
			Precursor {EV_TOGGLE_BUTTON_IMP}
			align_text_left
		end

feature -- Element change

	set_text (txt: STRING) is
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

	interface: EV_CHECK_BUTTON
	
end -- class EV_CHECK_BUTTON_IMP

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

