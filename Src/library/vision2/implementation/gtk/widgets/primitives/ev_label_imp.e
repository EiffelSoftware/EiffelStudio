indexing

	description: 
		"EiffelVision label, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_LABEL_IMP
	
inherit
	EV_LABEL_I

	EV_PRIMITIVE_IMP
	
	EV_BAR_ITEM_IMP

	EV_TEXTABLE_IMP
                rename
                        label_widget as widget
                end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
                        -- Create a gtk label.
                do
                        make_with_text ("")
                end

	make_with_text (txt: STRING) is
                        -- Create a gtk label.
                local
                        a: ANY
                do
                        a := txt.to_c
                        widget := gtk_label_new ($a)
			gtk_object_ref (widget)
                end
	
feature {NONE} -- Implementation
	
	set_label_widget (new_label_widget: POINTER) is
		do
			widget := new_label_widget
		end

end --class LABEL_IMP

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
