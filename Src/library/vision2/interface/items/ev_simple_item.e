indexing	
	description: 
		"EiffelVision item. Top class of menu_item, list_item%
		% and tree_item. This item isn't a widget, because most%
		% of the features of the widgets are inapplicable  here."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_ITEM

inherit
	EV_ANY
		redefine
			implementation
		end

	EV_PIXMAPABLE
		redefine
			implementation
		end

feature -- Access

	text: STRING is
			-- Current label of the item
		require
			exists: not destroyed
		do
			Result := implementation.text
		end

	data: ANY is
			-- A data kept by the item
		require
			exists: not destroyed
		do
			Result := implementation.data
		end

	parent: EV_ANY is
			-- The parent of the Current widget
			-- Can be void.
		require
			exists: not destroyed
		do
			if implementation.parent_imp /= Void then
				Result ?= implementation.parent_imp.interface
			else
				Result := Void
			end
		end
		
	parent_widget: EV_WIDGET is
			-- Parent widget of the current item
		require
			exists: not destroyed
		do
			Result := implementation.parent_widget
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		require
			exists: not destroyed
			valid_text: txt /= Void
		do
			implementation.set_text (txt)
		ensure
			text_set: text.is_equal (txt)
		end

	set_data (a: ANY) is
			-- Make `a' the new data of the item.
		require
			exists: not destroyed
		do
			implementation.set_data (a)
		ensure
			data_set: (data /= Void) implies (data.is_equal (a))
				and (data = Void) implies (a = Void)
		end

feature -- Event : command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is activated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_activate_command (cmd, arg)
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unactivated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_deactivate_command (cmd, arg)		
		end

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		require
			exists: not destroyed
		do
			implementation.remove_activate_commands			
		end	

	remove_deactivate_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		require
			exists: not destroyed
		do
			implementation.remove_deactivate_commands	
		end

feature -- Implementation

	implementation: EV_ITEM_I

end -- class EV_ITEM

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
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
