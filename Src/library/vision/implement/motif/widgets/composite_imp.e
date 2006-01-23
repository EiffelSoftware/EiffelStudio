indexing

	description: 
		"EiffelVision implementation of a MOTIF composite."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 		
	COMPOSITE_IMP

inherit

	WIDGET_IMP
		undefine
			mel_destroy, clean_up, object_clean_up, mel_set_insensitive
		end;

	MEL_COMPOSITE
		rename
            background_color as mel_background_color,
            background_pixmap as mel_background_pixmap,
            set_background_color as mel_set_background_color,
            set_background_pixmap as mel_set_background_pixmap,
            destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen
        end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class COMPOSITE_IMP

