-- Formatters to which a filter is applicable

deferred class FILTERABLE

inherit

	FORMATTER
		redefine
			filter
		end

feature

	filter (filtername: STRING) is
			-- Filter the `Current' format with `filtername'.
		local
			new_text: STRING;
			root_stone: STONE
		do
			root_stone := text_window.root_stone;
			if root_stone /= Void then
				set_global_cursor (watch_cursor);
				new_text := filtered_text (root_stone, filtername);
				if new_text /= Void then
					text_window.clear_text;
					text_window.set_text (new_text);
					text_window.set_changed (false);
					display_filter_header (root_stone, filtername);
					text_window.set_file_name (filtered_file_name (root_stone, filtername))
					text_window.set_editable;
					filter_name := clone (filtername);
					filtered := true
				end;
				restore_cursors
			end
		end;

	filtered_text (stone: STONE; filtername: STRING): STRING is
			-- Output of `filtername' applied to `stone'
			-- (Void if the filter is not readable)
		require
			stone_not_void: stone /= Void;
			filtername_not_void: filtername /= Void
		local
			full_pathname: FILE_NAME;
			fname: STRING;
			filter_file: PLAIN_TEXT_FILE;
			context: FORMAT_CONTEXT;
			text_filter: TEXT_FILTER
		do
			!!full_pathname.make_from_string (filter_path);
			fname := clone (filtername);
			fname.append (".fil");
			full_pathname.set_file_name (fname);
			!!filter_file.make (full_pathname.path);
			if filter_file.exists and then filter_file.is_readable then
				!!text_filter.make_from_filename (full_pathname.path);
				file_suffix := text_filter.file_suffix;
				context := filter_context (stone);
				text_filter.process_text (context.text);
				Result := text_filter.image
			else
				warner (text_window).gotcha_call 
					(w_Cannot_read_filter (full_pathname.path))
			end
		end;

	filtered_file_name (stone: STONE; filtername: STRING): STRING is
			-- Name of the file where the filtered output text will be stored
			-- (classname.file_suffix or classname.filtername)
		require
			stone_not_void: stone /= Void;
			filtername_not_void: filtername /= Void
		local
			filed_stone: FILED_STONE
		do
			filed_stone ?= stone;
			!!Result.make (0);
			if filed_stone /= Void then
				Result.append (filed_stone.file_name);
					--| remove "e"
				Result.remove (Result.count)
			end;
			if file_suffix /= Void then
				Result.append (file_suffix)
			else
				Result.append (filtername)
			end
		end;

	temp_filtered_file_name (stone: STONE; filtername: STRING): STRING is
			-- Name of the file where the filtered output text will be temporary			-- stored (classname.file_suffix or classname.filtername)
		require
			stone_not_void: stone /= Void;
			filtername_not_void: filtername /= Void
		local
			fname: FILE_NAME;
			class_stone: CLASSC_STONE
		do
			!!fname.make_from_string (tmp_directory);
			class_stone ?= stone;
			!! Result.make (0);
			if class_stone /= Void then
				Result.append (class_stone.class_c.class_name);
			end;
			Result.extend ('.');
			if file_suffix /= Void then
				Result.append (file_suffix)
			else
				Result.append (filtername)
			end;
			fname.set_file_name (Result);
			Result := fname.path
		end;

	filter_name: STRING;
			-- Name of the last filter applied

	file_suffix: STRING;
			-- Suffix of the file name where the filtered output text is stored;
			-- Void if it has not been specified in the filter specification

feature {NONE}

	filter_context (stone: STONE): FORMAT_CONTEXT is
		require
			not_stone_void: stone /= Void
		deferred
		end;

	display_filter_header (stone: STONE; filtername: STRING) is
			-- Show header.
		require
			stone_not_void: stone /= Void;
			filtername_not_void: filtername /= Void
		local
			new_title: STRING
		do
			!!new_title.make (50);
			new_title.append (title_part);
			new_title.append (stone.signature);
			new_title.append (" (");
			new_title.append (filtername);
			new_title.append (" format)");
			text_window.display_header (new_title)
		end;

end -- class FILTERABLE
