
class APP_SET_EXIT  

inherit 

	APP_COMMAND;
	SHARED_APPLICATION;
	
feature 

	undo is 
		local
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING];
			void_element: GRAPH_ELEMENT;
			sel_figure: APP_FIGURE
		do 
			temp_trans := Shared_app_graph.item (source_element);
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

	c_name: STRING is
		do
			Result := Command_names.app_set_exit_cmd_name
		end;

	work (l: STRING) is
			-- Set cmd_label to `l'.
		local
			transitions: TRANSITION;
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING];
			dest_element: GRAPH_ELEMENT
		do
			cmd_label := l;
			source_element := application_editor.selected_figure.data;
			transitions := application_editor.transitions;
			old_dest_element := transitions.destination_element (source_element, cmd_label);
			temp_trans := Shared_app_graph.item (source_element);
			if temp_trans.has (cmd_label) then
				dest_element := temp_trans.item (cmd_label);
				if (dest_element = Void) then
					is_return_label := True;
				end;
				if dest_element /= Shared_app_graph.exit_element then
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
			transitions.update_label (source_element, cmd_label, 
				Shared_app_graph.exit_element);
			perform_update_display
		end;

	update_display is
		local
			sel_figure: APP_FIGURE
		do
			sel_figure := application_editor.selected_figure;
			if
				not (sel_figure = Void) and
				(source_element = sel_figure.data)
			then
				application_editor.display_transitions
			end
		end;

	worked_on: STRING is
		do
			-- if added by samik
			if source_element /= Void and then cmd_label /= Void then
				!!Result.make (0);
				Result.append (source_element.label);
				Result.append (" - ");
				Result.append (cmd_label);
			end
		end;

end 
