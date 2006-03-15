indexing

	description:
		"Rectangle which displays a submenu when armed, and also %
		%changes its visuals from a 2-D to a 3-D look"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	MENU_B

inherit

	BUTTON
		redefine
			implementation, parent
		end

create

	make, make_unmanaged

feature {NONE} -- Initialziation

	make (a_name: STRING; a_parent: MENU) is
			-- Create a menu button with `a_name' as label
			-- 'a_parent' as parent and call `set_default'.
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

	make_unmanaged (a_name: STRING; a_parent: MENU) is
			-- Create an unmanaged menu button with `a_name' as label
			-- 'a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: MENU; man: BOOLEAN) is
			-- Create a menu button with `a_name' as label
			-- 'a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			if a_name /= Void then
				identifier := a_name.twin
			else
				identifier := Void
			end
			create {MENU_B_IMP} implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Access

	parent: MENU is
			-- Parent of current menu button
		do
			Result ?= widget_manager.parent (Current)
		end;

feature -- Element change

	attach_menu (a_menu: MENU_PULL) is
			-- Attach menu `a_menu' to the menu button, it will
			-- be the menu which will appear when the button
			-- is armed.
		require
			exists: not destroyed;
			valid_menu: a_menu /= Void;
			same_parent: a_menu.parent = parent
		do
			implementation.attach_menu (a_menu)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementaitno

	implementation: MENU_B_I;
			-- Implementation of menu button

feature {NONE} -- Implementation

	set_default is
			-- Set default value to current menu button.
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MENU_B

