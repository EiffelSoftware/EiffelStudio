indexing
	description: 
		"EiffelVision widget, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
        EV_WIDGET_IMP
        
inherit
        EV_WIDGET_I
        
--	WEL_WINDOW
--	rename
--	 	resize as set_size,
--		move as set_x_y,
--		command as wel_command,
--		parent as wel_parent
--	undefine
--		remove_command
--	end
	

feature -- Status report
	
	destroyed: BOOLEAN is
			-- Is Current widget destroyed?
		do
			Result := not wel_window.exists
		end
		
	insensitive: BOOLEAN is
			-- Is current widget insensitive?
                do
                        Result := not wel_window.enabled
		end

	shown: BOOLEAN is
		do
			Result := wel_window.shown
		end
	
feature -- Status setting

	destroy is
		do
			wel_window.destroy
		end
	
	hide is
			-- Make widget invisible on the screen.
		do
			wel_window.hide
		end
	
	show is
		do
			wel_window.show
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
			if flag then
				wel_window.disable
			else
				wel_window.enable
			end
		end
	
feature -- Measurement
	
	x: INTEGER is
		do
			Result := wel_window.x
		end
	
	y: INTEGER is
		do
			Result := wel_window.y
		end
	
	width: INTEGER is
		do
			Result := wel_window.width
		end
	
	height: INTEGER is 
		do
			Result := wel_window.height
		end
	
	minimum_width: INTEGER is
			-- Minimum width of widget
		once
			Result := 0
		end

	minimum_height: INTEGER is
			-- Minimum height of widget
		once
			Result := 0
		end
	
feature -- Resizing

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Resize the widget and notify the parent of 
			-- the resize
		do
			wel_window.resize (new_width, new_height)
			if parent_imp /= Void then
				parent_imp.child_has_resized (new_width, new_height)
			end
		end
	
	set_width (new_width :INTEGER) is
		do
			wel_window.set_width (new_width)
			if parent_imp /= Void then
				parent_imp.child_has_resized (new_width, height)
			end
		end
		
	set_height (new_height: INTEGER) is
		do
			wel_window.set_height (new_height)
			if parent_imp /= Void then
				parent_imp.child_has_resized (width, new_height)
			end
		end
	
	set_x (new_x: INTEGER) is
		do
			wel_window.set_x (new_x)
		end
		
	set_x_y (new_x: INTEGER; new_y: INTEGER) is
		do
			wel_window.move (new_x, new_y)
		end
	
	set_y (new_y: INTEGER) is
		do
			wel_window.set_y (new_y)
		end
	
	dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
		-- Check if the dimensions of the widget are set to 
		-- the values given or the minimum values possible 
		-- for that widget
		do
			Result := (width = new_width or else width = minimum_width) and then (height = new_height or else height = minimum_height)
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
		do		
			check
				not_yet_implemented: False
			end
		end


	remove_command (command_id: INTEGER) is
			-- Remove the command associated with
			-- 'command_id' from the list of actions for
			-- this context. If there is no command
			-- associated with 'command_id', nothing
			-- happens.
		do		
			check
				not_yet_implemented: False
			end
		end
	
	last_command_id: INTEGER
			-- Id of the last command added by feature
			-- 'add_command'
	
	
feature {EV_CONTAINER_IMP} -- Implementation
	
	set_parent_imp (p: EV_CONTAINER_IMP) is
		do
			parent_imp := p
		end
	
feature {NONE} -- Implementation
	
	parent_imp: EV_CONTAINER_IMP
			-- Container parent of this widget
	
feature {EV_WIDGET_IMP} -- Implementation
	
	wel_window: WEL_WINDOW is
			-- Actual WEL component
	        deferred
		end
	
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
