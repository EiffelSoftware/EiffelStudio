indexing
	description: "EiffelVision fixed container. Allows several children that%
				  % must be place in one's hand. Mswindows implementation"
	note: "We use `create with coordinates' to allow the notebook%
		% as containers. They are wel_windows and not%
		% wel_composite_windows."
	author: "Leila"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIXED_IMP

inherit
	EV_FIXED_I

	EV_INVISIBLE_CONTAINER_IMP
		redefine
			on_size
		end
		
creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the fixed container in  ev_window.
		local
			par_imp: WEL_WINDOW
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			initialize
			make_with_coordinates (par_imp, "Fixed", 0, 0, 0, 0)
		end

feature {NONE} -- Implementation : WEL features

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
		do
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
