indexing 

	description:
		"Most general notion of widget %
		%(i.e. user interface object)"
	status: "See notice at end of class"
	names: widget
	date: "$Date$"
	revision: "$Revision$"

--XX deferred class EV_WIDGET
class EV_WIDGET


feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a widget with `par' as parent and
                        -- call `set_default'. 
			-- This is a general initialization for 
			-- widgets and has to be called by all the 
			-- widgets with parents (Put call to 
			-- Precursor at the end of creation routine).
                require
                        valid_parent: par /= Void
		do
			parent := par
			-- For effective widgets, create widget_imp
			set_default 
                ensure
                        parent_set: parent.child = Current and par = parent
 			exists: not destroyed
		end
	
feature -- Access
	
	parent: EV_CONTAINER
	
	
feature -- Status report
	
	destroyed: BOOLEAN is
			-- Is Current widget destroyed?  
			-- (= implementation does not exist)
		do
			Result := (implementation = Void)
		end

	insensitive: BOOLEAN is
			-- Is current widget insensitive to
			-- user actions? (If it is, events will
			-- not be dispatched to Current widget or
			-- any of its children)
		require
			exists: not destroyed
		do
			Result := implementation.insensitive
		end
	
	shown: BOOLEAN is
			-- Is current widget visible?
		require
			exists: not destroyed
		do
			Result := implementation.shown
		end

	
	managed: BOOLEAN 
			-- Is the geometry of current widget managed by its 
			-- container? This is the case always unless 
			-- parent.manager = False (Always true except 
			-- when the container is EV_FIXED). This is 
			-- set in the procedure set_default
		

feature -- Status setting

	destroy is
			-- Destroy actual screen object of Current
			-- widget and of all children.
		do
			if not destroyed then
				implementation.destroy
				remove_implementation
			end
		ensure
			destroyed: destroyed
		end

	hide is
		 	-- Make widget and all children (recursively)
		 	-- invisible on the screen.
		require
			exists: not destroyed
		do
			implementation.hide
		ensure
			not shown
		end

	show is
		 	-- Make widget and all children (recursively)
		 	-- visible on the screen. (default)
		require
			exists: not destroyed
		do
			implementation.show
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
		do
			implementation.set_insensitive (flag)
		ensure
			flag = insensitive	
		end
	
	-- What is this for?
-- 	grab (a_cursor: SCREEN_CURSOR) is
-- 			-- Grab the mouse and the keyboard , i.e.
-- 			-- channel all events to Current widget 
-- 			-- regardless of where they occur
-- 			-- If `cursor' is not void, the pointer 
-- 			-- will have `a_cursor' shape during the grab.
-- 		require
-- 			exists: not destroyed
-- 		do
-- 			implementation.grab (a_cursor)
-- 		end

-- 	ungrab is
-- 			-- Release the mouse and the keyboard 
-- 			-- from an earlier grab.
-- 		require
-- 			exists: not destroyed
-- 		do
-- 			implementation.ungrab
-- 		end 

feature -- Measurement 
	
	-- The coordinates are effective only if widget is inside a
	-- fixed container. Otherwise they are calculated 
	-- automatically by the container widget.

	x: INTEGER is
			-- Horizontal position relative to parent
		require
			exists: not destroyed
			unmanaged: not managed
		do
			Result := implementation.x
		end

	y: INTEGER is
			-- Vertical position relative to parent
		require
			exists: not destroyed
			unmanaged: not managed
		do
			Result := implementation.y
		end

	width: INTEGER is
			-- Width of widget
		require
			exists: not destroyed
		do
			Result := implementation.width
		ensure
			Positive_width: Result >= 0
		end

	height: INTEGER is
			-- Height of widget
		require
			exists: not destroyed
		do
			Result := implementation.height
		ensure
			Positive_height: Result >= 0
		end 
	
	maximum_height: INTEGER is
                        -- Maximum height that application wishes widget
                        -- instance to have
                require
                        exists: not destroyed
                do
                        Result := implementation.maximum_height
                ensure
                        Result >= 0
                end

        maximum_width: INTEGER is
                        -- Maximum width that application wishes widget
                        -- instance to have
                require
                        exists: not destroyed
                do
                        Result := implementation.maximum_width
                ensure
                        Result >= 0
                end

	minimum_width: INTEGER is
                        -- Minimum width that application wishes widget
                        -- instance to have
		require
			exists: not destroyed
		do
			Result := implementation.minimum_width
		ensure
			Positive_height: Result >= 0
		end 
	
	minimum_height: INTEGER is
                        -- Minimum height that application wishes widget
                        -- instance to have
		require
			exists: not destroyed
		do
			Result := implementation.minimum_height
		ensure
			Positive_height: Result >= 0
		end 
	
-- 	-- Do we need this?
-- 	real_x: INTEGER is
-- 			-- Vertical position relative to root window
-- 		require
-- 			exists: not destroyed
-- 		do
-- 			Result := implementation.real_x
-- 		end 
-- 	-- Do we need this?
-- 	real_y: INTEGER is
-- 			-- Horizontal position relative to root window
-- 		require
-- 			exists: not destroyed
-- 		do
-- 			Result := implementation.real_y
-- 		end 
-- 	-- Do we need this?
-- 	depth: INTEGER
			-- Depth of Current widget
			-- (top_shell's depth is 0, its child's depth is 1,...)

