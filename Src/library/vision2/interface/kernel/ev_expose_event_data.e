indexing
	description: "EiffelVision expose event data.% 
	%Class for representing expose event data";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_EXPOSE_EVENT_DATA 

inherit
	EV_EVENT_DATA	
		redefine
			make,
			implementation,
			print_contents
		end	
	
creation
	make

feature {NONE} -- Initialization

	make is
		do
			!EV_EXPOSE_EVENT_DATA_IMP! implementation
		end

feature -- Access

	clip_region: EV_RECTANGLE is
			-- Exposed region
		do
			Result := implementation.clip_region
		end

	exposes_to_come: INTEGER is
			-- Number of expose events to come
		do
			Result := implementation.exposes_to_come
		end

feature -- Debug
	
	print_contents is
		do
			io.put_string ("EV_EXPOSE_EVENT_DATA: ")
			print (widget)
			clip_region.print_contents
			io.put_string ("%N")
		end

feature {EV_WIDGET_IMP} -- Implementation
	
	implementation: EV_EXPOSE_EVENT_DATA_I
	
end -- class EV_EXPOSE_EVENT_DATA

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
