indexing

	description: "Button represented with a pixmap";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PICT_COL_B_O 

inherit

	PICT_COL_B_I;

	PICT_COL_B_R_O
		export
			{NONE} all
		end;

	PUSH_B_O
		rename
			make as push_make
		export
			{NONE} all
		redefine
		 	text, set_text, set_font
		end;

creation

	make
	
feature 

	make (a_push_b: PICT_COLOR_B) is
			-- Create an openlook push button.
		
		local
			ext_name: ANY;
		do
			ext_name := a_push_b.identifier.to_c;
			screen_object := create_pict_color_b ($ext_name, a_push_b.parent.implementation.screen_object);
			a_push_b.set_font_imp (Current);
			allow_recompute_size;
		end; 

	pixmap: PIXMAP;
			-- Font name of label

	set_pixmap (a_pixmap: PIXMAP) is
			-- Set pixmap label to `pixmap_name'.
		require else
			a_pixmap_exists: not (a_pixmap = Void)
		
		local
			pixmap_implementation: PIXMAP_X;
			ext_label, ext_size: ANY
		do
			if not (pixmap = Void) then
				pixmap_implementation ?= pixmap.implementation;
				pixmap_implementation.remove_object (Current)
			end;
			pixmap := a_pixmap;
			pixmap_implementation ?= pixmap.implementation;
			pixmap_implementation.put_object (Current);
			ext_label := OlabelPixmap.to_c;
			if recompute_size then
				ext_size := OrecomputeSize.to_c;
				set_boolean (screen_object, True, $ext_size);
				set_openlook_pixmap (screen_object, pixmap_implementation.resource_pixmap (screen), $ext_label);
				set_boolean (screen_object, False, $ext_size);
			else
				set_openlook_pixmap (screen_object, pixmap_implementation.resource_pixmap (screen), $ext_label);
			end
		ensure then
			pixmap = a_pixmap
		end;
	
feature {NONE}

	update_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		
		local
			ext_name: ANY;
			pixmap_implementation: PIXMAP_X;
		do
			ext_name := OlabelPixmap.to_c;		
			pixmap_implementation ?= pixmap.implementation;
			set_openlook_pixmap (screen_object, 
						pixmap_implementation.resource_pixmap (screen), 
						$ext_name)
		end;
	
feature 

	text: STRING is
			-- Text of current button
		require else
			text_not_supported_for_pict_color_button: false
		do
		end;

	set_text (a_text: STRING) is
			-- Set current button text to `a_text'.
		require else
			text_not_supported_for_pict_color_button: false
		do
		end;

	set_font (a_font: FONT) is
			-- Set font to `a_font'.
		require else
			font_not_supported_for_pict_color_button: false
		do
		end;


feature {NONE} -- External features

	create_pict_color_b (name: POINTER; parent: POINTER): POINTER is
		external
			"C"
		end;

 	set_openlook_pixmap (scr_obj, pix: POINTER; resource: POINTER) is
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
