deferred class FORMATTER 

inherit

	ICONED_COMMAND
		rename
			work as format
		redefine
			execute
		end;
	SHARED_WORKBENCH;
	SHARED_RESCUE_STATUS
	
feature 

	formatted: STONE;

	execute (argument: ANY) is
			-- Execute current command but don't change the cursor into watch shape.
		do
			if 
				(argument /= get_in) and
				(argument /= get_out)
			then
				if last_warner /= Void then
					last_warner.popdown
				end
			end;

			if argument = get_in then
				text_window.tool.tell_type (command_name)
			elseif argument = get_out then
				text_window.tool.clean_type
			elseif license_problem then
				license_problem := False;
				if (argument = Void) then
					license_window.set_exclusive_grab;
					license_window.popup
				end
			elseif last_warner /= Void and argument = last_warner then
					--| If it comes here this means ok has
					--| been pressed in the warner window
					--| for file modification (only showtext
					--| command can modify text)
				set_global_cursor (watch_cursor);
				text_window.set_changed (false);
				execute_licenced (formatted);
				text_window.history.extend (text_window.root_stone);
				restore_cursors
			else
				if argument = text_window then
					formatted ?= text_window.root_stone
				else
					formatted ?= argument
				end;
				if not text_window.changed then
					set_global_cursor (watch_cursor);
					execute_licenced (formatted);
					restore_cursors;
				else
					warner (text_window).call (Current, l_File_changed)
				end
			end
		end;

feature 

	do_format: BOOLEAN;
			-- Will we call `format' without checking if this is really
			-- necessary (i.e. the format and the stone haven't changed
			-- since last call)?

	set_do_format (b: BOOLEAN) is
			-- Assign `b' to `do_format'.
		do
			do_format := b
		end;

	format (stone: STONE) is
			-- Show special format of `stone' in class text `text_window',
			-- if it's clickable; do nothing otherwise.
		local
			retried: BOOLEAN;
			tool: BAR_AND_TEXT
		do
			if not retried then 
				if 
					do_format or else filtered or else
					(text_window.last_format /= Current or
					not equal (stone, text_window.root_stone))
				then
					if stone /= Void and then stone.is_valid then
						if stone.clickable then
							set_global_cursor (watch_cursor);
							text_window.clean;
							text_window.set_root_stone (stone);
							display_header (stone);
							display_info (0, stone);
							text_window.set_editable;
							text_window.show_image;
							text_window.set_read_only;
							text_window.set_last_format (Current);
							filtered := false;
							restore_cursors
						else
							tool ?= text_window.tool;
							if tool /= Void then
								tool.showtext_command.execute (stone)
							end
						end
					end
				end
			else
				warner (text_window).gotcha_call (w_Cannot_retrieve_info);
				restore_cursors
			end
		rescue
			if not Rescue_status.fail_on_rescue then
				retried := true;
				retry
			end
		end;

feature -- Filters

	filtered: BOOLEAN;
			-- Has the last action of `current' been a filter action?
			-- (In other words, do we need to reformat the target)

	filter (filtername: STRING) is
			-- Filter the `Current' format with `filtername'.
		require
			filtername_not_void: filtername /= Void;
			current_format: text_window.last_format = Current
		do
			if text_window.root_stone /= Void then
				warner (text_window).gotcha_call (w_Not_a_filterable_format)
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
				Result.extend (' ');
				j := j - 1
			end
		end;

	indent: INTEGER
			-- Number of blank characters in a tab

end
