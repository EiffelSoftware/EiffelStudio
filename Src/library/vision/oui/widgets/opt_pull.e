--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Pulldown menu of an option button, it is attached to an option 
-- button which is automaticaly created. It can contain all 
-- kinds of button.

indexing

	date: "$Date$";
	revision: "$Revision$"

class OPT_PULL 

inherit

	PULLDOWN
		redefine
			parent, implementation
		end

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a pulldown menu with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			not_name_void: not (a_name = Void);
			not_parent_void: not (a_parent = Void)
		do
     		        depth := a_parent.depth+1;
           		widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation := toolkit.opt_pull (Current);
			set_default
		ensure
			parent = a_parent;
			identifier.is_equal (a_name)
		end;
	
	
feature -- Option Menu

	parent: COMPOSITE is
			-- Parent of pulldown menu
        do
            Result ?= widget_manager.parent (Current)
        end ;

	selected_button: BUTTON is
            		-- Current Push Button selected in the option menu
		do
			Result := implementation.selected_button
		end;

   	set_selected_button (a_button: BUTTON) is
            		-- Set `selected_button' to `a_button'
		do
			implementation.set_selected_button(a_button)				
		ensure
			a_button.same (selected_button)
		end;

	option_button: OPTION_B is
			-- Option button of the current opt_pull
		do
			Result := implementation.option_button
		end;

	button: BUTTON is
		do
			Result := option_button
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: OPT_PULL_I;
			-- Implementation of pulldown menu


feature {NONE}

	set_default is
			-- Set default values to current pulldown menu.
		do
		end;

end
