--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- 

indexing

	date: "$Date$";
	revision: "$Revision$"

class FILE_SEL_D 

inherit

	FILE_SELEC
		rename 
			make as file_selec_make
		redefine
			implementation
		end;

	DIALOG
		rename
			implementation as dialog_imp
		end


creation

	make

		
feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a file selection dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			name_not_void: not (a_name = Void);
			parent_not_void: not (a_parent = Void)
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.file_sel_d (Current);
			set_default
		ensure
			parent = a_parent;
			identifier.is_equal (a_name)
		end;

	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: FILE_SEL_D_I
			-- Implementation of current file selection dialog

end 
