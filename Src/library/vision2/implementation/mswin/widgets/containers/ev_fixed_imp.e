indexing
	description: "EiffelVision fixed container. Allows several children that%
				  % must be place in one's hand. Mswindows implementation"
	author: "Leila"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIXED_IMP

inherit
	EV_FIXED_I

	EV_INVISIBLE_CONTAINER_IMP

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the fixed container in  ev_window.
		local
			count_imp: EV_CONTAINER_IMP
		do
			count_imp ?= par.implementation
			check
				valid_container: count_imp /= Void
			end
			!! wel_window.make (count_imp.wel_window, "")
		end

end -- class EV_FIXED_IMP

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
