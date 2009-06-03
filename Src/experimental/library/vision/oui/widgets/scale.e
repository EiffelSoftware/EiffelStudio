note

	description:
		"Elongated rectangular region similar to a scrollbar with %
		%a slider that indicates an analog value"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	SCALE

inherit

	FONTABLE
		rename
			implementation as font_implementation
		end;

	PRIMITIVE
		redefine
			implementation, is_fontable
		end;

create

	make, make_unmanaged

feature {NONE} -- Initiaization

	make (a_name: STRING; a_parent: COMPOSITE)
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

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE)
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

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN)
			-- Create a scale with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			if a_name /= Void then
				identifier := a_name.twin
			else
				identifier := Void
			end
			create {SCALE_IMP} implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Access

	value: INTEGER
			-- Value of the current slider position along the scale
		require
			exists: not destroyed;
		do
			Result := implementation.value
		ensure
			value_large_enough: Result >= minimum;
			value_small_enough: Result <= maximum
		end
	granularity: INTEGER
			-- Value of the amount that the current slider can be moved
			-- whenever a move action occurs
		require
			exists: not destroyed
		do
			Result := implementation.granularity
		ensure
			granularity_large_enough: Result >=1;
			granularity_small_enough: Result <= (maximum - minimum)
		end;

	maximum: INTEGER
			-- Maximum value of the slider
		require
			exists: not destroyed
		do
			Result := implementation.maximum
		ensure
			maximum_greater_than_minimum: Result >= minimum
		end;

	minimum: INTEGER
			-- Minimum value of the slider
		require
			exists: not destroyed
		do
			Result := implementation.minimum
		ensure
			minimum_smaller_than_maximum: Result <= maximum
		end;

	text: STRING
			-- Scale text
		require
			exists: not destroyed
		do
			Result := implementation.text
		end;

feature -- Status report

	is_output_only: BOOLEAN
			-- Is scale mode output only?
		require
			exists: not destroyed;
		do
			Result := implementation.is_output_only
		end;

	is_horizontal: BOOLEAN
			-- Is scale oriented horizontal?
		require
			exists: not destroyed;
		do
			Result := implementation.is_horizontal
		end;

	is_value_shown: BOOLEAN
		require
			exists: not destroyed;
		do
			Result := implementation.is_value_shown;
		end;

	is_maximum_right_bottom: BOOLEAN
		require
			exists: not destroyed;
		do
			Result := implementation.is_maximum_right_bottom;
		end;

feature -- Status setting

	set_output_only (flag: BOOLEAN)
			-- Set scale mode to output only if `flag'. The user
			-- cannot modify the current scale interactively.
		require
			exists: not destroyed;
		do
			implementation.set_output_only (flag)
		ensure
			Output_only: is_output_only = flag
		end;

	set_horizontal (flag: BOOLEAN)
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		require
			exists: not destroyed;
		do
			implementation.set_horizontal (flag)
		ensure
			value_correctly_set: is_horizontal = flag
		end;

	set_maximum_right_bottom (flag: BOOLEAN)
		require
			exists: not destroyed;
		do
			implementation.set_maximum_right_bottom (flag);
		end;

	show_value (flag: BOOLEAN)
		require
			exists: not destroyed;
		do
			implementation.set_value_shown (flag);
		end;

feature -- Element change

	set_text (a_text: STRING)
			-- Set scale text to `a_text'.
		require
			exists: not destroyed;
			not_text_void: a_text /= Void
		do
			implementation.set_text (a_text);
		ensure
			text.is_equal (a_text)
		end;

	set_value (new_value: INTEGER)
			-- Set value to `new_value'.
		require
			exists: not destroyed;
			value_small_enough: new_value <= maximum;
			value_large_enough: new_value >= minimum
		do
			implementation.set_value (new_value)
		ensure
			value = new_value
		end;

	set_granularity (new_granularity: INTEGER)
			-- Set amount to move the slider when a move action
			-- occurs to `new_granularity'.
		require
			exists: not destroyed;
			granularity_large_enough: new_granularity >= 1;
			granularity_small_enough: new_granularity <= (maximum - minimum)
		do
			implementation.set_granularity (new_granularity)
		ensure
			granularity = new_granularity
		end;

	set_maximum (new_maximum: INTEGER)
			-- Set maximum value of the slider to `new_maximum'.
		require
			exists: not destroyed;
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

	set_minimum (new_minimum: INTEGER)
			-- Set minimum value of the slider to `new_minimum'.
		require
			exists: not destroyed;
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
	add_move_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to be executed
			-- when slide is moved.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_move_action (a_command, argument)
		end;

	add_value_changed_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to be execute when
			-- value is changed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_value_changed_action (a_command, argument)
		end;

feature -- Removal

	remove_move_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to be executed when
			-- slide is moved.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.remove_move_action (a_command, argument)
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to be executed when
			-- value is changed.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.remove_value_changed_action (a_command, argument)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: SCALE_I;
			-- Implementation of scale


feature {G_ANY, G_ANY_I, WIDGET_I} -- Implementation

	is_fontable: BOOLEAN = true;
			-- Is current widget an heir of FONTABLE ?

feature {NONE} -- Implementation

	set_default
			-- Set default values to current scale.
		do
		ensure then
			--maximum = 100;
			--minimum = 0;
			--granularity = 10;
			--value = 0;
			--not is_horizontal;
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SCALE

