
class APP_ADD_STATE 

inherit

	APP_ADD_FIGURE; 
	APP_FIND_FIGURE
		export
			{NONE} all
		end;
	APP_CMD_NAMES
		rename
			App_add_state_cmd_name as c_name
		export
			{NONE} all
		end

feature {NONE}

	figures: APP_FIGURES;

	work (added_state: STATE) is
			-- Add a state to the application if the state_stone
			-- is not used by an existing circle. Create a circle 
			-- and perform the specific_work. 
		local
			transitions: TRANSITION;
			point: COORD_XY_FIG
		do
			figures := application_editor.figures;
			transitions := application_editor.transitions;
			if
				(x = 0) and (y = 0)
					-- no initial point set
			then
				point := figures.previous_point;
				x := point.x;
				y := point.y;
			end;
			find_figure (added_state); 
			if 
				figures.after 
			then 
				!!figure.make; 
				figure.init; 
				figure.set_stone (added_state.original_stone);
				do_specific_work;
				update_history
			end;
			figures := Void
		end; -- work 

end -- APP_ADD_STATE
