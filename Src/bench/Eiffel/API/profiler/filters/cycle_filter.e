indexing

	description:
		"Profile filter to check whether `check_item' its argument conforms to %
		%CYCLE_PROFILE_DATA";
	date: "$Date$";
	revision: "$Revision$"

class CYCLE_FILTER

inherit
	LANGUAGE_FILTER

create
	make

feature -- Creation

	make is
		do
		end

feature -- Checking

	check_item (item: PROFILE_DATA): BOOLEAN is
		local
			c_p_d: CYCLE_PROFILE_DATA
		do
			c_p_d ?= item
			Result := c_p_d /= Void
		end

end -- class CYCLE_FILTER
