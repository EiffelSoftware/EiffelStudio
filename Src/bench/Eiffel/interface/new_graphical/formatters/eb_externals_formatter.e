indexing
	description: "Command to display class external routines."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNALS_FORMATTER

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
--			Result := Pixmaps.bm_Showexternals 
--		end
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showexternals
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showexternals
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Externals_of
		end

	post_fix: STRING is "ext"

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
		local
			cmd: E_SHOW_EXTERNALS
		do
			create cmd.make (c.e_class)
			cmd.execute
			Result := cmd.structured_text
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching for external features...")
		end

end -- class EB_EXTERNALS_FORMATTER
