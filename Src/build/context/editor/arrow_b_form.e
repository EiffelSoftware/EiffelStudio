
class ARROW_B_FORM 

inherit

	CONTEXT_CMDS
		export
			{NONE} all
		end;
	EDITOR_FORM
		redefine
			context
		end;

	ARROW_B_CONST


creation

	make

	
feature {NONE}

	arrow_up, arrow_down: EB_TOGGLE_B;
	arrow_left,arrow_right: EB_TOGGLE_B;

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, arrow_b_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			radio_b: RADIO_BOX
		do
			initialize (Arrow_b_form_name, a_parent);

			!!radio_b.make (R_ow_column, Current);
			!!arrow_up.make (U_p_arrow, radio_b, arrow_b_cmd, a_parent);
			!!arrow_down.make (D_own_arrow, radio_b, arrow_b_cmd, a_parent);
			!!arrow_left.make (L_eft_arrow, radio_b, arrow_b_cmd, a_parent);
			!!arrow_right.make (R_ight_arrow, radio_b, arrow_b_cmd, a_parent);

			attach_left (radio_b, 10);
--			attach_right (radio_b, 10);

			attach_top (radio_b, 10);
			attach_bottom (radio_b, 50);
		end;

	
feature {NONE}

	context: ARROW_B_C;

	reset is
		do
			inspect
				context.direction
			when up then
				arrow_up.arm
			when down then
				arrow_down.arm
			when left then
				arrow_left.arm
			else
				arrow_right.arm
			end;
		end;

	
feature 

	apply is
		do
			context.set_direction (new_direction)
		end;

	
feature {NONE}

	new_direction: INTEGER is
		do
			if arrow_up.state then
				Result := context.up
			elseif arrow_down.state then
				Result := context.down
			elseif arrow_left.state then
				Result := context.left
			else
				Result := context.right
			end;
		end;
			
end
