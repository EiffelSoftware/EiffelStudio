class C_FILTER

inherit
	LANGUAGE_FILTER

creation
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
