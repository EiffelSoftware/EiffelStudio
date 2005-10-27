indexing
	description: "Objects that allow modification of attributes. For%
		% insertion into a GB_OBJECT_EDITOR."
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

end -- class GB_OBJECT_EDITOR_ITEM
