indexing

	description: 
		"Motif implementation of a split window.";
	date: "$Date$";
	revision: "$Revision $"

class SPLIT_WINDOW_I

inherit

	MANAGER_I;

	MANAGER_M
		rename
			is_shown as shown
		end;

	MEL_PANED_WINDOW
		rename
			make as mel_paned_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen,
			is_shown as shown
		end

creation

	make

feature {NONE} -- Initialization

	make (a_window: SPLIT_WINDOW; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif frame.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_paned_make (a_window.identifier, mc, man);
			set_margin_height (0);
			set_margin_width (0);
			set_spacing (10);
		end

end -- class SPLIT_WINDOW_I
