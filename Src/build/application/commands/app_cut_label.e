
class APP_CUT_LABEL 

inherit 

	APP_COMMAND;
	APP_CMD_NAMES
		rename
			App_cut_label_cmd_name as c_name
		end

feature 

	undo is 
		local
			transitions: TRANSITION
		do
			transitions := application_editor.transitions;
			transitions.update_label (source_element, cmd_label, dest_element);
			perform_update_display
		end;

	set_source_element (element: GRAPH_ELEMENT) is
		do
			source_element := element
		end;
	
feature {NONE}

	source_element: GRAPH_ELEMENT;

	dest_element: GRAPH_ELEMENT;

	cmd_label: STRING;

	work (l: STRING) is
			-- Set cmd_label to `l'. Set source_element to the selected_figure original
			-- stone. Peform the specific work.
		local
			graph: APP_GRAPH;
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING];
		do 
			cmd_label := l;
			if
				(source_element = Void)
			then
				source_element := application_editor.selected_figure.original_stone;
			end;
			graph := application_editor.transitions.graph;
			temp_trans := graph.item (source_element);
			if
				temp_trans.has (cmd_label)
			then
				dest_element := temp_trans.item (cmd_label);
				do_specific_work;
				update_history
			end;
		end; -- work

	do_specific_work is
			-- Remove cmd_label from selected_figure transitions.
		local
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING];
			graph:APP_GRAPH
		do
			graph := application_editor.transitions.graph;
			temp_trans := graph.item (source_element);
			temp_trans.remove (cmd_label);
			perform_update_display;
		end; -- do_specific_work 

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
		end; -- update_display

	worked_on: STRING is
		do
			!!Result.make (0);
			Result.append (cmd_label);
		end; -- worked_on

end -- class APP_CUT_LABEL
