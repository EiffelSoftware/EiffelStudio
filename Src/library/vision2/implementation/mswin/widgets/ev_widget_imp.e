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
			Result := not exists
		end
		
	insensitive: BOOLEAN is
			-- Is current widget insensitive?
                do
                        Result := not enabled
		end

--	shown: from WEL_WINDOW

feature -- Status setting

--	destroy: from WEL_WINDOW

--	hide: from WEL_WINDOW
			-- Make widget invisible on the screen.
--	show: from WEL_WINDOW

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
				disable
			else
				enable
			end
		end
	
feature -- Measurement
	
--	x: from WEL_WINDOW

--	y: from WEL_WINDOW

--	width: from WEL_WINDOW

--	height: from WEL_WINDOW

feature -- Resizing

--	set_size: from WEL_WINDOW (resize)

--	set_width: from WEL_WINDOW
	
--	set_height: from WEL_WINDOW

--	set_x: from WEL_WINDOW
	
--	set_x_y: from WEL_WINDOW (move)

--	set_y: from WEL_WINDOW

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
	
	set_parent (p: EV_CONTAINER_IMP) is
		do
			parent := p
		end
	
feature {NONE} -- Implementation
	
	parent: EV_CONTAINER_IMP
			-- Container parent of this widget
		
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
