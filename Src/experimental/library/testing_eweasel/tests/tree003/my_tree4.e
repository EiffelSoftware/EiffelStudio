indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MY_TREE4

inherit
	FIXED_TREE [INTEGER]
		rename
			make as tree_make,
			make_filled as tree_make_filled
		redefine
			node_is_equal
		end

create
	make, make_filled

create {MY_TREE4}
	tree_make,
	tree_make_filled

feature {NONE} -- Initialization

	make (n: INTEGER) is
		do
			tree_make (n, 0)
		end

	make_filled (n: INTEGER) is
		do
			tree_make_filled (n, 0)
		end

feature -- Access

	foo: STRING

feature -- Comparison

	node_is_equal (other: like Current): BOOLEAN is
		do
			Result := equal (foo, other.foo) and then Precursor {FIXED_TREE} (other)
		end

feature -- Element change

	set_foo (s: STRING) is
		do
			foo := s
		ensure
			foo_set: foo = s
		end

end -- class MY_TREE4
