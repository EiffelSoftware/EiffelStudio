indexing

	description: 
		"Routines applied to different widgets for a particalar toolkit. %
		%In some instances, it was not worth while to abstract separate %
		%classes to implement simple routines.";
	date: "$Date$";
	revision: "$Revision $"

class WIDGET_ROUTINES

feature -- Setting

	set_scrolled_text_background_color (a_widget: SCROLLED_T_I; a_color: COLOR) is
			-- Set the scrolled text widget `a_widget' background color
			-- to `a_color' 
		local
			text_windows: TEXT_WINDOWS
		do
			text_windows ?= a_widget;
			text_windows.set_background_color (a_color)
		end;

	copy_text_from_widget (a_widget: SCROLLED_T_I) is
			-- Copy the text from `a_widget'.
		local
			wel_edit: WEL_EDIT
		do
			wel_edit ?= a_widget;
			if wel_edit.has_selection then
				wel_edit.clip_copy
			end
		end;
 
	cut_text_from_widget (a_widget: SCROLLED_T_I) is
			-- Cut the text from `a_widget'.
		local
			wel_edit: WEL_EDIT
		do
			wel_edit ?= a_widget;
			if wel_edit.has_selection then
				wel_edit.clip_cut
			end
		end;
 
	paste_text_to_widget (a_widget: SCROLLED_T_I) is
			-- Paste the text to `a_widget'.
		local
			wel_edit: WEL_EDIT
		do
			wel_edit ?= a_widget;
			wel_edit.clip_paste
		end;
 
	init_button (a_button: BUTTON_I) is
			-- Initialize the button.
		do
		end;
 
	real_project_height (a_widget: WIDGET_I): INTEGER is
		local
			wel_window: WEL_WINDOW
		do
			wel_window ?= a_widget;
			Result := wel_window.client_rect.height
		end

end -- class WIDGET_ROUTINES
