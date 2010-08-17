
class TEST
inherit
	TEST1 [TEST4]
		redefine
			make
		end
create
	make
feature
	make
		do
			precursor
			create c.make
			create d.make
		end

	c: TEST1 [TEST4]
	
	d: TEST1 [TEST4]
end
