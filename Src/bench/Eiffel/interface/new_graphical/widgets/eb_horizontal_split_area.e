indexing
	description	: "Split area with flat separators."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_HORIZONTAL_SPLIT_AREA

inherit
	EV_HORIZONTAL_SPLIT_AREA

create
	default_create

feature -- Status setting

	enable_flat_separator is
			-- Set the separator to be "flat"
		do
			implementation.enable_flat_separator
		end

	disable_flat_separator is
			-- Set the separator to be "raised"
		do
			implementation.disable_flat_separator
		end

end -- class EB_SPLIT_AREA
