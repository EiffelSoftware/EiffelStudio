-- Command to display text
-- No warning or watch cursor

class SHOW_TEXT 

inherit

	FORMATTER
		rename
			display_header as format_display_header
		redefine
			format, file_name, dark_symbol
		end;
	FORMATTER
		redefine
			format, display_header, file_name, dark_symbol
		select
			display_header
		end;
	SHARED_DEBUG

creation

	make

feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Showtext 
		end;
	
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showtext
		end;
	
feature {NONE}

	display_header (stone: STONE) is
		local
			new_title: STRING;
			filed_stone: FILED_STONE;
			fs: FEATURE_STONE;
		do
			!!new_title.make (0);
			new_title.append (stone.header);
			fs ?= stone;
			if
				(fs /= Void) and then
				Debug_info.is_breakpoint_set (fs.feature_i, 1) 
			then
				new_title.append ("   (stop)");		
			end;
			text_window.display_header (new_title);
			filed_stone ?= stone;
			if filed_stone /= Void then
				text_window.set_file_name (file_name (filed_stone));
			end;
		end;

	file_name (s: FILED_STONE): STRING is
		do
			Result := s.file_name
		end;

	command_name: STRING is do Result := l_Showtext end;

feature 

	format (stone: STONE) is
			-- Show text of `stone' in `text_window'
		local
			stone_text, temp, class_name: STRING;
			filed_stone: FILED_STONE;
			classc_stone: CLASSC_STONE;
			class_text: CLASS_TEXT;
			modified_class: BOOLEAN;
			last_cursor_position: INTEGER
		do
			classc_stone ?= stone;
			if 
				classc_stone /= Void and then classc_stone.is_valid and then
				classc_stone.class_c.lace_class.date_has_changed 
			then
				modified_class := true
			end;
			if
				do_format or modified_class or else
				(text_window.last_format /= Current or
				not equal (stone, text_window.root_stone))
			then
				if
					stone /= Void and then stone.is_valid
				then
					stone_text := stone.origin_text;
					if stone_text = Void then
						stone_text := "";
						filed_stone ?= stone;
						if filed_stone /= Void then
							!! temp.make (0);
							if filed_stone.file_name /= Void then
								temp.append ("File: ");
								temp.append (filed_stone.file_name);	
								temp.append (" cannot be read");
							else
								temp.append ("There is no associated file for pebble dropped");
							end;
							warner.set_window (text_window);
							warner.gotcha_call (temp);
						end			
					end;
					text_window.clean;
					display_header (stone);
					text_window.set_root_stone (stone);
					text_window.put_string (stone_text);
					if stone.clickable then
						if modified_class then
							!!temp.make (50);
							temp.append ("Class ");
							class_name := clone (classc_stone.class_c.class_name);
							class_name.to_upper;
							temp.append (class_name);
							temp.append (" has been modified since last compilation.%NThe text will not be clickable.");
							warner.set_window (text_window);
							warner.gotcha_call (temp)
						else
							click_list := stone.click_list;
							if (click_list /= Void) then
								text_window.share (click_list)
							end
						end
					end;
					class_text ?= text_window;
					if 
						class_text /= Void and then 
						class_text.last_format = class_text.tool.showclick_command
					then
						last_cursor_position := class_text.cursor_position
					end;
					text_window.set_editable;
					text_window.show_image;
					text_window.set_mode_for_editing;
					if last_cursor_position <= text_window.size then
						text_window.set_cursor_position (last_cursor_position)
					elseif last_cursor_position /= 0 then
						text_window.set_cursor_position (text_window.size)
					end;
					text_window.set_last_format (Current)
				end
			end
		end;

	click_list: ARRAY [CLICK_STONE]

	
feature {NONE}

	title_part: STRING is do Result := "" end;
	display_info (i: INTEGER; d: STONE) is do end
			-- Useless here

end
