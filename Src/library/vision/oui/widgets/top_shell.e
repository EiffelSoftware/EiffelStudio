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

create

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
			create {TOP_SHELL_IMP} implementation.make (Current);
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

