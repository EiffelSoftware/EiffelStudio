
class TRANSL_EDITOR 

inherit

	CONSTANTS;
	COMMAND;
	WINDOWS;
	FORM_D
		rename
			make as form_d_create,
			popup as form_popup
		end;
	FORM_D
		rename
			make as form_d_create
		redefine
			popup
		select
			popup
		end;
	CLOSEABLE

creation

	make
	
feature {NONE, EAR_BUTTON}

	transl_hole: TRANSL_HOLE;
	--transl_stone: TRANSL_EDIT_STONE;
	quit_button: CLOSE_WINDOW_BUTTON;
	ear_icon: EAR_BUTTON;
	negate_t: TOGGLE_B;
	sep1, sep2: SEPARATOR;
	trans_text: TEXT_FIELD;
	save_b: PUSH_B;

	close is
		do
			reset;
			popdown
		end;

feature 

	update_translation is
		do
			if edited_translation /= Void then
				transl_hole.update_name;
				trans_text.set_text (edited_translation.text)
			end
		end;

	make (a_parent: COMPOSITE) is
		do
			form_d_create (Widget_names.translation_editor, a_parent);
			!!transl_hole.make (Current);
			--!!transl_stone.make;
			--transl_stone.make_visible (Current);
			--!! quit_button.make_visible (Current, Current, );
			!!ear_icon.make (Current, Current);
			!!negate_t.make (Widget_names.negate_name, Current);
			!!sep1.make (Widget_names.separator, Current);
			!!sep2.make (Widget_names.separator1, Current);
			!!trans_text.make (Widget_names.textField, Current);
			!!save_b.make (Widget_names.save_name, Current);

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

			trans_text.add_activate_action (Current, trans_text);
			transl_hole.add_activate_action (Current, transl_hole);
			negate_t.add_activate_action (Current, negate_t);
			save_b.add_activate_action (Current, save_b);
			trans_text.set_text ("");
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
			if (argument = transl_hole) then
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

end
