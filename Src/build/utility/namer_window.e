class NAMER_WINDOW

inherit

	TOP_SHELL
		rename
			make as shell_make
		end
	COMMAND;
	CLOSEABLE;
	CONSTANTS;

creation
	make

feature
	
	namable: NAMABLE

	focus_label: FOCUS_LABEL

feature {NONE}

	text: TEXT

	make (a_screen: SCREEN) is
		local
			form: FORM;
			close_b: CLOSE_WINDOW_BUTTON;
			del_com: DELETE_WINDOW;
			ok_b: OK_BUTTON;
			namer_hole: NAMER_WIN_EDIT_HOLE
		do
			-- make the form
			shell_make (Widget_names.namer_window, a_screen)
			!! form.make (Widget_names.form, Current);
			!! focus_label.make (form);
			!! close_b.make (Current, form, focus_label);
			!! namer_hole.make (Current, form);
			!! ok_b.make (Current, form);
			!! text.make (Widget_names.textfield, form)

			form.attach_top (namer_hole, 0)
			form.attach_top (ok_b, 0)
			form.attach_top (focus_label, 0)
			form.attach_left (namer_hole, 0)
			form.attach_right_widget (ok_b, focus_label, 0)
			form.attach_left_widget (namer_hole, focus_label, 0)
			form.attach_right_widget (close_b, ok_b, 0)
			form.attach_right (close_b, 0);
			form.attach_left(text, 2)
			form.attach_right(text, 2)
			form.attach_top_widget (focus_label, text, 0)
			form.attach_top_widget (namer_hole, text, 0)
			form.attach_top_widget (ok_b, text, 2)
			form.attach_top_widget (close_b, text, 2)
			form.attach_bottom (text, 2)

			-- add callbacks and modal behaviour
			text.add_activate_action (Current, Current);
			text.set_single_line_mode;
			!! del_com.make (Current);
			set_delete_command (del_com);
			set_action ("<Map>,<Prop>", Current, Void);
		end 

feature

	set_namable (nam: like namable) is
		require
			valid_nam: nam /= Void
		do
			namable := nam;
			update_name;
		end;

	popup_with (nam: like namable) is
		require
			valid_nam: nam /= Void
		do
			set_namable (nam);
			set_x_y (screen.x, screen.y);
			if realized then
				raise
			else
				realize;
			end;
		end;

	popdown is
		do
			namable := Void;
			text.clear;
			set_title (Widget_names.translation_editor);
			set_icon_name (Widget_names.translation_editor);
			unrealize
		end;

	close is
			-- close the popup
		do
			popdown
		end

	set_name is
			-- set the name to text value
		local
			namer_cmd: NAMER_CMD
		do
			!! namer_cmd;
			namer_cmd.execute (Current);
			namable.set_visual_name(text.text)
		end;

	update_name is
		local
			tmp: STRING;
		do
			!! tmp.make (0);
			tmp.append (Widget_names.visual_name_label);
			tmp.append (namable.label);
			if namable.visual_name = Void then
				text.clear;
			else
				text.set_text (namable.visual_name);
			end;
			set_title (tmp)
			set_icon_name (tmp)
		end;

feature {NONE} -- Command Actions

	execute (arg: ANY) is
		do
			if arg = Void then
				if text.text.count > 0 then
					text.set_selection (0, text.text.count)
				end
			elseif not text.text.empty and then
				not equal (text.text, namable.visual_name)
			then
				set_name;
				popdown
			end
		end

end 
