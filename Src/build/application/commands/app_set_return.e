
class APP_SET_RETURN  

inherit 

	APP_COMMAND;
	APP_CMD_NAMES
		rename
			App_set_return_cmd_name as c_name
		export
			{NONE} all
		end
	
feature 

	undo is 
		local
			graph: APP_GRAPH;
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING];
			sel_figure: APP_FIGURE
		do 
			graph := application_editor.transitions.graph;
			temp_trans := graph.item (source_element);
			temp_trans.remove (cmd_label);
			if
				not (old_dest_element = Void)
			then
				temp_trans.force (old_dest_element, cmd_label);
			end;
			perform_update_display
		end;

feature {NONE}

	cmd_label: STRING;

	old_dest_element, source_element: GRAPH_ELEMENT;
	
	work (l: STRING) is
			-- Set cmd_label to `l'.
		local
			transitions: TRANSITION;
			graph: APP_GRAPH;
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING];
			dest_element: GRAPH_ELEMENT
		do
			cmd_label := l;
			source_element := application_editor.selected_figure.original_stone;
			transitions := application_editor.transitions;
			old_dest_element := transitions.destination_element (source_element, cmd_label);
			graph := transitions.graph;
			temp_trans := graph.item (source_element);
			if
				temp_trans.has (cmd_label)
			then
				dest_element := temp_trans.item (cmd_label);
				if
					not (dest_element = Void) -- not have return
				then
					do_specific_work;
					update_history
				end
			else
				do_specific_work;
				update_history
			end
		end; 

	do_specific_work is
			-- Set the return cmd_label.
		local
			dummy: GRAPH_ELEMENT;
			transitions: TRANSITION;
		do	
			transitions := application_editor.transitions;
			transitions.update_label (source_element, cmd_label, dummy);
			application_editor.display_transitions;
			perform_update_display
		end;

	update_display is
		local
			sel_figure: APP_FIGURE
		do
			sel_figure := application_editor.selected_figure;
			if
				not (sel_figure = Void) and
				(sel_figure.original_stone = source_element)
			then
				application_editor.display_transitions
			end
		end;

	worked_on: STRING is
		do
			!!Result.make (0);
			Result.append (source_element.label);
			Result.append (" - ");
			Result.append (cmd_label);
		end;

end 
