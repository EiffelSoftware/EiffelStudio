indexing 
	description: "EiffelVision printer. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "printer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PRINTER_I

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

feature -- Status setting

	set_printer_dc (a_dc: WEL_PRINTER_DC) is
			-- Set `printer_dc' to `a_dc'.
		require
			a_dc_not_void: a_dc /= Void
		deferred
		end

feature -- Status setting

	start_document is
		deferred
		end

	end_document is
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_PRINTER;

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




end -- class EV_PRINTER_I

