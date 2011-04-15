deferred class
	TEST2

inherit
	USABLE

feature -- Initialization

	f
		local
			b: BOOLEAN
		do
			b := is_interface_usable
		end

end
