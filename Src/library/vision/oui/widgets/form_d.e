indexing

	description:
		"Area which manages children relative to each other %
		%defining constraints on then. It is built on a dialog shell which %
		%can be popped up and popped down at any time";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	FORM_D 

inherit

	FORM
		rename
			make as form_make
		undefine
			raise, lower
		redefine
			implementation
		end;

	DIALOG
		rename
			implementation as dialog_imp
		end

creation

	make
	
feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a form dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require else
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			!FORM_D_IMP!implementation.make (Current, a_parent);
			set_default
		ensure 
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: FORM_D_I
			-- Implementation of form dialog

end -- class FORM_D



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