feature -- Resizing

	set_size (new_width: INTEGER; new_height: INTEGER) is
			-- Set width and height to `new_width'
			-- and `new_height'.
		require
			exists: not destroyed
			Positive_width: new_width >= 0
			Positive_height: new_height >= 0
		do
			implementation.set_size (new_width, new_height)
		ensure
			dimensions_set: implementation.dimensions_set (new_width, new_height)
		end 

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		require
			exists: not destroyed
			Positive_width: new_width >= 0
		do
			implementation.set_width (new_width)
		ensure
			dimensions_set: implementation.dimensions_set (new_width, height)
		end

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		require
			exists: not destroyed
			Positive_height: new_height >= 0
		do
			implementation.set_height (new_height)
		ensure					
			dimensions_set: implementation.dimensions_set (width, new_height)
		end
	
	set_maximum_height (max_height: INTEGER) is
                        -- Set `maximum_height' to `max_height'.
                require
                        exists: not destroyed
                        large_enough: max_height >= 0
                do
                        implementation.set_maximum_height (max_height)
                ensure
                        max_height = max_height
                end

        set_maximum_width (max_width: INTEGER) is
                        -- Set `maximum_width' to `max_width'.
                require
                        exists: not destroyed
                        large_enough: max_width >= 0
                do
                        implementation.set_maximum_width (max_width)
                ensure
                        max_width = max_width
                end 


        set_minimum_height (min_height: INTEGER) is
                        -- Set `minimum__height' to `min_height'.
                require
                        exists: not destroyed
                        large_enough: min_height >= 0
                do
                        implementation.set_minimum_height (min_height)
                ensure
                        min_height = min_height
                end

        set_minimum_width (min_width: INTEGER) is
                        -- Set `minimum_width' to `min_width'.
                require
                        exists: not destroyed
                        large_enough: min_width >= 0
                do
                        implementation.set_minimum_width (min_width)
                ensure
                        min_width = min_width
                end
	
	set_x (new_x: INTEGER) is
			-- Set  horizontal position relative
			-- to parent to `new_x'.
		require
			exists: not destroyed
			Unmanaged: not managed
								   
		do
			implementation.set_x (new_x)
		ensure
			x_set: x = new_x
		end

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Set horizontal position and
			-- vertical position relative to parent
			-- to `new_x' and `new_y'.
		require
			exists: not destroyed
			Unmanaged: not managed
								   
		do
			implementation.set_x_y (new_x, new_y)
		ensure
	--XX		x_set: x = new_x	
	--XX		y_set: y = new_y	
		end

	set_y (new_y: INTEGER) is
			-- Set vertical position relative
			-- to parent to `new_y'.
		require
			exists: not destroyed
			Unmanaged: not managed
								   
		do
			implementation.set_y (new_y)
		ensure
			y_set: y = new_y		
		end

feature -- Comparison

	same (other: like Current): BOOLEAN is
			-- Does Current widget and `other' correspond
			-- to the same screen object?
		require
			other_exists: other /= Void
		do
			Result := other.implementation = implementation
		end

feature -- Event - command association

	add_command (event: EV_EVENT; command: EV_COMMAND; 
		     arguments: EV_ARGUMENTS) is
			-- Add `command' at the _end_ of the list of
			-- actions to be executed when the 'event'
			-- happens `arguments' will be passed to
			-- `command' whenever it is invoked as a
			-- callback. 'arguments' can be Void, which
			-- means that no arguments are passed to the
			-- command.
		require
			exists: not destroyed
			Valid_event: event /= Void
			Valid_command: command /= Void
		do
			implementation.add_command (event, command, arguments)
		end

	remove_command (command_id: INTEGER) is
			-- Remove the command associated with
			-- 'command_id' from the list of actions for
			-- this context. If there is no command
			-- associated with 'command_id', nothing
			-- happens.
		require
			exists: not destroyed
		do
			implementation.remove_command (command_id)
		end
	
	
	last_command_id: INTEGER is
			-- Id of the last command added by feature
			-- 'add_command'
		require		
			exists: not destroyed
		do
			Result := implementation.last_command_id
		end
	

feature {EV_WIDGET} -- Implementation

	implementation: EV_WIDGET_I
			-- Implementation of Current widget

feature {NONE} -- Implementation
	
	remove_implementation is
			-- Remove implementation of Current widget.
                do
                        implementation := Void
                ensure
                        void_implementation: implementation = Void
                end

feature {NONE} -- Implementation

        set_default is
                        -- Do the necessary initialization after 
                        -- creation 
                        -- Set default values of Current widget.
                do
                        implementation.build
			parent.add_child (Current)
			managed := parent.manager
                end

invariant

  --XX      Widget_Positive_depth:  depth >= 0

end -- class EV_WIDGET


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
