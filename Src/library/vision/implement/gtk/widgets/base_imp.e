indexing

	description: 
		"EiffelVision base, gtk implementation.";
	status: "See notice at end of class";
	id: "$id: $";
	date: "$Date$";
	revision: "$Revision$"
	
class
	BASE_IMP
	
inherit
	BASE_I
	TOP_IMP
	SHARED_APPLICATION_CONTEXT
	
creation
	make
	
	

feature {NONE} -- Initialization

	make (a_base: BASE) is
			-- Create an application shell.
		do
			widget := gtk_window_new (GTK_WINDOW_TOPLEVEL)
			set_managed (True)
		ensure
			widget /= default_pointer
		end

feature -- Access

	mel_screen: MEL_SCREEN
			-- Screen of the shell
	
	
end -- class BASE_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
