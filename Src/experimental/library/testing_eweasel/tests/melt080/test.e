class TEST
create
	make
feature
	
	make is
		local
			nan: DOUBLE
			p: MANAGED_POINTER
			platform: PLATFORM
		do
			create platform
			
				-- Binary representation of IEEE 754 'NaN'.
				-- See: http://en.wikipedia.org/wiki/IEEE_754
			create p.make (8)
			if platform.is_little_endian then
				p.put_natural_8 (0, 0)
				p.put_natural_8 (0, 1)
				p.put_natural_8 (0, 2)
				p.put_natural_8 (0, 3)
				p.put_natural_8 (0, 4)
				p.put_natural_8 (0, 5)
				p.put_natural_8 (255, 6)
				p.put_natural_8 (127, 7)
			else
				p.put_natural_8 (0, 7)
				p.put_natural_8 (0, 6)
				p.put_natural_8 (0, 5)
				p.put_natural_8 (0, 4)
				p.put_natural_8 (0, 3)
				p.put_natural_8 (0, 1)
				p.put_natural_8 (255, 1)
				p.put_natural_8 (127, 0)
			end
			nan := p.read_real_64 (0)
			print (nan /= nan)
			print ("%N")
		end

end
