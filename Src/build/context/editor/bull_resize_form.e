
class BULL_RESIZE_FORM 

inherit

	EDITOR_FORM

creation

	make
	
feature -- Interface

	make_visible (a_parent: COMPOSITE) is
		do
			initialize (Widget_names.bulletin_form_name, a_parent);

			!! follow_x.make (Widget_names.follow_x_name, Current, 
						Resize_policy_cmd, editor);
			!! follow_y.make (Widget_names.follow_y_name, Current, 
						Resize_policy_cmd, editor);
			!! width_resizeable.make (Widget_names.width_resizable_name,
						Current, Resize_policy_cmd, editor);
			!! height_resizeable.make (Widget_names.height_resizable_name,
						Current, Resize_policy_cmd, editor);
	
			attach_left (follow_x, 10);
			attach_left (follow_y, 10);
			attach_left (width_resizeable, 10);
			attach_left (height_resizeable, 10);

			attach_top (follow_x, 10);
			attach_top_widget (follow_x, follow_y, 10);
			attach_top_widget (follow_y, width_resizeable, 10);
			attach_top_widget (width_resizeable, height_resizeable, 10);
			show_current
		end;
	
feature {NONE}

	form_number: INTEGER is
		do
			Result := Context_const.bulletin_resize_form_nbr
		end;

	format_number: INTEGER is
		do
			Result := Context_const.resize_format_nbr
		end;

	follow_x, follow_y, width_resizeable, height_resizeable: EB_TOGGLE_B;

	Resize_policy_cmd: RESIZE_CMD is
		once
			!! Result
		end;

	resize_policy: RESIZE_POLICY;

	reset is
			-- reset the content of the form
		do
			resize_policy := context.resize_policy;
			follow_x.set_state (resize_policy.to_follow_x);
			follow_y.set_state (resize_policy.to_follow_y);
			if context.is_group_composite then
				width_resizeable.unmanage;
				height_resizeable.unmanage;
			elseif height_resizeable.managed then
				width_resizeable.manage;
				height_resizeable.manage;
			end;
			width_resizeable.set_state (resize_policy.is_width_resizeable);
			height_resizeable.set_state (resize_policy.is_height_resizeable);
		end;
 
	apply is
			-- update the context according to the content of the form
		do
			if follow_x.state /= resize_policy.to_follow_x then
				resize_policy.follow_x (follow_x.state)
			end;
			if follow_y.state /= resize_policy.to_follow_y then
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
