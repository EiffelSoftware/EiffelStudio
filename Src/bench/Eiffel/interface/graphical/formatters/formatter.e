deferred class FORMATTER 

inherit

	ICONED_COMMAND
		rename
			work as format
		redefine
			execute
		end;
	SHARED_WORKBENCH;
	
feature 

	formatted: STONE;

	execute (argument: ANY) is
			-- Execute current command but don't change the cursor into watch shape.
		do
			if argument = get_in then
				text_window.tool.tell_type (command_name)
			elseif argument = get_out then
				text_window.tool.clean_type
			elseif argument = warner then
					--| If it comes here this means ok has
					--| been pressed in the warner window
					--| for file modification (only showtext
					--| command can modify text)
				set_global_cursor (watch_cursor);
				formatted := text_window.root_stone;
				if formatted /= Void then
						--| Last format has to be
						--| show text command.
					text_window.last_format.format (formatted);
				end
				--execute_licenced (formatted);
				restore_cursors;
			elseif not text_window.changed then
				if argument = text_window then
					formatted ?= text_window.root_stone
				else
					formatted ?= argument
				end;
				set_global_cursor (watch_cursor);
				execute_licenced (formatted);
				restore_cursors;
			else
				warner.call (Current, l_File_changed)
			end
		end;

feature 

	format (stone: STONE) is
			-- Show special format of `stone' in class text `text_window',
			-- if it's clickable; do nothing otherwise.
		do
			if stone /= Void and then stone.clickable then
				set_global_cursor (watch_cursor);
				text_window.clean;
				display_header (stone);
				display_info (0, stone);
				text_window.set_editable;
				text_window.show_image;
				text_window.set_read_only;
				text_window.set_root_stone (stone);
				text_window.set_last_format (Current);
				restore_cursors
			end
		end;

	
feature {NONE}

	post_fix: STRING is
			-- Postfix name of current format which generated
			-- from the dynamic value of object (minus the show_)
			-- so it is very important to name the format as
			-- SHOW_<type of format>
		do
			!!Result.make(0);
			Result.append (generator);
			Result.to_lower;
				--| remove the SHOW_
			Result := Result.substring (6, Result.count);
		end;

	title_part: STRING is deferred end;

	display_header (stone: STONE) is
			-- Show header for 'stone'.
		local
			new_title: STRING
		do
			!!new_title.make (50);
			new_title.append (title_part);
			new_title.append (stone.signature);
			text_window.display_header (new_title);
			text_window.set_file_name (file_name (stone));
		end;

	file_name (stone: STONE): STRING is
		local
			filed_stone: FILED_STONE
		do
			filed_stone ?= stone;
			!!Result.make (0);
			if filed_stone /= Void then
				Result.append (filed_stone.file_name);
					--| remove "e"
				Result.remove (Result.count);	
				Result.append (post_fix);
			end;
		end;

	display_info (i: INTEGER; d: STONE) is
			-- Display special format of `d' eventually in tree form (with 'i' tabulations).
		deferred
		end;

	tabs (i: INTEGER): STRING is
			-- String of `i' tabs, each tab is `indent' blank characters
		local
			j: INTEGER
		do
			from
				!!Result.make (i*indent);
				j := i*indent
			until
				j = 0
			loop
				Result.append_character (' ');
				j := j - 1
			end
		end;

	indent: INTEGER
			-- Number of blank characters in a tab

end
