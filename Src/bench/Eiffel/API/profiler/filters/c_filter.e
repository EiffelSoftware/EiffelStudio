indexing

	description:
		"Profile filter to check whether the type of the argument of `check_item' %
		%conforms to C_PROFILE_DATA";
	date: "$Date$";
	revision: "$Revision$"

class C_FILTER

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
			c_p_d: C_PROFILE_DATA
		do
			c_p_d ?= item
			Result := c_p_d /= Void
		end

end -- class C_FILTER
