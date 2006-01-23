indexing

	description: 
		"EiffelVision implementation of a Motif radio box."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	RADIO_BOX_IMP

inherit

	RADIO_BOX_I;

	MANAGER_IMP
		rename
			is_shown as shown
		undefine
			create_callback_struct
		end;

	MEL_RADIO_BOX
		rename
			make as mel_radio_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		end

create

	make

feature {NONE} -- Initialization

	make (a_radio_box: RADIO_BOX; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif radio_box.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_radio_make (a_radio_box.identifier, mc, man)
		end;

feature -- Status setting

	set_always_one (flag: BOOLEAN) is
			-- Set radio always one to `flag;.
		do
			if flag then
				enable_always_one 
			else
				disable_always_one
			end
		end;

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




end -- class RADIO_BOX_IMP

