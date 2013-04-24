note

	description:
		"Most general notion of widget %
		%(i.e. user interface object)"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	names: widget;
	date: "$Date$";
	revision: "$Revision$"

deferred class

	WIDGET 

inherit

	G_ANY
		export
			{NONE} all
		end;

	W_MAN_GEN
		export
			{NONE} all
		end

feature -- Access

	get_multi_click_time: INTEGER
			-- Get time granted for clicking
		require
			exists: not destroyed
		do
			Result := implementation.get_multi_click_time
		end;

	background_color: COLOR
			-- Background color of Current widget
		require
			exists: not destroyed
		do
			Result := implementation.background_color
		ensure
			valid_result: Result /= Void
		end;

	background_pixmap: PIXMAP
			-- Background pixmap of Current widget
		require
			exists: not destroyed
		do
			Result := implementation.background_pixmap
		ensure
			valid_result: (Result /= Void) implies Result.is_valid
		end;

	cursor: SCREEN_CURSOR
			-- Cursor of current widget
		require
			exists: not destroyed
		do
			Result := implementation.cursor
		end;

	top: TOP
			-- Top shell or base of Current widget
		require
			exists: not destroyed
		do
			Result := widget_manager.top (Current)
		ensure
			valid_result: Result /= Void
		end;

	parent: WIDGET
			-- Parent of Current widget
		do
			Result := widget_manager.parent (Current)
		end;

	screen: SCREEN
			-- Screen of Current widget
		require
			exists: not destroyed
		do
			Result := widget_manager.screen (Current)
		ensure
			valid_result: Result /= Void
		end; 

	identifier: STRING;
			-- Name of widget

feature -- Status report

	destroyed: BOOLEAN
			-- Is Current widget destroyed?
		do
			Result := (implementation = Void)
		end;

	managed: BOOLEAN
			-- Is Current widget subject to
			-- geometry managment?
		require
			exists: not destroyed
		do
			Result := implementation.managed
		end;

	realized: BOOLEAN
			-- Is Current widget realized?
		require
			exists: not destroyed;
		do
			Result := implementation.realized
		end;

	insensitive: BOOLEAN
			-- Is current widget insensitive to
			-- user actions? (If it is, events will
			-- not be dispatched to Current widget or
			-- any of its children)
		require
			exists: not destroyed
		do
			Result := implementation.insensitive
		end;

