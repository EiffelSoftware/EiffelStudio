indexing
	description: "Command to display the homonyms of the routine."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_HOMONYMS_FORMATTER

inherit
	EB_LONG_FORMATTER
		redefine
			display_temp_header
		end
	SHARED_SERVER

creation

	make
	
feature -- Porperties

	symbol: EV_PIXMAP is 
		once 
			Result := Pixmaps.bm_Showhomonyms 
		end
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showhomonyms
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showhomonyms
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Homonyms_of
		end

	post_fix: STRING is "hom"

	create_structured_text (f: FEATURE_STONE): STRUCTURED_TEXT is
			-- Display homononyms of the routine.
		local
			cmd: E_SHOW_ROUTINE_HOMONYMNS
		do
			create cmd.make (f.e_feature)
			cmd.execute
			Result := cmd.structured_text
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for homonyms...")
		end

end -- class EB_HOMONYMS_FORMATTER
