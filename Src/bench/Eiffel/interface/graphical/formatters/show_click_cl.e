indexing

	description:	
		"Command to make all elements in a class clickable %
			%and to display the result in the class text.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_CLICK_CL

inherit

	FILTERABLE
		rename
			filter_context_text as clickable_context_text
		redefine
			dark_symbol, text_window, format, display_temp_header,
			post_fix
		end;
	SHARED_FORMAT_TABLES

creation

	make
	
feature -- Initialization

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
			-- Initialize the command.
		do
			init (c, a_text_window)
		end;

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Clickable 
		end;
 
	dark_symbol: PIXMAP is 
			-- Dark version of `symbol'.
		once 
			Result := bm_Dark_clickable
		end;
 
	text_window: CLASS_TEXT;
			-- Text of offended class.

feature -- Formatting

	format (stone: CLASSC_STONE) is
			-- Show special format of `stone' in class text `text_window',
			-- if it's clickable; do nothing otherwise.
		local
			last_cursor_position, last_top_position: INTEGER;
			position_saved: BOOLEAN;
			root_stone: CLASSC_STONE;
			retried: BOOLEAN;
			tool: BAR_AND_TEXT
		do
			if not retried then
				root_stone ?= text_window.root_stone;
				if
					do_format or else filtered or else
					(text_window.last_format /= Current or
					not equal (stone, root_stone))
				then
					if stone /= Void and then stone.is_valid then
						if stone.clickable then
							display_temp_header (stone);
							set_global_cursor (watch_cursor);
							text_window.clean;
							text_window.set_file_name (file_name (stone));
							display_info (stone);
							if 
								text_window.last_format = 
									text_window.tool.showtext_command
							then
								last_cursor_position := text_window.cursor_position;
								last_top_position := text_window.top_character_position;
								position_saved := true
							end;
							text_window.set_editable;
							text_window.show_image;
							text_window.set_read_only;
							if position_saved then
								if last_cursor_position > text_window.size then
									last_cursor_position := text_window.size
								end;
								if last_top_position > text_window.size then
									last_top_position := text_window.size
								end;
								text_window.set_cursor_position (last_cursor_position);
								text_window.set_top_character_position (last_top_position)
							end;
							text_window.set_root_stone (stone);
							text_window.set_last_format (Current);
							filtered := false;
							display_header (stone);
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
			if original_exception = Io_exception then
					-- We probably don't have the read permissions
					-- on the server files.
				retried := true;
				retry
			end
		end;

feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := l_Showclick
		end;

	title_part: STRING is
		do
			Result := l_Click_form_of
		end;

	post_fix: STRING is "clk";

feature {NONE} -- Implementation

	display_info (c: CLASSC_STONE) is
			-- Display flat|short form of `c'.
		do
			text_window.process_text (clickable_context_text (c));	
		end

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			if text_window.last_format = Current then
				text_window.display_header ("Producing clickable format...")
			else
				text_window.display_header ("Switching to clickable format...")
			end
		end;

end -- class SHOW_CLICK_CL
