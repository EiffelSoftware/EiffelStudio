class 
	EV_TEXT_FIELD_WITH_LABEL
	
inherit 
	EV_TEXT_FIELD
		redefine
			make
		end
	
	
creation
	
	make,
	make_with_label 
	
feature -- Initialization
	
	make (par: EV_CONTAINER) is
                        -- Create a text field with, `par' as
                        -- parent
		do
			!!box.make (par)
			box.set_homogeneous (False)
			!!label.make (box)
			{EV_TEXT_FIELD} Precursor (box)
			set_text ("0")
			set_minimum_width (50)
		end
	
	make_with_label (par: EV_CONTAINER; name: STRING) is
			-- create a text field with name
		do
			make (par)
			label.set_text (name)
		end
	
	
feature -- Access
	
	label: EV_LABEL
	box: EV_HORIZONTAL_BOX
	
end
	

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

