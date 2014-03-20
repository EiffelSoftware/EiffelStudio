class
	STRING_ITERATION_CURSOR

create
	make

feature -- Initialization

	make (s: READABLE_STRING_GENERAL)
			-- Initialize cursor using structure `s'.
		require
			s_attached: s /= Void
		do
		end

	start
		do
		end

end
