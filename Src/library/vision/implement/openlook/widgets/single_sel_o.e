
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SINGLE_SEL_O 

inherit

	W_MAN_GEN
		export
			{NONE} all
		end;

	EVENT_HAND_O
		rename
			make as event_hand_o_make
		redefine
			create_context_data
		end

creation

	make
	
feature {NONE}

	list: LIST_MAN_O;
	
feature 

	make (screen_object: POINTER; resource: STRING; widget_oui: WIDGET; scroll: LIST_MAN_O) is
			-- Create an event handler for `widget_oui' triggered by the
			-- openlook call-back specified by `resource'.
		do
			event_hand_o_make (screen_object, resource, widget_oui);
			list := scroll;
		end;

feature {NONE}

	create_context_data (widget_oui: WIDGET): SINGLE_DATA is
			-- Context data for `single' action
		local
			xt_widget: SCROLL_L_O;
		do
			!!Result.make (widget_oui, 
					list.selected_position, 
					list.selected_item)
		end 

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
