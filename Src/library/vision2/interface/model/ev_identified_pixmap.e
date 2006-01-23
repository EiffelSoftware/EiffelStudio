indexing
	description: "Objects that is a pixmap with an id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_IDENTIFIED_PIXMAP
	
create
	make_with_id
	
feature {NONE} -- Initialisation

	make_with_id (a_pixmap: like pixmap; an_id: like id) is
			-- Create an EV_IDENTIFIED_PIXMAP containing `a_pixmap' with `an_id'.
		require
			a_pixmap_not_Void: a_pixmap /= Void
			an_id_positive: an_id > 0
		do
			pixmap := a_pixmap
			id := an_id
		ensure
			set: pixmap = a_pixmap and id = an_id
		end

feature -- Access

	pixmap: EV_PIXMAP
		-- Font
	
	id: INTEGER
		-- id for `pixmap'.
	
invariant
	pixmap_not_Void: pixmap /= Void
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




end -- class EV_IDENTIFIED_PIXMAP

