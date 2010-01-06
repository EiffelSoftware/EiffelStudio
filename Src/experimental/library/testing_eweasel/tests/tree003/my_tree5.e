indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MY_TREE5

inherit
	ARRAYED_TREE [INTEGER]
		rename
			make as tree_make
		redefine
			node_is_equal
		end

create
	make

create {MY_TREE5} 
	tree_make

feature {NONE} -- Initialization

	make is
		do
			tree_make (3, 5)
		end

feature -- Access

	foo: STRING

feature -- Comparison

	node_is_equal (other: like Current): BOOLEAN is
		do
			Result := equal (foo, other.foo) and then Precursor {ARRAYED_TREE} (other)
		end

feature -- Element change

	set_foo (s: STRING) is
		do
			foo := s
		ensure
			foo_set: foo = s
		end

end -- class MY_TREE5
