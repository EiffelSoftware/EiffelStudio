class TEST
create
	make

feature

	test: TUPLE [ b: BOOLEAN; i: ANY ]
 
	make is
		do
			create test
			test.b := False -- Works
			test.i := ({ANY}).attempt (7) -- Works
			test.i := 7 -- Segmentation violation; Operating system signal
			test.i := True -- Segmentation violation; Operating system signal
		end

end
