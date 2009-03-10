
class TEST2 [G]
inherit
	TEST
		redefine
			default_create
		end
	ANY
		redefine
			default_create
		end

create
	default_create, make_from_test
convert
	make_from_test ({TEST})

feature
	make_from_test (a: TEST)
		do
		end

	default_create
		do
		end

	to_test1: TEST2 [HASH_TABLE [STRING, DOUBLE]]
		do
			create Result
		end

end
