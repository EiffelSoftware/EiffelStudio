indexing
	description:
		""

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
	date: "$Date$"
	revision: "$Revision$"

class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			l1, l2: LINKED_LIST [STRING]
		do
			create l1.make
			l1.compare_references
			l1.extend ("foo")
			l1.extend ("bar")
			l1.extend ("baz")
			l2 := clone (l1)
			Io.put_boolean (equal (l1, l2))
			Io.put_new_line
			create l1.make
			l1.compare_objects
			l1.extend ("foo")
			l1.extend ("bar")
			l1.extend ("baz")
			l2 := clone (l1)
			Io.put_boolean (equal (l1, l2))
			Io.put_new_line
		end

end -- class TEST

 
