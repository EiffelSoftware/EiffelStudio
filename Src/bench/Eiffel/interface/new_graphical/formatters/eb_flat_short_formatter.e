indexing
	description: "Command to display the flat/short version of a class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FLAT_SHORT_FORMATTER

inherit
	EB_FILTERABLE
		rename
			create_structured_text as flatshort_context_text
		redefine
			 display_temp_header, post_fix
		end

	EB_SHARED_FORMAT_TABLES

creation

	make

feature -- Properties

	symbol: EV_PIXMAP is 
		once 
			Result := Pixmaps.bm_Showfs 
		end
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showfs
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showfs
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Flatshort_form_of
		end

	post_fix: STRING is "fsh"

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring ancestors to produce flat-short form...")
		end

end -- class EB_FLAT_SHORT_FORMATTER
