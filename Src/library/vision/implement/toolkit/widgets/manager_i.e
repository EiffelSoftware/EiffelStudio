indexing

	description: "General manager implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	MANAGER_I 

inherit

	COMPOSITE_I;

	STACKABLE_I;

feature -- Access

	foreground_color: COLOR is
			-- Foreground color of manager widget
		deferred
		end;

feature -- Status setting

	update_foreground_color is
		deferred
		end;
        
	set_initial_input_focus (a_widget: WIDGET) is
			-- Set child which will initially have input focus
		require
			a_widget_not_void: not (a_widget = Void)
		deferred
		end

feature -- Element change

	set_foreground_color (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require
			color_not_void: new_color /= Void
		deferred
		ensure
			foreground_color_set: foreground_color = new_color
		end;

end -- class MANAGER_I

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

