
class TRANSL_EDITOR 

inherit

	COMMAND
		redefine
			context_data_useful
		end;
	PIXMAPS;
	WINDOWS;
	FORM_D
		rename
			make as form_d_create,
			popup as form_popup
		undefine
			init_toolkit
		end;
	FORM_D
		rename
			make as form_d_create
		undefine
			init_toolkit
		redefine
			popup
		select
			popup
		end;
	WIDGET_NAMES

creation

	make
	
feature {NONE}

	transl_hole: TRANSL_HOLE;
	--transl_stone: TRANSL_EDIT_STONE;
	quit_button: EB_PICT_B;
	ear_icon: EB_PICT_B;
	negate_t: TOGGLE_B;
	sep1, sep2: SEPARATOR;
	trans_text: TEXT_FIELD;
	save_b: PUSH_B;

	context_data_useful: BOOLEAN is True;

feature 

	update_translation is
		do
			if edited_translation /= Void then
				transl_hole.update_name;
				trans_text.set_text (edited_translation.text)
			end
		end;

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			form_d_create (a_name, a_parent);
			!!transl_hole.make (Current);
			--!!transl_stone.make;
			--transl_stone.make_visible (Current);
			!!quit_button.make_visible (Current);
			!!ear_icon.make_visible (Current);
			!!negate_t.make (T_oggle, Current);
			!!sep1.make (S_eparator, Current);
			!!sep2.make (S_eparator1, Current);
			!!trans_text.make (T_extField, Current);
			!!save_b.make (P_Cbutton, Current);

			attach_top (transl_hole, 5);
			--attach_top (transl_stone, 5);
			attach_top (quit_button, 5);
			attach_left (transl_hole, 5);
			attach_left (ear_icon, 10);
			--attach_left_widget (transl_hole, transl_stone, 5);
			attach_right (quit_button, 5);

			attach_left (sep1, 5);
			attach_right (sep1,5);
			attach_top (sep1, 55);
			attach_top_widget (sep1, ear_icon, 15);
			attach_top_widget (sep1, save_b, 15);
			attach_left_widget (ear_icon, save_b, 10);
			attach_top_widget (ear_icon, sep2, 15);
			attach_left (sep2, 5);
			attach_right (sep2, 5);
			attach_left (negate_t, 10);
			attach_top_widget (sep2, negate_t, 5);
			attach_top_widget (negate_t, trans_text, 5);
			attach_left (trans_text, 5);
			attach_right (trans_text, 5);
			attach_bottom (trans_text, 5);

			quit_button.set_symbol (Quit_pixmap);
			quit_button.add_activate_action (Current, quit_button);
			trans_text.add_activate_action (Current, trans_text);
			transl_hole.add_activate_action (Current, transl_hole);
			negate_t.add_activate_action (Current, negate_t);
			ear_icon.add_key_press_action (Current, ear_icon);
			ear_icon.add_button_press_action (1, Current, ear_icon);
			ear_icon.add_button_press_action (2, Current, ear_icon);
			ear_icon.add_button_press_action (3, Current, ear_icon);
			save_b.add_activate_action (Current, save_b);
			trans_text.set_text ("");
			save_b.set_text ("Save");
			ear_icon.set_symbol (Ear_pixmap);
			negate_t.set_text ("negate");
		end;

feature 

	popup is
		do
			form_popup;
			--transl_stone.hide				
		end;

	set_edited_translation (trans: TRANSLATION) is
		require
			not_void_trans: trans /= Void
		do
			edited_translation := trans;
			transl_hole.set_translation (edited_translation);
			edited_translation.set_editor (Current);
			trans_text.set_text (edited_translation.text);
		end;

	reset is
		do
			if edited_translation /= Void then
				edited_translation.reset;
				edited_translation := Void;
				trans_text.set_text ("");
				transl_hole.reset;
			end
		end;

