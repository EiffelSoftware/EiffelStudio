indexing
	description: "Page representing the color properties."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class COLOR_FORM 

inherit

	COMMAND
	EDITOR_FORM

creation

	make

feature -- Interface

	make_visible (a_parent: COMPOSITE) is
		local
			pixmap_open_b: PUSH_B
			color_set: COLOR_SET
			label_bg_color: LABEL
			label_pixmap: LABEL
			label_fg_color: LABEL
			label_colors: LABEL
			colors_stone: COLORS_STONE
			bg_pixmap_stone: BG_PIXMAP_STONE
			separator: THREE_D_SEPARATOR
		do
			initialize (Widget_names.color_form_name, a_parent)
				--| Create widgets
			!! label_fg_color.make (Widget_names.foreground_color_name, 
						Current)
			!! fgr_color.make (Widget_names.textfield, Current, editor)
			!! label_bg_color.make (Widget_names.background_color_name, Current)
			!! label_colors.make (Widget_names.colors_name, Current)
			!! backgr_color.make (Widget_names.textfield, Current, editor)
			!! label_pixmap.make (Widget_names.background_pixmap_name, Current)
			!! backgr_pixmap.make (Widget_names.textfield, Current, 
					Bg_pixmap_cmd, editor)
			!! pixmap_open_b.make (Widget_names.open_pixmap_name, Current)
			!! color_set.make (Widget_names.color_form_name, Current, editor)

			!! colors_stone.make (Current, editor)
			!! bg_pixmap_stone.make (Current, editor)
			!! bg_color_stone.make (Current, backgr_color, editor)
			!! fg_color_stone.make (Current, fgr_color, editor)
			!! separator.make ("", Current)

				--| Perform attachments
			attach_left (colors_stone, 10)
			attach_left (bg_color_stone, 10)
			attach_left (fg_color_stone, 10)
			attach_left (bg_pixmap_stone, 10)
			attach_left (label_fg_color, 10)
			attach_left (label_bg_color, 10)
			attach_left (label_pixmap, 10)
			attach_left (pixmap_open_b, 10)
			attach_left (separator, 0)

			attach_left_widget (fg_color_stone, fgr_color, 5)
			attach_left_widget (bg_color_stone, backgr_color, 5)
			attach_left_widget (bg_pixmap_stone, backgr_pixmap, 5)
			attach_left_widget (colors_stone, label_colors, 5)

			attach_right (fgr_color, 5)
			attach_right (backgr_color, 5)
			attach_right (backgr_pixmap, 5)
			attach_right (label_colors, 5)
			attach_right (separator, 0)

			attach_top (label_fg_color, 10)
			attach_top_widget (label_fg_color, fgr_color, 10)
			attach_top_widget (label_fg_color, fg_color_stone, 10)
			attach_top_widget (fgr_color, colors_stone, 10)
			attach_top_widget (fgr_color, label_colors, 10)
			attach_top_widget (label_colors, label_bg_color, 15)
			attach_top_widget (label_bg_color, backgr_color, 10)
			attach_top_widget (label_bg_color, bg_color_stone, 10)
			attach_top_widget (backgr_color, label_pixmap, 10)
			attach_top_widget (label_pixmap, backgr_pixmap, 10)
			attach_top_widget (label_pixmap, bg_pixmap_stone, 10)
			attach_top_widget (backgr_pixmap, pixmap_open_b, 5)
			attach_top_widget (pixmap_open_b, separator, 2)
			attach_top_widget (separator, color_set, 2)
			attach_left (color_set, 5)
				-- !! FIXME !!: If attach_bottom is used, one of the
				-- children in this form disappear. It is the one 
				-- which is attached to the bottom if no `attach_bottom_widget'
				-- are used. If so, the one that disappears is the one on which
				-- are called both `attach_top_widget' and `attach_bottom_widget'.

				--| Set callbacks
			pixmap_open_b.add_activate_action (Current, Void)

			show_current
		end

	unregister_holes is
		do
			if is_initialized then
				bg_color_stone.unregister
				fg_color_stone.unregister
				backgr_color.unregister
				fgr_color.unregister
			end
		end

feature {NONE}

	backgr_color: EB_BG_COLOR_TF

	backgr_pixmap: EB_TEXT_FIELD

	bg_color_stone: BG_COLOR_STONE
	fg_color_stone: FG_COLOR_STONE

	fgr_color: EB_FG_COLOR_TF

	pixmap_selection_box: PIXMAP_FILE_BOX

	form_number: INTEGER is
		do
			Result := Context_const.color_form_nbr
		end

	format_number: INTEGER is
		do
			Result := Context_const.color_format_nbr
		end

	Bg_pixmap_cmd: BG_PIXMAP_CMD is
		once
			!! Result
		end

	execute (argument: ANY) is
		do
			if (pixmap_selection_box = Void) then
				!! pixmap_selection_box.make 
					(backgr_pixmap, Current, Bg_pixmap_cmd, editor)
			end
			pixmap_selection_box.popup
		end

feature {NONE}

	reset is
		do
			if context.bg_pixmap_name /= Void then
				backgr_pixmap.set_text (context.bg_pixmap_name)
			else
				backgr_pixmap.set_text ("")
			end
			if context.bg_color_name /= Void then
				backgr_color.set_text (context.bg_color_name)
			else
				backgr_color.set_text ("")
			end
			if context.fg_color_name /= Void then
				fgr_color.set_text (context.fg_color_name)
			else
				fgr_color.set_text ("")
			end
		end

	apply is
		do
			if not equal (backgr_pixmap.text, context.bg_pixmap_name) then
				context.set_bg_pixmap_name (backgr_pixmap.text)
			end
			if not equal (backgr_color.text, context.bg_color_name) then
				context.set_bg_color_name (backgr_color.text)
			end
			if not equal (fgr_color.text, context.fg_color_name) then
				context.set_fg_color_name (fgr_color.text)
			end
		end

end
