indexing

	description:	
		"Command to display flat form of a class."
	date: "$Date$"
	revision: "$Revision$"

class SHOW_FLAT 

inherit

	FILTERABLE
		rename
			create_structured_text as flat_context_text
		redefine
			display_temp_header, post_fix
		end

	SHARED_SERVER

	SHARED_FORMAT_TABLES

create

	make
	
feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Showflat 
		end
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showflat
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showflat
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Flat_form_of
		end
	
	post_fix: STRING is "fla"

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring ancestors to produce flat form...")
		end

end -- class SHOW_FLAT
