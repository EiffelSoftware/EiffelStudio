class
	TEST

create
	make

feature {NONE} -- Creation

	make
		local
			a: A [ANY]
		do
			create {B} a
			a.f (Current)
		end

end
