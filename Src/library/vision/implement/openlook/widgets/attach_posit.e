--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class ATTACH_POSIT

inherit
	ATTACHMENT
		redefine
			is_form_or_posit,
			perform_attach
		end;

	DIRECTION_DEF
		export
			{NONE} all
		end;

	BASIC_ROUTINES
		export
			{NONE} all
		end

creation

	make
	
feature {NONE}

	position: INTEGER;

feature 

	is_form_or_posit: BOOLEAN is 
			-- Is Current attachment using forms or positioning ?
		do
			Result := True;
		end;

	make (a_position: INTEGER) is
			-- Make an attachment with position `a_position'.
		do
			position := a_position
		end; 

	perform_attach (a_widget: WIDGET_I; a_length: INTEGER; a_fract_base: INTEGER; a_side: INTEGER) is
			-- Attach widget `a_widget' with length `a_length' 
			-- and fraction_base `a_fract_base' to side `a_side'.	
		do
			inspect a_side
				when bottom_side then
					attach_form_bottom (a_widget.screen_object, 
							real_to_integer (a_length/a_fract_base*(a_fract_base-position)))
				when top_side then
					attach_form_top (a_widget.screen_object, 
							real_to_integer (a_length/a_fract_base*position))				
				when left_side then
					attach_form_left (a_widget.screen_object, 
							real_to_integer (a_length/a_fract_base*position))
				when right_side then
					attach_form_right (a_widget.screen_object,  
							real_to_integer (a_length/a_fract_base*(a_fract_base-position)))
			end
		end;

feature {NONE} -- External features

	attach_form_bottom (scr_obj: POINTER; offset: INTEGER) is
		external
			"C"
		end; 

	attach_form_right (scr_obj: POINTER; offset: INTEGER) is
		external
			"C"
		end; 

	attach_form_left (scr_obj: POINTER; offset: INTEGER) is
		external
			"C"
		end; 

	attach_form_top (scr_obj: POINTER; offset: INTEGER) is
		external
			"C"
		end; 

end 
