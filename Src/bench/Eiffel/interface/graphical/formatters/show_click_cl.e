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
			tool, format, display_temp_header,
			post_fix
		end;
	SHARED_FORMAT_TABLES

creation

	make
	
feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Clickable 
		end;
 
	tool: CLASS_W;
			-- Tool of edited class

feature -- Formatting

	format (stone: STONE) is
			-- Show special format of `stone' in class text `text_window',
			-- if it's clickable; do nothing otherwise.
		local
			cur: CURSOR;
			root_stone: CLASSC_STONE;
			retried: BOOLEAN;
			mp: MOUSE_PTR
			same_stone: BOOLEAN
			c_stone: CLASSC_STONE
		do
			if not retried then
				c_stone ?= stone
				if c_stone /= Void then
					root_stone ?= tool.stone;
					same_stone := root_stone /= Void and then c_stone.same_as (root_stone)
					if
						do_format or else filtered or else
						(tool.last_format.associated_command /= Current or
						not same_stone)
					then
						if c_stone.is_valid then
							tool.close_search_window;
							if c_stone.clickable then
								display_temp_header (c_stone);
								!! mp.set_watch_cursor;
								cur := text_window.cursor;
								text_window.clear_window;
								tool.set_read_only_text;
								tool.set_file_name (file_name (c_stone));
								display_info (c_stone);
								if cur /= Void and then same_stone then
									text_window.go_to (cur)
								else
									text_window.set_top_character_position (0)
								end;
								tool.show_read_only_text;
								text_window.display;
								tool.set_stone (c_stone);
								tool.set_last_format (holder);
								filtered := false;
								display_header (c_stone);
								mp.restore
							else
								holder.set_selected (False);
								tool.showtext_frmt_holder.execute (c_stone)
							end
						else
							holder.set_selected (False);
						end
					end
				else
					holder.set_selected (False);
					tool.showtext_frmt_holder.execute (stone)
				end
			else
				if mp /= Void then
					mp.restore
				end;
				warner (popup_parent).gotcha_call (Warning_messages.w_Cannot_retrieve_info);
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
			Result := Interface_names.f_Showclick
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showclick
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_Click_form_of
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
