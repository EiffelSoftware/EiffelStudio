class EAR_BUTTON

inherit

	EB_BUTTON
	COMMAND
		redefine
			context_data_useful
		end

creation

	make

feature {NONE}

	editor: TRANSL_EDITOR

	context_data_useful: BOOLEAN is True;

	make (ed: like editor; a_parent: COMPOSITE) is
		do
			editor := ed;
			make_visible (a_parent);
			add_key_press_action (Current, Void);
			add_button_press_action (1, Current, Void);
			add_button_press_action (2, Current, Void);
			add_button_press_action (3, Current, Void);
		end
	
	create_focus_label is
		do
			set_focus_string (Focus_labels.listen_label)
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.ear_pixmap
		end;

	execute (arg: ANY) is
		do
			if editor.edited_translation /= Void then
				listen
			end
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
					if cd.string /= Void and then not cd.string.empty then
						!! ctrl_str.make (cd.string.item_code (1));
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
						temp.append ("Alt");
						temp.append ("<Key>");
						temp.append (cd.string);
					end;
				elseif kb.shift_pressed then
					if cd.string /= Void then
						temp.append ("<Key>");
						temp.append (cd.string);
					else
						temp.append ("Shift");
					end;
				elseif kb.lock_pressed then
					if cd.string /= Void and then
						not cd.string.empty and then 
						cd.string.item_code (1) <= 31 
					then
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
				editor.trans_text.clear
				editor.negate_t.set_toggle_off
				editor.only_t.set_toggle_off
				editor.trans_text.set_text (temp)
			end;
		end;

	process_modifier (kb: KEYBOARD): STRING is
		do
			if kb.control_pressed then
				if kb.shift_pressed then
					Result := "Ctrl Shift";
				else
					Result := "Ctrl";
				end;
			elseif kb.shift_pressed then
				Result := "Shift";
			else
				Result := "";
			end;
		end;

end
