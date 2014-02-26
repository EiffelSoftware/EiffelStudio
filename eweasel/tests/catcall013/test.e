class TEST

create
	make

feature

	make
		do
		end

	is_equivalent (other: like Current): BOOLEAN
		local
			t2: TEST2 [ANY]
		do
			Result := raw.is_equal (other.raw)
		end

	raw: TEST1 [NATURAL_8]
		do
			create Result
		end

end

