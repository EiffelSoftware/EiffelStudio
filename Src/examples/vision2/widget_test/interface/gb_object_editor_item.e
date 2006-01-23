indexing
	description: "Objects that allow modification of attributes. For%
		% insertion into a GB_OBJECT_EDITOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_EDITOR_ITEM

inherit
	EV_VERTICAL_BOX

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			--
		do
			components := a_components
			default_create
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_OBJECT_EDITOR_ITEM
