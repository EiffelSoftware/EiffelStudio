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
			create_structured_text as clickable_context_text
		redefine
			dark_symbol, tool, format, display_temp_header,
			post_fix
		end;
	SHARED_FORMAT_TABLES

creation

	make
	
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
 
	tool: CLASS_W;
			-- Tool of edited class

feature -- Formatting

	format (stone: CLASSC_STONE) is
			-- Show special format of `stone' in class text `text_window',
			-- if it's clickable; do nothing otherwise.
		local
			cur: CURSOR;
			root_stone: CLASSC_STONE;
			retried: BOOLEAN;
			mp: MOUSE_PTR
		do
			if not retried then
				root_stone ?= tool.stone;
				if
					do_format or else filtered or else
					(tool.last_format.associated_command /= Current or
					not stone.same_as (root_stone))
				then
					if stone /= Void and then stone.is_valid then
						if stone.clickable then
							display_temp_header (stone);
							!! mp.set_watch_cursor;
							text_window.clear_window;
							tool.set_read_only_text;
							tool.set_file_name (file_name (stone));
							display_info (stone);
							if 
								tool.last_format = 
									tool.showtext_frmt_holder
							then
								cur := text_window.cursor;
							end;
							tool.show_read_only_text;
							text_window.display;
							if cur /= Void then
								text_window.go_to (cur)
							end;
							tool.set_stone (stone);
							tool.set_last_format (holder);
							filtered := false;
							display_header (stone);
							mp.restore
						else
							tool.showtext_frmt_holder.execute (stone)
						end
					end
				end
			else
				warner (popup_parent).gotcha_call (w_Cannot_retrieve_info);
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

	name: STRING is
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

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			if tool.last_format.associated_command = Current then
				tool.set_title ("Producing clickable format...")
			else
				tool.set_title ("Switching to clickable format...")
			end
		end;

end -- class SHOW_CLICK_CL
