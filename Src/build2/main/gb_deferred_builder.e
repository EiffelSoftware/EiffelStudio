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
			-- For every item in `all_gb_ev', execute the deferred
			-- building features. Wipe out `all_gb_ev' and
			-- `all_element' during the process.
		require
			lists_equal_in_length: all_gb_ev.count = all_element.count
		local
			counter: INTEGER
		do
			from
				all_gb_ev.start
				all_element.start
			until
				all_gb_ev.is_empty
			loop
				all_gb_ev.item.modify_from_xml_after_build (all_element.item)
				all_gb_ev.remove
				all_element.remove
				check
					all_element.count = all_gb_ev.count
				end
			end
		ensure
			all_gb_ev_is_empty: all_gb_ev.is_empty
			all_element_is_empty: all_element.is_empty
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
		
feature {GB_XML_OBJECT_BUILDER} -- Basic operation

	--| FIXME this should be removed after the first release. This is required
	--| as when picking a component, we simply build the object from XML, as if we were
	--| loading it from a file. This sets defered building on it which should not be
	--| the case. This feature is only here as a temporary fix. Julian 11/13/2001.

	clear_deferred is
			-- Remove all deferred building currently stored.
		do
			all_gb_ev.wipe_out
			all_element.wipe_out
		end
	
feature {NONE} -- Implementation

	all_gb_ev: ARRAYED_LIST [GB_EV_ANY]
		-- All instances of `gb_ev_any' which have been set as
		-- deferred in the building process.
		
	all_element: ARRAYED_LIST [XML_ELEMENT]
		-- All the XML elements containing information for
		-- building objects from the elements of `all_gb_ev'.
		
invariant
	
	list_count_equal: all_gb_ev /= Void implies all_gb_ev.count = all_element.count

end -- class GB_DEFERRED_BUILDER
