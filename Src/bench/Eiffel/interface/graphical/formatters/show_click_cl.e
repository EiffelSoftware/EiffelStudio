-- Command to make all elements in a class clickable and to
-- display the result in the class text.

class SHOW_CLICK_CL

inherit

	FORMATTER
		redefine
			dark_symbol, text_window, format
		end;
	SHARED_FORMAT_TABLES

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Clickable 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_clickable
		end;
 
	text_window: CLASS_TEXT;

	format (stone: CLASSC_STONE) is
			-- Show special format of `stone' in class text `text_window',
			-- if it's clickable; do nothing otherwise.
		local
			last_cursor_position: INTEGER;
			root_stone: CLASSC_STONE
		do
			root_stone ?= text_window.root_stone;
			if
				do_format or else
				(text_window.last_format /= Current or
				not equal (stone, root_stone))
			then
				if
					stone /= Void and then
					(stone.is_valid and stone.clickable)
				then
					set_global_cursor (watch_cursor);
					text_window.clean;
					display_header (stone);
					display_info (0, stone);
					if 
						text_window.last_format = text_window.tool.showtext_command
					then
						last_cursor_position := text_window.cursor_position
					end;
					text_window.set_editable;
					text_window.show_image;
					text_window.set_read_only;
					if last_cursor_position <= text_window.size then
						text_window.set_cursor_position (last_cursor_position)
					elseif last_cursor_position /= 0 then
						text_window.set_cursor_position (text_window.size)
					end;
					text_window.set_root_stone (stone);
					text_window.set_last_format (Current);
				   restore_cursors
				end
			end
		end;

feature {NONE}

	command_name: STRING is do Result := l_Showclick end;

	title_part: STRING is do Result := l_Click_form_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display flat|short form of `c'.
		do
			text_window.process_text (clickable_context (c).text);	
		end

end
