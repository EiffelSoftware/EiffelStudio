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
			!EV_EXPOSE_EVENT_DATA_IMP!implementation.make (Current)
		end	


feature -- Access

	clip_region: EV_RECTANGLE
			-- Exposed region

	exposes_to_come: INTEGER
			-- Number of expose events to come
	
feature -- Debug
	
	print_contents is
		do
			io.put_string ("EV_EXPOSE_EVENT_DATA: ")
			print (widget)
			clip_region.print_contents
			io.put_string ("%N")
		end

feature {EV_EXPOSE_EVENT_DATA_I} -- Element change	
	
	set_clip_region (clip: EV_RECTANGLE) is
		do
			clip_region := clip
		end 
		
feature {NONE} -- Implementation
	
	implementation: EV_EXPOSE_EVENT_DATA_I
	
end
			
	
