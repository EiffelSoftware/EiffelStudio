indexing
	description: 
		"Root class of EiffelVision Tutorial Application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	TUTORIAL

inherit
	EV_APPLICATION
		redefine
			initialize
		end

	PIXMAP_PATH

create
	make

feature -- Access

	first_window: MAIN_WINDOW is
			-- Main window of the example
		once
			create Result.make_top_level 
		end

feature -- Application initialization

	initialize is
			-- Redefine this feature to initialize your application,
			-- set your splash screen pixmap, add your global accelerators.
		local
			pix: EV_PIXMAP
		do
			create pix.make_from_file (pixmap_path ("isepower"))
			splash_pixmap (pix)
		end

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


end -- class TUTORIAL

