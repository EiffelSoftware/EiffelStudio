
class TRANSL_EDITOR 

inherit

	COMMAND;
	WINDOWS
		select
			init_toolkit
		end
	EB_TOP_SHELL
		rename
			make as shell_make
		redefine
			set_geometry
		end;
	CLOSEABLE

creation

	make
	
feature -- Geometry

	set_geometry is
		do
			set_width (Resources.trans_ed_width)
		end;

feature {NONE, EAR_BUTTON}

	trans_text: TEXT_FIELD;
	save_b: PUSH_B;
	negate_t: TOGGLE_B;
	only_t: TOGGLE_B;

	close is
		do
			clear;
			popdown
		end;

feature 

	update_translation is
		do
			if edited_translation /= Void then
				trans_text.set_text (edited_translation.text)
			end
		end;


feature {NONE}

	transl_hole: TRANSL_HOLE;

	make is
		local
			close_button: CLOSE_WINDOW_BUTTON;
			del_com: DELETE_WINDOW;
			ear_icon: EAR_BUTTON;
			sep1: SEPARATOR;
			form: FORM
		do
			shell_make (Widget_names.translation_editor, Eb_screen);
			if Pixmaps.translation_pixmap.is_valid then
				set_icon_pixmap (Pixmaps.translation_pixmap)
			end;
			reset_title;
			!! form.make (Widget_names.form, Current);
			!! close_button.make (Current, form);
			!! transl_hole.make (Current, form);
			!! ear_icon.make (Current, form);
			!! negate_t.make (Widget_names.negate_name, form);
			!! only_t.make (Widget_names.only_name, form);
			!! sep1.make (Widget_names.separator, form);
			!! trans_text.make (Widget_names.textField, form);
			!! save_b.make (Widget_names.save_name, form);

			form.attach_top (transl_hole, 0);
			form.attach_top (close_button, 0);
			form.attach_left (transl_hole, 0);
			form.attach_left (ear_icon, 10);
			form.attach_right (close_button, 0);
			form.attach_top_widget (transl_hole, sep1, 2);
			form.attach_top_widget (close_button, sep1, 2);

			form.attach_left (sep1, 5);
			form.attach_right (sep1,5);
			form.attach_top_widget (sep1, ear_icon, 5);
			form.attach_top_widget (sep1, save_b, 5);
			form.attach_left_widget (ear_icon, save_b, 10);
			form.attach_left (negate_t, 10);
			form.attach_left_widget (negate_t, only_t, 5);
			form.attach_top_widget (ear_icon, negate_t, 5);
			form.attach_top_widget (ear_icon, only_t, 5);
			form.attach_top_widget (negate_t, trans_text, 5);
			form.attach_top_widget (only_t, trans_text, 5);
			form.attach_left (trans_text, 5);
			form.attach_right (trans_text, 5);
			form.attach_bottom (trans_text, 5);

			trans_text.add_activate_action (Current, trans_text);
			transl_hole.add_activate_action (Current, transl_hole);
			negate_t.add_activate_action (Current, negate_t);
			only_t.add_activate_action (Current, only_t);
			save_b.add_activate_action (Current, save_b);
			trans_text.set_text ("");
			!! del_com.make (Current);
			set_delete_command (del_com);
			initialize_window_attributes
		end;

feature 

	popdown is
		do
			unrealize
		end;

	popup is
		do
			set_x_y (screen.x + 5, screen.y);
			if realized then
				raise
			else
				realize
			end
		end;

	set_edited_translation (trans: TRANSLATION) is
		require
			not_void_trans: trans /= Void
		do
			transl_hole.set_full_symbol;
			edited_translation := trans;
			edited_translation.set_editor (Current);
			trans_text.set_text (edited_translation.text);
			update_title
		end;

	reset_title is
		do
			set_title (Widget_names.translation_editor);
			set_icon_name (Widget_names.translation_editor);
		end;

	update_title is
		local
			tmp: STRING
		do
			!! tmp.make (0);
			tmp.append (Widget_names.translation_name);
			tmp.append (": ");
			tmp.append (edited_translation.label);
			set_title (tmp);	
			set_icon_name (tmp);	
		end;

	clear is
		do
			transl_hole.set_empty_symbol;
			if edited_translation /= Void then
				reset_title;
				edited_translation.reset;
				edited_translation := Void;
				trans_text.set_text ("");
			end
		end;

	edited_translation: TRANSLATION;
	
feature {NONE}

	execute (argument: ANY) is
		local
			transl_set_text: TRANSL_SET_TEXT;
		do
			if (edited_translation /= Void) then 
				if ((argument = trans_text) 
					or (argument = save_b)) and then
					((not trans_text.text.empty) and then
					(not equal (trans_text.text, edited_translation.text))) then
					update_title;
					!!transl_set_text.make (trans_text.text, edited_translation)
				elseif (argument = negate_t) then
					replace_trans_text (negate_t.state, "~")
				elseif (argument = only_t) then
					replace_trans_text (only_t.state, "!")
				end;
			end;
		end;

	replace_trans_text (state: BOOLEAN; s: STRING) is
		require
			valid_s: s /= Void;
			valid_s_count: s.count = 1
		do
			if state then
				if trans_text.text.empty then
					trans_text.text.append (s)	
				else
					if (s.item (1) /= trans_text.text.item (1)) and then
						(trans_text.text.count = 1 or else
							s.item (1) /= trans_text.text.item (2))
					then
						trans_text.insert (s, 0);
						update_title
					end
				end
			elseif trans_text.text.count > 0 then
				if (trans_text.text.item (1) = s.item (1))  then
					trans_text.replace (0, 1, "");
					update_title
				elseif (trans_text.text.item (2) = s.item (1)) then
					trans_text.replace (0, 2, "");
					update_title
				end
			end
		end;

end
