class TEST 
feature

	make is
		do
			t.f ("STRING")
		end

	t: $ENTITY_MARK TEST1 [$GENERIC_MARK STRING]

	t2: TEST1 [FILE_NAME]

end
