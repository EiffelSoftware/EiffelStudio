indexing
	description: "Smart Progress Bar"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SMART_PROGRESS_BAR

inherit
	EV_HORIZONTAL_PROGRESS_BAR

creation
	make_with_text

feature -- Initialization

	make_with_text(par: EV_CONTAINER;s:STRING) is
			-- Initialize
		require
			s_exists: s /= Void
			parent_exists: par /= Void
		do
			!! h1.make ( par )
			h1.set_vertical_resize(FALSE)
			h1.set_spacing(10)
			!! text.make_with_text(h1,s)
			make(h1)
			text.set_expand(FALSE)
			set_continuous
		end

feature -- Implementation

	h1: EV_HORIZONTAL_BOX

	text: EV_LABEL

end -- class SMART_PROGRESS_BAR
