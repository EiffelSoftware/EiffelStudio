indexing
	description: "Command to display the history of a feature."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PAST_FORMATTER

inherit
	EB_FILTERABLE
		redefine
			display_temp_header
		end
	SHARED_SERVER

creation
	make
	
feature -- Properties

--	symbol: EV_PIXMAP is 
--		once 
--			Result := Pixmaps.bm_Showaversions 
--		end
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showpast
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showpast
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Past
		end

	create_structured_text (f: FEATURE_STONE): STRUCTURED_TEXT is
			-- Display history of `f'.
		local
			cmd: E_SHOW_ROUTINE_ANCESTORS
		do
			create cmd.make (f.e_feature)
			if cmd.has_valid_feature then
				cmd.execute
				Result := cmd.structured_text
			end
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for ancestor versions...")
		end

end -- class EB_PAST_FORMATTER
