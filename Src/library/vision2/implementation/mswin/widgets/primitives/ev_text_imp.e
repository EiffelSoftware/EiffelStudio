indexing
	description: "EiffelVision text area. %
				  %Mswindows implementation."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_AREA_IMP

inherit
	EV_TEXT_AREA_I
		
	EV_TEXT_COMPONENT_IMP
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
			-- set text in component to 'txt'
			-- To go to a new line, write "%N%R"
		do
			wel_window.set_text (txt)	
		end

feature -- Implementation

	wel_window: WEL_MULTIPLE_LINE_EDIT
			-- Current wel_window

end -- class EV_TEXT_AREA_IMP

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
