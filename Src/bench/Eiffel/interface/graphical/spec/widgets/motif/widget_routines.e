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
			mel_widget: MEL_SCROLLED_TEXT;
			color_x: COLOR_IMP;
		do
			mel_widget ?= a_widget;
			color_x ?= a_color.implementation;
			color_x.allocate_pixel;
			mel_widget.set_background_color (color_x)
		end;

	copy_text_from_widget (a_widget: SCROLLED_T_I) is
			-- Copy the text from `a_widget'.
		local
			mel_widget: MEL_SCROLLED_TEXT;
		do
			mel_widget ?= a_widget;
			mel_widget.copy_text (0);
		end;

	cut_text_from_widget (a_widget: SCROLLED_T_I) is
			-- Cut the text from `a_widget'.
		local
			mel_widget: MEL_SCROLLED_TEXT;
		do
			mel_widget ?= a_widget;
			mel_widget.cut_text (0);
		end;

	paste_text_to_widget (a_widget: SCROLLED_T_I) is
			-- Paste the text to `a_widget'.
		local
			mel_widget: MEL_SCROLLED_TEXT;
		do
			mel_widget ?= a_widget;
			mel_widget.paste_text
		end;

	init_button (a_button: BUTTON_I) is
			-- Initialize the button.
		local
			mel_primitive: MEL_PRIMITIVE
		do
			mel_primitive ?= a_button;	
			mel_primitive.set_highlight_thickness (0);
			--mel_primitive.set_shadow_thickness (3)
		end;

	real_project_height (a_widget: WIDGET_I): INTEGER is
			-- Height of `a_widget'
		do
			Result := a_widget.height
		end
 
end -- class WIDGET_ROUTINES
