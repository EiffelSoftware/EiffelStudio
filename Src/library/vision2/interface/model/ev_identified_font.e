indexing
	description: "Objects that is an font with an id (for EV_SCALED_FONT_FACTORY)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_IDENTIFIED_FONT
	
create
	make_with_id
	
feature {NONE} -- Initialisation

	make_with_id (a_font: like font; an_id: like id) is
			-- Create an EV_IDENTIFIED_FONT containing `a_font' with `an_id'.
		require
			a_font_not_void: a_font /= Void
			an_id_positive: an_id > 0
		do
			font := a_font
			id := an_id
		ensure
			set: font = a_font and id = an_id
		end

feature -- Access

	font: EV_FONT
		-- Font
	
	id: INTEGER
		-- id for `font'.
	
invariant
	font_not_void: font /= Void
	id_positive: id >= 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_IDENTIFIED_FONT

