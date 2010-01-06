class
	APPLICATION

create
	make

feature -- Initialization

	make is
			-- Run application.
		local
			a: A
		do
			create a
			a.f
		end

end -- class APPLICATION
