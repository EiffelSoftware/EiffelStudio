indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_SOURCE

inherit
	EV_TEXT

	EV_PND_SOURCE

creation
	make_source

feature -- Initialization

	make_source(par: EV_CONTAINER; active_image: ACTIVE_TEXT) is
			-- Initialize
		require
			parent_exists: parent /= Void
			image_exists: active_image /= Void
		local
			com: EV_ROUTINE_COMMAND
		do
			make(par)
			active_text := active_image
		ensure
			text_set: active_text = active_image
		end

feature -- Implementation

	active_text: ACTIVE_TEXT

end -- class TEXT_SOURCE
