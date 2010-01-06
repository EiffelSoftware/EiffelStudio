class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			c: C
		do
			create c.make
				-- Following should not exists because it's consumable attribute is set to False
			c.no_consume
		end

end