feature -- Status setting

	destroy
			-- Destroy actual screen object of Current
			-- widget and of all children.
		do
			if not destroyed then
				widget_manager.destroy (Current);
			end
		end;

	hide
			-- Hide Current widget.
		require
			exists: not destroyed;
			widget_realized: realized
		do
			implementation.hide
		ensure
			shown: (parent /= Void and then 
				parent.shown implies not shown) or else
				(parent = Void implies not shown)
		end;

	show
			-- Show Current widget.
		require
			exists: not destroyed;
			widget_realized: realized
		do
			implementation.show
		ensure
			shown: (parent /= Void and then not 
				parent.shown implies shown) or else
				(parent = Void implies shown)
		end;

	shown: BOOLEAN
			-- Is current widget visible?
		require
			exists: not destroyed;
			widget_realized: realized
		do
			Result := implementation.shown
		end;

	manage
			-- Enable geometry managment.
		require
			exists: not destroyed
		do
			implementation.set_managed (True)
		ensure
			managed: parent /= Void implies managed
		end;

	lower
			-- lower current to the bottom
			-- of its peer stacking order
		require
			exists: not destroyed;
			is_realized: realized;
		do
			implementation.lower;
		end;

	set_managed (b: BOOLEAN)
		require
			exists: not destroyed
		do
			if b then
				manage
			else
				unmanage
			end
		end;

	unmanage
			-- Disable geometry managment.
		require
			exists: not destroyed
		do
			implementation.set_managed (False)
		ensure
			not_managed: parent /= Void implies not managed
		end;

	raise
			-- raise the Current widget to the top
			-- of its peer stacking order
		require
			exists: not destroyed;
			is_realized: realized;
		do
			implementation.raise;
		end;

	realize
			-- Create actual screen object of Current
			-- widget and of all children (recursively) .
		require
			exists: not destroyed;
		do
			implementation.realize
		ensure
			Realized: realized
		end;

	unrealize
			-- Destroy screen window implementation and all
			-- screen window implementations of its children if `flag'.
		require
			exists: not destroyed
		do
			implementation.unrealize
		ensure
			not_realized: not realized
		end;

	set_sensitive
			-- Make Current widget sensitive.
		require
			exists: not destroyed
		do
			implementation.set_insensitive (False)
		ensure
			Sensitive: not insensitive	
		end;

	set_insensitive
			-- Make Current widget insensitive
		require
			exists: not destroyed
		do
			implementation.set_insensitive (True)
		ensure
			Insensitive: insensitive
		end;

	set_no_event_propagation
			-- Do not propagate events to direct
			-- parent.
		require
			exists: not destroyed;
			widget_realized: realized
		do
			implementation.set_no_event_propagation
		end;

	propagate_event
			-- Propagate events not handled by Current
			-- widget to direct parent.
		require
			exists: not destroyed;
			widget_realized: realized
		do
			implementation.propagate_event
		end;

	grab (a_cursor: SCREEN_CURSOR)
			-- Grab the mouse and the keyboard , i.e.
			-- channel all events to Current widget 
			-- regardless of where they occur
			-- If `cursor' is not void, the pointer 
			-- will have `a_cursor' shape during the grab.
		require
			exists: not destroyed;
			widget_realized: realized
		do
			implementation.grab (a_cursor)
		end;

	ungrab
			-- Release the mouse and the keyboard 
			-- from an earlier grab.
		require
			exists: not destroyed;
			widget_realized: realized
		do
			implementation.ungrab
		end; 

feature -- Measurement

	x: INTEGER
			-- Horizontal position relative to parent
		require
			exists: not destroyed
		do
			Result := implementation.x
		end;

	y: INTEGER
			-- Vertical position relative to parent
		require
			exists: not destroyed
		do
			Result := implementation.y
		end;

	width: INTEGER
			-- Width of widget
		require
			exists: not destroyed
		do
			Result := implementation.width
		ensure
			Positive_width: Result >= 0
		end;

	height: INTEGER
			-- Height of widget
		require
			exists: not destroyed
		do
			Result := implementation.height
		ensure
			Positive_height: Result >= 0
		end; 

	real_x: INTEGER
			-- Vertical position relative to root window
		require
			exists: not destroyed
		do
			Result := implementation.real_x
		end; 

	real_y: INTEGER
			-- Horizontal position relative to root window
		require
			exists: not destroyed
		do
			Result := implementation.real_y
		end; 

	depth: INTEGER;
			-- Depth of Current widget
			-- (top_shell's depth is 0, its child's depth is 1,...)

feature -- Resizing

	set_size (new_width:INTEGER; new_height: INTEGER)
			-- Set width and height to `new_width'
			-- and `new_height'.
		require
			exists: not destroyed;
			Positive_width: new_width >= 0;
			Positive_height: new_height >= 0
		do
			implementation.set_size (new_width, new_height)
		end; 

	set_width (new_width :INTEGER)
			-- Set width to `new_width'.
		require
			exists: not destroyed;
			Positive_width: new_width >= 0;
		do
			implementation.set_width (new_width)
		end;

	set_height (new_height: INTEGER)
			-- Set height to `new_height'.
		require
			exists: not destroyed;
			Positive_height: new_height >= 0
		do
			implementation.set_height (new_height)
		end;

	set_x (new_x: INTEGER)
			-- Set  horizontal position relative
			-- to parent to `new_x'.
		require
			exists: not destroyed;
		do
			implementation.set_x (new_x)
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER)
			-- Set horizontal position and
			-- vertical position relative to parent
			-- to `new_x' and `new_y'.
		require
			exists: not destroyed;
		do
			implementation.set_x_y (new_x, new_y)
		end;

	set_y (new_y: INTEGER)
			-- Set vertical position relative
			-- to parent to `new_y'.
		require
			exists: not destroyed;
		do
			implementation.set_y (new_y)
		end

feature -- Comparison

	same (other: like Current): BOOLEAN
			-- Does Current widget and `other' correspond
			-- to the same screen object?
		require
			other_exists: other /= Void
		do
			Result := other.implementation = implementation
		end;

feature -- Element change

	add_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of actions to be executed 
			-- when the mouse is moved while the `number'-th mouse 
			-- button is pressed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_button_motion_action (number, a_command, argument)
		end; 

	add_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of actions to be executed 
			-- when the `number'-th mouse button is pressed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_button_press_action (number, a_command, argument)
		end; 

	add_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of actions to be executed 
			-- when the `number'-th mouse button is released.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_button_release_action (number, a_command, argument)
		end; 

	add_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of actions to be executed
			-- when the `number'-th mouse button is clicked
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		obsolete
			"Use `add_button_press_action' and `add_button_release_action' instead"
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_button_click_action (number, a_command, argument)
		end;

	set_multi_click_time (time: INTEGER)
			-- Set time granted for clicking
		require
			exists: not destroyed
		do
			implementation.set_multi_click_time (time)
		end;

	add_destroy_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of actions to be executed 
			-- when current widget is destroyed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_destroy_action (a_command, argument)
		end; 

	add_enter_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of actions to be executed 
			-- when the pointer enters Current widget.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_enter_action (a_command, argument)
		end; 

	add_key_press_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of actions to be executed 
			-- when a key is pressed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_key_press_action (a_command, argument)
		end;

	add_key_release_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of actions to be executed 
			-- when a key is released.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_key_release_action (a_command, argument)
		end; 

	add_leave_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of actions to be executed 
			-- when the pointer leaves Current widget.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_leave_action (a_command, argument)
		end; 

	add_pointer_motion_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of actions to be executed 
			-- when the mouse is moved.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_pointer_motion_action (a_command, argument)
		end; 

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY)
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' must be specified with the X toolkit conventions.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void;
			Valid_translation: a_translation /= Void
		do
			implementation.set_action (a_translation, a_command, argument)
		end;

