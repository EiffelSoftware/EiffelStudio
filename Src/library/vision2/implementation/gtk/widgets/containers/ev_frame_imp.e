indexing
	description:
		"EiffelVision Frame, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_FRAME_IMP

inherit
	EV_FRAME_I

	EV_CONTAINER_IMP

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a frame with `par' as parent.
		do
			make_with_text (par, "")
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a frame with `par' as parent.
		local
			a: ANY
		do
			a ?= txt.to_c
			widget := gtk_frame_new ($a)
			show
		end

end -- class EV_FRAME_IMP

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
