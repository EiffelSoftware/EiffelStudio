indexing

	description:
		"A text editor for one line of text without echo. %
		%Characters are shown as '*' (stars)."; 
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	PASSWORD

inherit

	TEXT_FIELD
		redefine
			create_ev_widget
		end

create

	make, make_unmanaged

feature {NONE} -- Initialization

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a password field with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			create {PASSWORD_IMP} implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

end -- class PASSWORD

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

