indexing

	description: "EiffelVision list_item, implementation interface."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_LIST_ITEM_I
	
inherit
	EV_ITEM_I

	EV_PIXMAP_CONTAINER_I

feature {NONE} -- Initialization

	make (par: EV_LIST) is
		require
			valid_parent: par.is_valid
		deferred
		end
	
	make_with_text (par: EV_LIST; txt: STRING) is
		require
			valid_parent: par.is_valid
			valid_string: txt /= Void
		deferred
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			exists: not destroyed
		deferred
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposit status.
		require
			exists: not destroyed
		deferred
		end

feature -- Event : command association

	add_double_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make 'cmd' the executed command the item is double clicked.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end	

end -- class EV_LIST_ITEM_I

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
