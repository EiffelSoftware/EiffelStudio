indexing	
	description: "EiffelVision item. Mswindows implementation"
	note: "It is not necessary to inherit from%
		% EV_TEXT_CONTAINER_IMP because all the features%
		% use `wel_window', but such a big object isn't%
		% necessary here."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_ITEM_IMP

inherit
	EV_ITEM_I

	EV_PIXMAPABLE_IMP

	EV_EVENT_HANDLER_IMP
		export
			{EV_ITEM_CONTAINER_IMP} execute_command
		end

	EV_ITEM_EVENTS_CONSTANTS_IMP

feature -- Access

	parent_widget: EV_WIDGET is
			-- Parent widget of the current item
		do
			Result := parent.current_widget
		end

feature -- Event : command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executed command when the item is 
			-- activated.
		do
			add_command (Cmd_item_activate, cmd, arg)			
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executed command when the item is
			-- unactivated.
		do
			add_command (Cmd_item_deactivate, cmd, arg)		
		end

feature {EV_ITEM_CONTAINER_IMP} -- Implementation

	id: INTEGER
		-- Id of the item in its container

	set_id (new_id: INTEGER) is
			-- Set `id' to `new_id'
		do
			id := new_id
		end

feature {NONE} -- Implementation

	parent: EV_ITEM_CONTAINER_IMP
		-- The current container of the item

	wel_window: WEL_WINDOW is
			-- Window used to create the related pixmap. It has
			-- to be a wel_control.
			-- It correspond to the implementation of the
			-- parent_widget.
		do
			Result ?= parent_widget.implementation
		end

end -- class EV_ITEM_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
