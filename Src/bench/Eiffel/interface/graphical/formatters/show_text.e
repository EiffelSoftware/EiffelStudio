-- Command to display text
-- No warning or watch cursor

class SHOW_TEXT 

inherit

	FORMATTER
		redefine
			format, display_header,
			file_name
		end

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
	
feature {NONE}

	display_header (stone: STONE) is
		local
			new_title: STRING;
			filed_stone: FILED_STONE;
		do
			!!new_title.make (0);
			new_title.append (stone.header);
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
			stone_text: STRING;
		do
			if stone /= Void then
				stone_text := stone.origin_text;
				if stone_text /= Void then
					text_window.clean;
					display_header (stone);
					text_window.set_root_stone (stone);
					text_window.put_string (stone_text);
					if stone.clickable then
						click_list := stone.click_list;
						if (click_list /= Void) then
							text_window.share (click_list)
						end
					end;
					text_window.set_editable;
					text_window.show_image;
					text_window.set_mode_for_editing;
					text_window.set_last_format (Current);
				end
			end
		end;

	click_list: ARRAY [CLICK_STONE]

	
feature {NONE}

	title_part: STRING is do Result := "" end;
	display_info (i: INTEGER; d: STONE) is do end
			-- Useless here

end
