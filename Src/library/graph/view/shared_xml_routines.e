indexing
	description: "[
			Common shared routines for XML extraction, saving and deserialization
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_XML_ROUTINES

inherit
	ANY

	XM_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end

feature {NONE} -- Implementation

	Xml_routines: XML_ROUTINES is
			-- Access the common xml routines.
		once
			create Result.default_create
		ensure
			non_void_Xml_routines: Xml_routines /= Void
		end

end -- Class SHARED_XML_ROUTINES

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
