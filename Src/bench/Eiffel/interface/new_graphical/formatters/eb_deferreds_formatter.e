indexing
	description: "Command to display class deferred routines."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEFERREDS_FORMATTER

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
--			Result := Pixmaps.bm_Showdeferreds 
--		end
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showdeferreds
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showdeferreds
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Deferreds_of
		end

	post_fix: STRING is "def"

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
		local
			cmd: E_SHOW_DEFERRED_ROUTINES
		do
			!! cmd.make (c.e_class)
			cmd.execute
			Result := cmd.structured_text
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching for deferred features...")
		end

end -- class EB_DEFERREDS_FORMATTER
