

class S_LABEL_TEXT

inherit

	S_CONTEXT
		redefine
			set_context_attributes
		end

feature 

	make (n: LABEL_TEXT_C) is
		do
			save_attributes (n);
			if node.text_modified then
				text := node.text;
			end;
			left_alignment := node.left_alignment;
			left_alignment_modified := node.left_alignment_modified;
			resize_policy_disabled := node.resize_policy_disabled;
			resize_policy_disabled_modified := node.resize_policy_disabled_modified;
		end;

	set_context_attributes (a_context: LABEL_TEXT_C) is
		do
			if not (text = Void) then
				a_context.set_text (text)
			end;
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

	left_alignment: BOOLEAN;

	left_alignment_modified: BOOLEAN;

	resize_policy_disabled: BOOLEAN;

	resize_policy_disabled_modified: BOOLEAN;

end

