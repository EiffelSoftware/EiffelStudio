class TEST

create
	make

feature {NONE}

	make
			-- Create expanded objects that need to initialize their attributes.
		local
			x: A
			y: A
		do
			x := y
			create x.make_self1
			create x.make_self2
			create x.make_self3
			create x.make_other (Current)
		end

feature -- Access

	access (a: A)
			-- Do nothing.
		do
		end

end
