indexing

	description: 
		"EiffelVision implementation of a Motif separator."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	SEPARATOR_IMP

inherit

	SEPARATOR_I;

	PRIMITIVE_IMP
		rename
			is_shown as shown
		end;

	MEL_SEPARATOR
		rename
			make as mel_sep_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			set_horizontal as mel_set_horizontal,
			is_shown as shown
		end

create

	make

feature {NONE} -- Initialization

	make (a_separator: SEPARATOR; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif separator.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_sep_make (a_separator.identifier, mc, man)
		end

feature -- Status setting

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		do
			if flag then
				mel_set_horizontal 
			else
				set_vertical
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




end -- class SEPARATOR_IMP

