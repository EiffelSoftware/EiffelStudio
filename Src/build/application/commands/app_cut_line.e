
class APP_CUT_LINE 

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

feature {NONE}

	source_element, dest_element: GRAPH_ELEMENT;

	line: STATE_LINE;

	labels_cut: LINKED_LIST [APP_CUT_LABEL];
	
	c_name: STRING is
		do
			Result := Command_names.app_cut_line_cmd_name
		end;

feature 

	redo is
		do
			from
				labels_cut.start
			until
				labels_cut.after
			loop
				labels_cut.item.redo;
				labels_cut.forth
			end;
			old_redo;
		end;

	undo is 
		local
			sel_figure: APP_FIGURE;
			transitions: TRANSITION;
			lines: APP_LINES
		do 
			transitions := application_editor.transitions;
			lines := application_editor.lines;
			lines.append (line);
			from
				labels_cut.start
			until
				labels_cut.after
			loop
				labels_cut.item.undo;
				labels_cut.forth
			end;
			perform_update_display
		end; -- undo
		
feature {NONE}

	work (a_line: STATE_LINE) is
			-- Set line to `a_line'. Set the source_element and dest_element
			-- using line. And then remove the line.
		local
			transitions: TRANSITION;
			temp_tran: HASH_TABLE [GRAPH_ELEMENT, STRING];
			cut_label_command: APP_CUT_LABEL
		do
			line := a_line;
			source_element := line.source.data;
			dest_element := line.destination.data;
			!!labels_cut.make;
			transitions := application_editor.transitions;
			temp_tran := transitions.transition (source_element,
								 dest_element);
			from
				temp_tran.start
			until
				temp_tran.off
			loop
				!!cut_label_command;
				cut_label_command.set_for_macro;
				cut_label_command.set_source_element (source_element);
				cut_label_command.execute (temp_tran.key_for_iteration);
				labels_cut.put_right (cut_label_command);
				temp_tran.forth	
			end;
			do_specific_work;
			update_history
		end; 

	do_specific_work is
			-- Remove `line'. Update the transitions and redisplay
			-- the transition list. 
		local
			lines: APP_LINES;
			transitions: TRANSITION;
		do 
			lines := application_editor.lines;
			transitions := application_editor.transitions;
			transitions.remove_transition (source_element, dest_element);
			lines.start;
			lines.search (line);
			if not lines.after then
				lines.remove
			end;
			perform_update_display;
		end;

	update_display is
		local
			sel_figure: APP_FIGURE
		do
			sel_figure := application_editor.selected_figure;
			if
				not (sel_figure = Void) and 
				(sel_figure.data = source_element) and
				not (labels_cut = Void) 
				and not labels_cut.Empty
			then
				application_editor.display_transitions
			end;
			application_editor.draw_figures;
		end;

	worked_on: STRING is
		do
			-- if added by samik
			if source_element /= Void and then dest_element /= Void then
				!!Result.make (0);
				Result.append (source_element.label);
				Result.append ("->");
				Result.append (dest_element.label);
			end
		end;

end 
