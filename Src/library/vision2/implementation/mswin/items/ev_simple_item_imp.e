indexing	
	description: "EiffelVision item. Mswindows implementation"
	note: "It is not necessary to inherit from              %
		% EV_TEXT_CONTAINER_IMP because all the features %
		% use `wel_window', but such a big object isn't  %
		% necessary here."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 

	EV_ITEM_IMP

inherit

	EV_ITEM_I

feature {NONE} -- Access for implementation

	id: INTEGER
		-- Id of the item in the menu_item_container

	command: EV_COMMAND
		-- Command that must be called when the menu is selected
		-- by the user.

	arguments: EV_ARGUMENTS
		-- Argument that goes with the command

feature -- Status report

	text: STRING is
			-- Current label of the item
		deferred
		end

	destroyed: BOOLEAN is
			-- Is current object destroyed
		deferred
		end

feature -- Status setting

	set_center_alignment is
			-- Set text alignment of current label to center.
		do
			check
                               not_yet_implemented: False
            end
		end

	set_right_alignment is
			-- Set text alignment of current label to right.
		do
			check
                                not_yet_implemented: False
                        end
		end

	set_left_alignment is
			-- Set text alignment of current label to left.
		do
			check
                                not_yet_implemented: False
                        end
		end

feature {NONE} -- Status setting for implementation

	set_id (new_id: INTEGER) is
			-- Set `id' to `new_id'
		do
			id := new_id
		end

feature -- Element change

	set_text (str: STRING) is
			-- Set `text' to `str'
		deferred
		end

feature -- Event : command association

	add_activate_command (a_command: EV_COMMAND; 
			       an_arguments: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be
			-- executed when the menu item is activated
		do
			command := a_command
			arguments := an_arguments
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
