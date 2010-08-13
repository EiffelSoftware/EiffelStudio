class
	TEST2 [G]

inherit
	TYPED_PREFERENCE [G]

feature

	do_something
		local
			test: TEST2 [G]
		do
			create test
		end

end
