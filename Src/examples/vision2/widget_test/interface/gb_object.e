indexing
	description: "An empty class to ensures files from Build compile."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT
	
feature

	output_name: STRING
	
	name: STRING
	
	type: STRING
	
	actual_type: STRING
	
	object: EV_ANY
	
	set_object (an_object: EV_ANY) is
			--
		do
			object := an_object
		end

	display_object: EV_ANY
	
	real_display_object: EV_ANY
	
	actual_ev_any_from_display_object: EV_ANY
	
	enable_expanded_in_box is
			--
		do
		end
		
	disable_expanded_in_box is
			--
		do
		end
		
	children: ARRAYED_LIST [GB_OBJECT]

end -- class GB_OBJECT
