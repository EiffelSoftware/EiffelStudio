--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- OpenLook button implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

class BUTTON_O 

inherit

	STRING_R_O
		export
			{NONE} all
		end;

	BUTTON_R_O
		export
			{NONE} all
		end;

	PRIMITIVE_O
		redefine 
			realize
		end;

	SIZE_MAN_O
		export
			{NONE} all
		end			
	
feature {NONE}

	is_gadget_valid (a_parent: COMPOSITE): BOOLEAN is
			-- Does `a_parent' manage a gadget implementation for current
			-- button?
		do
			Result := True
		end; 
	
feature 

	realize is
			-- Realize the widget.
		do
		end;

	text: STRING is
			-- Text of button
		do
			Result := xt_string (screen_object, OlabelString)
		end;

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		require
			not_text_void: not (a_text = Void)
		local
			size_res, string_res, ext_text: ANY
		do
			string_res := OlabelString.to_c;
			ext_text := a_text.to_c;
			if recompute_size then
				size_res := OrecomputeSize.to_c;
				set_boolean (screen_object, True, $size_res);
				set_string (screen_object, $ext_text, $string_res);
				set_boolean (screen_object, False, $size_res);
			else
				set_string (screen_object, $ext_text, $string_res);
			end
		ensure
			text.is_equal (a_text)
		end;

	set_center_alignment is
			-- Set text alignment to center
		do
			set_xt_unsigned_char (screen_object, OL_CENTER, OlabelJustify)
	   end;
 
	set_left_alignment is
			-- Set text alignment to left.
		do
			set_xt_unsigned_char (screen_object, OL_LEFT, OlabelJustify)
		end;
 
end 
