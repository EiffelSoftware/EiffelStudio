indexing
	description: "Command to display text. No warning or watch cursor."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DYNAMIC_TEXT_FORMATTER

inherit
	EB_FORMATTER
		redefine
			tool, 
			format, display_header, file_name, display_temp_header
		end

	EXCEPTIONS
		rename
			class_name as exception_class_name
		end
		-- added here (was before inherited from SHARED_LICENCE)

	SHARED_APPLICATION_EXECUTION

	EB_SHARED_FORMAT_TABLES

creation

	make

feature -- Properties

	symbol: EV_PIXMAP is 
		once 
			Result := Pixmaps.bm_Showtext 
		end

	tool: EB_DYNAMIC_LIB_TOOL
	
feature {FEATURE_TOOL_LIST} -- Displaying

	display_header (stone: STONE) is
		local
			new_title: STRING
			fs: FEATURE_STONE
		do
			create new_title.make (0)
			new_title.append (stone.header)
			fs ?= stone
			if
				(fs /= Void) and then
				Application.has_breakpoint_set (fs.e_feature) 
			then
				new_title.append ("   (stop)")		
			end
			tool.set_title (new_title)
		end

feature -- Formatting

	format is
			-- Show text of tool stone in `text_area'
		local
			retried: BOOLEAN
--			mp: MOUSE_PTR
--			cur: CURSOR
			cur: INTEGER
--			st: STRUCTURED_TEXT
			wd: EV_WARNING_DIALOG
		do
			if not retried then
--				create mp.set_watch_cursor
				cur := tool.text_area.position
				
				display_temp_header (tool.stone)

--				if cur /= Void then
					tool.text_area.go_to (cur)
--				end
				tool.set_clickable (False)
				tool.display_clickable_dynamic_lib_exports (False)
				tool.set_last_format (Current)
				display_header (tool.stone)
--				mp.restore
			else
--				if mp /= Void then
--					mp.restore
--				end
				create wd.make_with_text (Warning_messages.w_Cannot_retrieve_info)
				wd.show_modal
			end
		rescue
			if original_exception = Io_exception then
					-- We probably don't have the read permissions
					-- on the server files.
				retried := true
				retry
			end
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			if tool.last_format = Current then
				tool.set_title ("Producing text format...")
			else
				tool.set_title ("Switching to text format...")
			end
		end

	display_info (d: STONE) is do end
			-- Useless here

feature {NONE} -- Properties

	file_name: STRING is
		do
			Result := tool.stone.file_name
		end

	name: STRING is
		do
			Result := Interface_names.f_Showtext
		end

	title_part: STRING is
		do
			Result := ""
		end

	post_fix: STRING is "dyt"

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showtext
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
--			Result := Interface_names.a_Showtext
		end

end -- class EB_DYNAMIC_TEXT_FORMATTER
