-- Command to display text
-- No warning or watch cursor

class SHOW_TEXT 

inherit

	FORMATTER
		redefine
			display_header,
			format
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
			!!Result.make; 
			Result.read_from_file (bm_Showtext) 
		end;
	
feature {NONE}

	command_name: STRING is do Result := l_Showtext end;

feature 

	format (stone: STONE) is
			-- Show text of `stone' in `text_window'
		local
			stone_text: STRING
		do
			if stone /= Void then
				stone_text := stone.origin_text;
				if stone_text /= Void then
					text_window.clean;
					display_header (stone);
					text_window.put_string (stone_text);
					if stone.clickable then
						text_window.share (stone.click_list)
					end;
					text_window.set_editable;
					text_window.show_image;
					text_window.set_root_stone (stone);
					text_window.set_last_format (Current)
				end
			end
		end;

	
feature {NONE}

	display_header (stone: STONE) is
			-- Show header for 'stone': file name for a filed dragable,
			-- signature otherwise.
		local
			filed_stone: FILED_STONE
		do
			filed_stone ?= stone;
			if filed_stone /= Void then
				text_window.set_file_name (filed_stone.file_name)
			else
				text_window.set_file_name (stone.signature)
			end
		end;

	title_part: STRING is do Result := "" end;
	display_info (i: INTEGER; d: STONE) is do end
			-- Useless here

end
