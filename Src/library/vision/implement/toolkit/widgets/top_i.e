indexing

	description: "Description of a top";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	TOP_I 

inherit

	SHELL_I

feature -- Access

	icon_name: STRING is
			-- Short form of application name to be displayed
			-- by the window manager when application is iconified
		deferred
		end;

feature -- Status report

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		deferred
		end

	is_maximized_state: BOOLEAN is
			-- Does application start in maximized state?
		deferred
		end

feature -- Status setting

	set_iconic_state is
			-- Set start state of the application to be iconic.
		deferred
		end;

	set_normal_state is
			-- Set start state of the application to be normal.
		deferred
		end;

	set_maximized_state is
			-- Set start state of the application to be maximized.
		deferred
		end;

feature -- Element change

	set_icon_name (a_name: STRING) is
			-- Set `icon_name' to `a_name'.
		require
			not_a_name_void: a_name /= Void
		deferred
		end;

feature {NONE} -- Implementation

	oui_top: TOP;
			-- Keep track of the oui widget
			-- Useful when calling 'delete_window_action'

	delete_window_action is
			-- Called when base window has been destroyed
		do
			oui_top.delete_window_action
		end;

end -- class TOP_I

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

