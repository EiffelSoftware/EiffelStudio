
class COLOR_FORM 

inherit

	COMMAND
		export
			{NONE} all
		end;
	CONTEXT_CMDS
		export
			{NONE} all
		end;
	EDITOR_FORM
		redefine
			form_name
		end

creation

	make

feature 

	form_name: STRING is
			-- Name of the form in the menu
		do
			Result := C_olor_form_name;
		end;
	
feature {NONE}

	backgr_color: EB_BG_COLOR_TF;

	backgr_pixmap: EB_TEXT_FIELD;

	foreground_color: EB_FG_COLOR_TF;

	pixmap_selection_box: PIXMAP_FILE_BOX;

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, color_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
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
			initialize (C_olor_form_name, a_parent);

			!!label_fg_color.make (F_oreground_color, Current);
			!!foreground_color.make (T_extfield, Current, fg_color_cmd, a_parent);
			!!label_bg_color.make (B_ackground_color, Current);
			!!label_colors.make (C_olors, Current);
			!!backgr_color.make (T_extfield, Current, bg_color_cmd, a_parent);
			!!label_pixmap.make (B_ackground_pixmap, Current);
			!!backgr_pixmap.make (T_extfield, Current, bg_pixmap_cmd, a_parent);
			!!pixmap_open_b.make (P_Cbutton, Current);
			!!color_set.make ("COLOR_SET", Current);

			!!bg_color_stone;
			!!fg_color_stone;
			!!colors_stone;
			!!bg_pixmap_stone;
			bg_color_stone.make (Current, a_parent);
			fg_color_stone.make (Current, a_parent);
			colors_stone.make (Current, a_parent);
			bg_pixmap_stone.make (Current, a_parent);

			attach_left (colors_stone, 10);
			attach_left (bg_color_stone, 10);
			attach_left (fg_color_stone, 10);
			attach_left (bg_pixmap_stone, 10);
			attach_left (label_fg_color, 10);
			attach_left (label_bg_color, 10);
			attach_left (label_pixmap, 10);

			attach_left_widget (fg_color_stone, foreground_color, 5);
			attach_left_widget (bg_color_stone, backgr_color, 5);
			attach_left_widget (bg_pixmap_stone, backgr_pixmap, 5);
			attach_left_widget (colors_stone, label_colors, 5);

			attach_top (label_fg_color, 10);
			attach_top_widget (label_fg_color, foreground_color, 10);
			attach_top_widget (label_fg_color, fg_color_stone, 10);
			attach_top_widget (foreground_color, colors_stone, 10);
			attach_top_widget (foreground_color, label_colors, 10);
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
			pixmap_open_b.set_text ("open pixmap");
		end;

	
feature {NONE}

	execute (argument: ANY) is
		do
			if (pixmap_selection_box = Void) then
				!!pixmap_selection_box.make 
					(backgr_pixmap, Current, bg_pixmap_cmd, editor);
			end;
			pixmap_selection_box.popup
		end;

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
				foreground_color.set_text (context.fg_color_name)
			else
				foreground_color.set_text ("")
			end;
		end;

	
feature 

	apply is
		do
			if (not equal (backgr_pixmap.text, context.bg_pixmap_name)) then
				context.set_bg_pixmap_name (backgr_pixmap.text);
			end;
			if (not equal (backgr_color.text, context.bg_color_name)) then
				context.set_bg_color_name (backgr_color.text);
			end;
			if (not equal (foreground_color.text, context.fg_color_name)) then
				context.set_fg_color_name (foreground_color.text);
			end;
		end;

end
