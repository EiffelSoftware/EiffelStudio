indexing
	description: "An event page in the event catalog."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class EVENT_PAGE

inherit
	CATALOG_PAGE [EVENT]
		redefine
			make
		end

	SHARED_EVENTS

feature {NONE} -- Initialization

	make (cat: EVENT_CATALOG) is
			-- Create a catalog page.
		do
			{CATALOG_PAGE} Precursor (cat)
			set_column_title ("Events", 1)
		end

feature -- Access

	update_content (ctxt: CONTEXT) is
			-- Update current page for the context `ctxt'.
		deferred
		end

feature {NONE} -- Pick and Drop

	pnd_type: EV_PND_TYPE is
		do
			Result := Pnd_types.event_type
		end

end -- class EVENT_PAGE

