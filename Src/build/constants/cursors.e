

class CURSORS

inherit

	UNIX_ENV
		export
			{NONE} all
		end



	
feature {NONE}

	Application_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("application.curs")
		end;

	Transition_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("transition.curs")
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

	State_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("state.curs")
		end;

	Type_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("type.curs")
		end;

	Label_cursor: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("label.curs")
		end;

	cursor_file_content (fn: STRING): SCREEN_CURSOR is
		local
			temp: PIXMAP;
            full_path: STRING
		do
            full_path := Bitmaps_directory;
            full_path.append ("/");
            full_path.append (fn);
			!!Result.make;
			!!temp.make;
			temp.read_from_file (full_path);
			Result.set_pixmap (temp, temp);
		end

end
