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

feature {NONE} -- Initialization

	make_with_text (txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
			make
			set_text (txt)
		end

	make_with_pixmap (pix: EV_PIXMAP) is
			-- Create an item with `par' as parent and `pix'
			-- as pixmap.
		do
			make
--			set_pixmap (pix)
		end

	make_with_all (txt: STRING; pix: EV_PIXMAP) is
			-- Create an item with `par' as parent, `txt' as text
			-- and `pix' as pixmap.
		do
			make
			set_text (txt)
--			set_pixmap (pix)
		end

feature -- Access

	text: STRING 
			-- Current label of the item

	id: INTEGER
		-- Id of the item in its container

feature -- Element change

	set_id (new_id: INTEGER) is
			-- Set `id' to `new_id'
		do
			id := new_id
		end

feature -- Event : command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is activated.
		do
			add_command (Cmd_item_activate, cmd, arg)			
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unactivated.
		do
			add_command (Cmd_item_deactivate, cmd, arg)		
		end

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		do
			remove_command (Cmd_item_activate)			
		end	

	remove_deactivate_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		do
			remove_command (Cmd_item_deactivate)		
		end

feature -- Implementation

	parent_imp: EV_ITEM_CONTAINER_IMP is
			-- The current container of the item
		deferred
		end

	parent_widget: EV_WIDGET is
			-- Parent widget of the current item
		do
			Result := parent_imp.current_widget
		end

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
