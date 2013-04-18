note
	description: "Summary description for {IRON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON

create
	make

feature {NONE} -- Initialization

	make (a_layout: IRON_LAYOUT)
		do
			layout := a_layout
			create installation_api.make_with_layout (a_layout)
			create catalog_api.make_with_layout (a_layout)
		end

feature -- Access

	layout: IRON_LAYOUT

	installation_api: IRON_INSTALLATION_API

	catalog_api: IRON_CATALOG_API

end
