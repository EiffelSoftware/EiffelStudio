--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.4.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.2  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.1.6.2  2000/01/27 19:30:14  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.6.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.2.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
