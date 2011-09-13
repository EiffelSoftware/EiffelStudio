note
	description: "[
					The In-Ribbon Gallery is a control that displays a collection of related items or
					Commands in the Ribbon. If there are too many items in the gallery, an expand arrow
					is provided to display the rest of the collection in an expanded pane.
																										]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_IN_RIBBON_GALLERY

inherit
	EV_RIBBON_DROP_DOWN_GALLERY
			redefine
				item_source
			end

feature -- Query

	item_source: ARRAYED_LIST [EV_RIBBON_IN_RIBBON_GALLERY_ITEM]
			-- <Precursor>
end
