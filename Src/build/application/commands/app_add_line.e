indexing
	description: "Add an arrow line in the application editor."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class APP_ADD_LINE

inherit 
	APP_COMMAND
		redefine
			redo
		end 

feature -- Access

	redo is
		do
			Precursor
			perform_update_display
		end

	undo is
		local
			removed: BOOLEAN
			lines: APP_LINES
			pos: INTEGER
		do
			lines := application_editor.lines
			from
				lines.start
			until
				lines.after or  else lines.line = line
			loop
				lines.forth
			end
			if not lines.after then
				lines.remove
			end
			perform_update_display
		end

	execute (arg: EV_ARGUMENT2 [STATE_CIRCLE, APP_FIGURE]; ev_data: EV_EVENT_DATA) is
			-- Find the destination_figure. If found,
			-- set line found to line and then add a line.
		require else
			not_void_source_circle: arg.first /= Void
		local
			figures: APP_FIGURES
			lines: APP_LINES
		do
			if arg.first /= arg.second then
				create line.make
				line.set_elements (arg.first, arg.second)
				do_specific_work 
				line.calculate
				line.attach_drawing (application_editor.drawing_area)
				lines := application_editor.lines
				if not lines.found then
					perform_update_display
					successful := True
					update_history
				end
			end
		end

	successful: BOOLEAN
			-- Was the command successful?

feature {NONE} -- Implementation

	line: STATE_LINE
			-- Line added

	do_specific_work is
			-- Add a line. 
		local
			lines: APP_LINES
		do
			lines := application_editor.lines
			lines.append (line)
		end

	update_display is
		do
			application_editor.draw_figures
		end

	name: STRING is
		do
			Result := Command_names.app_add_line_cmd_name
		end

	comment: STRING is
		do
			create Result.make (0)
			if line /= Void and then line.source /= Void
			and then line.destination /= Void
			then
				Result.append (line.source.label)
				Result.append (" -> ")
				Result.append (line.destination.label)
			end
		end

end -- class APP_ADD_LINE

