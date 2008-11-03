class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			b: B [STRING]
		do
			create b.make
		end

end
