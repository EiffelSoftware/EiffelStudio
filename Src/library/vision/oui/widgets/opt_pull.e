
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
		end;

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
			identifier:= clone (a_name);
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


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
