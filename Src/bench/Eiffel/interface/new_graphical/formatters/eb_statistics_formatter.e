indexing
	description: "Statistics"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_STATISTICS_FORMATTER

inherit
	EB_FILTERABLE
		redefine
			display_temp_header, post_fix
		end

creation

	make
	
feature -- Properties

--	symbol: EV_PIXMAP is 
--		once 
--			Result := Pixmaps.bm_Showstatistics 
--		end
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showstatistics
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showstatistics
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Statistics_of
		end

	post_fix: STRING is "sta"

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Show statistics about the system.
		local
			cmd: E_SHOW_STATISTICS
		do
			create cmd.make
			cmd.execute
			Result := cmd.structured_text
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring system to compute statistics...")
		end

end -- class EB_STATISTICS_FORMATTER
