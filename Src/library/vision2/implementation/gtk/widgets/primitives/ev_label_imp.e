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
	
	EV_BAR_ITEM_IMP

	EV_TEXT_CONTAINER_IMP
                rename
                        label_widget as widget
                end
creation

	make

feature {NONE} -- Initialization

        make (parent: EV_CONTAINER) is
                        -- Create a gtk label.
                local
                        a: ANY
			s: STRING
                do
			!!s.make (0)
			s := ""
                        a ?= s.to_c
                        widget := gtk_label_new ($a)
                end



end --class LABEL_I

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
