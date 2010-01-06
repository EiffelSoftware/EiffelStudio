
class TEST
inherit
	TEST1
		redefine
			value
		end
create
	make, default_create
feature
	
	make is
		do
			create x
			x.try
		end

	value (n: INTEGER): INTEGER
		do
			Result := precursor (n)
		end

	x: TEST2 [TEST]

end
