
class APP_UPDATE_TRANS 

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

feature 

	c_name: STRING is
		do
			Result := Command_names.app_update_transitions_cmd_name
		end;

	redo is
		do
			if
				not (add_line_command = Void)
				and add_line_command.successful
			then
				add_line_command.redo
			end;
			old_redo
		end; 

	undo is
		local
			transitions: TRANSITION;
			sel_figure: APP_FIGURE
	 	do 
			transitions := application_editor.transitions;
			if
				(old_dest_element = Void)
			then
				transitions.update_label (source_element, cmd_label, source_element)
			else
				transitions.update_label (source_element, cmd_label, old_dest_element)
			end;
			if
				not (add_line_command = Void) and
				add_line_command.successful
			then
				add_line_command.undo
			end;
			perform_update_display
		end; -- undo
	
feature {NONE}

	add_line_command: APP_ADD_LINE;

	cmd_label: STRING;

	old_dest_element, source_element, dest_element: GRAPH_ELEMENT;

	do_specific_work is
			-- Update the transitions between 
			-- source_element and dest_element
			-- with `cmd_label'.
		require else
			source_element: not (source_element = Void)
		local
			transitions: TRANSITION
		do
			transitions := application_editor.transitions;
			transitions.update_label (source_element, cmd_label, dest_element);
			perform_update_display
		end; 

	work (l: STRING) is
			-- Update the transition between two element (i.e. figure). 
			-- This can be done by either dropping the cmd_label on the 
			-- destination figure or on the square of the line coming 
			-- from the selected figure.
		local
			figures: APP_FIGURES;
			lines: APP_LINES;
			transitions: TRANSITION;
			source_circle: STATE_CIRCLE;
			dest_figure: APP_FIGURE;
		do 
			cmd_label := l;
			figures := application_editor.figures;
			transitions := application_editor.transitions;
			lines := application_editor.lines;
			figures.find;
			if
				not figures.found
			then
				lines.find;
				if
					not lines.off
				then
					dest_figure := lines.line.destination;
					source_circle ?= lines.line.source;
					source_element := source_circle.data;
					dest_element := dest_figure.data;
					old_dest_element := transitions.destination_element (source_element, cmd_label);
					if
						not (old_dest_element = dest_element)
					then
						do_specific_work;
						update_history
					end;
				end
			else
				source_circle ?= application_editor.selected_figure;
				dest_figure := figures.figure;
				source_element := source_circle.data;
				dest_element := dest_figure.data;
				old_dest_element := transitions.destination_element (source_element, cmd_label);
				if
					not (old_dest_element = dest_element)
				then
					!!add_line_command;
					add_line_command.set_for_macro;
					add_line_command.set_source_circle (source_circle);
					add_line_command.execute (dest_figure);
					do_specific_work;
					update_history
				end
			end
		end; 

	update_display is
		local
			sel_figure: APP_FIGURE
		do
			sel_figure := application_editor.selected_figure;
			if
				not (sel_figure = Void) and
				(sel_figure.data = source_element)
			then
				application_editor.display_transitions		
			end;
			if
				not (add_line_command = Void) and
				add_line_command.successful
			then
				application_editor.draw_figures
			end
		end;

	worked_on: STRING is
		do
			-- if added by samik
			if source_element /= Void and then cmd_label /= Void then	
				!!Result.make (0);
				Result.append (source_element.label);
				Result.append (" - ");
				Result.append (cmd_label)
			end
		end;

end 
