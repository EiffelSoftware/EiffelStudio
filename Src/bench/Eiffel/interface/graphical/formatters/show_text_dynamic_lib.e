indexing
	description:	"Command to display text. No warning or watch cursor.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_TEXT_DYNAMIC_LIB

inherit
	FORMATTER
		rename
			init as make,
			class_name as exception_class_name
		redefine
			tool, 
			format, display_header, file_name, display_temp_header
		end

	SHARED_APPLICATION_EXECUTION

	SHARED_FORMAT_TABLES

creation

	make

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Showtext 
		end;

	tool: DYNAMIC_LIB_W
	
feature {ROUTINE_WIN_MGR} -- Displaying

	display_header (stone: STONE) is
		local
			new_title: STRING;
			fs: FEATURE_STONE;
		do
			!!new_title.make (0);
			new_title.append (stone.header);
			fs ?= stone;
			if
				(fs /= Void) and then
				Application.has_breakpoint_set (fs.e_feature) 
			then
				new_title.append ("   (stop)");		
			end;
			tool.set_title (new_title);
		end;

feature -- Formatting

	format (stone: STONE) is
			-- Show text of `stone' in `text_window'
		local
			retried: BOOLEAN;
			mp: MOUSE_PTR;
			cur: CURSOR;
		do
			if not retried then
				!! mp.set_watch_cursor;
				cur := text_window.cursor;
				
				display_temp_header (stone);

				if cur /= Void then
					text_window.go_to (cur)
				end;
				tool.set_clickable(False)
				tool.display_clickable_dynamic_lib_exports(False)
				tool.set_last_format (holder);
				display_header (stone);
				mp.restore
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

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			if tool.last_format.associated_command = Current then
				tool.set_title ("Producing text format...")
			else
				tool.set_title ("Switching to text format...")
			end
		end;

	display_info (d: STONE) is do end
			-- Useless here

feature {NONE} -- Properties

	file_name (s: FILED_STONE): STRING is
		do
			Result := s.file_name
		end;

	name: STRING is
		do
			Result := Interface_names.f_Showtext
		end;

	title_part: STRING is
		do
			Result := ""
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showtext
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
--			Result := Interface_names.a_Showtext
		end

end -- SHOW_TEXT
