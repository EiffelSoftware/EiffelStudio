indexing
	description:
		"EiffelVision Frame, gtk implementation";
	status: "See notice at end of class."
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

	make is
			-- Create a frame with `par' as parent.
		do
			widget := gtk_frame_new (default_pointer)
			gtk_object_ref (widget)
		end

	make_with_text (txt: STRING) is
			-- Create a frame with `par' as parent.
		local
			a: ANY
		do
			a := txt.to_c
			widget := gtk_frame_new ($a)
			gtk_object_ref (widget)
		end

feature -- Status report

	text: STRING is
			-- Text of the frame
		local
			p: POINTER
		do
			p := c_gtk_frame_text (widget)
			create Result.make (0)
			Result.from_c (p)
		end

feature -- Status setting

	set_text (txt: STRING) is
			-- set the `text' of the frame
		local
			a: ANY
		do
			a := txt.to_c
			gtk_frame_set_label (widget, $a)
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
