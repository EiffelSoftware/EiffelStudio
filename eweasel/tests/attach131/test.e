class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			if attached (agent make).operands as operands then
				across
					operands as o
				loop
					separate o as i do
						if i /= Void and then i.out ~ "" then
							i.generator.do_nothing
						end
					end
				end
			end
		end
end
