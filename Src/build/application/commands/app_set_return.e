indexing
	description: "Undoable command to do a back trasition on the previous state."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class APP_SET_RETURN

inherit
	APP_COMMAND

	SHARED_APPLICATION

feature -- Access

	execute (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Set to return label.
		local
			cmd: CMD_LABEL
			transitions: TRANSITION
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]
			dest_element: GRAPH_ELEMENT
		do
			cmd ?= ev_data.data
			cmd_label := cmd.label

			source_element := application_editor.selected_figure.data
			transitions := application_editor.transitions
			old_dest_element := transitions.destination_element (source_element, cmd_label)
			temp_trans := Shared_app_graph.item (source_element)
			if temp_trans.has (cmd_label) then
				dest_element := temp_trans.item (cmd_label)
				if dest_element /= Void then -- not have return
					do_specific_work
				else
					failed := True
				end
			else
				do_specific_work
			end
		end

	undo is
		local
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]
			sel_figure: APP_FIGURE
		do 
			temp_trans := Shared_app_graph.item (source_element)
			temp_trans.remove (cmd_label)
			if
				not (old_dest_element = Void)
			then
				temp_trans.force (old_dest_element, cmd_label)
			end
			perform_update_display
		end

feature {NONE} -- Implementation

	cmd_label: STRING

	old_dest_element, source_element: GRAPH_ELEMENT

	do_specific_work is
			-- Set the return cmd_label.
		local
			dummy: GRAPH_ELEMENT
			transitions: TRANSITION
		do	
			transitions := application_editor.transitions
			transitions.update_label (source_element, cmd_label, dummy)
			application_editor.display_transitions
			perform_update_display
		end

	update_display is
		local
			sel_figure: APP_FIGURE
		do
			sel_figure := application_editor.selected_figure
			if
				not (sel_figure = Void) and
				(sel_figure.data = source_element)
			then
				application_editor.display_transitions
			end
		end

	name: STRING is
		do
			Result := Command_names.app_set_return_cmd_name
		end

	comment: STRING is
		do
			-- if added by samik
			if source_element /= Void and then cmd_label /= Void then
				!!Result.make (0)
				Result.append (source_element.label)
				Result.append (" - ")
				Result.append (cmd_label)
			end
		end

end -- class APP_SET_RETURN

