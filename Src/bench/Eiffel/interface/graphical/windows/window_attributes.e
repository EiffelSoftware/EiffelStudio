indexing

	description:	
		"Class to set window attributes. %
					%CLASS NAME SHOULD CHANGE!";
	date: 	"$Date$";
	revision: 	"$Revision$"

class SET_WINDOW_ATTRIBUTES
	-- FIXME: *****************************************************************

inherit
	
	SHARED_BENCH_RESOURCES

feature -- Properties

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
			terminal: TERMINAL_OUI;
			tmp_bg_color, tmp_fg_color: COLOR;
			tmp_font: FONT
		do
			tmp_bg_color := bg_color;
			tmp_fg_color := fg_color;
			tmp_font := global_font
			if 
				tmp_bg_color /= Void or else 
				tmp_fg_color /= Void or else
				tmp_font /= Void
			then
				children := composite.descendents;
				children.extend (composite);
				from
					children.start
				until
					children.after
				loop
					widget := children.item;
					if tmp_bg_color /= Void then
						widget.set_background_color (tmp_bg_color)
					end;
					if tmp_fg_color /= Void then
						primitive ?= widget;
						if primitive /= Void then
							primitive.set_foreground_color (tmp_fg_color)
						else
							manager ?= widget;
							if manager /= Void then
								manager.set_foreground_color (tmp_fg_color)
							end
						end
					end;
					if tmp_font /= Void then
						fontable ?= widget;
						if fontable /= Void then
							fontable.set_font (tmp_font)
						else
							terminal ?= widget;
							if terminal /= Void then
								terminal.set_button_font (tmp_font);
								terminal.set_label_font (tmp_font);
								terminal.set_text_font (tmp_font)
							end
						end
					end;
					children.forth
				end
			end
		end;

end -- class SET_WINDOW_ATTRIBUTES
