indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_ENUMERATOR_IMP

inherit
	WEL_FONT_FAMILY_ENUMERATOR
		rename
			make as font_family_enumerator_make
		end

creation
	make

feature {NONE}

	make is
		-- Create the enumerator.
		do
			create available_font_names.make (0)
			setup_enumerator
		end

	setup_enumerator is
		-- Initailise the enumerator and list.
		local
			dc: WEL_MEMORY_DC
		do
			create dc.make
			font_family_enumerator_make (dc, Void)
		end

	action (enum_log_font: WEL_ENUM_LOG_FONT; tm: WEL_TEXT_METRIC; font_type: INTEGER) is
			-- Called for each font found.
		do
				available_font_names.extend (enum_log_font.full_name)
				io.putstring(enum_log_font.full_name)
				io.new_line
		end

feature -- Access

		
	available_font_names: ARRAYED_LIST [STRING]
		-- list of all available font names.
	
invariant
	invariant_clause: -- Your invariant here

end -- class EV_FONT_ENUMERATOR_IMP
