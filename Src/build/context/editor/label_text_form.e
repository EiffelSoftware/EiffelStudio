class LABEL_TEXT_FORM 

inherit

	CONTEXT_CMDS;
	EDITOR_FORM
		redefine
			context
		end;

creation
	
	make

feature

	text: EB_TEXT_FIELD;

	forbid_recomp: EB_TOGGLE_B;

	center_alignment, left_alignment: EB_TOGGLE_B;

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, label_text_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			label: LABEL_G;
			radio_box: RADIO_BOX
		do
			initialize (Label_text_form_name, a_parent);
			!!label.make (T_ext_label, Current);
			!!text.make (T_extfield, Current, label_text_cmd, a_parent);
			!!forbid_recomp.make (F_orbid_recomp_size, Current, label_resize_cmd, a_parent);
			!!radio_box.make (R_adio_box, Current);
			!!left_alignment.make (L_eft_alignment, radio_box, label_alignment_cmd, a_parent);
			!!center_alignment.make (C_enter_alignment, radio_box, label_alignment_cmd, a_parent);

			attach_left (label, 10);
			attach_right (text, 10);
			attach_left (text, 100);

			attach_left (forbid_recomp, 10);
			attach_left (radio_box, 10);

			attach_top (text, 10);
			attach_top (label, 10);
			attach_top_widget (text, forbid_recomp, 10);
			attach_top_widget (forbid_recomp, radio_box, 10);
			detach_bottom (radio_box);
		end;

	context: LABEL_TEXT_C;

	reset is
		do
			text.set_text (context.text);
			forbid_recomp.set_state (context.resize_policy_disabled);
			left_alignment.set_state (context.left_alignment);
			center_alignment.set_state (not context.left_alignment);
		end;

	apply is
		do
			if context.resize_policy_disabled /= forbid_recomp.state then
				context.disable_resize_policy (forbid_recomp.state);
			end;
			if context.left_alignment /= left_alignment.state then
				context.set_left_alignment (left_alignment.state);
			end;
			if context.text = Void 
				or else not equal (text.text, context.text) then
				context.set_text (text.text);
			end;
		end;

end
