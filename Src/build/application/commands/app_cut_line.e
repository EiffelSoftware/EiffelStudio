indexing
	description: "Cut an arrow line in the application editor."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class APP_CUT_LINE

inherit
	APP_COMMAND
		redefine
			redo
		end

feature -- Access

	redo is
		do
			from
				labels_cut.start
			until
				labels_cut.after
			loop
				labels_cut.item.redo
				labels_cut.forth
			end
			Precursor
		end

	undo is
		local
			sel_figure: APP_FIGURE
			transitions: TRANSITION
			lines: APP_LINES
		do
			transitions := application_editor.transitions
			lines := application_editor.lines
			lines.append (line)
			from
				labels_cut.start
			until
				labels_cut.after
			loop
				labels_cut.item.undo
				labels_cut.forth
			end
			perform_update_display
		end

	execute (arg: EV_ARGUMENT1 [STATE_LINE]; ev_data: EV_EVENT_DATA) is
			-- Set line to `a_line'. Set the source_element and dest_element
			-- using line. And then remove the line.
		local
			transitions: TRANSITION
			temp_tran: HASH_TABLE [GRAPH_ELEMENT, STRING]
			cut_label_command: APP_CUT_LABEL
			args: EV_ARGUMENT2 [STRING, GRAPH_ELEMENT]
		do
			line := arg.first
			source_element := line.source.data
			dest_element := line.destination.data
			create labels_cut.make
			transitions := application_editor.transitions
			temp_tran := transitions.transition (source_element, dest_element)
			from
				temp_tran.start
			until
				temp_tran.off
			loop
				create cut_label_command
				cut_label_command.set_for_macro
				create args.make (temp_tran.key_for_iteration, source_element)
				cut_label_command.execute (args, Void)
				cut_label_command.update_history
				labels_cut.put_right (cut_label_command)
				temp_tran.forth	
			end
			do_specific_work
			update_history
		end

feature {NONE} -- Implementation

	source_element, dest_element: GRAPH_ELEMENT

	line: STATE_LINE

	labels_cut: LINKED_LIST [APP_CUT_LABEL]

	do_specific_work is
			-- Remove `line'. Update the transitions and redisplay
			-- the transition list. 
		local
			lines: APP_LINES
			transitions: TRANSITION
		do 
			lines := application_editor.lines
			transitions := application_editor.transitions
			transitions.remove_transition (source_element, dest_element)
			lines.start
			lines.search (line)
			if not lines.after then
				lines.remove
			end
			perform_update_display
		end

	update_display is
		local
			sel_figure: APP_FIGURE
		do
			sel_figure := application_editor.selected_figure
			if sel_figure /= Void and then sel_figure.data = source_element
			and then labels_cut /= Void and then not labels_cut.empty
			then
				application_editor.display_transitions
			end
			application_editor.draw_figures
		end

	name: STRING is
		do
			Result := Command_names.app_cut_line_cmd_name
		end

	comment: STRING is
		do
			create Result.make (0)
			if source_element /= Void and then dest_element /= Void then
				Result.append (source_element.label)
				Result.append ("->")
				Result.append (dest_element.label)
			end
		end

end -- class APP_CUT_LINE