feature -- Removal

	remove_action (a_translation: STRING)
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		require
			exists: not destroyed;
			Valid_translation: a_translation /= Void
		do
			implementation.remove_action (a_translation)
		end; 

	remove_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed when the
			-- mouse is moved while the `number'-th mouse button is pressed.
			-- Do nothing if the pair (`a_command', `argument') had not 
			-- been specified previously.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.remove_button_motion_action (number, a_command, argument)
		end; 

	remove_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed when the
			-- `number'-th mouse button is pressed.
			-- Do nothing if the pair (`a_command', `argument') had not 
			-- been specified previously.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.remove_button_press_action (number, a_command, argument)
		end; 

	remove_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed when the
			-- `number'-th mouse button is released.
			-- Do nothing if the pair (`a_command', `argument') had not 
			-- been specified previously.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.remove_button_release_action (number, a_command, argument)
		end; 

	remove_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed when the
			-- `number'-th mouse button is clicked.
			-- Do nothing if the pair (`a_command', `argument') had not
			-- been specified previously.
		obsolete
			"Use `remove_button_press_action' and `remove_button_release_action' instead"
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.remove_button_click_action (number, a_command, argument)
		end;

	remove_destroy_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed when
			-- Current widget is destroyed.
			-- Do nothing if the pair (`a_command', `argument') had not 
			-- been specified previously.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.remove_destroy_action (a_command, argument)
		end; 

	remove_enter_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed when the
			-- pointer enters Current widget.
			-- Do nothing if the pair (`a_command', `argument') had not 
			-- been specified previously.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.remove_enter_action (a_command, argument)
		end;

	remove_key_press_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed when
			-- a key is pressed.
			-- Do nothing if the pair (`a_command', `argument') had not 
			-- been specified previously.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.remove_key_press_action (a_command, argument)
		end;

	remove_key_release_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed when
			-- a key is released.
			-- Do nothing if the pair (`a_command', `argument') had not 
			-- been specified previously.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.remove_key_release_action (a_command, argument)
		end;

	remove_leave_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed when the
			-- pointer leaves Current widget.
			-- Do nothing if the pair (`a_command', `argument') had not 
			-- been specified previously.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.remove_leave_action (a_command, argument)
		end;

	remove_pointer_motion_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of actions to be executed when the
			-- mouse is moved.
			-- Do nothing if the pair (`a_command', `argument') had not 
			-- been specified previously.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.remove_pointer_motion_action (a_command, argument)
		end;

	set_background_color (new_color: COLOR)
			-- Set background color to `new_color'.
		require
			exists: not destroyed;
			Valid_color: new_color /= Void
		do
			implementation.set_background_color (new_color)
		ensure
			color_set: background_color = new_color;
			--reset_background_pixmap_to_default:
		end;

	set_background_pixmap (a_pixmap: PIXMAP)
			-- Set background pixmap to `a_pixmap'.
		require
			exists: not destroyed;
			Valid_pixmap: a_pixmap /= Void
		do
			implementation.set_background_pixmap (a_pixmap)
		ensure
			pixmap_set: background_pixmap = a_pixmap;
			--reset_background_color_to_default: 
		end;

	set_cursor (a_cursor: SCREEN_CURSOR)
			-- Set `cursor' of current widget to `a_cursor'.
		require
			exists: not destroyed;
			Valid_cursor: a_cursor /= Void;
			Widget_realized: realized
		do
			implementation.set_cursor (a_cursor)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: WIDGET_I;
			-- Implementation of Current widget

feature {W_MANAGER} -- Implementation
	
	remove_implementation
			-- Remove implementation of Current widget.
		do
			implementation := Void
		ensure
			void_implementation: implementation = Void
		end;

feature {G_ANY, G_ANY_I, WIDGET_I} -- Implementation

	is_fontable: BOOLEAN
			-- Can a font be set for Current
			-- widget?
		do
		end; 

feature {NONE} -- Implementation

	set_default
			-- Set default values of Current widget.
		deferred
		end;

invariant

	Widget_Positive_depth:  depth >= 0

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




end -- class WIDGET

