--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class SCALE_O 

inherit

	SCALE_I;

	SLIDER_O
		export
			{NONE} all
		end;

--	FONTABLE_O
--		rename
--			font as old_font,
--			set_font as old_set_font
--		export
--			{NONE} all
--		end

creation

	make

feature 

	make (a_scale: SCALE) is
			-- Create a openlook scale.
		
		local
			ext_name: ANY;
		do
			ext_name := a_scale.identifier.to_c;		
			screen_object := create_vertical_scale ($ext_name, a_scale.parent.implementation.screen_object);
			a_scale.set_font_imp (Current);
			set_granularity (10)
		ensure
			maximum = 100;
			minimum = 0;
			granularity = 10;
			value = 0;
			not is_horizontal;
			not is_value_shown;
			not is_maximum_right_bottom
		end; 

	set_horizontal (flag: BOOLEAN) is
            		-- Set orientation of the scale to horizontal if `flag',
            		-- to vertical otherwise.
        	do
			if flag xor is_horizontal then
				screen_object := set_scale_horizontal (screen_object, flag);
				is_horizontal := flag;
				update_event_handlers;
			end
        	ensure then
            		value_correctly_set: is_horizontal = flag
        	end; 

feature {NONE} -- External features

	create_vertical_scale (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end; 

	create_horizontal_scale (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end; 

	set_scale_horizontal (scr_obj: POINTER; flag: BOOLEAN): POINTER is
		external
			"C"
		end; 

end 
