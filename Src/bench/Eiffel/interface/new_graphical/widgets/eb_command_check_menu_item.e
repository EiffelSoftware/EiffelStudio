indexing
	description	: "Menu item for a menuable command"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_COMMAND_CHECK_MENU_ITEM 

inherit
	EB_COMMAND_MENU_ITEM
		undefine
			is_in_default_state
		redefine
			implementation,
			create_implementation
		end

	EV_CHECK_MENU_ITEM
		redefine
			implementation,
			create_implementation
		end

create
	make

feature {NONE} -- Implementation

	implementation: EV_CHECK_MENU_ITEM_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_CHECK_MENU_ITEM_IMP} implementation.make (Current)
		end

end -- class EB_COMMAND_CHECK_MENU_ITEM