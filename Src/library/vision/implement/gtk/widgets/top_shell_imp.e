indexing

	description: 
		"EiffelVision top shell, gtk implementation.";
	status: "See notice at end of class";
	id: "$id: $";
	date: "$Date$";
	revision: "$Revision$"
	
class
	TOP_SHELL_IMP

inherit

	TOP_SHELL_I

	TOP_IMP

creation
	
	make
	
feature {NONE} -- Initialization
	
		make (a_top_shell: TOP_SHELL) is
			-- Create a gtk top level shell.
			-- XX parameter not yet used
		local
			x_display: MEL_DISPLAY;
		do
			widget := gtk_window_new (GTK_WINDOW_POPUP)
		ensure
			widget /= default_pointer
		end

end -- class TOP_SHELL_IMP

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
