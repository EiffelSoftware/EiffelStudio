indexing
	description: "Cut a label in the application editor."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class APP_CUT_LABEL

inherit
	APP_COMMAND

	SHARED_APPLICATION

feature -- Access

	execute (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
			cmd_l: CMD_LABEL
			arg1: EV_ARGUMENT2 [STRING, GRAPH_ELEMENT]
		do
			cmd_l ?= ev_data.data
			create arg1.make (cmd_l.label, Void)
			work (arg1)
		end

	work (arg: EV_ARGUMENT2 [STRING, GRAPH_ELEMENT]) is
			-- Set `cmd_label' to `arg.first'.
			-- Set `source_element' to the `arg.second' data.
			-- Peform the specific work.
			-- Do not update history.
		local
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]
		do 
			cmd_label := arg.first
			if arg.second /= Void then
				source_element := arg.second
			else
				source_element := application_editor.selected_figure.data
			end
			temp_trans := Shared_app_graph.item (source_element)
			if temp_trans.has (cmd_label) then
				dest_element := temp_trans.item (cmd_label)
				do_specific_work
			else
				failed := True
			end
		end

	undo is
		local
			transitions: TRANSITION
		do
			transitions := application_editor.transitions
			transitions.update_label (source_element, cmd_label, dest_element)
			perform_update_display
		end

feature {NONE} -- Implementation

	source_element: GRAPH_ELEMENT

	dest_element: GRAPH_ELEMENT

	cmd_label: STRING

	do_specific_work is
			-- Remove cmd_label from selected_figure transitions.
		local
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]
		do
			temp_trans := Shared_app_graph.item (source_element)
			temp_trans.remove (cmd_label)
			perform_update_display
		end

	update_display is
		local
			sel_figure: APP_FIGURE
		do
			sel_figure := application_editor.selected_figure
			if sel_figure /= Void and then sel_figure.data = source_element	then
				application_editor.display_transitions
			end
		end

	name: STRING is
		do
			Result := Command_names.app_cut_label_cmd_name
		end

	comment: STRING is
		do
			create Result.make (0)
			if cmd_label /= Void then
				Result.append (cmd_label)
			end
		end

end -- class APP_CUT_LABEL

