indexing
	description: "EiffelVision check button.%
			% Mswindows implementation"
	author: ""
	date: "$$"
	revision: "$$"

class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		
	EV_TOGGLE_BUTTON_IMP
		redefine
			make_with_text
		end

creation
	make_with_text


feature -- Initialization

	make_with_text (par: EV_CONTAINER; txt: STRING) is
        		-- Create a wel toggle button.
		local
			cont_imp: EV_CONTAINER_IMP
		do
			cont_imp ?= par.implementation
			check
				valid_container: cont_imp /= Void
			end
			!! wel_window.make (cont_imp.wel_window, txt, 0, 0, 10, 10, 0)
			set_font (font)
			set_default_size
		end

end -- class EV_CHECK_BUTTON_IMP

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
