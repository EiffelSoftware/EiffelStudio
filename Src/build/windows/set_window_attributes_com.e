class SET_WINDOW_ATTRIBUTES_COM

inherit
	
	COMMAND;
	CONSTANTS

feature

	execute (composite: COMPOSITE) is
		local
			fg_color, bg_color: COLOR;
			a_font: FONT;
			ch: ARRAYED_LIST [WIDGET];
			widget: WIDGET;
			primitive: PRIMITIVE;
			manager: MANAGER;
			fontable: FONTABLE;
			term: TERMINAL_OUI
			color_stone: COLOR_STONE
		do
--			bg_color := Resources.background_color;
			fg_color := Resources.foreground_color;
			a_font := Resources.default_font;
			if bg_color /= Void or else 
				fg_color /= Void or else
				a_font /= Void
			then
				ch := composite.descendants;
				ch.extend (composite);
				from
					ch.start
				until
					ch.after
				loop
					widget := ch.item;
					term ?= widget;
--					if bg_color /= Void then
--						color_stone ?= widget
						-- If the widget is of type COLOR_STONE, we
						-- do not want to set the background color
--						if color_stone = Void then
--							widget.set_background_color (bg_color)
--						end
--					end;
					if fg_color /= Void then
						primitive ?= widget;
						if primitive /= Void then
							primitive.set_foreground_color (fg_color)
						elseif term /= Void then
							term.set_foreground_color (fg_color)
						end;
					end;
					if a_font /= Void then
						fontable ?= widget;
						if fontable /= Void then
							fontable.set_font (a_font)
						end
						if term /= Void then
							term.set_button_font (a_font);
							term.set_label_font (a_font);
							term.set_text_font (a_font);
						end;
					end;
					ch.forth
				end
			end;
		end;

end
