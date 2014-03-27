class TEST2
inherit
	TEST1
		redefine
			foo
		end

create
	make

feature

	foo: STRING

end

