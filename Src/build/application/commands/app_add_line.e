
class APP_ADD_LINE 

inherit 

	APP_COMMAND
		rename
			redo as old_redo
		end;
	APP_COMMAND
		redefine
			redo
		select
			redo
		end; 

feature 

	successful: BOOLEAN;
			-- Was the command successful?

	set_source_circle (circle: STATE_CIRCLE) is
		do
			source_circle := circle
		end; -- set_source_circle

	c_name: STRING is
		do
			Result := Command_names.app_add_line_cmd_name
		end;

	redo is
		do
			old_redo;
			perform_update_display
		end;-- redo

	undo is
		local
			removed: BOOLEAN;
			lines: APP_LINES;
			pos: INTEGER
		do
			lines := application_editor.lines;
			from
				lines.start
			until
				lines.after or 
				else (lines.line = line) 
			loop
				lines.forth	
			end;
			if not lines.after then
				lines.remove
			end;
			perform_update_display
		end; -- undo

	
feature {NONE}

	line: STATE_LINE;
			-- Line added

	source_circle: STATE_CIRCLE;
			-- Source circle for line

	do_specific_work is
			-- Add a line. 
		local
			lines: APP_LINES;
		do 
			lines := application_editor.lines;
			lines.append (line);
		end; -- add_line

feature {NONE}

	work (dest_figure: APP_FIGURE) is
			-- Find the destination_figure. If found,
			-- set line found to line and then add a line.
		require else
			not_void_source_circle: not (source_circle = Void)
		local
			figures: APP_FIGURES;
			lines: APP_LINES
		do 
			if
				(source_circle /= dest_figure)
			then
				!!line.make;
				line.set_elements (source_circle, dest_figure);
				do_specific_work; 
				line.calculate;
				lines := application_editor.lines;
				if
					not lines.found
				then
					perform_update_display;
					successful := True;
					update_history
				end
			end
		end; -- work 

	update_display is
		do
			application_editor.draw_figures		
		end; -- update_display

	worked_on: STRING is
		do
			-- if added by samik
			if line /= Void and then line.source /= Void and then line.destination /= Void then

				!!Result.make (0);
				Result.append (line.source.label);
				Result.append (" -> ");
				Result.append (line.destination.label);
			end
		end; -- worked_on

end 
