indexing

	description: "Special area to draw";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DRAWING_AREA 

inherit

	PRIMITIVE
		redefine
			implementation
		end;

	DRAWING
		
creation

	make

feature {NONE} -- Creation 

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a drawing area with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void;
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged drawing area with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void;
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a drawing area with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			implementation := toolkit.drawing_area (Current, man);
			implementation.set_widget_default;
			set_default
		end;

feature -- Callbacks (adding) 

	add_input_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- a key is pressed or when a mouse button is pressed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_input_action (a_command, argument)
		end;

	add_resize_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- current area is resized.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_resize_action (a_command, argument)
		end;

feature -- Callbacks (removing)

	remove_input_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' with `argument' from the list of action 
			-- to be executed when a key is pressed or when a mouse button 
			-- is pressed.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.remove_input_action (a_command, argument)
		end;

	remove_resize_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' with `argument' from the list of action 
			-- to be executed when current area is resized.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.remove_resize_action (a_command, argument)
		end;
	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: D_AREA_I;
			-- Implementation of drawing area

feature {NONE}

	set_default is
			-- Set default values to current drawing area.
		do
		end

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
