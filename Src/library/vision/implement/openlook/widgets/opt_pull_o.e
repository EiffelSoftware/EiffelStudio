
-- OPT_PULL_O: implementation of pulldown menu for an option button.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class OPT_PULL_O 

inherit
	OPT_PULL_I		
		export
			{NONE} all
		end;

	PULLDOWN_O
		redefine
			button
		end;

	PULLDOWN_R_O
		export
			{NONE} all
		end

creation

	make
	
feature 

	button: OPTION_B;

	make (a_pulldown: OPT_PULL) is
			-- Create an openlook pulldown menu.
		
		local
			ext_name: ANY;
		do
			!!button.make(a_pulldown.identifier,a_pulldown.parent);
			ext_name := OmenuPane.to_c;
			screen_object := get_widget(button.implementation.screen_object, $ext_name);
			abstract_menu := a_pulldown;
			option_button := button
		end; 

	selected_button: BUTTON is
					-- Current Push Button selected in the option menu
		do
			Result := button.selected_button
		end;

   	set_selected_button (a_button: PUSH_B) is
					-- Set `selected_button' to `button'
		do
			option_button.set_selected_button(a_button)				
			ensure then
				selected_button.same (a_button)
		end; 

	Caption: STRING is
		do
		end;

	set_caption (a_caption: STRING) is do end;
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
