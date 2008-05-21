class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			l_io: ANY
		do
			if {a: ANY} io then
				l_io := a
			else
				check False end
			end
		end


end
