note
	description: "Same as EV_GRID_LABEL_ITEM using a different name so that we can ignore those objects from the list of displayed objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_GRID_LABEL_ITEM

inherit
	EV_GRID_LABEL_ITEM

create {MA_OBJECT_SNAPSHOT_MEDIATOR}
	default_create,
	make_with_text

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
