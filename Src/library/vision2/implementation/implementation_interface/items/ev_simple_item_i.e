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

feature -- Status settings

-- XX to implement
--	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void.
--		require
--			exists: not destroyed
--		deferred
--		ensure
--			parent_set: parent = par
--		end

feature -- Event : command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executed command when the item is 
			-- activated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executed command when the item is
			-- unactivated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end	

feature -- Implementation

	interface: EV_ITEM
			-- Interface of the current item

	set_interface (an_interface: EV_ITEM) is
			-- Make `an_interface' the new interface of the item.
		require
			an_interface /= Void
		do
			interface := an_interface
		ensure
			interface = an_interface
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
