
class APP_CUT_FIGURE 

inherit 

	APP_COMMAND
		rename
			redo as old_redo
		end;
	APP_COMMAND
		redefine
			redo
		select
			redo
		end;
	ERROR_POPUPER;

creation

	make

feature -- Creation

	make (a_circle: STATE_CIRCLE) is
		do
			circle := a_circle
		end	

feature {NONE}

	state_editor: STATE_EDITOR;

	lines_cut: LINKED_LIST [APP_CUT_LINE];

	selected: BOOLEAN;
			-- Was the figure selected before the cut ?

	circle: STATE_CIRCLE;
			-- circle removed

	c_name: STRING is
		do
			Result :=Command_names.app_cut_state_cmd_name
		end;

	popuper_parent: COMPOSITE is
		do
			Result := App_editor
		end;
	
feature 

	redo is
		do
			from
				lines_cut.start
			until
				lines_cut.after
			loop
				lines_cut.item.redo;
				lines_cut.forth
			end;
			old_redo;
		end; -- redo

	undo is 
		local
			transitions: TRANSITION;
			lines: APP_LINES;
			figures: APP_FIGURES;
		do 
			transitions := app_editor.transitions;
			transitions.init_element (circle.data);
			lines := app_editor.lines;
			figures := app_editor.figures;
			figures.append (circle);
			from
				lines_cut.start
			until
				lines_cut.after
			loop
				lines_cut.item.undo;
				lines_cut.forth
			end;
			if
				selected 
			then
				app_editor.set_selected (circle);
			end;
			perform_update_display;
			if
				not (state_editor = Void)
			then
				state_editor.set_edited_function
					 (circle.data)
			end;
		end; -- undo

	
feature {NONE}

	work (argument: ANY) is
			-- Do the work for the removal of `circle'. 
		local
			transitions: TRANSITION;
			lines: APP_LINES;
			temp_lines: LINKED_LIST [STATE_LINE];
			sel_figure: STATE_CIRCLE;
			cut_line_command: APP_CUT_LINE;
		do 
			if (app_editor.initial_state_circle = circle) then
				error_box.popup (Current, Messages.remove_init_state_er, Void);
			else
				transitions := app_editor.transitions;
				lines := app_editor.lines;
				from
					!!temp_lines.make;
					lines.start
				until
					lines.after
				loop
					if  (lines.line.source = circle)
						or (lines.line.destination = circle)
					then
						temp_lines.put_right (lines.line)
					end;
					lines.forth
				end;
				from
					!!lines_cut.make;
					temp_lines.start
				until
					temp_lines.after
				loop
					!!cut_line_command;
					cut_line_command.set_for_macro;
					cut_line_command.execute (temp_lines.item);
					lines_cut.put_right (cut_line_command);
					temp_lines.forth
				end;
				sel_figure := app_editor.selected_figure;
				if
					circle = sel_figure
				then
					selected := True;
				end;
				do_specific_work;
				update_history;
			end
		end; 

	do_specific_work is
			-- Remove circle and update the transitions.
		local
			transitions: TRANSITION;
			sel_figure: STATE_CIRCLE;
			figures: APP_FIGURES;
		do
			if selected then
				app_editor.set_selected (app_editor.initial_state_circle)
			end;
			transitions := app_editor.transitions;
			figures := app_editor.figures;
			transitions.remove_element (circle.data);
			figures.start;
			figures.search (circle);
			if not figures.after then
				figures.remove
			end;
			state_editor := circle.data.func_editor;
			if state_editor /= Void then
				state_editor.clear
			end;
			perform_update_display;
		end;

	update_display is
		do
			app_editor.display_states;
			app_editor.draw_figures;
			app_editor.display_transitions;
		end; 

	worked_on: STRING is
		do
			!!Result.make (0);
			Result.append (circle.label);
		end; 

end 
