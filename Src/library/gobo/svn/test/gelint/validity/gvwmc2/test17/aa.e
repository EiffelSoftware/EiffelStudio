class AA

create

	make

feature

	make is
		do
			f
		end

	f is
		local
			a: ANY
		do
				-- +0x80 (i.e. 128) is not representable as an INTEGER_8,
				-- even though ISE compiler considers that 0x80 (with no sign)
				-- as representable as an INTEGER_8 (with value -128).
			a := {INTEGER_8} +0x80
		end

end
