indexing
	description: "Objects that are used to defer building of certain components until the%
		%very end of the load/build cycle."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		
feature {GB_XML_LOAD, GB_COMPONENT, GB_OBJECT_HANDLER, GB_XML_IMPORT, GB_XML_OBJECT_BUILDER} -- Basic operation

	build is
			-- For every item in `all_gb_ev', execute the deferred
			-- building features. Wipe out `all_gb_ev' and
			-- `all_element' during the process.
		do
			from
				all_gb_ev.start
				all_element.start
			invariant
				lists_have_same_count: all_element.count = all_gb_ev.count
			until
				all_gb_ev.is_empty
			loop
				all_gb_ev.item.modify_from_xml_after_build (all_element.item)
				all_gb_ev.remove
				all_element.remove
			end
		ensure
			all_gb_ev_is_empty: all_gb_ev.is_empty
			all_element_is_empty: all_element.is_empty
		end
		
	
feature {GB_EV_ANY} -- Basic operation

	defer_building (gb_ev: GB_EV_ANY; element: XM_ELEMENT;) is
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
	
feature {GB_COMPONENT, GB_XML_LOAD} -- Implementation

	all_gb_ev: ARRAYED_LIST [GB_EV_ANY]
		-- All instances of `gb_ev_any' which have been set as
		-- deferred in the building process.
		
	all_element: ARRAYED_LIST [XM_ELEMENT]
		-- All the XML elements containing information for
		-- building objects from the elements of `all_gb_ev'.
		
invariant
	
	list_count_equal: all_gb_ev /= Void implies all_gb_ev.count = all_element.count

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_DEFERRED_BUILDER
