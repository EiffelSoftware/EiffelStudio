indexing
	description: "Objects that are used to defer building of certain components until the%
		%very end of the load/build cycle."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DEFERRED_BUILDER
	
create
	
	initialize
	
feature {NONE} -- Initialization

	initialize is
			-- Create `Current' and initialize.
		do
			create all_gb_ev.make (0)
			create all_element.make (0)
		ensure
			all_gb_ev_not_void: all_gb_ev /= Void
			all_element_not_void: all_element /= Void
		end
		
feature {GB_XML_LOAD} -- Basic operation

	build is
			--
		local
			counter: INTEGER
		do
			from
				counter := 1
			until
				counter = all_gb_ev.count + 1
			loop
				(all_gb_ev @ counter).modify_from_xml_after_build (all_element @ counter)
				counter := counter + 1
			end
		end
		
	
feature {GB_EV_ANY} -- Basic operation

	defer_building (gb_ev: GB_EV_ANY; element: XML_ELEMENT;) is
			-- Add `gb_ev' to `all_gb_ev', `element' to `all_element' and `objects' to `all_object'.
		require
			gb_ev_not_void: gb_ev /= Void
			element_not_void: element /= Void
		do
			all_gb_ev.force (gb_ev)
			all_element.force (element)
		ensure
			all_gb_ev_extended: all_gb_ev.has (gb_ev) and (all_gb_ev.count = old all_gb_ev.count + 1)
			all_element_extended: all_element.has (element) and (all_element.count = old all_element.count + 1)
		end
		
	
feature {NONE} -- Implementation

	all_gb_ev: ARRAYED_LIST [GB_EV_ANY]
	all_element: ARRAYED_LIST [XML_ELEMENT]

end -- class GB_DEFERRED_BUILDER
