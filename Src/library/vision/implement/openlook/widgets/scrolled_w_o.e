
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLLED_W_O 

inherit

	SCROLLED_W_I
		
		export
			{NONE} all
		end;

	SCROLLED_W_R_O
		export
			{NONE} all
		end;

	MANAGER_O

creation

	make

feature 

	make (a_scrolled_window: SCROLLED_W) is
			-- Create an openlook scrolled window.
		local
			ext_name: ANY;
		do
			ext_name := a_scrolled_window.identifier.to_c;		
			screen_object := create_scrolled_w ($ext_name,
					a_scrolled_window.parent.implementation.screen_object);
		end;

	working_area: WIDGET;
			-- Working area of window which will
			-- be moved using scrollbars

	set_working_area (a_widget: WIDGET) is
			-- Set work area of window to `a_widget'.
		require else
			not_a_widget_void: not (a_widget = Void)
		do
			working_area := a_widget;
			set_xt_widget (screen_object, a_widget.implementation.screen_object, OworkWindow)
		ensure then
			working_area = a_widget
		end 

feature {NONE} -- External features

	create_scrolled_w (name: ANY; parent: POINTER): POINTER is
		external
			"C"
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
