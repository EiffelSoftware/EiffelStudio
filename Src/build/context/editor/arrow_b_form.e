
class ARROW_B_FORM 

inherit

	EDITOR_FORM
		redefine
			context
		end;

creation

	make
	
feature -- Interface

	make_visible (a_parent: COMPOSITE) is
		local
			radio_b: RADIO_BOX
		do
			initialize (Widget_names.arrow_b_form_name, a_parent);

			!!radio_b.make (Widget_names.row_column, Current);
			!!arrow_up.make (Widget_names.up_arrow_name, 
					radio_b, Arrow_b_cmd, editor);
			!!arrow_down.make (Widget_names.down_arrow_name, 
					radio_b, Arrow_b_cmd, editor);
			!!arrow_left.make (Widget_names.left_arrow_name, 
					radio_b, Arrow_b_cmd, editor);
			!!arrow_right.make (Widget_names.right_arrow_name, 
					radio_b, Arrow_b_cmd, editor);

			attach_left (radio_b, 10);
			attach_top (radio_b, 10);
			attach_bottom (radio_b, 50);
			show_current
		end;

feature {NONE}

	context: ARROW_B_C is
		do
			Result ?= editor.edited_context
		end;

	reset is
		local
			dir:INTEGER
		do
			dir := context.direction;
			if dir = Context_const.up_arrow_direction then
				arrow_up.arm
			elseif dir = Context_const.down_arrow_direction then
				arrow_down.arm
			elseif dir = Context_const.left_arrow_direction then
				arrow_left.arm
			else
				arrow_right.arm
			end;
		end;

	apply is
		do
			context.set_direction (new_direction)
		end;
	
	new_direction: INTEGER is
		do
			if arrow_up.state then
				Result := Context_const.up_arrow_direction
			elseif arrow_down.state then
				Result := Context_const.down_arrow_direction
			elseif arrow_left.state then
				Result := Context_const.left_arrow_direction
			else
				Result := Context_const.right_arrow_direction
			end;
		end;
			
feature {NONE} 

	arrow_up, arrow_down: EB_TOGGLE_B;

	arrow_left,arrow_right: EB_TOGGLE_B;

	form_number: INTEGER is
		do
			Result := Context_const.arrow_b_att_form_nbr
		end;

	Arrow_b_cmd: ARROW_B_CMD is
		once
			!! Result
		end;

end
