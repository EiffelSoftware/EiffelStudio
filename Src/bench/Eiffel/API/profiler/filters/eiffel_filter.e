indexing

	description:
		"Profile filter used to check whether `check_item' its argument's type %
		%conforms to EIFFEL_PROFILE_DATA.";
	date: "$Date$";
	revision: "$Revision$"

class EIFFEL_FILTER

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
			e_p_d: EIFFEL_PROFILE_DATA
		do
			e_p_d ?= item
			Result := e_p_d /= Void
		end

end -- class EIFFEL_FILTER
