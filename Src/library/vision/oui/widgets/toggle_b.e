indexing

	description: "Toggle button";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	TOGGLE_B 

inherit

	BUTTON
		redefine
			add_activate_action,
			remove_activate_action,
			implementation
		end

creation

	make, make_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a toggle button with `a_name' as label,
			-- 'a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifer_set: identifier.is_equal (a_name);
			managed: managed
		end; 

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged toggle button with `a_name' as label,
			-- 'a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifer_set: identifier.is_equal (a_name);
			not_managed: not managed
		end; 

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a toggle button with `a_name' as label,
			-- 'a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			!TOGGLE_B_IMP!implementation.make (Current, man, a_parent);
			implementation.set_widget_default
			set_default
		end; 

feature -- Status report

	is_parent_menu_pull: BOOLEAN is
			-- Is `parent' a menu pull?
		local
			a_menu_pull: MENU_PULL
		do
			a_menu_pull ?= parent;
			Result := a_menu_pull /= Void
		end;

	state: BOOLEAN is
			-- State of current toggle button.
		require
			exists: not destroyed
		do
			Result := implementation.state
		end 

feature -- Status setting

	set_toggle_on is
			-- Set Current toggle on and set
			-- state to True.
		require
			exists: not destroyed
		do
			implementation.set_toggle_on
		ensure
			state_is_true: state
		end;

	set_toggle_off is 
			-- Set Current toggle off and set
			-- state to False.
		require
			exists: not destroyed
		do
			implementation.set_toggle_off
		ensure
			state_is_false: not state
		end;

	arm is
			-- Set `state' to True and call 
			-- callback (if set).
		require
			exists: not destroyed
		do
			implementation.arm
		ensure
			state_is_true: state
		end;

	disarm is
			-- Set `state' to False and call 
			-- callback (if set).
		require
			exists: not destroyed
		do
			implementation.disarm
		ensure
			state_is_false: not state
		end; 

	set_default is
			-- Set default values to current toggle button.
		do
		ensure then
			not state
		end;

feature -- Element change

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when value
			-- is changed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_value_changed_action (a_command, argument)
		end;

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when 
			-- arrow button is activated.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
			-- (Synonym for add_value_changed_action)
		do
			add_value_changed_action (a_command, argument)
		end;

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

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' with `argument' from the list of action 
			-- to be executed when value is changed.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.remove_value_changed_action (a_command, argument)
		end; 

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to be executed when 
			-- arrow button is activated.
		do
			remove_value_changed_action (a_command, argument)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: TOGGLE_B_I;
			-- Implementation of current toggle button

end -- class TOGGLE_B



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

