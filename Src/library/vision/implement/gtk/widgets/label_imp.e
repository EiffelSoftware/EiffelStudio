indexing

	description: 
		"EiffelVision label, gtk implementation.";
	status: "See notice at end of class";
	id: "$id: $";
	date: "$Date$";
	revision: "$Revision$"
	
class
	LABEL_IMP

inherit

	LABEL_I

	PRIMITIVE_IMP
	FONTABLE_IMP
	TEXT_CONTAINER
		rename
			label_widget as widget
		end
	
creation
	make
	

feature {NONE} -- Initialization

	make (a_label: LABEL; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif label.
		local
			a: ANY
		do
			a := a_label.identifier.to_c
			widget := gtk_label_new ($a)
			
			common_widget_make (man, oui_parent)
		end
	

end

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
