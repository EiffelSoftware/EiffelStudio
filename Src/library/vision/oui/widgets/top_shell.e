indexing

	description:
		"Top level shell which is used in an application that needs %
		%more than one root shell";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	TOP_SHELL 

inherit 

	TOP
		redefine
			implementation
		end

creation

	make
	
feature {NONE} -- Initialization

	make  (a_name: STRING; a_screen: SCREEN) is
			-- Create a top_shell with `a_name' as identifier,
			-- only if `a_name' not void otherwise identifier
			-- will be defined as application name and call
			-- `set_default'.
		require
			non_void_screen: a_screen /= Void;
			valid_screen: a_screen.is_valid			
		do
			depth := 0;
			screen := a_screen;
			identifier := clone (a_name);
			widget_manager.new (Current, Void);
			!TOP_SHELL_IMP!implementation.make (Current);
			set_default
		end;
	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: TOP_SHELL_I
			-- Implementation of top_shell

feature {NONE} -- Implementation

	set_default is
			-- Set default values of current top shell.
		do
		end; 

end -- class TOP_SHELL



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

