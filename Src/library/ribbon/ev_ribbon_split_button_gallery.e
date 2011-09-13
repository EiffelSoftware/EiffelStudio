note
	description: "[
					The Split Button Gallery is a composite control that contains a primary
					button which exposes a single default item or Command, and a secondary button
					which when clicked displays the rest of the item or Command collection in a
					mutually exclusive drop-down list.
																									]"
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
