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