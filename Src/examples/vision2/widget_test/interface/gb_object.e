indexing
	description: "An empty class to ensures files from Build compile."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		
	children: ARRAYED_LIST [GB_OBJECT];

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


end -- class GB_OBJECT
