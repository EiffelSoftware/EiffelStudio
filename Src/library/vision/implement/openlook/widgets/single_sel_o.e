--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

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
