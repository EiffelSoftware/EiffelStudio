class SET_DIALOG_ATTRIBUTES_COM

inherit
	
	COMMAND;
	CONSTANTS

feature

	execute (dialog: TERMINAL_OUI) is
		local
			fg_color, bg_color: COLOR;
			a_font: FONT;
			widget: WIDGET;
			primitive: PRIMITIVE;
			fontable: FONTABLE
		do
			bg_color := Resources.background_color;
			fg_color := Resources.foreground_color;
			a_font := Resources.default_font;
			if bg_color /= Void or else 
				fg_color /= Void or else
				a_font /= Void
			then
--				if bg_color /= Void then
--					dialog.set_background_color (bg_color)
--				end;
				if fg_color /= Void then
					dialog.set_foreground_color (fg_color)
				end;
				if a_font /= Void then
					dialog.set_label_font (a_font);
					dialog.set_text_font (a_font);
					dialog.set_button_font (a_font);
				end;
			end;
		end;

end
