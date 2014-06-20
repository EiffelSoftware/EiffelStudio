note
	description: "project2 application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		local
			l_foo_1: detachable TEST__BAD_1
			l_foo_2: detachable TEST_BAD_2
		do
			l_foo_1 := Void
			l_foo_2 := Void
			io.put_string ("Foo")
		end

end
