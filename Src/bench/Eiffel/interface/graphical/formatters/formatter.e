indexing

	description:	
		"Abstract notion of a formatter.";
	date: "$Date$";
	revision: "$Revision$"

deferred class FORMATTER

inherit

	TWO_STATE_CMD
		rename
			true_state_symbol as symbol,
			false_state_symbol as dark_symbol,
			work as format
		undefine
			dark_symbol
		redefine
			execute, holder
		end;
	SHARED_BENCH_RESOURCES;
	WARNER_CALLBACKS
		rename
			execute_warner_ok as loose_changes
		end

feature -- Properties

	formatted: STONE;


	do_format: BOOLEAN;
			-- Will we call `format' without checking if this is 
			-- really necessary (i.e. the format and the stone
			-- haven't changed since last call)?

feature -- Callbacks

	execute_warner_help is
		do
		end;

	loose_changes (argument: ANY) is
			-- If it comes here this means ok has
			-- been pressed in the warner window
			-- for file modification (only showtext
			-- command can modify text)
		local
			old_do_format: BOOLEAN;
			mp: MOUSE_PTR
		do
			!! mp.set_watch_cursor;
			text_window.set_changed (false);
				-- Because the text in the window has been changed,
				-- we have to force the new format in order to update
				-- the window as it was before the modifications.
			old_do_format := do_format;
			do_format := true;
			execute_licenced (formatted);
			do_format := old_do_format;
			tool.history.extend (tool.stone);
			mp.restore
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Execute current command but don't change the cursor into watch shape.
		local
			mp: MOUSE_PTR;
			f: FOCUSABLE
		do
			if is_sensitive then
				if holder /= Void then
					f ?= holder.associated_button
				end;
				if f /= Void then
					f.popdown
				end;

				if last_warner /= Void then
					last_warner.popdown
				end;

				if argument = tool then
					formatted ?= tool.stone
				else
					formatted ?= argument
				end;
				if not text_window.changed then
					execute_licenced (formatted)
				else
					warner (popup_parent).call (Current, l_File_changed)
				end
			end
		end;

feature -- Setting

	set_do_format (b: BOOLEAN) is
			-- Assign `b' to `do_format'.
		do
			do_format := b
		end;

feature -- Formatting

	format (stone: STONE) is
			-- Show special format of `stone' in class text `text_window',
			-- if it's clickable; do nothing otherwise.
		local
			retried: BOOLEAN;
			bar_and_text_tool: BAR_AND_TEXT;
			mp: MOUSE_PTR
		do
			if not retried then 
				if 
					do_format or else filtered or else
					(tool.last_format.associated_command /= Current or
					(stone /= Void and then not stone.same_as (tool.stone)))
				then
					if stone /= Void and then stone.is_valid then
						if stone.clickable then
							display_temp_header (stone);
							!! mp.set_watch_cursor;
							text_window.clear_window;
							tool.set_read_only_text;
							tool.set_stone (stone);
							tool.set_file_name (file_name (stone));
							display_info (stone);
							tool.show_read_only_text;
							text_window.display;
							tool.set_last_format (holder);
							filtered := false;
							display_header (stone);
							mp.restore
						else
							bar_and_text_tool ?= tool;
							if bar_and_text_tool /= Void then
								bar_and_text_tool.showtext_frmt_holder.execute (stone)
							end
						end
					end
				end
			else
				warner (popup_parent).gotcha_call (w_Cannot_retrieve_info);
				mp.restore;
			end
		rescue
			if not resources.get_boolean (r_Fail_on_rescue, False) then
				if original_exception = Io_exception then
						-- We probably don't have the read permissions
						-- on the server files.
					retried := true;
					retry
				end
			end
		end;

feature -- Filters; Properties

	filtered: BOOLEAN;
			-- Has the last action of `current' been a filter action?
			-- (In other words, do we need to reformat the target)

feature -- Filters; Implementation

	filter (filtername: STRING) is
			-- Filter the `Current' format with `filtername'.
		require
			filtername_not_void: filtername /= Void;
			current_format: tool.last_format.associated_command = Current
		do
			if tool.stone /= Void then
				warner (popup_parent).gotcha_call (w_Not_a_filterable_format)
			end
		end;

feature {NONE} -- Properties

	holder: FORMAT_HOLDER
			-- Holds the format holder in which
			-- Current is a property.

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
				--| Maximum length is 3. (Portability)
			Result := Result.substring (6, Result.count.min (9))
		ensure
			Result_not_void: Result /= Void;
			valid_extension: Result.count <= 3
		end;

	title_part: STRING is
		deferred
		end;

	file_name (stone: STONE): STRING is
		local
			filed_stone: FILED_STONE;
			fname: FILE_NAME;
			i: INTEGER
		do
			filed_stone ?= stone;
			if filed_stone /= Void then
				Result := clone (filed_stone.file_name);
					--| remove the extension
				from
					i := Result.count
				until
					i = 0 or else Result.item (i) = '.'
				loop
					i := i - 1
				end;
				if i /= 0 and i >= Result.count - 3 then
					Result.head (i - 1)
				end;

				!!fname.make_from_string (Result);
				fname.add_extension (post_fix);
				Result := fname
			else
				!!Result.make (0)
			end;
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

feature {ROUTINE_W} -- Implementation

	display_header (stone: STONE) is
			-- Show header for 'stone'.
		local
			new_title: STRING
		do
			!!new_title.make (50);
			new_title.append (title_part);
			new_title.append (stone.signature);
			tool.set_title (new_title)
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		local
			new_title: STRING
		do
			!!new_title.make (50);
			new_title.append (title_part);
			new_title.append (stone.signature);
			new_title.append (" ...");
			tool.set_title (new_title)
		end;

	display_info (s: STONE) is
			-- Display special format of for stone `s'.
		deferred
		end;

end -- class FORMATTER
