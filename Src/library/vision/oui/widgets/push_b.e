indexing

	description: "Button with a border shadow";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	PUSH_B 

inherit

	BUTTON
		redefine
			implementation, real_x, real_y
		end;

creation

	make, make_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a push button with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void;
			parent_not_menu_bar: is_valid (a_parent)
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged push button with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void;
			parent_not_menu_bar: is_valid (a_parent)
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a push button with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			!PUSH_B_IMP!implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Access

	real_x: INTEGER is
		do
			Result := parent.real_x + x;
		end;

	real_y: INTEGER is
		do
			Result := parent.real_y + y;
		end;

feature -- Status report

	is_valid (other: COMPOSITE): BOOLEAN is
			-- Is `other' a valid parent?
		local
			a_bar: BAR
		do
			a_bar ?= other;
			Result := (a_bar = Void)
		end;

	is_parent_menu_pull: BOOLEAN is
			-- Is `parent' a menu pull?
		local
			a_menu_pull: MENU_PULL
		do
			a_menu_pull ?= parent;
			Result := a_menu_pull /= Void
		end;

feature -- Element change

	set_accelerator_action (a_translation: STRING) is
			-- Set the accerlator action (modifiers and key to use as a shortcut
			-- in selecting a button) to `a_translation'.
			-- `a_translation' must be specified with the X toolkit conventions.
		require
			exists: not destroyed;
			translation_not_void: a_translation /= Void;
			parent_is_menu_pull: is_parent_menu_pull
		do
			implementation.set_accelerator_action (a_translation)
		end;

feature -- Removal

	remove_accelerator_action is
			-- Remove the accelerator action.
		require
			exists: not destroyed;
			parent_is_menu_pull: is_parent_menu_pull
		do
			implementation.remove_accelerator_action
		end;

feature {NONE} -- Implementation
	
	set_default is
			-- Set default values to current push button.
		do
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: PUSH_B_I;
			-- Implementation of push button

end -- class PUSH_B



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

