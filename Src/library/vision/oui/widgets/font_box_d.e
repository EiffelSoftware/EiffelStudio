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

class FONT_BOX_D 

inherit

	FONT_BOX
		rename
			make as font_box_make
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
			-- Create a font box with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			name_not_void: not (a_name = Void);
			parent_not_void: not (a_parent = Void)
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.font_box_d (Current);
			set_default
		ensure
			parent = a_parent;
			identifier.is_equal (a_name)
		end; 

	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: FONT_B_D_I;
			-- Implementation of current font box

end 
