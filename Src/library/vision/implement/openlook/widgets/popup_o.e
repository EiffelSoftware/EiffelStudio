
-- POPUP_O: implementation of popup menu.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class POPUP_O 

inherit

	POPUP_I;

	MENU_O
		export
			{NONE} all
		redefine
			set_title
		end;
	
	PULLDOWN_R_O
		export
			{NONE} all
		end

creation

	make
	
feature 

	make (a_popup: POPUP) is
			-- Create an openlook popup menu 
			-- set screen_object with the menuPane of the popup
		
		local
			ext_name: ANY;
			ext_id: ANY;
		do
			ext_id := a_popup.identifier.to_c;
			the_popup := create_popup ($ext_id, a_popup.parent.implementation.screen_object);
			ext_name := OmenuPane.to_c;
			screen_object := get_widget (the_popup, $ext_name);
			abstract_menu := a_popup
		end; 
	
feature {NONE}

	the_popup : POINTER;
			-- C identifier of the popup menu
	
feature 

	set_title (a_title: STRING) is
			-- Set menu title to `a_title'.
		require else
			not_title_void: not (a_title = Void)
		
		local
			ext_name: ANY;
			ext_title: ANY;
		do
			ext_name := Otitle.to_c;
			ext_title := a_title.to_c;
			set_string (the_popup, $ext_title, $ext_name);
			title := a_title
		end;

	popup is
			-- Popup current popup menu on screen.
		
		do
			xt_popup_none (the_popup)
		end

feature {NONE} -- External features

	create_popup (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end;

	xt_popup_none (scr_obj: POINTER) is
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
