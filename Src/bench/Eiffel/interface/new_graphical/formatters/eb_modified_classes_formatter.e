indexing
	description: "Classes modified since last compilation."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_MODIFIED_CLASSES_FORMATTER

inherit
	EB_FILTERABLE
		redefine
			display_temp_header, post_fix, make
		end

creation

	make
	
feature -- Initialization

	make (t: like tool) is 
		do
			Precursor {EB_FILTERABLE} (t)
			do_format := true
		end 

feature -- Properties

	symbol: EV_PIXMAP is 
		once 
			Result := Pixmaps.bm_Showmodified 
		end
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showmodified
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showmodified
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Modified_of
		end

	post_fix: STRING is "mod"

feature {NONE} -- Attributes

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Display modified classes list.
		local
			cmd: E_SHOW_MODIFIED_CLASSES
		do
			create cmd.make
			cmd.execute
			Result := cmd.structured_text
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for modified classes...")
		end

end -- class EB_MODIFIED_CLASSES_FORMATTER
