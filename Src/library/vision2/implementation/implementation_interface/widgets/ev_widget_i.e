indexing

	description: "General widget implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	EV_WIDGET_I 


feature {EV_WIDGET} -- Initialization
	
	
	build is
			-- Called after creation from oui class
		do
		end

feature -- Status report

	destroyed: BOOLEAN is			
			-- Is Current widget destroyed?
		deferred
		end
	
	insensitive: BOOLEAN is
			-- Is current widget insensitive?
		require
			exists: not destroyed
		deferred
		end

	shown: BOOLEAN is
			-- Is current widget visible?
		require
			exists: not destroyed
		deferred
		end
	
feature -- Status setting

	destroy is
			-- Destroy screen widget implementation.
		deferred
		ensure
			destroyed: destroyed
		end

	hide is
			-- Make widget invisible on the screen.
		require
			exists: not destroyed
		deferred
		ensure
			not shown
		end
	
	show is
			-- Make widget visible on the screen.
		require
			exist: not destroyed
		deferred
		ensure
			shown		
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
			-- `flag'. This means that any events with an
			-- event type of KeyPress, KeyRelease,
			-- ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or
			-- FocusOut will not be dispatched to current
			-- widget and to all its children.  Set it to
			-- sensitive mode otherwise.
		require
			exists: not destroyed
		deferred
		ensure
			flag = insensitive
		end
	
feature -- Measurement
	
	x: INTEGER is
			-- Horizontal position relative to parent
		require
			exists: not destroyed		
		deferred
		end

	y: INTEGER is
			-- Vertical position relative to parent
		require
			exists: not destroyed
		deferred
		end	

	width: INTEGER is
			-- Width of widget
		require
			exists: not destroyed
		deferred
		ensure
			Positive_width: Result >= 0
		end

	height: INTEGER is
			-- Height of widget
		require
			exists: not destroyed
		deferred
		ensure
			Positive_height: Result >= 0
		end

feature -- Resizing

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
		require
			exists: not destroyed
			Positive_width: new_width >= 0
			Positive_height_: new_height >= 0
		deferred
		ensure
			width_set: width = new_width
			height_set: height = new_height		
		end

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		require
			exists: not destroyed
			Positive_width: new_width >= 0
		deferred
		ensure
			width_set: width = new_width
		end
	
	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		require
			exists: not destroyed
			Positive_height: new_height >= 0
		deferred
		ensure					
			height_set: height = new_height
		end

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
		require
			exists: not destroyed
		deferred
		ensure
			x_set: x = new_x
		end

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		require
			exists: not destroyed
		deferred
		ensure
			x_set: x = new_x	
			y_set: y = new_y	
		end

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
		require
			exists: not destroyed
		deferred
		ensure
			y_set: y = new_y		
		end

feature -- Event - command association

	add_command (event: EV_EVENT; command: EV_COMMAND; 
		     arguments: EV_ARGUMENTS) is
			-- Add `command' at the end of the list of
			-- actions to be executed when the 'event'
			-- happens `arguments' will be passed to
			-- `command' whenever it is invoked as a
			-- callback. 'arguments' can be Void, which
			-- means that no arguments are passed to the
			-- command.
		require
			exists: not destroyde
			Valid_event: event /= Void
			Valid_command: command /= Void
		deferred
		end

	remove_command (command_id: INTEGER) is
			-- Remove the command associated with
			-- 'command_id' from the list of actions for
			-- this context. If there is no command
			-- associated with 'command_id', nothing
			-- happens.
		require
			exists: not destroyed
		deferred
		end
	
	last_command_id: INTEGER is
			-- Id of the last command added by feature
			-- 'add_command'
		require		
			exists: not destroyed
		deferred
		end
	
end -- class EV_WIDGET_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