feature {NONE}

	edited_translation: TRANSLATION;
	
	execute (argument: ANY) is
		local
			cmd: NAMER_CMD;
			transl_add: TRANSL_ADD;
			transl_set_text: TRANSL_SET_TEXT;
		do
			if (argument = quit_button) then
				reset;
				popdown
			elseif (argument = transl_hole) then
				!!transl_add;
				!!edited_translation.make;
				edited_translation.generate_internal_name;
				set_edited_translation (edited_translation);
				transl_add.execute (edited_translation);
			elseif (edited_translation /= Void) then 
				if ((argument = trans_text) 
					or (argument = save_b)) and then
					((not trans_text.text.empty) and then
					(not equal (trans_text.text, edited_translation.text))) then
					!!transl_set_text;
					transl_set_text.set_text (trans_text.text);
					transl_set_text.execute (edited_translation);
				elseif (argument = ear_icon) then
					listen
				elseif (argument = negate_t) then
					if negate_t.state then
						if trans_text.text.empty then
							trans_text.append ("~")	
						else
							if ('~' /= trans_text.text.item (1)) then
								trans_text.insert ("~", 0);
							end
						end
					else
						if (trans_text.text.item (1).is_equal ('~'))  then
							trans_text.replace (0, 1, "");
						end
					end
				end;
			end;
		end;

	listen is
			-- Determine the translation defined by the user
			-- by "listening" to the keypress.
		local
			cd: KYPRESS_DATA;
			bd: BTPRESS_DATA;
			temp: STRING;
			kb: KEYBOARD;
			bb: BUTTONS;
			ctrl_str: CONTROL_STR;
		do
			cd ?= context_data;
			bd ?= context_data;
			!!temp.make (0);
			if cd /= Void then
				kb := cd.keyboard;
				if kb.control_pressed then
					if cd.string /= Void then
						!!ctrl_str.make (cd.string.item_code (1));
						if (kb.lock_pressed and
						  not kb.shift_pressed) or 
						  (kb.shift_pressed and
						  not kb.lock_pressed) then
							ctrl_str.set_lock (True);
						end;
						temp.append (ctrl_str.cntrl_str);
					end;
				elseif kb.modifiers.item (1) then
					if cd.string /= Void then
						temp.append ("<Alt>");
						temp.append ("<Key>");
						temp.append (cd.string);
					end;
				elseif kb.shift_pressed then
					if cd.string /= Void then
						temp.append ("<Key>");
						temp.append (cd.string);
					else
						temp.append ("<Shift>");
					end;
				elseif kb.lock_pressed then
					if cd.string /= Void and cd.string.item_code (1) <= 31 then
						!!ctrl_str.make (cd.string.item_code (1));
						ctrl_str.set_lock (True);
						temp.append (ctrl_str.cntrl_str);
					elseif cd.string /= Void then
						temp.append ("<Key>");
						temp.append (cd.string);
					end;
				elseif cd.string /= Void then
					temp.append ("<Key>");
					temp.append (cd.string);
				end;
			elseif bd /= Void then
				kb := bd.keyboard;
				temp.append (process_modifier (kb));
				if bd.button = 1 then
					temp.append ("<Btn1Down>");
				elseif bd.button = 2 then
					temp.append ("<Btn2Down>");
				elseif bd.button = 3 then
					temp.append ("<Btn3Down>");
				elseif bd.button = 4 then
					temp.append ("<Btn4Down>");
				elseif bd.button = 5 then
					temp.append ("<Btn5Down>");
				end;
				
			end;
			if not temp.empty then
				trans_text.clear; 
				trans_text.set_text (temp);
			end;
		end;

	process_modifier (kb: KEYBOARD): STRING is
		do
			if kb.control_pressed then
				if kb.shift_pressed then
					Result := "<Ctrl><Shift>";
				else
					Result := "<Ctrl>";
				end;
			elseif kb.shift_pressed then
				Result := "<Shift>";
			else
				Result := "";
			end;
		end;

end
