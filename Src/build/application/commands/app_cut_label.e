
class APP_CUT_LABEL 

inherit 

	SHARED_APPLICATION;
	APP_COMMAND;

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

	c_name: STRING is
		do
			Result := Command_names.app_cut_label_cmd_name
		end;

	work (l: STRING) is
			-- Set cmd_label to `l'. Set source_element to the selected_figure original
			-- stone. Peform the specific work.
		local
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING];
		do 
			cmd_label := l;
			if
				(source_element = Void)
			then
				source_element := application_editor.selected_figure.data;
			end;
			temp_trans := Shared_app_graph.item (source_element);
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
		do
			temp_trans := Shared_app_graph.item (source_element);
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
				(sel_figure.data = source_element)
			then
				application_editor.display_transitions
			end
		end; -- update_display

	worked_on: STRING is
		do
			!!Result.make (0);
			-- if added by samik
			if cmd_label /= Void then	
				Result.append (cmd_label);
			end
		end; -- worked_on

end -- class APP_CUT_LABEL
