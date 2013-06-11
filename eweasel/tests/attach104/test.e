class TEST

create
	make,
	make_from_other

feature

	make
		do
			if condition then
					-- Initialize all attributes and use Current.
				create a.make
				create b.make
				if a = Current then end
			end
				-- Current was used when all attributes were initialized,
				-- so it should not trigger an error when creation procedures
				-- making qualified calls are called.
			create a.make
			create b.make_from_other (a)
		end

	make_from_other (other: TEST)
		do
			a := other.a
			b := other.b
		end

feature

	condition: BOOLEAN
		do
		end

        a, b: TEST

end
