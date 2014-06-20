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
			l_ok: detachable STRING
			l_bad__1: detachable STRING
			l_baD_2: detachable STRING
			l_baD_3: detachable STRING
			bad_4: detachable STRING -- ok if l_ prefix is not enforced
		do
			l_ok := Void
			l_bad__1 := Void
			l_baD_2 := Void
			l_baD_3 := Void
			bad_4 := Void
			io.put_string ("Foo")
		end

end
