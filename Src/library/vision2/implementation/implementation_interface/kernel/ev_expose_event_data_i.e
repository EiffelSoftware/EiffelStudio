indexing
	description: "EiffelVision expose event data. Implementation interface";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_EXPOSE_EVENT_DATA_I

inherit
	EV_EVENT_DATA_I	
		redefine
			print_contents
		end	

feature -- Access

	clip_region: EV_RECTANGLE
			-- Exposed region

	exposes_to_come: INTEGER
			-- Number of expose events to come

feature -- Element change	
	
	set_clip_region (clip: EV_RECTANGLE) is
		do
			clip_region := clip
		end 

feature -- Debug
	
	print_contents is
		do
			io.put_string ("EV_EXPOSE_EVENT_DATA: ")
			print (widget)
			clip_region.print_contents
			io.put_string ("%N")
		end

end -- class EV_EXPOSE_EVENT_DATA_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
