
class COLOR_FORM 

inherit

	COMMAND;
	EDITOR_FORM

creation

	make

feature -- Interface

	make_visible (a_parent: COMPOSITE) is
		local
			pixmap_open_b: PUSH_BG;
			color_set: COLOR_SET;
			label_bg_color: LABEL;
			label_pixmap: LABEL;
			label_fg_color: LABEL;
			label_colors: LABEL;
			bg_color_stone: BG_COLOR_STONE;
			fg_color_stone: FG_COLOR_STONE;
			colors_stone: COLORS_STONE;
			bg_pixmap_stone: BG_PIXMAP_STONE;
			Nothing: ANY
		do
			initialize (Context_const.color_form_name, a_parent);

			!!label_fg_color.make (Context_const.foreground_color_name, 
						Current);
			!!fgr_color.make (Widget_names.textfield, Current, 
					Fg_color_cmd, editor);
			!!label_bg_color.make (Context_const.background_color_name, Current);
			!!label_colors.make (Context_const.colors_name, Current);
			!!backgr_color.make (Widget_names.textfield, Current, 
					Bg_color_cmd, editor);
			!!label_pixmap.make (Context_const.background_pixmap_name, Current);
			!!backgr_pixmap.make (Widget_names.textfield, Current, 
					Bg_pixmap_cmd, editor);
			!!pixmap_open_b.make (Context_const.open_pixmap_name, Current);
			!!color_set.make (Context_const.color_form_name, Current);

			!!bg_color_stone;
			!!fg_color_stone;
			!!colors_stone;
			!!bg_pixmap_stone;
			bg_color_stone.make (Current, editor);
			fg_color_stone.make (Current, editor);
			colors_stone.make (Current, editor);
			bg_pixmap_stone.make (Current, editor);

			attach_left (colors_stone, 10);
			attach_left (bg_color_stone, 10);
			attach_left (fg_color_stone, 10);
			attach_left (bg_pixmap_stone, 10);
			attach_left (label_fg_color, 10);
			attach_left (label_bg_color, 10);
			attach_left (label_pixmap, 10);

			attach_left_widget (fg_color_stone, fgr_color, 5);
			attach_left_widget (bg_color_stone, backgr_color, 5);
			attach_left_widget (bg_pixmap_stone, backgr_pixmap, 5);
			attach_left_widget (colors_stone, label_colors, 5);

			attach_top (label_fg_color, 10);
			attach_top_widget (label_fg_color, fgr_color, 10);
			attach_top_widget (label_fg_color, fg_color_stone, 10);
			attach_top_widget (fgr_color, colors_stone, 10);
			attach_top_widget (fgr_color, label_colors, 10);
			attach_top_widget (label_colors, label_bg_color, 15);
			attach_top_widget (label_bg_color, backgr_color, 10);
			attach_top_widget (label_bg_color, bg_color_stone, 10);
			attach_top_widget (backgr_color, label_pixmap, 10);
			attach_top_widget (label_pixmap, backgr_pixmap, 10);
			attach_top_widget (label_pixmap, bg_pixmap_stone, 10);
			attach_top_widget (backgr_pixmap, pixmap_open_b, 5);
			attach_top_widget (pixmap_open_b, color_set, 25);
			attach_bottom (color_set, 2);
			attach_left (color_set, 2);
			attach_right (color_set, 2);
			pixmap_open_b.add_activate_action (Current, Nothing);
			show_current
		end;

feature {NONE}

	backgr_color: EB_BG_COLOR_TF;

	backgr_pixmap: EB_TEXT_FIELD;

	fgr_color: EB_FG_COLOR_TF;

	pixmap_selection_box: PIXMAP_FILE_BOX;

	form_number: INTEGER is
		do
			Result := Context_const.color_form_nbr
		end;

	Fg_color_cmd: FG_COLOR_CMD is
		once
			!!Result
		end;

	Bg_color_cmd: BG_COLOR_CMD is
		once
			!!Result
		end;

	Bg_pixmap_cmd: BG_PIXMAP_CMD is
		once
			!!Result
		end;

	execute (argument: ANY) is
		do
			if (pixmap_selection_box = Void) then
				!!pixmap_selection_box.make 
					(backgr_pixmap, Current, Bg_pixmap_cmd, editor);
			end;
			pixmap_selection_box.popup
		end;

feature {NONE}

	reset is
		do
			if not (context.bg_pixmap_name = Void) then
				backgr_pixmap.set_text (context.bg_pixmap_name)
			else
				backgr_pixmap.set_text ("")
			end;
			if not (context.bg_color_name = Void) then
				backgr_color.set_text (context.bg_color_name)
			else
				backgr_color.set_text ("")
			end;
			if not (context.fg_color_name = Void) then
				fgr_color.set_text (context.fg_color_name)
			else
				fgr_color.set_text ("")
			end;
		end;

	apply is
		do
			if (not equal (backgr_pixmap.text, context.bg_pixmap_name) and
				then not backgr_pixmap.text.empty) 
			then
				context.set_bg_pixmap_name (backgr_pixmap.text);
			end;
			if (not equal (backgr_color.text, context.bg_color_name) and 
				then not backgr_color.text.empty) 
			then
				context.set_bg_color_name (backgr_color.text);
			end;
			if (not equal (fgr_color.text, context.fg_color_name) and then
				not fgr_color.text.empty) 
			then
				context.set_fg_color_name (fgr_color.text);
			end;
		end;

end
