--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class ATTACH_FORM

inherit

	ATTACHMENT
		redefine
			is_form_or_posit,
			perform_attach
		end;

	DIRECTION_DEF
		export
			{NONE} all
		end

creation

	make
	
feature {NONE}

	offset: INTEGER;
	
feature 

	is_form_or_posit: BOOLEAN is
			-- Is Current attachment using forms or positioning?
		do
			Result := True
		end;

	make (an_offset: INTEGER) is
			-- Make an attachment with an offset `an_offset'.
		do
			offset := an_offset
		end;

	perform_attach (a_widget: WIDGET_I; length: INTEGER; dummy: INTEGER; a_side: INTEGER) is
			-- Attach widget `a_widget' to side `a_side'.
		do
			inspect a_side
				when bottom_side then
					attach_form_bottom (a_widget.screen_object, offset)
				when top_side then
					attach_form_top (a_widget.screen_object, offset)
				when left_side then
					attach_form_left (a_widget.screen_object, offset)
				when right_side then
					attach_form_right (a_widget.screen_object, offset)
			end
		end;

feature {NONE} -- External features

	attach_form_bottom (scr_obj: POINTER; an_offset: INTEGER) is
		external
			"C"
		end; 

	attach_form_right (scr_obj: POINTER; an_offset: INTEGER) is
		external
			"C"
		end; 

	attach_form_left (scr_obj: POINTER; an_offset: INTEGER) is
		external
			"C"
		end; 

	attach_form_top (scr_obj: POINTER; an_offset: INTEGER) is
		external
			"C"
		end; 

end 
