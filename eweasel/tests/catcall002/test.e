class TEST 
feature

	make
		do
			create t
			t.f ("STRING")
		end

	t: $ANCESTOR_TYPE

	t2: TEST1 [FILE_NAME]

end
