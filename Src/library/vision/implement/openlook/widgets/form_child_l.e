indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FORM_CHILD_L

inherit
	LINKED_LIST [FORM_CHILD]
		rename
			search as list_search
		end;

creation

	make
	
feature 

	is_side_ok (a_widget: WIDGET_I; a_side: INTEGER): BOOLEAN is
			-- Is `a_side' of `a_widget' an ok attachment ?
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := search (a_widget);
			Result := (child_attachments = Void) or else child_attachments.is_ok (a_side)
		end;

	search (a_child: WIDGET_I): FORM_CHILD is
			-- If contains a form child which
			-- widget is `a_child' return the form child
			-- else return void 
		local
			init_position: INTEGER;
		do	
			init_position := index;
			from
				start
			variant
				count - position + 1
			until
				after
				or else (item.widget = a_child)
			loop
				forth
			end;
			if not after then
				Result := item
			end;
			go (init_position);
		end; 

	find (a_child: WIDGET_I): FORM_CHILD is
			-- If  contains a form child which
			-- widget is `a_child' return the form child
			-- else create the form child and insert it 
		local
			init_position: INTEGER;
		do
			init_position := index;
			Result := search (a_child);
			if (Result = Void) then
				!!Result.make (a_child);
				finish;
				put_right (Result);
			end;
			go (init_position);
		ensure
			not_void : not (Result = Void)
		end; 

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
