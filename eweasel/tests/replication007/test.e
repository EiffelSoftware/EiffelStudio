class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			b: B
		do
			create b.make
			b.f
			b.f1
		end

end
