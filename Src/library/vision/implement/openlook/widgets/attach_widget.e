
indexing
	copyright: "See notice at end of class";

class ATTACH_WIDGET

inherit
	
	ATTACHMENT

creation

	make
	
feature 

	extremity: WIDGET_I;

	offset: INTEGER;

	make (a_widget: WIDGET_I; an_offset: INTEGER) is
			-- Make an attach_widget  with `a_widget' as extremity
			-- and `an_offset' as offset.
		do
			extremity := a_widget;
			offset := an_offset;
		end;

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
