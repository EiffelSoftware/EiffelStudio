indexing

	description: "Command to flat of routine."
	date: "$Date$"
	revision: "$Revision$"

class SHOW_ROUT_FLAT

inherit

	FILTERABLE
		rename
			create_structured_text as rout_flat_context_text
		redefine
			display_temp_header
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

	title_part: STRING is
		do
			Result := Interface_names.t_Feature_flat_form_of
		end

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

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring ancestors to produce flat form...")
		end

end -- class SHOW_ROUT_FLAT
