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
;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
