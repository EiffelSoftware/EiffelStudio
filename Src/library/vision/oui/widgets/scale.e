
-- Elongated rectangular region similar to a scrollbar with
-- a slider that indicates an analog value.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SCALE 

inherit

	FONTABLE
		rename
			implementation as font_implementation
		end;

	PRIMITIVE
		redefine
			implementation, is_fontable
		end;

creation

	make, make_unmanaged
	
feature {NONE} -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a scale with `a_name' as identifier,
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
			-- Create an unmanaged scale with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
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

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a scale with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			implementation := toolkit.scale (Current, man);
			set_default
		end;

feature -- Callbacks (adding)

	add_move_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed
			-- when slide is moved.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		do
			implementation.add_move_action (a_command, argument)
		end;

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be execute when 
			-- value is changed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		do
			implementation.add_value_changed_action (a_command, argument)
		end; 

	remove_move_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to be executed when
			-- slide is moved.
		require
			Valid_command: a_command /= Void
		do
			implementation.remove_move_action (a_command, argument)
		end; 

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to be executed when
			-- value is changed.
		require
			Valid_command: a_command /= Void
		do
			implementation.remove_value_changed_action (a_command, argument)
		end;

feature -- Slider setup (max, min, granularity ...)

	granularity: INTEGER is
			-- Value of the amount that the current slider can be moved 
			-- whenever a move action occurs
		do
			Result := implementation.granularity
		ensure
			granularity_large_enough: Result >=1;
			granularity_small_enough: Result <= (maximum - minimum)
		end;

	maximum: INTEGER is
			-- Maximum value of the slider
		do
			Result := implementation.maximum
		ensure
			maximum_greater_than_minimum: Result >= minimum
		end;

	minimum: INTEGER is
			-- Minimum value of the slider
		do
			Result := implementation.minimum
		ensure
			minimum_smaller_than_maximum: Result <= maximum
		end;

	set_granularity (new_granularity: INTEGER) is
			-- Set amount to move the slider when a move action 
			-- occurs to `new_granularity'.
		require
			granularity_large_enough: new_granularity >= 1;
			granularity_small_enough: new_granularity <= (maximum - minimum)
		do
			implementation.set_granularity (new_granularity)
		ensure
			granularity = new_granularity
		end;

	set_maximum (new_maximum: INTEGER) is
			-- Set maximum value of the slider to `new_maximum'.
		require
			maximum_greater_than_minimum: new_maximum > minimum
		do
			if value > new_maximum then
				set_value (new_maximum);
			end;
			implementation.set_maximum (new_maximum)
		ensure
			maximum = new_maximum;
			value <= maximum;
		end;

	set_minimum (new_minimum: INTEGER) is
			-- Set minimum value of the slider to `new_minimum'.
		require
			minimum_smaller_than_maximum: new_minimum < maximum
		do
			if value < new_minimum then
				set_value (new_minimum);
			end;
			implementation.set_minimum (new_minimum)
		ensure
			minimum = new_minimum;
			value >= minimum;
		end;

feature -- Slider Value

	set_value (new_value: INTEGER) is
			-- Set value to `new_value'.
		require
			value_small_enough: new_value <= maximum;
			value_large_enough: new_value >= minimum
		do
			implementation.set_value (new_value)
		ensure
			value = new_value
		end;

	value: INTEGER is
			-- Value of the current slider position along the scale
		do
			Result := implementation.value
		ensure
			value_large_enough: Result >= minimum;
			value_small_enough: Result <= maximum
		end

feature -- Output Mode

	is_output_only: BOOLEAN is
			-- Is scale mode output only?
		do
			Result := implementation.is_output_only
		end;

	set_output_only (flag: BOOLEAN) is
			-- Set scale mode to output only if `flag'. The user
			-- can not modify the current scale interactively.
		do
			implementation.set_output_only (flag)
		ensure
			Output_only: is_output_only = flag
		end; 

feature -- Orientation of Slider

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		do
			implementation.set_horizontal (flag)
		ensure
			value_correctly_set: is_horizontal = flag
		end;

	is_horizontal: BOOLEAN is
			-- Is scale oriented horizontal?
		do
			Result := implementation.is_horizontal
		end; 

feature -- Text

	set_text (a_text: STRING) is
			-- Set scale text to `a_text'.
		require
			not_text_void: not (a_text = Void)
		do
			implementation.set_text (a_text);
		ensure
			text.is_equal (a_text)
		end; 

	text: STRING is
			-- Scale text
		do
			Result := implementation.text
		end;


feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: SCALE_I;
			-- Implementation of scale

	
feature {G_ANY, G_ANY_I, WIDGET_I}

	is_fontable: BOOLEAN is true;
			-- Is current widget an heir of FONTABLE ?

feature {NONE}

	set_default is
			-- Set default values to current scale.
		do
		ensure then
			maximum = 100;
			minimum = 0;
			granularity = 10;
			value = 0;
			--not is_horizontal;
		end;

feature 
 
 
    is_maximum_right_bottom: BOOLEAN is 
		do 
			Result := implementation.is_maximum_right_bottom;
		end;

    set_maximum_right_bottom (flag: BOOLEAN) is 
		do 
			implementation.set_maximum_right_bottom (flag);
		end;

    show_value (flag: BOOLEAN) is 
		do 
			implementation.show_value (flag);
		end;

    is_value_shown: BOOLEAN is 
		do 
			Result := implementation.is_value_shown;
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
