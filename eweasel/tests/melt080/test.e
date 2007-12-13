class TEST
create
	make
feature
	
	make is
		local
			nan: DOUBLE
			p: MANAGED_POINTER
		do
				-- Binary representation of IEEE 754 'NaN'.
				-- See: http://en.wikipedia.org/wiki/IEEE_754
			create p.make (8)
			p.put_natural_8 (0, 0)
			p.put_natural_8 (0, 1)
			p.put_natural_8 (0, 2)
			p.put_natural_8 (0, 3)
			p.put_natural_8 (0, 4)
			p.put_natural_8 (0, 5)
			p.put_natural_8 (255, 6)
			p.put_natural_8 (127, 7)
			nan := p.read_real_64 (0)
			print (nan /= nan)
			print ("%N")
		end

end
