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
