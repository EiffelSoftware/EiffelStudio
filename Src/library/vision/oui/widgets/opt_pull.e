indexing

	description:
		"Pulldown menu of an option button, it is attached to an option %
		%button which is automatically created. It can contain all %
		%kinds of buttons";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class OPT_PULL 

inherit

	PULLDOWN
		redefine
			parent, implementation
		end;

creation

	make, make_unmanaged

feature {NONE} -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a pulldown menu with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_name: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged pulldown menu with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_name: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;
	
	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a pulldown menu with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			identifier:= clone (a_name);
			widget_manager.new (Current, a_parent);
			implementation := toolkit.opt_pull (Current, man);
			implementation.set_widget_default;
			set_default
		end;
	
feature -- Option Menu

	parent: COMPOSITE is
			-- Parent of pulldown menu
        do
            Result ?= widget_manager.parent (Current)
        end;

	selected_button: BUTTON is
            		-- Current Push Button selected in the option menu
		require
			exists: not destroyed
		do
			Result := implementation.selected_button
		end;

   	set_selected_button (a_button: BUTTON) is
            		-- Set `selected_button' to `a_button'
		require
			exists: not destroyed
		do
			implementation.set_selected_button(a_button)				
		ensure
			a_button.same (selected_button)
		end;

	option_button: OPTION_B is
			-- Option button of the current opt_pull
		require
			exists: not destroyed
		do
			Result := implementation.option_button
		end;

	button: BUTTON is
		do
			Result := option_button
		end;

	caption: STRING is
		require
			exists: not destroyed
		do
			Result := implementation.caption;
		end

	set_caption (a_caption: STRING) is
		require
			exists: not destroyed;
			valid_caption: a_caption /= Void;
		do
			implementation.set_caption (a_caption);
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
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
