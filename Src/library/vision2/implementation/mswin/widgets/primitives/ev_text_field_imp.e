indexing

	description: 
		"EiffelVision text field. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_FIELD_IMP
	
inherit
	EV_TEXT_FIELD_I
	
	EV_TEXT_COMPONENT_IMP
		redefine
			wel_window
		end

	EV_BAR_ITEM_IMP
		redefine
			wel_window
		end
	              
creation

	make


feature {NONE} -- Initialization


	make (par: EV_CONTAINER) is
			-- Create the `wel_multiple_line_edit'
		do
			test_and_set_parent (par)
			!! wel_window.make (parent_imp.wel_window, "", 0, 0, 0, 0, 0)	
		end

feature -- Status setting
	
	set_text (txt: STRING) is
		do
			wel_window.set_text (txt)	
		end

feature -- Event - command association
	
	add_activate_command ( command: EV_COMMAND; 
			       arguments: EV_ARGUMENTS) is	
		do
		end

feature -- Implementation

	wel_window: WEL_SINGLE_LINE_EDIT
			-- Current wel_window

end -- class EV_TEXT_FIELD_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable  components for ISE Eiffel.
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
