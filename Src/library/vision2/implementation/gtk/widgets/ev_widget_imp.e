indexing

	description: 
		"EiffelVision widget, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
--XX deferred class
class
	
        EV_WIDGET_IMP
        
inherit
        EV_WIDGET_I
        
        EV_GTK_EXTERNALS
        EV_GTK_CONSTANTS
	

feature -- Status report

	realized: BOOLEAN is
			-- Is screen window realized?
                do
                        Result := c_gtk_widget_realized (widget)
 		end

	insensitive: BOOLEAN is
			-- Is current widget insensitive?
                do
                        Result := not c_gtk_widget_sensitive (widget)
		end

	shown: BOOLEAN is
			-- Is current widget visible?
                do
                        Result := c_gtk_widget_visible (widget)
		end

feature -- Status setting

	destroy is
			-- Destroy screen widget implementation.
                do
                        gtk_widget_destroy (widget)
		end

	hide is
			-- Make widget invisible on the screen.
                do
                        gtk_widget_hide (widget)
		end
	
	show is
			-- Make widget visible on the screen. (default)
		do
			gtk_widget_show (widget)
			c_gtk_widget_show_children (widget)
		end

	realize is
			-- Realize the widget
		do
			gtk_widget_realize (widget)
			show
		end

	unrealize is
		do
                        check
                                not_yet_implemented: False
                        end		
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
		do
			gtk_widget_set_sensitive (widget, not flag)
		end
	
feature -- Measurement
	
	x: INTEGER is
			-- Horizontal position relative to parent
		do
                        check
                                not_yet_implemented: False
                        end
		end

	y: INTEGER is
			-- Vertical position relative to parent
		do
                        check
                                not_yet_implemented: False
                        end
		end	

	width: INTEGER is
			-- Width of widget
		do
			Result := c_gtk_widget_width (widget)
		end

	height: INTEGER is
			-- Height of widget
                do
                        Result := c_gtk_widget_height (widget)
		end

feature -- Resizing

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
                do
                        gtk_widget_set_usize (widget, new_width, new_height)
		end

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
                do
                        gtk_widget_set_usize (widget, new_width, height)
		end
	
	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		do
                        check
                                not_yet_implemented: False
                        end		
		end

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
		do
                        check
                                not_yet_implemented: False
                        end
		end

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		do
                        check
                                not_yet_implemented: False
                        end
		end

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
		do
                        check
                                not_yet_implemented: False
                        end
		end

feature -- Event - command adding

	put_command (event: EV_EVENT; command: EV_COMMAND; argument: ARGUMENTS) is
			-- Associate `command' and 'event' so that
			-- 'command' will be executed when the 'event'
			-- happens. `arguments' will be passed to
			-- `command' whenever it is invoked as a
			-- callback.
		
			-- Only one command per event is possible
			-- A new put_command with an existing event 
			-- will replace the old command with the new one.
		local
			gtk_command_id: INTEGER
                do
			-- check if to use gtk signals or x events
			gtk_command_id := c_gtk_signal_connect (widget,
                                                                $event,
                                                                command.execute_address,
                                                                $command,
                                                                $argument)      
			-- save the event/id pair

		end


feature -- Event - command removal

-- 	remove_command (event: EV_EVENT) is
-- 			-- Remove the command associated with 'event'.
-- 			-- Do nothing if there is no command 
-- 			-- associated with 'event'.
-- 		do
-- 			-- Find the id in event/id table and remove 
-- 			-- the signal
-- 		end




feature {EV_WIDGET_IMP} -- Implementation

        widget: POINTER
                        -- pointer to the C structure representing this widget





end

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
