class TEST

create
	make

feature {NONE} -- Creation

	make
		do
			;(agent
				do
					;(item = {REAL_64}.nan).do_nothing
				end).do_nothing
		end

feature {NONE} -- Access

	item: REAL_64
			-- Value.

end