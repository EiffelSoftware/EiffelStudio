class SET_WINDOW_ATTRIBUTES

inherit
	
	SHARED_RESOURCES

feature -- Access

	bg_color: COLOR is
		local
			color_name: STRING
		once
			color_name := Resources.get_string (r_Background_color, Void);
			if color_name /= Void then
				!! Result.make;
				Result.set_name (color_name)
			end
		end;

	fg_color: COLOR is
		local
			color_name: STRING
		once
			color_name := Resources.get_string (r_Foreground_color, Void);
			if color_name /= Void then
				!! Result.make;
				Result.set_name (color_name)
			end
		end;

	global_font: FONT is
		local
			font_name: STRING
		once
			font_name := Resources.get_string (r_Font, Void);
			if font_name /= Void then
				!! Result.make;
				Result.set_name (font_name)
			end
		end;

feature -- Setting

	set_composite_attributes (composite: COMPOSITE) is
		local
			children: ARRAYED_LIST [WIDGET];
			widget: WIDGET;
			primitive: PRIMITIVE;
			fontable: FONTABLE;
			manager: MANAGER;
			terminal: TERMINAL_OUI
		do
			if 
				bg_color /= Void or else 
				fg_color /= Void or else
				global_font /= Void
			then
				children := composite.descendents;
				children.extend (composite);
				from
					children.start
				until
					children.after
				loop
					widget := children.item;
					if bg_color /= Void then
						widget.set_background_color (bg_color)
					end;
					if fg_color /= Void then
						primitive ?= widget;
						if primitive /= Void then
							primitive.set_foreground_color (fg_color)
						else
							manager ?= widget;
							if manager /= Void then
								manager.set_foreground_color (fg_color)
							end
						end
					end;
					if global_font /= Void then
						fontable ?= widget;
						if fontable /= Void then
							fontable.set_font (global_font)
						else
							terminal ?= widget;
							if terminal /= Void then
								terminal.set_button_font (global_font);
								terminal.set_label_font (global_font);
								terminal.set_text_font (global_font)
							end
						end
					end;
					children.forth
				end
			end
		end;

end
