class LABEL_TEXT_FORM 

inherit

	EDITOR_FORM
		redefine
			context
		end;

creation
	
	make

feature {NONE} -- Interface

	text: EB_TEXT_FIELD;

	forbid_recomp: EB_TOGGLE_B;

	center_alignment, left_alignment: EB_TOGGLE_B;

	context: LABEL_TEXT_C is
		do
			Result ?= editor.edited_context
		end;

	form_number: INTEGER is
		do
			Result := Context_const.label_text_att_form_nbr
		end;

	Label_alignment_cmd: LABEL_ALIGNMENT_CMD is
		once
			!!Result
		end;

	Label_resize_cmd: LABEL_RESIZE_CMD is
		once
			!!Result
		end;

	Label_text_cmd: LABEL_TEXT_CMD is
		once
			!!Result
		end;

feature -- Interface

	make_visible (a_parent: COMPOSITE) is
		local
			label: LABEL_G;
			radio_box: RADIO_BOX
		do
			initialize (Context_const.label_text_form_name, a_parent);
			!!label.make (Context_const.text_label_name, Current);
			!!text.make (Widget_names.textfield, Current, Label_text_cmd, 
						editor);
			!!forbid_recomp.make (Context_const.forbid_recomp_size_name, 
						Current, Label_resize_cmd, editor);
			!!radio_box.make (Widget_names.radio_box, Current);
			!!left_alignment.make (Context_const.left_alignment_name, 
						radio_box, Label_alignment_cmd, editor);
			!!center_alignment.make (Context_const.center_alignment_name, 
						radio_box, Label_alignment_cmd, editor);
			left_alignment.arm;
			radio_box.set_always_one (True);

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
			show_current
		end;

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
