--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class READ_ACTION_O 

feature {NONE}

	expose_data (widget_oui: WIDGET): EXPOSE_DATA is
            		--  
        	local
            		clip: CLIP;
            		coord: COORD_XY
        	do
            		!!coord;
            		coord.set (c_clip_action_x, c_clip_action_y);
            		!!clip;
            		clip.set (coord, c_clip_action_width, c_clip_action_height);
            		!!Result.make (widget_oui, clip)
        	end; 

	browse_data (widget_oui: WIDGET): SINGLE_DATA is
			-- Context data for `browse' action
		
		do
			!!Result.make (widget_oui, c_click_action_position, 
								c_click_action_item)
		end; 

	click_data (widget_oui: WIDGET): CLICK_DATA is
			-- Context data for `click' action
		
		do
			!!Result.make (widget_oui, c_click_action_position, 
								c_click_action_item)
		end; 

	create_context_data (widget_oui: WIDGET): CONTEXT_DATA is
			-- Context data for the current action
		
		do
			!!Result.make (widget_oui)
		end;

feature {NONE} -- External features

	c_clip_action_x: INTEGER is
		external
			"C"
		end; 

	c_click_action_item: STRING is
		external
			"C"
		end; 

	c_click_action_position: INTEGER is
		external
			"C"
		end; 

	c_clip_action_height: INTEGER is
		external
			"C"
		end;

	c_clip_action_width: INTEGER is
		external
			"C"
		end;

	c_clip_action_y: INTEGER is
		external
			"C"
		end; 

end

