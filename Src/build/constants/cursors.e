

class CURSORS

inherit

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

feature {NONE} -- Read from file

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
