
class PULLDOWN_FORM 

inherit

	MENU_FORM
		rename
			apply as old_apply,
			reset as old_reset
		redefine
			context, make_visible,
			form_number
		end;
	MENU_FORM
		redefine
			apply, reset, context, 
			make_visible, form_number
		select
			apply, reset
		end

creation

	make
	
feature {NONE}

	text: EB_TEXT_FIELD;

	forbid_recomp: EB_TOGGLE_B;

	context: PULLDOWN_C is
		do
			Result ?= editor.edited_context
		end;

	form_number: INTEGER is
		do
			Result := Context_const.pulldown_sm_form_nbr
		end;

	pulldown_cmd: PULLDOWN_CMD is
		once
			!!Result
		end;

	pulldown_resize_cmd: PULLDOWN_RESIZE_CMD is
		once
			!!Result;
		end;

feature

	make_visible (a_parent: COMPOSITE) is
		local
			label_text: LABEL;
			label: LABEL;
		do
			initialize (Widget_names.pulldown_form_name, a_parent);

			!!label_text.make (Widget_names.button_text_name, Current);
			!!label.make (Widget_names.title_name, Current);
			!!text.make (Widget_names.textfield, Current, 
					Pulldown_cmd, editor);
			!!forbid_recomp.make (Widget_names.forbid_auto_recomp_size_name, 
					Current, Pulldown_resize_cmd, editor);
			create_buttons;

			attach_left (label_text, 10);
			attach_left (text, 100);
			attach_right (text, 10);

			attach_left (label, 10);

			attach_top (text, 10);
			attach_top (label_text, 15);
			attach_top_widget (text, title, 10);
			attach_top_widget (text, label, 15);
			attach_top_widget (title, add_button, 10);
			attach_top_widget (add_button, add_submenu, 10);
			attach_top_widget (add_submenu, forbid_recomp, 10);
			-- **** detach_top (forbid_recomp);
			show_current
		end;

feature {NONE}

	reset is
		do
			old_reset;
			if not (context.text = Void) then
				text.set_text (context.text)
			else
				text.set_text ("")
			end;
			forbid_recomp.set_state (context.resize_policy_disabled);
		end;

	
feature 

	apply is
		do
			old_apply;
			if not text.text.is_equal (context.text) then
				context.set_text (text.text);
			end;
			if forbid_recomp.state /= context.resize_policy_disabled then
				context.disable_resize_policy (forbid_recomp.state);
			end;

		end;

end
