indexing
	description: "EiffelVision radio button.%
			% Mswindows implementation"
	author: ""
	date: "$$"
	revision: "$$"

class
	EV_RADIO_BUTTON_IMP

inherit
	EV_RADIO_BUTTON_I
		undefine
			build
		end
		
	EV_CHECK_BUTTON_IMP
		redefine
			wel_window
		end
		
creation
	make_with_text


feature -- Implementation

	wel_window: WEL_RADIO_BUTTON

end -- class EV_RADIO_BUTTON_IMP

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
