--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Special shell which can be poped up or poped down at any time.

indexing

	date: "$Date$";
	revision: "$Revision$"

class DIALOG_SHELL 

inherit

	POPUP_SHELL
		redefine
			implementation
		end;

	WM_SHELL
		rename
			implementation as wm_implementation
		end

creation

	make
	
feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a dialog shell with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.dialog_shell (current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifer_set: identifier.is_equal (a_name)
		end;
	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: DIALOG_S_I
			-- Implementation of dialog shell

feature {NONE}

	set_default is
			-- Set default values to current dialog shell.
		do
		end;

end
