class CURSORS

inherit

	CURSOR_TYPE;
	CONSTANTS

feature 

	Application_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("application.curs")
		end;

	Behavior_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("behavior.curs")
		end;

	Command_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("command.curs")
		end;

	Command_instance_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("command_instance.curs")
		end;

	Context_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("context.curs")
		end;

	Event_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("event.curs")
		end;

	Label_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("label.curs")
		end;

	State_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("state.curs")
		end;

	Transition_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("transition.curs")
		end;

	Type_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("type.curs")
		end;

feature -- Context Cursors

	move_cursor: SCREEN_CURSOR is
			-- Cross cursor shape (move mode)
		once
			Result := create_cursor (Fleur)
		end;

	top_left_corner_cursor: SCREEN_CURSOR is
			-- Top left corner cursor (resize mode)
		once
			Result := create_cursor (Top_left_corner)
		end;

	top_right_corner_cursor: SCREEN_CURSOR is
			-- Top right corner cursor (resize mode)
		once
			Result := create_cursor (Top_right_corner)
		end;

	bottom_left_corner_cursor: SCREEN_CURSOR is
			-- Bottom left corner cursor (resize mode)
		once
			Result := create_cursor (Bottom_left_corner)
		end;

	bottom_right_corner_cursor: SCREEN_CURSOR is
			-- Bottom right corner cursor (resize mode)
		once
			Result := create_cursor (Bottom_right_corner)
		end;

	question_arrow_cursor: SCREEN_CURSOR is
			-- Question arrow cursor
		once
			Result := create_cursor (Question_arrow)
		end;

	cross_cursor: SCREEN_CURSOR is
			-- Cross cursor
		once
			Result := create_cursor (Tcross)
		end;


feature -- Watch Cursor

	Watch_cursor: SCREEN_CURSOR is
			-- Watch cursor
		once
			Result := create_cursor (Watch)
		end;

feature {NONE} 

	create_cursor (cursor_type: INTEGER): SCREEN_CURSOR is
			-- Create a cursor with `cursor_type' shape
		do
			!! Result.make;
			Result.set_type (cursor_type);
		end;

	cursor_file_content (fn: STRING): SCREEN_CURSOR is
		local
			p: PIXMAP;
			full_name: STRING
		do
			full_name := clone (Environment.bitmaps_directory);
			full_name.extend (Environment.directory_separator);
			full_name.append (fn);
			!! p.make;
			p.read_from_file (full_name);
			!! Result.make;
			if p.is_valid then
				Result.set_pixmap (p, p);
			else
				io.error.putstring ("EiffelBuild: Can not read bitmap file%N");
				io.error.putstring (full_name);
				io.error.putstring (".%N");
			end;
		end

end
