
class BULL_RESIZE_FORM 

inherit

	CONTEXT_CMDS
		export
			{NONE} all
		end;
	EDITOR_FORM
		redefine
			form_name
		end


creation

	make

	
feature 

	form_name: STRING is
		do
			Result := "Resizing policy"
		end;

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, bulletin_resize_form_number);
		end;

	
feature {NONE}

	follow_x, follow_y, width_resizeable, height_resizeable: EB_TOGGLE_B;

	resize_policy_cmd: RESIZE_CMD is
		once
			!!Result
		end;

	
feature 

	make_visible (a_parent: CONTEXT_EDITOR) is
		do
			initialize ("Bulletin Form", a_parent);

			!!follow_x.make ("Follow x", Current, resize_policy_cmd, a_parent);
			!!follow_y.make ("Follow y", Current, resize_policy_cmd, a_parent);
			!!width_resizeable.make ("width_resizeable", Current, resize_policy_cmd, a_parent);
			!!height_resizeable.make ("height_resizeable", Current, resize_policy_cmd, a_parent);
	
			attach_left (follow_x, 10);
			attach_left (follow_y, 10);
			attach_left (width_resizeable, 10);
			attach_left (height_resizeable, 10);

			attach_top (follow_x, 10);
			attach_top_widget (follow_x, follow_y, 10);
			attach_top_widget (follow_y, width_resizeable, 10);
			attach_top_widget (width_resizeable, height_resizeable, 10);
		end;

	
feature {NONE}

	resize_policy: RESIZE_POLICY;

	reset is
			-- reset the content of the form
		do
			resize_policy := context.resize_policy;
			follow_x.set_state (not resize_policy.x_fixed);
			follow_y.set_state (not resize_policy.y_fixed);
			width_resizeable.set_state (resize_policy.is_width_resizeable);
			height_resizeable.set_state (resize_policy.is_height_resizeable);
		end;
 
	
feature 

	apply is
			-- update the context according to the content of the form
		do
			if follow_x.state = resize_policy.x_fixed then
				resize_policy.follow_x (follow_x.state)
			end;
			if follow_y.state = resize_policy.y_fixed then
				resize_policy.follow_y (follow_y.state)
			end;
			if width_resizeable.state /= resize_policy.is_width_resizeable then
				resize_policy.width_resizeable (width_resizeable.state)
			end;
			if height_resizeable.state /= resize_policy.is_height_resizeable then
				resize_policy.height_resizeable (height_resizeable.state)
			end;
		end;

end
