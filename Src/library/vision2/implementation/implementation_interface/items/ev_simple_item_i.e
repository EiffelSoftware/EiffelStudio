indexing	
	description: 
		"EiffelVision item. Implementation interface"
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_ITEM_I

inherit
	EV_ANY_I

	EV_PIXMAPABLE_I

feature {NONE} -- Initialization

	make is
			-- Create the widget with `par' as parent.
		deferred
		end

	make_with_text (txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		require
			valid_text: txt /= Void
		deferred
		end

	make_with_pixmap (pix: EV_PIXMAP) is
			-- Create an item with `par' as parent and `pix'
			-- as pixmap.
		require
			valid_pixmap: is_valid (pix)
		deferred
		end

	make_with_all (txt: STRING; pix: EV_PIXMAP) is
			-- Create an item with `par' as parent, `txt' as text
			-- and `pix' as pixmap.
		require
			valid_text: txt /= Void
			valid_pixmap: is_valid (pix)
		deferred
		end

feature -- Access

	text: STRING is
			-- Current label of the item
		require
			exists: not destroyed
		deferred
		end

	parent_widget: EV_WIDGET is
			-- Parent widget of the current item
		require
			exists: not destroyed
		deferred
		end

	parent_imp: EV_ANY_I is
			-- Parent of the current item
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		require
			exists: not destroyed
			valid_text: txt /= Void
		deferred
		ensure
			text_set: text.is_equal (txt)
		end

	set_parent (par: EV_ANY) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		require
			exists: not destroyed
		deferred
		ensure
			parent_set: parent_set (par)
		end

feature -- Assertion

	parent_set (par: EV_ANY): BOOLEAN is
			-- Is the parent set
		do
			if parent_imp /= Void then
				Result := parent_imp.interface = par
			else
				Result := par = Void
			end				
		end

feature -- Event : command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is activated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unactivated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end	

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		require
			exists: not destroyed
		deferred			
		end	

	remove_deactivate_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		require
			exists: not destroyed
		deferred	
		end

end -- class EV_ITEM_I

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
