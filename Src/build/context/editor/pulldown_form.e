
class PULLDOWN_FORM 

inherit

	MENU_FORM
		rename
			apply as old_apply,
			reset as old_reset
		redefine
			make, context, make_visible
		end;

	MENU_FORM
		redefine
			apply, reset, make, context,
			make_visible
		select
			apply, reset
		end


creation

	make

	
feature {NONE}

	text: EB_TEXT_FIELD;

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, pulldown_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			label_text: LABEL_G;
			label: LABEL_G;
		do
			initialize (Pulldown_form_name, a_parent);

			!!label_text.make (B_utton_text, Current);
			!!label.make (T_itle, Current);
			!!text.make (T_extfield, Current, pulldown_cmd, a_parent);
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
			detach_top (add_submenu);
		end;

	
feature {NONE}

	context: PULLDOWN_C;

	reset is
		do
			old_reset;
			if not (context.text = Void) then
				text.set_text (context.text)
			else
				text.set_text ("")
			end;
		end;

	
feature 

	apply is
		do
			old_apply;
			if not text.text.is_equal (context.text) then
				context.set_text (text.text);
			end;
		end;

end
