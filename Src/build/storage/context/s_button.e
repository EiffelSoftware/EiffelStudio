

deferred class S_BUTTON 

inherit

	S_CONTEXT
		redefine
			set_context_attributes
		end



	
feature {NONE}

	create_node (node: BUTTON_C) is
		do
			save_attributes (node);
			if node.text_modified then
				text := node.text;
			end;
			resize_policy_disabled := node.resize_policy_disabled;
			resize_policy_disabled_modified := node.resize_policy_disabled_modified;
		 end;

	
feature 

	set_context_attributes (a_context: BUTTON_C) is
		do
			if not (text = Void) then
				a_context.set_text (text)
			end;
			if resize_policy_disabled_modified then
				a_context.disable_resize_policy (resize_policy_disabled);
			end;
			set_attributes (a_context);
		end;

	
feature {NONE}

	text: STRING;

	resize_policy_disabled: BOOLEAN;

	resize_policy_disabled_modified: BOOLEAN;

end

