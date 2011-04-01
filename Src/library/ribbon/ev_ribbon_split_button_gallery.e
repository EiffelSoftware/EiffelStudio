note
	description: "Summary description for {EV_RIBBON_SPLIT_BUTTON_GALLERY}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_SPLIT_BUTTON_GALLERY

inherit
	EV_RIBBON_DROP_DOWN_GALLERY
			redefine
				item_source
			end

feature -- Query

	item_source: ARRAYED_LIST [EV_RIBBON_SPLIT_BUTTON_GALLERY_ITEM]
			-- <Precursor>
end
