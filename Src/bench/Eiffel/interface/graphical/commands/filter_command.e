class FILTER_COMMAND 

inherit

	ICONED_COMMAND
		redefine
			text_window
		end;
	SHARED_FORMAT_TABLES

creation

	make
	
feature 

	filter_window: FILTER_W;

	filter_name: STRING;

	text_window: CLASS_TEXT;

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			!!filter_window.make (c, Current);
			init (c, a_text_window);
			add_button_click_action (3, Current, Void);
			filter_name := "troff"
		end;

feature {NONE}

	work (argument: ANY) is
			-- If left mouse button was pressed -> execute filter.
			-- If right mouse button was pressed -> bring up filter window. 
		local
			text_filter: TEXT_FILTER;
			full_pathname: STRING;
			filter_file: PLAIN_TEXT_FILE;
			last_format: FORMATTER;
			format_context: FORMAT_CONTEXT;
			stone: CLASSC_STONE;
			tool: CLASS_W;
			new_title, message: STRING
		do
			if argument = Void then
					-- 3rd button pressed
				filter_window.call 
			elseif text_window.root_stone /= Void then
				last_format := text_window.last_format;
				tool :=  text_window.tool;
				if 
					last_format = tool.showclick_command or
					last_format = tool.showflat_command or
					last_format = tool.showshort_command or
					last_format = tool.showflatshort_command
				then	
					stone ?= text_window.root_stone;
					if stone /= Void then
						full_pathname := clone (Eiffel3_dir_name);
						full_pathname.extend (Directory_separator);
						full_pathname.append ("bench");
						full_pathname.extend (Directory_separator);
						full_pathname.append ("help");
						full_pathname.extend (Directory_separator);
						full_pathname.append ("filters");
						full_pathname.extend (Directory_separator);
						full_pathname.append (filter_name);
						full_pathname.append (".fil");
						!!filter_file.make (full_pathname);
						if 
							filter_file.exists and then 
							filter_file.is_readable 
						then
							!!text_filter.make_from_filename (full_pathname);
							if last_format = tool.showclick_command then
								format_context := clickable_context (stone)
							elseif last_format = tool.showflat_command then
								format_context := flat_context (stone)
							elseif last_format = tool.showshort_command then
								format_context := short_context (stone)
							elseif last_format = tool.showflatshort_command then
								format_context := flatshort_context (stone)
							end;
							text_filter.process_text (format_context.text);
							!!new_title.make (50);
							new_title.append (last_format.title_part);
							new_title.append (stone.signature);
							new_title.append (" (");
							new_title.append (filter_name);
							new_title.append (" format)");
							text_window.display_header (new_title);
							text_window.clear_clickable;
							text_window.set_text (text_filter.image);
							text_window.set_changed (false);
							text_window.set_editable
						else
							!!message.make (50);
							message.append ("Cannot read filter ");
							message.append (full_pathname);
							warner.set_window (text_window);
							warner.gotcha_call (message)
						end
					else
						!!message.make (50);
						message.append ("Class is not compiled");
						warner.set_window (text_window);
						warner.gotcha_call (message)
					end
				else
					!!message.make (50);
					message.append ("Only clickable, flat, short and flat-short forms may be filtered");
					warner.set_window (text_window);
					warner.gotcha_call (message)
				end
			end
		end;
	
feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Filter 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Filter end;

end -- class FILTER_COMMAND
