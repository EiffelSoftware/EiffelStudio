--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Area which manages children relative to each other
-- defining constraints on then. It is built on a dialog shell which
-- can be poped up and poped down at any time.

indexing

	date: "$Date$";
	revision: "$Revision$"

class FORM_D 

inherit

	FORM
		redefine
			implementation, make
		end;

	DIALOG
		rename
			implementation as dialog_imp
		end


creation

	make

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a form dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require else
			name_not_void: not (a_name = Void);
			parent_not_void: not (a_parent = Void)
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := a_name.duplicate;
			implementation := toolkit.form_d (Current);
			set_default
		ensure then
			parent = a_parent;
			identifier.is_equal (a_name);
			fraction_base = 100
		end;

	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: FORM_D_I
			-- Implementation of form dialog

end
