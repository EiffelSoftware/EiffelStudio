
class APP_SET_EXIT  

inherit 

	APP_COMMAND;
	SHARED_APPLICATION;
	APP_CMD_NAMES
		rename
			App_set_exit_cmd_name as c_name
		end
	
feature 

	undo is 
		local
			g_raph: APP_GRAPH;
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING];
			void_element: GRAPH_ELEMENT;
			sel_figure: APP_FIGURE
		do 
			g_raph := application_editor.transitions.graph;
			temp_trans := g_raph.item (source_element);
			temp_trans.remove (cmd_label);
			if
				not (old_dest_element = Void)
			then
				temp_trans.put (old_dest_element, cmd_label);
			elseif
				is_return_label
			then
				temp_trans.put (void_element, cmd_label)
			end;
			perform_update_display
		end; 
	
feature {NONE}

	cmd_label: STRING;

	old_dest_element, source_element: GRAPH_ELEMENT;

	is_return_label: BOOLEAN;
			-- Is the `cmd_label' a return label?

	work (l: STRING) is
			-- Set cmd_label to `l'.
		local
			transitions: TRANSITION;
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING];
			g_raph: APP_GRAPH;
			dest_element: GRAPH_ELEMENT
		do
			cmd_label := l;
			source_element := application_editor.selected_figure.original_stone;
			transitions := application_editor.transitions;
			old_dest_element := transitions.destination_element (source_element, cmd_label);
			g_raph := transitions.graph;
			temp_trans := g_raph.item (source_element);
			if
				temp_trans.has (cmd_label)
			then
				dest_element := temp_trans.item (cmd_label);
				if
					(dest_element = Void)
				then
					is_return_label := True;
				end;
				if
					not (dest_element = exit_element)
				then
					do_specific_work;
					update_history
				end
			else
				do_specific_work;
				update_history
			end;
		end;

	do_specific_work is
			-- Set the return cmd_label.
		local
			transitions: TRANSITION
		do	
			transitions := application_editor.transitions;
			transitions.update_label (source_element, cmd_label, exit_element);
			perform_update_display
		end;

	update_display is
		local
			sel_figure: APP_FIGURE
		do
			sel_figure := application_editor.selected_figure;
			if
				not (sel_figure = Void) and
				(source_element = sel_figure.original_stone)
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
