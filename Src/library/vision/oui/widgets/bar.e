
-- Rectangle to build a menu bar with menu button as children.

indexing

	date: "$Date$";
	revision: "$Revision$"

class BAR 

inherit

	MENU
		redefine
			implementation
		end

creation

	make, make_unmanaged

feature {NONE} -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a menu bar with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged menu bar with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			unmanaged: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a menu bar with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			implementation := toolkit.bar (Current, man);
			set_default
		end;

feature -- Help

	help_button: MENU_B is
			-- Menu Button which appears at the lower right corner of the
			-- menu bar
		require
			exists: not destroyed
		do
			Result := implementation.help_button
		end;

	set_help_button (button: MENU_B) is
			-- Set the Menu Button which appears at the lower right corner
			-- of the menu bar.
		require
			exists: not destroyed
		do
			implementation.set_help_button (button)
		ensure
			help_button.same (button)
		end;

	allow_recompute_size is
		require
			exists: not destroyed
		do
			implementation.allow_recompute_size;
		end;

	forbid_recompute_size is
		require
			exists: not destroyed
		do
			implementation.forbid_recompute_size;
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: BAR_I
			-- Implementation of menu bar

feature {NONE}

	set_default is
			-- Set default values to current menu bar.
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
