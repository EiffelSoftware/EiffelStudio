indexing
	description: "Objects that represent a displayable radio link."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	
class
	GB_RADIO_GROUP_LINK
	
inherit
	EV_LIST_ITEM
		undefine
			is_in_default_state
		end
	
	GB_DEFAULT_STATE	
	
create
	make_with_text

feature -- Access

	object: GB_OBJECT
			-- Object linked by `Current'.
			
	gb_ev_container: GB_EV_CONTAINER
			-- Creator of `Current'.

feature -- Status setting

	set_object (an_object: GB_OBJECT) is
			-- Assign `an_object' to `object'.
		require
			object_not_void: an_object /= Void
		do
			object := an_object
		ensure
			object_set: object = an_object
		end
		
	set_gb_ev_container (a_container: GB_EV_CONTAINER) is
			-- Assign `a_container' to `gb_ev_container'.
		require
			container_not_void: a_container /= Void
		do
			gb_ev_container := a_container
		ensure
			container_set: gb_ev_container = a_container
		end
		
end -- class GB_RADIO_GROUP_LINK
