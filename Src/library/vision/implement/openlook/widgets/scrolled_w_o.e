--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

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

