expanded class A

inherit
	TEST
		redefine
			default_create
		end

create
	default_create

feature

	default_create
		do
			create r
		end

	r: TEST

end