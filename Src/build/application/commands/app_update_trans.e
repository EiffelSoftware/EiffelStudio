indexing
	description: "Update translations in the application editor."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class APP_UPDATE_TRANS

inherit 
	APP_COMMAND
		redefine
			redo
		end

feature -- Access

	redo is
		do
			if add_line_command /= Void and then add_line_command.successful then
				add_line_command.redo
			end
			Precursor
		end 

	undo is
		local
			transitions: TRANSITION
			sel_figure: APP_FIGURE
		do 
			transitions := application_editor.transitions
			if old_dest_element = Void then
				transitions.update_label (source_element, cmd_label, source_element)
			else
				transitions.update_label (source_element, cmd_label, old_dest_element)
			end
			if add_line_command /= Void and then add_line_command.successful then
				add_line_command.undo
			end
			perform_update_display
		end

	execute (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Update the transition between two element (i.e. figure). 
			-- This can be done by either dropping the cmd_label on the 
			-- destination figure or on the square of the line coming 
			-- from the selected figure.
		local
			label_list: LABEL_SCR_L
			figures: APP_FIGURES
			lines: APP_LINES
			transitions: TRANSITION
			source_circle: STATE_CIRCLE
			dest_figure: APP_FIGURE
			args: EV_ARGUMENT2 [STATE_CIRCLE, APP_FIGURE]
		do
			label_list ?= ev_data.data
			if label_list /= Void then
				cmd_label := label_list.selected_label
				figures := application_editor.figures
				transitions := application_editor.transitions
				lines := application_editor.lines

				figures.find (ev_data.x, ev_data.y)
				if not figures.found then
					lines.find (ev_data.x, ev_data.y)
					if not lines.off then
						dest_figure := lines.line.destination
						source_circle ?= lines.line.source
						source_element := source_circle.data
						dest_element := dest_figure.data
						old_dest_element := transitions.destination_element (source_element, cmd_label)
						if old_dest_element /= dest_element then
							do_specific_work
						end
					end
				else
					source_circle ?= application_editor.selected_figure
					dest_figure := figures.figure
					source_element := source_circle.data
					dest_element := dest_figure.data
					old_dest_element := transitions.destination_element (source_element, cmd_label)
					if old_dest_element /= dest_element then
						create add_line_command
						create args.make (source_circle, dest_figure)
						add_line_command.set_for_macro
						add_line_command.execute (args, Void)
						do_specific_work
					end
				end
			else
				failed := True
			end
		end

feature {NONE} -- Implementation

	add_line_command: APP_ADD_LINE

	cmd_label: STRING

	old_dest_element, source_element, dest_element: GRAPH_ELEMENT

	do_specific_work is
			-- Update the transitions between 
			-- source_element and dest_element
			-- with `cmd_label'.
		require else
			invalid_source_element: source_element /= Void
		local
			transitions: TRANSITION
		do
			transitions := application_editor.transitions
			transitions.update_label (source_element, cmd_label, dest_element)
			perform_update_display
		end

	update_display is
		local
			sel_figure: APP_FIGURE
		do
			sel_figure := application_editor.selected_figure
			if sel_figure /= Void and sel_figure.data = source_element then
				application_editor.display_transitions		
			end
			if add_line_command /= Void and then add_line_command.successful then
				application_editor.draw_figures
			end
		end

	name: STRING is
		do
			Result := Command_names.app_update_transitions_cmd_name
		end

	comment: STRING is
		do
			create Result.make (0)
			if source_element /= Void and then cmd_label /= Void then	
				Result.append (source_element.label)
				Result.append (" - ")
				Result.append (cmd_label)
			end
		end

end -- class APP_UPDATE_TRANS

