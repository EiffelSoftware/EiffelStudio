

deferred class S_BUTTON_R1

inherit

	S_CONTEXT
		redefine
			set_context_attributes
		end
	
feature {NONE}

	create_node (node: BUTTON_C) is
		do
			save_attributes (node);
			left_alignment := node.left_alignment;
			left_alignment_modified := node.left_alignment_modified;
			if node.text_modified then
				text := node.text;
			end;
			resize_policy_disabled := node.resize_policy_disabled;
			resize_policy_disabled_modified := node.resize_policy_disabled_modified;
		 end;
	
feature 

	set_context_attributes (a_context: BUTTON_C) is
		do
			--if not (text = Void) then
				--a_context.set_text (text)
				-- taken care by visual name
			--end;
			if left_alignment_modified then
				a_context.set_left_alignment (left_alignment);
			end;
			if resize_policy_disabled_modified then
				a_context.disable_resize_policy (resize_policy_disabled);
			end;
			set_attributes (a_context);
		end;

	
feature {NONE}

	text: STRING;
		-- to be removed (visual name)

	resize_policy_disabled: BOOLEAN;

	resize_policy_disabled_modified: BOOLEAN;

	left_alignment_modified: BOOLEAN;

	left_alignment: BOOLEAN

end

