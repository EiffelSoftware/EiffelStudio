indexing
	description: "Cut a figure in the application editor."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class APP_CUT_FIGURE 

inherit 
	APP_COMMAND
		redefine
			redo, popuper_parent
		end

	ERROR_POPUPER

feature -- Access

	execute (arg: EV_ARGUMENT1 [STATE_CIRCLE]; ev_data: EV_EVENT_DATA) is
			-- Do the work for the removal of `circle'. 
		local
			transitions: TRANSITION
			lines: APP_LINES
			temp_lines: LINKED_LIST [STATE_LINE]
			sel_figure: STATE_CIRCLE
			cut_line_cmd: APP_CUT_LINE
			args: EV_ARGUMENT1 [STATE_LINE]
		do
			circle := arg.first
			if (app_editor.initial_state_circle = circle) then
				error_dialog.popup (Current, Messages.remove_init_state_er, Void)
			else
				transitions := app_editor.transitions
				lines := app_editor.lines
				from
					create temp_lines.make
					lines.start
				until
					lines.after
				loop
					if (lines.line.source = circle)
						or (lines.line.destination = circle)
					then
						temp_lines.put_right (lines.line)
					end
					lines.forth
				end
				from
					create lines_cut.make
					temp_lines.start
				until
					temp_lines.after
				loop
					create cut_line_cmd
					create args.make (temp_lines.item)
					cut_line_cmd.set_for_macro
					cut_line_cmd.execute (args, Void)
					lines_cut.put_right (cut_line_cmd)
					temp_lines.forth
				end
				sel_figure := app_editor.selected_figure
				if
					circle = sel_figure
				then
					selected := True
				end
				do_specific_work
				update_history
			end
		end 

	redo is
		do
			from
				lines_cut.start
			until
				lines_cut.after
			loop
				lines_cut.item.redo
				lines_cut.forth
			end
			Precursor
		end

	undo is 
		local
			transitions: TRANSITION
			lines: APP_LINES
			figures: APP_FIGURES
		do 
			transitions := app_editor.transitions
			transitions.init_element (circle.data)
			lines := app_editor.lines
			figures := app_editor.figures
			figures.append (circle)
			from
				lines_cut.start
			until
				lines_cut.after
			loop
				lines_cut.item.undo
				lines_cut.forth
			end
			if
				selected 
			then
				app_editor.set_selected (circle)
			end
			perform_update_display
			if
				not (state_editor = Void)
			then
				state_editor.set_edited_function
					 (circle.data)
			end
		end

feature {NONE} -- Implementation

	do_specific_work is
			-- Remove circle and update the transitions.
		local
			transitions: TRANSITION
			sel_figure: STATE_CIRCLE
			figures: APP_FIGURES
		do
			if selected then
				app_editor.set_selected (app_editor.initial_state_circle)
			end
			transitions := app_editor.transitions
			figures := app_editor.figures
			transitions.remove_element (circle.data)
			figures.start
			figures.search (circle)
			if not figures.after then
				figures.remove
			end
			state_editor := circle.data.func_editor
			if state_editor /= Void then
				state_editor.clear
			end
			perform_update_display
		end

	update_display is
		do
			app_editor.display_states
			app_editor.draw_figures
			app_editor.display_transitions
		end

	state_editor: STATE_EDITOR

	lines_cut: LINKED_LIST [APP_CUT_LINE]

	selected: BOOLEAN
			-- Was the figure selected before the cut ?

	circle: STATE_CIRCLE
			-- circle removed

	name: STRING is
		do
			Result := Command_names.app_cut_state_cmd_name
		end

	comment: STRING is
		do
			create Result.make (0)
			if circle /= Void then
				Result.append (circle.label)
			end
		end 

	popuper_parent: EV_CONTAINER is
		do
			Result := App_editor
		end

end -- class APP_CUT_FIGURE

