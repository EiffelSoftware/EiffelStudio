indexing
	description: 
		"Root class of EiffelVision Tutorial Application."
	status: "See notice at end of class"
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

creation
	make

feature -- Access

	first_window: MAIN_WINDOW is
			-- Main window of the example
		once
			!! Result.make_top_level 
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

end -- class TUTORIAL

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

