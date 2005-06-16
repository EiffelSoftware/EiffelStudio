indexing
	description: "Objects that ..."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_XML_STORABLE
	
inherit
	ANY

	XM_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end

feature -- Access
	
	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml node representing `Current's state.
		require
			node_not_void: node /= Void
		deferred
		ensure
			Result_not_void: Result /= Void
		end
		
	xml_node_name: STRING is
			-- Name of the node returned by `xml_element'.
		deferred
		ensure
			Result_not_Void: Result /= Void
			Result_not_empty: not Result.is_empty
		end
		
feature -- Element change
		
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		require
			node_not_void: node /= Void
		deferred
		end
		
feature {NONE} -- Implementation

	xml_namespace: XM_NAMESPACE is
		once
			create Result.make_default
		end

	Xml_routines: XML_GRAPH_ROUTINES is
			-- Access the common xml routines.
		once
			create Result.default_create
		ensure
			non_void_Xml_routines: Xml_routines /= Void
		end	

end -- class EG_XML_STORABLE

--|----------------------------------------------------------------
--| EiffelGraph: library of graph components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

