
indexing
	copyright: "See notice at end of class";

class ATTACHMENT
	
feature 

	is_form_or_posit: BOOLEAN is 
			-- Is Current attachment using forms or positioning?			
		do
			Result := false;
		end;

	perform_attach (widget: WIDGET_I; length: INTEGER; fraction_base: INTEGER; side: INTEGER) is
			-- Do nothing.
		do
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
